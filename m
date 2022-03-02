Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFA4CAEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiCBTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiCBTpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:45:09 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7302CA0DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:44:24 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 96F9B3F609
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646250263;
        bh=CXgP08C1PuFq4bqpjNjFmw31qLuU1W2/XX2cgUb+4wc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ReaNoNkZPHpbDnlCJb8wdbhj7vA9g0We8sf6i4wYTFmJTehsAlJVK+utKO2MNZ8wu
         MSIYT2JiVykvc2YU85iB/59PF2lRDxmpcbJ8xSiNJ/DOGt/HA6scoKRrlb53/l5V8O
         KR11Ix7mvZSFjv05Wa94kvaAxFkTZRIssVapA31snbA9jgZ3NICwnzcuDFlTxZI+FN
         wI0bESjkQPdD0Uogase46Vg9u2O7Q1bWK2MwP9bMu9G9JEdfrGLbIrIXntcIo3pGxF
         Plcfjg26f/tPhteP5ElSI0qzF/9XWR8kmt7kednP+HI3vYEbVmf0kEuBe3DnBIGeL2
         VjnPcnbeUxabw==
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1504595ejk.16
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CXgP08C1PuFq4bqpjNjFmw31qLuU1W2/XX2cgUb+4wc=;
        b=1cu3RDWC/smkbMGNrtGrVYFDoRcKchupPNspY60LFLdo0a0j7tkWPCrRF2ax0DNaXI
         qvqYrJ2Zmz28UMsGfz3g0XGLMh56KaledAUsuwPwm7PCFVa36iHXtL+sYpHsr7BK7BTI
         vA9x/ByRyU/XwhI+If7tSZG5J8A5kbSphJskUqn5w493OwUuo/SgWF5LUydx4HPJGbkO
         h08w9Od1qAhNhBMu0GsoCsZoT1Mh2uuOiuE7xpuEylZ35Kn/iAHfTJI62pj1MQ/A3rOp
         jQJAAujzPY9p/TpJAUl2jG96jF7eET77E+M4D6hiCOdjzeeP7xUUbGf++v0g7h+bwJ9T
         tZAg==
X-Gm-Message-State: AOAM531UjPQdyujo0wEGe71glNJPXWTy+jDqRbejXfKnrA9FkVVgy6fo
        64+/UZKLa6T+ISmv087ASVkmISDprN8a65QBjjiujDLYIp+yJpHTRuxAqJrEl1ihTifZJlbLBUL
        PMCnlugTriwMT7P/aFVRjSnJvP2ZfziWs4o6JT9NI4A==
X-Received: by 2002:a17:906:7056:b0:6d6:dd99:f2a4 with SMTP id r22-20020a170906705600b006d6dd99f2a4mr9253741ejj.43.1646250263270;
        Wed, 02 Mar 2022 11:44:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeddp5OV+Flh+0Pd77oYKfgd5Yl2rsTAbN/GiVUOQXPIPUCAJzYFwH4LA4d4WjKVxsccE4rQ==
X-Received: by 2002:a17:906:7056:b0:6d6:dd99:f2a4 with SMTP id r22-20020a170906705600b006d6dd99f2a4mr9253733ejj.43.1646250263033;
        Wed, 02 Mar 2022 11:44:23 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id y12-20020a50eb8c000000b00410f02e577esm9138825edr.7.2022.03.02.11.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:44:22 -0800 (PST)
Message-ID: <72fafc84-4986-926f-67ae-155f4fced88b@canonical.com>
Date:   Wed, 2 Mar 2022 20:44:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-5-git-send-email-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646210609-21943-5-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 09:43, Ashish Mhetre wrote:
> Add new function 'get_int_channel' in tegra_mc_soc struture which is
> implemented by tegra SOCs which support multiple MC channels. This
> function returns the channel which should be used to get the information
> of interrupts.
> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
> Add error specific MC status and address register bits and use them on
> tegra186, tegra194 and tegra234.
> Add error logging for generalized carveout interrupt on tegra186, tegra194
> and tegra234.
> Add error logging for route sanity interrupt on tegra194 an tegra234.
> Add register for higher bits of error address which is available on
> tegra194 and tegra234.
> Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
> will be true if soc has register for higher bits of memory controller
> error address. Set it true for tegra194 and tegra234.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       | 102 ++++++++++++++++++++++++++++++++++------
>  drivers/memory/tegra/mc.h       |  37 ++++++++++++++-
>  drivers/memory/tegra/tegra186.c |  45 ++++++++++++++++++
>  drivers/memory/tegra/tegra194.c |  44 +++++++++++++++++
>  drivers/memory/tegra/tegra234.c |  59 +++++++++++++++++++++++
>  include/soc/tegra/mc.h          |   4 ++
>  6 files changed, 275 insertions(+), 16 deletions(-)
> 

(...)

>  
> +static int tegra186_mc_get_channel(struct tegra_mc *mc, int *mc_channel)
> +{
> +	u32 g_intstatus;
> +
> +	g_intstatus = mc_ch_readl(mc, MC_BROADCAST_CHANNEL,
> +				  MC_GLOBAL_INTSTATUS);
> +
> +	switch (g_intstatus & mc->soc->int_channel_mask) {
> +	case BIT(0):
> +		*mc_channel = 0;
> +		break;
> +
> +	case BIT(1):
> +		*mc_channel = 1;
> +		break;
> +
> +	case BIT(2):
> +		*mc_channel = 2;
> +		break;
> +
> +	case BIT(3):
> +		*mc_channel = 3;
> +		break;
> +
> +	case BIT(24):
> +		*mc_channel = MC_BROADCAST_CHANNEL;
> +		break;
> +
> +	default:
> +		pr_err("Unknown interrupt source\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  const struct tegra_mc_soc tegra186_mc_soc = {
>  	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
>  	.clients = tegra186_mc_clients,
>  	.num_address_bits = 40,
>  	.num_channels = 4,
> +	.client_id_mask = 0xff,
> +	.intmask = MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
> +		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
> +		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
>  	.ops = &tegra186_mc_ops,
> +	.int_channel_mask = 0x100000f,
> +	.get_int_channel = tegra186_mc_get_channel,
>  };
>  #endif
> diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
> index 9400117..bc16567 100644
> --- a/drivers/memory/tegra/tegra194.c
> +++ b/drivers/memory/tegra/tegra194.c
> @@ -1343,10 +1343,54 @@ static const struct tegra_mc_client tegra194_mc_clients[] = {
>  	},
>  };
>  
> +static int tegra194_mc_get_channel(struct tegra_mc *mc, int *mc_channel)

Looks like 'mc' could be a pointer to const.

> +{
> +	u32 g_intstatus;

Variable name just "status" because it looks like some
hungarian-notation-style...

The same in other places like this.


Best regards,
Krzysztof
