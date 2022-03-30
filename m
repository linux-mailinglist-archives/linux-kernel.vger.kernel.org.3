Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86534EC859
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiC3PfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348270AbiC3PfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:35:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0725140D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648654403; x=1680190403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9WqpUiHeb0dkBTIAkEzlYUBlUbAPYQTJ6dWYSxlYa6s=;
  b=VQbPbo5VahIZk+FFNHn3bp2KYP/Ldp/Y9DKewLbPGu09E0bqzubq5TbT
   cJDc7BcutOBqi/2qMDOGcGmQj6OHnb9y13ytXTx3edvnHaZwZMDh7aH3D
   fgorlyzQgqgh4QU64FfuQcX6RHvmzmvRoSuO4CroXb10z3/Umh+w1w0u3
   AoPqzEydncrTs9g9Rk04qvbey2sNIMp+/3dw2pzqrwxpXnDkven3q9kd/
   KqJN+LsV3yBDfzbHjbHqvzdZ439OWGsC3SLVxm2ojvNAR+IySE8krqGni
   h6Dt25QNS+tsSlTY3wzFdZfXHCSqFcCl1jCqLjqhVP20Lcvi9HfqsYYJ8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320270002"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="320270002"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:33:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="586041626"
Received: from amahade1-mobl2.amr.corp.intel.com (HELO [10.209.45.250]) ([10.209.45.250])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:33:22 -0700
Message-ID: <c54c8c77-d35f-49b0-ff2f-21eb597f41f0@intel.com>
Date:   Wed, 30 Mar 2022 08:33:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86: undef REG_IN/REG_OUT to avoid define collisions
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
References: <20220330152808.1461758-1-narmstrong@baylibre.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220330152808.1461758-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 08:28, Neil Armstrong wrote:
> These defines are only used in the inline functions declared
> in the arch_hweight.h file, and collides with internal defines
> of the Amlogic Mes pinctrl driver when COMPILE_TEST is enabled:
> 
> arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
> 9 | #define REG_OUT "a"
>   |                 ^~~
> drivers/pinctrl/meson/pinctrl-meson.h:69:9: note: in expansion of macro ‘REG_OUT’
> 69 |         REG_OUT,
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/x86/include/asm/arch_hweight.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
> index ba88edd0d58b..139a4b0a2a14 100644
> --- a/arch/x86/include/asm/arch_hweight.h
> +++ b/arch/x86/include/asm/arch_hweight.h
> @@ -52,4 +52,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
>  }
>  #endif /* CONFIG_X86_32 */
>  
> +#undef REG_IN
> +#undef REG_OUT

Wouldn't it be a bit less hackish to give these a more qualified name
like HWEIGHT_REG_IN?
