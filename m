Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8748B908
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiAKU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:56:44 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33764
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235047AbiAKU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:56:43 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C6343F32E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641934601;
        bh=joK4ZHDMtjn7XdRm0td7fXUsOXKWOtlWbAnMaVZPaew=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=k+Wlr9Y2kuZxbbVkSzyXAeg9DDnixtsYhtNOx35lVmBPu0SoLO3A9okxuPcUk9dT8
         Zb1To6/xYxrcF7blHR4wKN7UG7ByURuNGrMDtqGVeuw+15u8ZjLBOGG6MFHpUPlQ8q
         rHQvynO8GS9TErrleajctBNIq5Z8hW9gECo7coH5Q57r91d9Gg+icJhQ6uYCJMVLJ3
         sisUeUi0gp/knkA2MB/bauCrTxOEv5ZlCcEac0I+pg9wLrBlcHmlzhvaM3Zys4s6h1
         d5HDanMmJ2i8Z/Ev0xsp7vl/veXg8eQnN5pUHC4j8PKg1Vs8fFcG0WAbqg+UfLOPS1
         2lRaREcFK7LSw==
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so270987edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=joK4ZHDMtjn7XdRm0td7fXUsOXKWOtlWbAnMaVZPaew=;
        b=KJBmB2lRMisMx1xe5niZcjPrHhutMNvZXWb1Yqce01CR0x/Mgc4K/oS9krTOnEI1fW
         dmc6A5quNUDeK4O1av22COj5Fe+BBuvVdxoOcH7Tel4ZRQGN/2YptVDS7YUw0PnE49Dn
         R6+gCMPJ5hGZQYZTiJrk3ZnaDozhsZFyW6V8CtuFk47jLuRp6+4dSqD9uH/AsWbFq09A
         BiIezHqdeLptdton25mdpIGibZN2R5DL+wxAguVxT9llo+gK2ysNRdNLLUeA73H+q+XF
         KFZ3ROtmvXHO5rR8rg/t34EwJTA+h4DFMASsHoCgap/GgOwegzsqpe493GCxIjto9tWj
         s3ew==
X-Gm-Message-State: AOAM533fI3GUi8bgzAMaJARYH+z0bpfYh6wCLKCcNxmA5QSZ2vDLRvjf
        qyOJCfVR3Tv/LuBaU+PFiy54erN/m4ULznTNWKJFRaVy4Kj1VTdShYU8J0EB+ZELnR/AWUXsEu6
        mVKuqDgVZtvMq5siPFyt2bdRxq3DQOMa50oeTwjZjSg==
X-Received: by 2002:a17:906:cc50:: with SMTP id mm16mr5018856ejb.515.1641934599346;
        Tue, 11 Jan 2022 12:56:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHxmM3ssxvS7T+yoQLKzgq1V+7D7WNOuOj9cI6ighPxndQeJa5uBWY90FwFBrdBQ6JjPPqIg==
X-Received: by 2002:a17:906:cc50:: with SMTP id mm16mr5018844ejb.515.1641934599152;
        Tue, 11 Jan 2022 12:56:39 -0800 (PST)
Received: from [192.168.0.26] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id gs9sm3887865ejc.30.2022.01.11.12.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 12:56:38 -0800 (PST)
Message-ID: <dd9bacd6-1365-d9f9-1b28-c603bfa708d7@canonical.com>
Date:   Tue, 11 Jan 2022 21:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com,
        Dmitry Osipenko <digetx@gmail.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc in the future also Dmitry, because he was involved in these drivers
quite a lot.

On 11/01/2022 19:45, Ashish Mhetre wrote:
> Add all mc-errors supported by T186.
> Implement mc interrupt handling routine for T186.

Here and in other patches - please use Tegra186 (and similar) to be
consistent with existing upstream naming.

> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.h       |  17 +++++++
>  drivers/memory/tegra/tegra186.c | 100 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
> index 2d4f495..7817492 100644
> --- a/drivers/memory/tegra/mc.h
> +++ b/drivers/memory/tegra/mc.h
> @@ -44,6 +44,15 @@
>  #define MC_TIMING_CONTROL_DBG				0xf8
>  #define MC_TIMING_CONTROL				0xfc
>  
> +#define MC_ERR_VPR_STATUS				0x654
> +#define MC_ERR_VPR_ADR					0x658
> +#define MC_ERR_SEC_STATUS				0x67c
> +#define MC_ERR_SEC_ADR					0x680
> +#define MC_ERR_MTS_STATUS				0x9b0
> +#define MC_ERR_MTS_ADR					0x9b4
> +#define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
> +#define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
> +
>  #define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
>  #define MC_INT_WCAM_ERR					BIT(19)
>  #define MC_INT_SCRUB_ECC_WR_ACK				BIT(18)
> @@ -159,6 +168,14 @@ extern const struct tegra_mc_ops tegra186_mc_ops;
>  extern const char * const tegra_mc_status_names[32];
>  extern const char * const tegra_mc_error_names[8];
>  
> +struct tegra_mc_error {
> +	u32 int_bit;

Where is it used (read)?

> +	const char *msg;
> +	u32 status_reg;
> +	u32 addr_reg;

Please describe all these fields with kerneldoc.

> +	u32 addr_reg_hi;

Looks unused.

> +};
> +
>  /*
>   * These IDs are for internal use of Tegra ICC drivers. The ID numbers are
>   * chosen such that they don't conflict with the device-tree ICC node IDs.
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 6766cc4..4f3ae71 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -146,8 +146,107 @@ static void tegra186_mc_clear_interrupt(struct tegra_mc *mc)
>  	mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
>  }
>  
> +static const struct tegra_mc_error int_mc_errors[] = {
> +	{
> +		.int_bit = MC_INT_DECERR_EMEM,
> +		.msg = "EMEM address decode error",
> +		.status_reg = MC_ERR_STATUS,
> +		.addr_reg = MC_ERR_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_SECURITY_VIOLATION,
> +		.msg = "non secure access to secure region",
> +		.status_reg = MC_ERR_STATUS,
> +		.addr_reg = MC_ERR_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_DECERR_VPR,
> +		.msg = "MC request violates VPR requirements",
> +		.status_reg = MC_ERR_VPR_STATUS,
> +		.addr_reg = MC_ERR_VPR_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_SECERR_SEC,
> +		.msg = "MC request violated SEC carveout requirements",
> +		.status_reg = MC_ERR_SEC_STATUS,
> +		.addr_reg = MC_ERR_SEC_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_DECERR_MTS,
> +		.msg = "MTS carveout access violation",
> +		.status_reg = MC_ERR_MTS_STATUS,
> +		.addr_reg = MC_ERR_MTS_ADR,
> +	},
> +	{
> +		.int_bit = MC_INT_DECERR_GENERALIZED_CARVEOUT,
> +		.msg = "GSC access violation",
> +		.status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS,
> +		.addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR,
> +	},
> +};
> +
> +static irqreturn_t tegra186_mc_handle_irq(int irq, void *data)
> +{
> +	struct tegra_mc *mc = data;
> +	unsigned long status;
> +	unsigned int bit;
> +
> +	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(bit, &status, 32) {

Don't you need bitops.h for this?

> +		const char *error = int_mc_errors[bit].msg ?: "unknown";

int_mc_errors has size of 6, but it's index (the bit variable) can be 20
or even 32. Are you sure indices are used properly or maybe
int_mc_errors missed initializer per-index?

> +		const char *client = "unknown";
> +		const char *direction, *secure;
> +		phys_addr_t addr = 0;
> +		unsigned int i;
> +		u8 id;
> +		u32 value;

Keep order in reversed xmas tree plus name it in a meaningful way. You
read here several registers, so which one is value? Probably you meant
status?

> +
> +		value = mc_readl(mc, int_mc_errors[bit].status_reg);
> +
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +		if (mc->soc->num_address_bits > 32) {
> +			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
> +				MC_ERR_STATUS_ADR_HI_MASK);
> +			addr <<= 32;
> +		}
> +#endif
> +		addr |= mc_readl(mc, int_mc_errors[bit].addr_reg);
> +
> +		if (value & MC_ERR_STATUS_RW)
> +			direction = "write";
> +		else
> +			direction = "read";
> +
> +		if (value & MC_ERR_STATUS_SECURITY)
> +			secure = "secure ";
> +		else
> +			secure = "";
> +
> +		id = value & mc->soc->client_id_mask;
> +
> +		for (i = 0; i < mc->soc->num_clients; i++) {
> +			if (mc->soc->clients[i].id == id) {
> +				client = mc->soc->clients[i].name;
> +				break;
> +			}
> +		}
> +
> +		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s\n",
> +				    client, secure, direction, &addr, error);
> +	}
> +
> +	/* clear interrupts */
> +	mc_writel(mc, status, MC_INTSTATUS);> +
> +	return IRQ_HANDLED;

I don't think you are actually handling these errors as stated in commit
message. You only log them. Please adjust the commit subject and message
to mention the actual purpose/action of error handling.

> +}
> +
>  const struct tegra_mc_interrupt_ops tegra186_mc_interrupt_ops = {
>  	.clear_interrupt = tegra186_mc_clear_interrupt,
> +	.handle_irq = tegra186_mc_handle_irq,
>  };
>  
>  const struct tegra_mc_ops tegra186_mc_ops = {
> @@ -886,6 +985,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
>  	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
>  	.clients = tegra186_mc_clients,
>  	.num_address_bits = 40,
> +	.client_id_mask = 0xff,
>  	.intmask = MC_INT_WCAM_ERR | MC_INT_SCRUB_ECC_WR_ACK |
>  		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
>  		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
> 



Best regards,
Krzysztof
