Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62784CAED3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbiCBTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiCBTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:36:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D531D8859
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:36:00 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 539343F1B3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249759;
        bh=5wyQTLndbR1770shQ9vCiiUodd9jZDMmW24GTz8q7QA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PGinYwWn+mcuW1mCvYCn2S99SlZjE3nFQuJKhFZkygtIIju0Zk01xZY2onyBbURTc
         JELkj2a2JHXRnMSecZTh7XdJkdhX8e3+mdaXemQ5LS3XTSPYPqQ6P6nSD7bA22rd/H
         ze9Wu+9gFNUpe8PSFvevc0ZaC9L1pThJrcVlhSfwgMe3xBguTs2wE8koSzzOCh5Hm/
         nQI59eiFSrFAFIbRmuiRFd6C9PE+rNopOpxlB0iuayyWeUTTplRtP7D1wD+a3uG/x9
         r+vq3rMUdvj7l8MsWqY/nMK2JzzDXUem27/T61RihMnDxXMjztEQ8xl8JRN0mLfTku
         5G72e7v/hwKHA==
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so1491347ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5wyQTLndbR1770shQ9vCiiUodd9jZDMmW24GTz8q7QA=;
        b=21mKEoFja+9Et2c2znIfuxLIJUChls1/HR4Ox/hTU4NI3ip77xoYmVboiciRVNliUu
         57luZnvwYW//tJiqtaJ99HZ/KH/cod/OhkQdzbfmrSXG9F51GLCjdBU0uamgPLFnuKo7
         OEeYAS+P5pT0NSvtCcq+mwNXbz+ixgc1cr7y4sxt/4CDAyP9uc6Gloq8i4dNXFQNqgGo
         9TypDetuWnqBob0Ofg8i6LWjdifhiZ7BNEDREOUhmSdb7rVEcDk5YHyxQOnjXYpjpjTL
         IU742Dh+bbKo+5Hnh5u4H8hqsk61JOws9X8GWmIGM7f1sEkC2SrKqryvUsuSO2KzWZ8H
         l0tg==
X-Gm-Message-State: AOAM533hypt/h8Tc27aEx89cTA7nOka6lY+alY3f3IJDN7S0v5SiW3ns
        bkZIY600bIdQ0mVtyO00PIxvs83I3fvYX0GS+ffrAw9fo7l8YrvV60A+bBQvPPnnfuAAQMd9nTE
        7oIgiD+sWItnrGM25g7H9rgNOOD0Rf/DpTawOGI+gEw==
X-Received: by 2002:a05:6402:53:b0:415:c610:168e with SMTP id f19-20020a056402005300b00415c610168emr2734107edu.291.1646249759040;
        Wed, 02 Mar 2022 11:35:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOzefDrgrOFqNbJ++xpGQo0pnJymI1R6/pv/xxsa1NzVv+OV2Y/dASa6qdp76/GQwLpz98Vw==
X-Received: by 2002:a05:6402:53:b0:415:c610:168e with SMTP id f19-20020a056402005300b00415c610168emr2734085edu.291.1646249758878;
        Wed, 02 Mar 2022 11:35:58 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm6677084ejb.194.2022.03.02.11.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:35:58 -0800 (PST)
Message-ID: <34646ebd-2c37-65ec-ecfe-cfbfa4bd29d2@canonical.com>
Date:   Wed, 2 Mar 2022 20:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v4 3/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-4-git-send-email-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646210609-21943-4-git-send-email-amhetre@nvidia.com>
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
> From tegra186 onwards, memory controller support multiple channels.
> Add support for mapping address spaces of these channels.
> During error interrupts from memory controller, appropriate registers
> from these channels need to be accessed for logging error info.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       |  6 ++++++
>  drivers/memory/tegra/tegra186.c | 21 +++++++++++++++++++++
>  drivers/memory/tegra/tegra194.c |  1 +
>  drivers/memory/tegra/tegra234.c |  1 +
>  include/soc/tegra/mc.h          |  7 +++++++
>  5 files changed, 36 insertions(+)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index bf3abb6..3cda1d9 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
>  	if (IS_ERR(mc->regs))
>  		return PTR_ERR(mc->regs);
>  
> +	if (mc->soc->ops && mc->soc->ops->map_regs) {
> +		err = mc->soc->ops->map_regs(mc, pdev);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	mc->debugfs.root = debugfs_create_dir("mc", NULL);
>  
>  	if (mc->soc->ops && mc->soc->ops->probe) {
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 3d15388..59a4425 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -139,11 +139,31 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>  	return 0;
>  }
>  
> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
> +				struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int i;
> +
> +	mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> +	if (IS_ERR(mc->mcb_regs))
> +		return PTR_ERR(mc->mcb_regs);
> +
> +	for (i = 0; i < mc->soc->num_channels; i++) {
> +		mc->mc_regs[i] = devm_platform_get_and_ioremap_resource(pdev, i + 2, &res);
> +		if (IS_ERR(mc->mc_regs[i]))
> +			return PTR_ERR(mc->mc_regs[i]);

This breaks the ABI, so I need Thierry's ack that such ABI break is
perfectly ok.

> +	}
> +
> +	return 0;
> +}
> +


Best regards,
Krzysztof
