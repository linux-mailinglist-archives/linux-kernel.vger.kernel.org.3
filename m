Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63525110BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357937AbiD0GBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357329AbiD0GBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:01:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418D31343
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651039081; x=1682575081;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gfJsfPJq8cUzS9Ox+cK2uh+mhYc6kAesSnXXf9coeI8=;
  b=P0AXcKQ/SSfxKpvwy5OsD9P2u/FkvnwoLHw+ASj3Svb9BD/Ji47toJjN
   16+uqPt/iNhGZROK8jXui2ZynxsEsdnovL5f7IvSTb4uop7UwvCb/4Wjh
   HjjsgqpgSIlRG2XrGU0F2DH3s21+MAFTn7IA9zNOWPuI7ZQ80FNkf4+6H
   m3/ikDoNAFSAk0SPu/jSWKojEzJwKwPWaap31DYmWkIYY9ekWupjkxwK5
   JGf+/Q9qpVF6VjotZaaf8Jw28HcWQiPZ7nQLSWbn78vPv1wttWcLUukHN
   yOT+EeWOphU4FqsvprOBmHS5WMLcwczC+fBCG4cYL+sEUEggJRIILUhfQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="352262465"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="352262465"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:58:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="807869180"
Received: from aliang-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.1.170])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:57:59 -0700
Message-ID: <191409fcadfed4c08eb818335008cb36167d9477.camel@intel.com>
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 27 Apr 2022 17:57:57 +1200
In-Reply-To: <20220427054523.GA4167861@ls.amr.corp.intel.com>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220427054523.GA4167861@ls.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 22:45 -0700, Isaku Yamahata wrote:
> > + */
> > +long tdx_mcall_tdreport(void *data, void *reportdata)
> > +{
> > +	u64 ret;
> > +
> > +	/*
> > +	 * Check for a valid TDX guest to ensure this API is only
> > +	 * used by TDX guest platform. Also make sure "data" and
> > +	 * "reportdata" pointers are valid.
> > +	 */
> > +	if (!data || !reportdata ||
> > !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Pass the physical address of user generated report data
> > +	 * and the physical address of output buffer to the TDX module
> > +	 * to generate the TD report. Generated data contains
> > +	 * measurements/configuration data of the TD guest. More info
> > +	 * about ABI can be found in TDX 1.0 Module specification, sec
> > +	 * titled "TDG.MR.REPORT".
> > +	 */
> > +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(data),
> > +				virt_to_phys(reportdata), 0, 0, NULL);
> > +
> > +	if (ret)
> > +		return TDCALL_RETURN_CODE(ret);
> 
> Why is status code masked?
> 
> 
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
> 
> Can this function be put into attest.c. Instead, wecan export
> __tdx_module_call.

As we discussed, there's no need to export this anymore.

Btw, I even think we can move this function to attest.c so it can be static. 
Theoretically there should be no other caller of this except attest.c.  I
understand in this way we need to define TDX_GET_REPORT macro in attest.c but
this looks fine to me.  This function can even be removed, and we can call
__tdx_module_call() directly in attest.c.  This function literally doesn't do
anything meaningful more than __tdx_module_call(), instead, calling
__tdx_module_call() directly gives us more context, i.e., we can easily see the
buffer is allocated by kernel and passed to TDX module, etc.

-- 
Thanks,
-Kai


