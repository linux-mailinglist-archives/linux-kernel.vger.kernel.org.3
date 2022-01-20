Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A6494E62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiATMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbiATMyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:54:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC271C061574;
        Thu, 20 Jan 2022 04:53:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h26so6519998lfv.11;
        Thu, 20 Jan 2022 04:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1LqZq0O7eLdirdCHQCT48HNOIc+4FU2wpYuxnO3KmGg=;
        b=T6b7UUlDDd35DwuHRdlQ2pHINjJp7EbhX29Y7FYCaWKUvlgm3Hi0ns0gwtFvsS4Vpu
         V+CU6jHSU14H0DzSYQTWlOxcXvGJQ0D0IkkQH1OEXJmvoPYhiqsyk504YqSRVSyU0dup
         dWm+3TqHhguyE9BQ1Fzgobh0ZnOshPappS3Hka+4I9asmEz7fTfuJ6B81Sboew+iWWOH
         pIL8G/u/1ktLYX5iTUU9OgqUi10x2Z5+g4aD/WT+g3czm0/V4ks9AeeZtwjozrZxWOUh
         IkvIJ5FfDipk8kEZsXdHGGCuOgRtPliW5rOTC06eCmVbOoiVM68CG0BHbC0i3k/5eRZN
         A3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1LqZq0O7eLdirdCHQCT48HNOIc+4FU2wpYuxnO3KmGg=;
        b=1zrnA7+FKtqm7SdQj8vlZI5viaKHVVWKGP+g9sPt/Myl2ahcy8mSrSb2imaj0icGMT
         c9K57vk2o72vMTz0+pHPPSbdJPnhYxU/6ZszZ5a10GqmD4lULZzsf0aaBW6OPoGt1B25
         YmfqNTrSGP2nUWCumVUl47JkkoBBkYg+DIcWzlybZrikJtEpZe5McIqeoPl5eTz1jr7k
         L1uUj5wVgzl0pxESmCmcvq389KSjs9E7U8ZFThJWIF+BXX0tsZ/0Zv1/2b0GcjCpHNq0
         akC2jiLxHk5a4pWXG19WG2pQo6HU1pLcPVyvmEgitSrR7PeuyDH4yuUYsVDTe7p/u8sD
         s21Q==
X-Gm-Message-State: AOAM530fWZtUlLEK2uRpX5535+0lTydKteZr81ZY2dB8fgkHweBom3j2
        Nbfglq0bE/p5DoXo+Vnk7eSFiDA9DQU=
X-Google-Smtp-Source: ABdhPJxpNVNnlti34Aue4nQMiHS3+GO2b3oxC1ilHEaQZ2/skp8FzRBKUDvVR+CckwbGgiiGAn+TeQ==
X-Received: by 2002:a2e:2405:: with SMTP id k5mr24710279ljk.402.1642683204910;
        Thu, 20 Jan 2022 04:53:24 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id y12sm271345ljh.26.2022.01.20.04.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 04:53:24 -0800 (PST)
Message-ID: <3ebf9021-8df2-3d62-7f6c-0ff660e93735@gmail.com>
Date:   Thu, 20 Jan 2022 15:53:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V2] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.01.2022 12:02, Ashish Mhetre пишет:
> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
> Add error specific MC status and address register bits and use them on
> tegra186, tegra194 and tegra234.
> Add error logging for generalized carveout interrupt on tegra186, tegra194
> and tegra234.
> Add error logging for route sanity interrupt on tegra194 an tegra234.
> Add register for higher bits of error address and use it on tegra194 and
> tegra234.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> Changes in v2:
> - Updated patch subject and commit message
> - Removed separate irq handlers
> - Updated tegra30_mc_handle_irq to be used for Tegra186 onwards as well
> 
>  drivers/memory/tegra/mc.c       | 73 ++++++++++++++++++++++++++++++++++-------
>  drivers/memory/tegra/mc.h       | 16 +++++++++
>  drivers/memory/tegra/tegra186.c |  7 ++++
>  drivers/memory/tegra/tegra194.c |  5 +++
>  drivers/memory/tegra/tegra234.c |  5 +++
>  5 files changed, 94 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index bf3abb6..badebe8 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -508,7 +508,21 @@ int tegra30_mc_probe(struct tegra_mc *mc)
>  	return 0;
>  }
>  
> -static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
> +const struct tegra_mc_ops tegra30_mc_ops = {
> +	.probe = tegra30_mc_probe,
> +	.handle_irq = tegra30_mc_handle_irq,
> +};
> +#endif
> +
> +#if defined(CONFIG_ARCH_TEGRA_3x_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_114_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_124_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_132_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_210_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_186_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_234_SOC)

Ifdefs are unnecessary, please remove them. They are okay for
tegra30_mc_ops, which is known to be used only by specific older SoC
versions, not okay in case of newer SoCs.

> +irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  {
>  	struct tegra_mc *mc = data;
>  	unsigned long status;
> @@ -521,23 +535,64 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  
>  	for_each_set_bit(bit, &status, 32) {
>  		const char *error = tegra_mc_status_names[bit] ?: "unknown";
> +		u32 status_reg = MC_ERR_STATUS, addr_reg = MC_ERR_ADR;
>  		const char *client = "unknown", *desc;
>  		const char *direction, *secure;
>  		phys_addr_t addr = 0;
> +		u32 addr_hi_reg = 0;
>  		unsigned int i;
>  		char perm[7];
>  		u8 id, type;
>  		u32 value;
>  
> -		value = mc_readl(mc, MC_ERR_STATUS);
> +#if defined(CONFIG_ARCH_TEGRA_186_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_234_SOC)

Please drop these ifdefs.

> +		switch (bit) {
> +		case MC_INT_DECERR_VPR:
> +			status_reg = MC_ERR_VPR_STATUS;
> +			addr_reg = MC_ERR_VPR_ADR;

I mentioned previously that VPR is supported by T124+. Hence ifdefs are
incorrect.

...
> +		addr |= mc_readl(mc, addr_reg);
>  
>  		if (value & MC_ERR_STATUS_RW)
>  			direction = "write";
> @@ -591,9 +646,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  			break;
>  		}
>  
> -		value = mc_readl(mc, MC_ERR_ADR);

Don't change the order of the code, just replace the MC_ERR_ADR here.

> -		addr |= value;
> -
>  		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
>  				    client, secure, direction, &addr, error,
>  				    desc, perm);
> @@ -604,11 +656,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  
>  	return IRQ_HANDLED;
>  }
> -
> -const struct tegra_mc_ops tegra30_mc_ops = {
> -	.probe = tegra30_mc_probe,
> -	.handle_irq = tegra30_mc_handle_irq,
> -};
>  #endif
>  
>  const char *const tegra_mc_status_names[32] = {
> @@ -622,6 +669,8 @@ const char *const tegra_mc_status_names[32] = {
>  	[12] = "VPR violation",
>  	[13] = "Secure carveout violation",
>  	[16] = "MTS carveout violation",
> +	[17] = "Generalized carveout violation",
> +	[20] = "Route Sanity error",
>  };
>  
>  const char *const tegra_mc_error_names[8] = {
> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
> index 062886e..9b1b0dc 100644
> --- a/drivers/memory/tegra/mc.h
> +++ b/drivers/memory/tegra/mc.h
> @@ -44,6 +44,8 @@
>  #define MC_TIMING_CONTROL_DBG				0xf8
>  #define MC_TIMING_CONTROL				0xfc
>  
> +#define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
> +#define MC_INT_DECERR_GENERALIZED_CARVEOUT		BIT(17)
>  #define MC_INT_DECERR_MTS				BIT(16)
>  #define MC_INT_SECERR_SEC				BIT(13)
>  #define MC_INT_DECERR_VPR				BIT(12)
> @@ -65,6 +67,18 @@
>  #define MC_ERR_STATUS_SECURITY				BIT(17)
>  #define MC_ERR_STATUS_RW				BIT(16)
>  
> +#define MC_ERR_VPR_STATUS				0x654
> +#define MC_ERR_VPR_ADR					0x658
> +#define MC_ERR_SEC_STATUS				0x67c
> +#define MC_ERR_SEC_ADR					0x680
> +#define MC_ERR_MTS_STATUS				0x9b0
> +#define MC_ERR_MTS_ADR					0x9b4
> +#define MC_ERR_ROUTE_SANITY_STATUS			0x9c0
> +#define MC_ERR_ROUTE_SANITY_ADR				0x9c4
> +#define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
> +#define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
> +#define MC_ERR_ADR_HI					0x11fc

Please put these regs right after the MC_TIMING_CONTROL. There is no
reason to separate them.

