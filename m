Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E124C38AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiBXWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiBXWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:23:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7011F6BE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645741362; x=1677277362;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5RiZZ9aPukW4GiysnDDSrpGKUCcJUHrJhiwKvfkbbek=;
  b=KoTxr0dMmW17nB3tsSmkzgNSGXGmzAELExP4t79AGCWzf9bXwtkAP2iI
   mOfbPBuMhTJIn4JLKGBsF4gpU1en/4HfaCFN/ERWZls45laC6gPKzQ9Gq
   HIGlWa8WsxODMd7z/AM/fFkHMS/Qh++wqx/o7/C+94Trc4/fvdgQDOxLx
   1icxvP2WvoGLhqkorn3/+RLh9PnsBXvklcFxQGVdUOxSoyFLcAPfAd1lk
   38V9qulwnugGQVDxiHMYg1oNxuDoQq1R645iepX1KICHK1VvY3Np0L1QE
   ZFgjoF90B9XKevCRFzJdIBJmqDKZu7/ote58U73RwSdBpXl+vwClFWuRd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="235873948"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="235873948"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 14:22:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639902503"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 14:22:41 -0800
Message-ID: <10b4cfef-49f8-12db-0ad7-2a6acad00234@intel.com>
Date:   Thu, 24 Feb 2022 14:22:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-17-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 16/30] x86/boot/compressed: Support TDX guest port I/O
 at decompression time
In-Reply-To: <20220224155630.52734-17-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> @@ -24,4 +88,11 @@ void early_tdx_detect(void)
>  
>  	/* Cache TDX guest feature status */
>  	tdx_guest_detected = true;
> +
> +	pio_ops.inb = tdx_inb;
> +	pio_ops.inw = tdx_inw;
> +	pio_ops.inl = tdx_inl;
> +	pio_ops.outb = tdx_outb;
> +	pio_ops.outw = tdx_outw;
> +	pio_ops.outl = tdx_outl;
>  }

I guess the kernel isn't going to get far if any of this goes wrong.
But, I do kinda wish that code ^^ was connected to the below code somehow:

> +static inline void init_io_ops(void)
> +{
> +	pio_ops.inb = inb;
> +	pio_ops.inw = inw;
> +	pio_ops.inl = inl;
> +	pio_ops.outb = outb;
> +	pio_ops.outw = outw;
> +	pio_ops.outl = outl;
> +}

Maybe just a comment would do it.  Or, maybe init_io_ops() should  just
be called init_default_io_ops().  I think this would do:

	/*
	 * Use the normal I/O instructions by default.
	 * TDX guests override these to use hypercalls.
	 */

if it went in init_io_ops() from the last patch.

> 
> +static inline unsigned int tdx_io_in(int size, u16 port)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = EXIT_REASON_IO_INSTRUCTION,
> +		.r12 = size,
> +		.r13  = 0,

		    ^ munged whitespace?

> +		.r14 = port,
> +	};
> +
> +	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
> +		return UINT_MAX;
> +
> +	return args.r11;
> +}

With that fixed:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
