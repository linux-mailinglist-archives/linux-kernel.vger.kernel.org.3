Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC094ED175
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352418AbiCaB5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiCaB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:57:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016F56224;
        Wed, 30 Mar 2022 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648691750; x=1680227750;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lHLZ4I5xa6yWYpmA1xGZQGutesD6YXR+ZTkC/Y45Kpo=;
  b=AnNZ+Ms2FhPpnZzSmSpUEJ/uot3nD6qGg3h69ixLuQa/xhkwBUEgCQgD
   dKi+VH1zKlIivKDUZGB0Weo3srtyHBX/2KbFEKJSEd+y16xPtj/cdJcTd
   jgPKjRrVT/2iSqofO9F7smzjAjK6FYR+8IbaxTCkyczUsODpMOBlWL8xi
   UxyVDT7YTfMP0W5DW4bg6/1x1W3Iby+plJzWtUPLr0A8zbsea2zaZhFtA
   +RdATRGBbqnQhasVGXlvtV7HZWM67iDphryiVpBOgQByvfZOJh/GMSzd2
   19jA5uM2/cyxXVCmAqDO8ct9gj5HblI+uqpK/RpMqPhdVsMeKgIraOvb+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257269460"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="257269460"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="654288448"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 18:55:46 -0700
Subject: Re: [PATCH v2 2/6] x86/tdx: Add tdx_hcall_get_quote() API support
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
References: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
 <4ebf6b5c5676718f115e29c9fd34bc11f0c3a799.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <0922133d-27c4-a187-2b26-090d67074790@linux.intel.com>
Date:   Thu, 31 Mar 2022 09:55:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4ebf6b5c5676718f115e29c9fd34bc11f0c3a799.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/31 上午6:18, Kuppuswamy Sathyanarayanan wrote:
> Attestation is the process used by two un-trusted entities to prove to
> each other that it can be trusted. In TDX guest, attestation is mainly
> used to verify the trustworthiness of a TD to the 3rd party key
> servers.
> 
> First step in the attestation process is to generate the TDREPORT data.
> This support is added using tdx_mcall_tdreport() API. The second stage
> in the attestation process is for the guest to request the VMM generate
> and sign a quote based on the TDREPORT acquired earlier. More details
> about the steps involved in attestation process can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.5, section
> titled "TD attestation"
> 
> Add tdx_hcall_get_quote() helper function to implement the GetQuote
> hypercall.
> 
> More details about the GetQuote TDVMCALL are in the Guest-Host
> Communication Interface (GHCI) Specification, sec 3.3, titled
> "VP.VMCALL<GetQuote>".
> 
> This will be used by the TD attestation driver in follow-on patches.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c    | 47 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/tdx.h |  2 ++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3721e357262e..54b54e321c63 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -21,6 +21,7 @@
>  
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> +#define TDVMCALL_GET_QUOTE		0x10002
>  
>  /* MMIO direction */
>  #define EPT_READ	0
> @@ -42,6 +43,10 @@
>  #define TDCALL_INVALID_OPERAND		0x8000000000000000
>  #define TDCALL_OPERAND_BUSY		0x8000020000000000
>  
> +/* TDX hypercall error codes */
> +#define TDVMCALL_GET_QUOTE_ERR		0x8000000000000000
> +#define TDVMCALL_GET_QUOTE_QGS_UNAVIL	0x8000000000000001
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -151,6 +156,48 @@ int tdx_mcall_tdreport(void *data, void *reportdata)
>  }
>  EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
>  
> +/*
> + * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
> + *
> + * @data        : Address of 8KB GPA memory which contains
> + *                TDREPORT_STRUCT.
> + * @len		: Length of the GPA in bytes.
> + *
> + * return 0 on success or failure error number.
> + */
> +int tdx_hcall_get_quote(void *data, u64 len)
> +{
> +	u64 ret;
> +
> +	/*
> +	 * Use confidential guest TDX check to ensure this API is only
> +	 * used by TDX guest platforms.
> +	 */
> +	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EINVAL;
> +
> +	/*
> +	 * Pass the physical address of tdreport data to the VMM
> +	 * and trigger the tdquote generation. Quote data will be
> +	 * stored back in the same physical address space. More info
> +	 * about ABI can be found in TDX Guest-Host-Communication
> +	 * Interface (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
> +	 */
> +	ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
> +			     len, 0, 0);

May I know why we need cc_mkdec() here?

IIUC, this guest physical address(GPA) is stored in the register when
TDCALL brings the context back to the VMX root mode, and hypervisor(QEMU)
will find the mapped host virtual address(HVA) with the GPA in the register,
and the subsequent ops will be HVA<->HVA in hypervisor, EPT will not be
involved so no need to cc_mkdec() this GPA.

Thanks,
-Aubrey
