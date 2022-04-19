Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA969506226
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbiDSCcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244392AbiDSCcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:32:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846882E688;
        Mon, 18 Apr 2022 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650335363; x=1681871363;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1jcWKfWahIx2WpR/x2hL9GOikQOTZYyBLB86DBI79I=;
  b=LLrOx5fseTNurCu+rcCIIzdlQB/38EZpVH5yEhTvJWf7jIOVQtAthoUj
   qhQiPqCF9YqTXhwo7npPU8N/hSCBZuzeqYtjdN2AIR0NeKVP8a9E/I6DB
   HpAU0ommURdEuxF+7lllPI+YHhZaOvacFBd0LU4+PeocoSZddUtWjxTFt
   7F5ISs1zfaEMbOrIXjiBU/0nfrCgICk0xummA3MdCyyTzCcl0CouUnTJa
   gRZbRIrdpX226E8d+KVdVRjS9lX+gukEHbl+A9lwxcg05S6YnwK15ZPP9
   DIl/dHsAEZMcvcxPK6pWitjlZDnNMpamKm/CzXcTM5AHBKX345IQqoM3w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326556869"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="326556869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:29:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657465581"
Received: from jaspuehl-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.31.185])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:29:19 -0700
Message-ID: <eca68f9b522b6586c883ac9765d8a071e803ee3f.camel@intel.com>
Subject: Re: [PATCH v3 1/4] x86/tdx: Add tdx_mcall_tdreport() API support
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
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
Date:   Tue, 19 Apr 2022 14:29:17 +1200
In-Reply-To: <20220415220109.282834-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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

On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
> In TDX guest, attestation is mainly used to verify the trustworthiness
> of a TD to the 3rd party key servers. 
> 

"key servers" is only a use case of using the attestation service. This sentence
looks not accurate.

> First step in attestation process
> is to get the TDREPORT data and the generated data is further used in
> subsequent steps of the attestation process. TDREPORT data contains
> details like TDX module version information, measurement of the TD,
> along with a TD-specified nonce
> 
> Add a wrapper function (tdx_mcall_tdreport()) to get the TDREPORT from
> the TDX Module.
> 
> More details about the TDREPORT TDCALL can be found in TDX Guest-Host
> Communication Interface (GHCI) for Intel TDX 1.5, section titled
> "TDCALL [MR.REPORT]".

Attestation is a must for TDX architecture, so The TDCALL[MR.REPORT] is
available in TDX 1.0.  I don't think we should use TDX 1.5 here.  And this
TDCALL is defined in the TDX module spec 1.0.  You can find it in the public TDX
module 1.0 spec (22.3.3. TDG.MR.REPORT Leaf):

https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf

> 
> Steps involved in attestation process can be found in TDX Guest-Host
> Communication Interface (GHCI) for Intel TDX 1.5, section titled
> "TD attestation"

It's strange we need to use GHCI for TDX 1.5 to get some idea about the
attestation process.  Looking at the GHCI 1.0 spec, it seems it already has one
section to talk about attestation process (5.4 TD attestation).

> 
> This API will be mainly used by the attestation driver. Attestation
> driver support will be added by upcoming patches.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c    | 46 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/tdx.h |  2 ++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 03deb4d6920d..3e409b618d3f 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -11,10 +11,12 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/io.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
>  #define TDX_GET_VEINFO			3
> +#define TDX_GET_REPORT			4
>  #define TDX_ACCEPT_PAGE			6
>  
>  /* TDX hypercall Leaf IDs */
> @@ -34,6 +36,10 @@
>  #define VE_GET_PORT_NUM(e)	((e) >> 16)
>  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>  
> +/* TDX Module call error codes */
> +#define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
> +#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -98,6 +104,46 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
>  
> +/*
> + * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
> + *
> + * @data        : Address of 1024B aligned data to store
> + *                TDREPORT_STRUCT.
> + * @reportdata  : Address of 64B aligned report data
> + *
> + * return 0 on success or failure error number.
> + */
> +long tdx_mcall_tdreport(void *data, void *reportdata)
> +{
> +	u64 ret;
> +
> +	/*
> +	 * Check for a valid TDX guest to ensure this API is only
> +	 * used by TDX guest platform. Also make sure "data" and
> +	 * "reportdata" pointers are valid.
> +	 */
> +	if (!data || !reportdata || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EINVAL;

Do we need to manually check the alignment since it is mentioned in the comment
of this function?

> +
> +	/*
> +	 * Pass the physical address of user generated reportdata
> +	 * and the physical address of out pointer to store the
> +	 * TDREPORT data to the TDX module to generate the
> +	 * TD report. Generated data contains measurements/configuration
> +	 * data of the TD guest. More info about ABI can be found in TDX
> +	 * Guest-Host-Communication Interface (GHCI), sec titled
> +	 * "TDG.MR.REPORT".

If you agree with my above comments, then this comment should be updated too: 
TDG.MR.REPORT is defined in TDX module 1.0 spec.

> +	 */
> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(data),
> +				virt_to_phys(reportdata), 0, 0, NULL);
> +
> +	if (ret)
> +		return TDCALL_RETURN_CODE(ret);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
> +
>  static u64 get_cc_mask(void)
>  {
>  	struct tdx_module_output out;
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 020c81a7c729..a151f69dd6ef 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -67,6 +67,8 @@ void tdx_safe_halt(void);
>  
>  bool tdx_early_handle_ve(struct pt_regs *regs);
>  
> +long tdx_mcall_tdreport(void *data, void *reportdata);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };

