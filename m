Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7E54D6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350505AbiFPBTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355569AbiFPBTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:19:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EE757174
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655342368; x=1686878368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JpkS80tB6/bbnuFv7vHBvQImiWFcwS3sHy76sYiwtUY=;
  b=Hv22ydKQerAA8N1qqZ6eED7/QDovSpr8iTgwgkzzPfAkfs4yuG1A+5Qc
   vYJEv9vSAhZ7doklVaA8ymvysuS0dHBNv4XQxftkPq697EhKf21K21o0V
   utnxiiqG22pT+J0nQOfJXBWs/XKcW3eXltanoqoKkW3XFM+k53CMM5nCV
   xq/kaefA9n6duhvHhbwA1NoVZJXB5Dlevb9oW5u0n3Zdl08FOARWbzZS3
   GgStopoyRZByHoLuv81XsbOlA+xXVS4IlvX9I+vXRAwz3GH3VFvuP/1GT
   78c7AJBt+UGel2vkhtxcLTOKmv4MgZtmqGh6cc8gHQRhlE2pWCm5Bpj6p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277934941"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277934941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641296226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2022 18:19:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 48F02109; Thu, 16 Jun 2022 04:19:26 +0300 (EEST)
Date:   Thu, 16 Jun 2022 04:19:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220616011926.hjmogvbzo6e4d5cj@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <20220615225200.lflv4tbqus6lnj5u@black.fi.intel.com>
 <db63853f-dbd8-7593-032d-e674046bff8e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db63853f-dbd8-7593-032d-e674046bff8e@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:34:48PM -0700, Dave Hansen wrote:
> On 6/15/22 15:52, Kirill A. Shutemov wrote:
> >> +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> >> +	if (vaddr / PAGE_SIZE != (vaddr + size) / PAGE_SIZE)
> > Oops. I just realized it has off-by-one. It supposed to be:
> > 
> > 	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)
> 
> That was bugging me.  Glad you caught this.
> 
> Wouldn't this be more obviously correct?
> 
> 	if (ALIGN_DOWN(vaddr,        PAGE_SIZE) !=
> 	    ALIGN_DOWN(vaddr + size, PAGE_SIZE))
> 		...

I don't think it fixes anything.

Consider the case when vaddr is 4092 and size is 4. This is legitimate
access -- aligned and not page crosser.

The left side of the check will be evaluated to 0 and the right will be 1
which is wrong and will get us -EFAULT.

I cannot think of a helper that would fit the need.

-- 
 Kirill A. Shutemov
