Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2F5062E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbiDSDyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDSDyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:54:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27261B7B9;
        Mon, 18 Apr 2022 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650340295; x=1681876295;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=efwo8qAJsBXDjFH/JWE6hSD0peUDHe9QXQ90jyrFGJw=;
  b=ZGMan7wn3jWpELj5gA/YXxJsPWyaWWxqwp+M7y29r6qQE3oxVq1yPNI0
   /wpdC3PeS+hfwY1AtF1NaoD/c/FcqsJ6BCIa14s34elfynOPNjv9DxuCf
   iQ5pii81laRDsXbv1aUlWh19ibv0btZic8YgM3EcBONMaCd0PyY+q7BVD
   MJdP/uCKmbuOJspDXvWxawcTtMzkDJBq+cx4vx3KixmfpsP4pAeOYWU7l
   3/pZti/EzLvb51qDwf8qAcpTMM/7ki8x3J9B5fxQQFhHd9MiiVgjtRyuU
   cXUkUERFAUJAq9Wlwq7T4tG5oknwm1uZRxRW20m/h3rURiJ52NKGPlLWz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350116278"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350116278"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:51:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="647103983"
Received: from jaspuehl-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.31.185])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:51:28 -0700
Message-ID: <283f3d9ec19597856521e66895348e80ef51f10a.camel@intel.com>
Subject: Re: [PATCH v3 1/4] x86/tdx: Add tdx_mcall_tdreport() API support
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
Date:   Tue, 19 Apr 2022 15:51:26 +1200
In-Reply-To: <ce0c1d0b-b60f-79e1-b602-450def91ae77@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <eca68f9b522b6586c883ac9765d8a071e803ee3f.camel@intel.com>
         <ce0c1d0b-b60f-79e1-b602-450def91ae77@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-18 at 20:37 -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 4/18/22 7:29 PM, Kai Huang wrote:
> > On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
> > > In TDX guest, attestation is mainly used to verify the trustworthiness
> > > of a TD to the 3rd party key servers.
> > > 
> > 
> > "key servers" is only a use case of using the attestation service. This sentence
> > looks not accurate.
> 
> I thought it is mainly used for this use case. If it is not accurate,
> how about following?
> 
> Attestation is used to verify the trustworthiness of a TD to the other
> 3rd party entities (like key servers) before exchanging sensitive
> information.

Fine to me, although not sure whether you need to mention key servers.  We Intel
guys has some first impression of what does "key servers" mean mainly because we
defined some use cases around here using attestation.  However for other people
"key servers" can be very generic and may not be the case we defined.

> 
> > 
> > > First step in attestation process
> > > is to get the TDREPORT data and the generated data is further used in
> > > subsequent steps of the attestation process. TDREPORT data contains
> > > details like TDX module version information, measurement of the TD,
> > > along with a TD-specified nonce
> > > 
> > > Add a wrapper function (tdx_mcall_tdreport()) to get the TDREPORT from
> > > the TDX Module.
> > > 
> > > More details about the TDREPORT TDCALL can be found in TDX Guest-Host
> > > Communication Interface (GHCI) for Intel TDX 1.5, section titled
> > > "TDCALL [MR.REPORT]".
> > 
> > Attestation is a must for TDX architecture, so The TDCALL[MR.REPORT] is
> > available in TDX 1.0.  I don't think we should use TDX 1.5 here.  And this
> 
> Yes. It is also part of v1.0. Since the feature is similar between v1.0
> and v1.5, I have included one link. If v1.0 reference is preferred, I
> will update it.

I think we should use 1.0.  Attestation is a essential part for TDX, which means
it must be included in TDX1.0, therefore it doesn't make sense to use TDX1.5 to
reference it.

[...]

> > > +/*
> > > + * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
> > > + *
> > > + * @data        : Address of 1024B aligned data to store
> > > + *                TDREPORT_STRUCT.
> > > + * @reportdata  : Address of 64B aligned report data
> > > + *
> > > + * return 0 on success or failure error number.
> > > + */
> > > +long tdx_mcall_tdreport(void *data, void *reportdata)
> > > +{
> > > +	u64 ret;
> > > +
> > > +	/*
> > > +	 * Check for a valid TDX guest to ensure this API is only
> > > +	 * used by TDX guest platform. Also make sure "data" and
> > > +	 * "reportdata" pointers are valid.
> > > +	 */
> > > +	if (!data || !reportdata || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> > > +		return -EINVAL;
> > 
> > Do we need to manually check the alignment since it is mentioned in the comment
> > of this function?
> 
> Users are responsible to allocate aligned data. I don't think we need
> to add a check for it. If it is unaligned, TDCALL will return error.

Actually this is the kernel memory, but not user memory.  Otherwise
virt_to_phys() doesn't make sense.  You copied the user data to kernel memory in
the last patch.  So whether user memory is aligned doesn't matter, and in last
patch, you have guaranteed the alignment is met during kernel memory allocation.

Anyway like you said the TDCALL will fail if alignment doesn't meet, so I guess
is fine.



