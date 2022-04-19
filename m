Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174DD5065A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349278AbiDSHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349286AbiDSHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:24:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D3326C4;
        Tue, 19 Apr 2022 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650352907; x=1681888907;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zn5qckyF4wgTfjbl8sye8FXpD4CMqZJPRK+O9uow4hA=;
  b=l7Hg6XmjoKW0dFydGn2h4kA0l3vXeVcdliStNVgcJT39YpdcAWpmhcb0
   xM3+kSsghjn6ZHfjyhMvUGoEu8ObTVozZGAa/gtFFGUWu0HQNV6hDCpOg
   5SayJRv0R9QulqT7ATYw9id7hydfA+wi4fP9Q+JkjDOnzfDUT3kE76wqe
   8w9i1VrCrXwqGEXF8Yf8aXaB5hX1MtHMAjaqGs2Usq4maWBKBqRVEaFdF
   pB2DIZCW4yRPcbvT5ycDlFPYSogV+UrSAzSTHtRnWpaxfXPsmS9rSW4er
   NJk9SdwGzvq3bnQ7yXB8UDSfn2YyEv0JEukWNS4t06KblxCxoJSCN81pl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262558664"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="262558664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 00:21:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="702089665"
Received: from csambran-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.20])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 00:21:43 -0700
Message-ID: <386efdc4a7f9dabd84cd19823c094a468a8644c4.camel@intel.com>
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 19 Apr 2022 19:21:41 +1200
In-Reply-To: <67eda184-6823-7b23-85d2-9ff22bc0d215@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <4ad97e6118688faf35e96ade46690c84f6c729f4.camel@intel.com>
         <0a49a4f1-637a-fa92-555f-485b529e6811@linux.intel.com>
         <7f6f73aeb37aeb4339059ad9a139a0d24458affc.camel@intel.com>
         <67eda184-6823-7b23-85d2-9ff22bc0d215@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-18 at 22:28 -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 4/18/22 9:40 PM, Kai Huang wrote:
> > > Please check the latest 1.0 specification (updated on Feb 2022). It has
> > > details about R13 register.
> > Thanks.  So it seems GHCI 1.0 has also been updated and it is consistent with
> > GHCI 1.5 now.  In this case, why do we still assume 8K shared memory?  Are you
> > going to update the driver?
> > 
> 
> Since the GetQuote spec only requires memory in 4K alignment, we just
> went with 8k constant allocation. Since existing users does not
> require more than 8k, it works. But I agree that this needs to be
> changed.

Quote format can be vendor specific, so there's no guarantee 3rd party won't
have a Quote larger than 8k.

> 
> In next version, I will change the driver to choose the allocation size
> based on user space request. Since this change would require us to do
> the memory allocation in IOCTL routine (instead of init code), it will
> make it slower. But I think this is negligible compared to time it takes
> for Quote request. So it should be fine.
> 
> > 

Yes attestation request should never be something that is very frequent, thus
should never be in a performance critical path.
