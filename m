Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAB4BF9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiBVNxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiBVNxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:53:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0A9ADA4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645537963; x=1677073963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jEaNgm19P8FjXxnGWpXVhLOGHVYgCc4zAob/JKxLo0=;
  b=VC5iP2qvCVdSiC0ldHIm4rfZH7KPkMKmQVBVHfnXDAwIKuqmNTt2bGa/
   df4hAqp6V3821d8VA2e5Vj/AW9znrMJANL5b1Ay1ZY/+KvdIr2qt2mIJH
   bOZXFIn0MwWspon3BdCPXORpfnnz3rwkJ91wTOtFH2xvJ9US+8KwQ/yN9
   R+CGkOlziz5wmKubfDxJky0ngXWMQKDy9s/MdPpEt2Xal/bXBkg+aKzec
   eR3jeeli0hbSlprJTBL8IsiZC4bbmKu2jK0RUh/bt5JYo1ENd7Bj4jZdy
   iwbgP7wnJM+Nt53+T7cbzuEX2LI+Te0wK4iDxGkGx5MZsKf+20GSp8nN8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251634366"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251634366"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="627696968"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2022 05:52:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id F0286142; Tue, 22 Feb 2022 15:52:53 +0200 (EET)
Date:   Tue, 22 Feb 2022 16:52:53 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <20220222135253.k6ayc7zgpqrsoiex@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
 <20220221222856.c6b74b3n3fwqe6vy@black.fi.intel.com>
 <20220222110312.q7eaepfph2tyjq3e@black.fi.intel.com>
 <YhTnF4Wpd8/9QjO/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhTnF4Wpd8/9QjO/@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:37:27PM +0100, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 02:03:12PM +0300, Kirill A. Shutemov wrote:
> > I would rather make cc_mkenc()/cc_mkdec() to operate on u64 (or
> > phys_addr_t?) while pgprot_encrypted()/pgprot_decrypted() cover pgprot_t.
> > It also makes set_memory cleaner:
> > 
> > 	cpa.mask_set = __pgprot(enc ? cc_mkenc(0) : cc_mkdec(0));
> > 	cpa.mask_clr = __pgprot(enc ? cc_mkdec(0) : cc_mkenc(0));
> > 
> > Opinions?
> 
> Right, do I see it correctly that the cc_mk{enc,dec}() things should
> take a u64 as an argument and return a pgprot_t, and that would be the
> most optimal way for all the use cases?

No, not really. With u64-in-u64-out in tdx_enc_status_changed() we have 

	if (!enc) {
		start |= cc_mkdec(0);
		end |= cc_mkdec(0);
	}

to iterate over the range of physical addresses with shared bit set.
With u64-in-pgprot_t-out we will have do add pgprot_val() there.

We will have more cases like this in attestation code when we need to do
hypercall on a shared page.

-- 
 Kirill A. Shutemov
