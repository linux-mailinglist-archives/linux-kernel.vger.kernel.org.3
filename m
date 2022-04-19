Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5550626E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiDSDCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiDSDCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:02:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958412654C;
        Mon, 18 Apr 2022 19:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650337173; x=1681873173;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53+MNw00qTUFIb8zfaOYGDdhCKIUzsDZnoy15EzE9L8=;
  b=CzF1yJo1Cw4OjmyfaShG3GRLW+cspUiz9NQPbciIZ92MP7lnpp463hRV
   RHgAmZYL0x/h2xQmfhpygvuaOHQZlGrjK1mjP0EcqRyMxWaLKLEmodr4s
   eDPdKZ1kkFXeXUvGE+EqXMT8qb8CUNFPbdRMfykRGX9HflW8B34yonqQj
   +KvG2WH0fFNcITqCAdBNn0fvoqoTMLYcVDDPNWwRlgE/zn/y6XyoBa11C
   t/E6qrHczmOcvOp8qL89IBuKLhrwY8Q5DLE5x7olu1yfRqZEjS45Hpky5
   x5Npy8MJ7jp4hblZXcXwlKKhwZdzfKxU+weBGHXUlZ9ZB3phCpaC7/oby
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326560470"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="326560470"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:59:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="647092487"
Received: from jaspuehl-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.31.185])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:59:29 -0700
Message-ID: <4ad97e6118688faf35e96ade46690c84f6c729f4.camel@intel.com>
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
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
Date:   Tue, 19 Apr 2022 14:59:27 +1200
In-Reply-To: <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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
> Attestation is the process used by two un-trusted entities to prove to
> each other that it can be trusted. 
> 

I don't think this is accurate.  TDX attestation is used to attest a TD is
genuine and runs on genuine Intel platforms to any challenger who wants to
verify this.  Theoretically, the TD guest doesn't necessarily need to verify the
trustworthiness of the challenger.

> In TDX guest, attestation is mainly
> used to verify the trustworthiness of a TD to the 3rd party key
> servers.

And "key servers" is only one potential use case of using the attestation
service.  I don't think it's right to say attestation is mainly used for this.

> 
> First step in the attestation process is to generate the TDREPORT data.
> This support is added using tdx_mcall_tdreport() API. The second stage
> in the attestation process is for the guest to request the VMM generate
> and sign a quote based on the TDREPORT acquired earlier. 
> 

This is not accurate.  The VMM cannot generate and sign the Quote.  Only Quoting
enclave (QE) can do that.  The VMM is just a bridge which helps to send the
TDREPORT to the QE and then give the Quote back to TD guest when it receives it.

For instance, theoretically GetQuote TDVMCALL isn't absolutely necessarily for
attestation.  The TD attestation agent (runs in TD guest userspace) can choose
to connect to QE directly if feasible (i.e. via vsock, tcp/ip, ..) and then send
the TDREPORT to QE and receive the Quote directly.

> More details
> about the steps involved in attestation process can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.5, section
> titled "TD attestation"

See my reply to previous patch.  It's mentioned in GHCI 1.0 spec (section 5.4 TD
attestation).

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
>  arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/tdx.h |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3e409b618d3f..c259d81a5d7f 100644
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
> @@ -144,6 +145,43 @@ long tdx_mcall_tdreport(void *data, void *reportdata)
>  }
>  EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
>  
> +/*
> + * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
> + *
> + * @data        : Address of 8KB GPA memory which contains
> + *                TDREPORT_STRUCT.
> + * @len		: Length of the GPA in bytes.

It seems GetQuote definitions in public GHCI 1.0 and GHCI 1.5 are different.  In
GHCI 1.5, R13 is used to specify the shared memory size.

I think it is because the public GHCI 1.0 hasn't been updated yet?

> + *
> + * return 0 on success or failure error number.
> + */
> +long tdx_hcall_get_quote(void *data, u64 len)
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

I think this function gives people impression that when this function is done,
the Quote is ready immediately in the shared buffer.  But actually GetQuote is
asynchronous.  It only means the VMM has accepted this request, but the Quote is
actually only ready when the guest receives the event notification (done in
later patch).  So I guess there should be a comment somewhere (or even in commit
message) to explain that?  

> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
> +
>  static u64 get_cc_mask(void)
>  {
>  	struct tdx_module_output out;
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index a151f69dd6ef..014cc6192dc5 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -69,6 +69,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
>  
>  long tdx_mcall_tdreport(void *data, void *reportdata);
>  
> +long tdx_hcall_get_quote(void *data, u64 len);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };

