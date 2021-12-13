Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93942473611
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbhLMUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:37:23 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37729 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbhLMUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:37:22 -0500
Received: by mail-oi1-f182.google.com with SMTP id bj13so24788945oib.4;
        Mon, 13 Dec 2021 12:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgfptJ9Nc5V7IoyX3trjYNyQOy+R5xm/7NE8jjO7OEA=;
        b=A+7A8e7+X4eKMs8NI1gbybdxm308BK7IwKilQmoBnTzZtl+SDoxun+Gr7X58uAEz4T
         xAjqtnWmMG4c+7WZOOevpvAOsmDs1D86OLUaXmdYkK3BwRShcWAsXXkK5qdkmOBE9eBL
         XCZaOvYe5zsNGy0pqj5hiPvsjU7MeLs3PFNo76zHtK8V7GaXc2CITxncIDC0yPXnm8HZ
         zSRafWzkdLChC2xdU+oSC20hNxMYn1HUG9FNCMBpnU3GOF2UR70fq5OzXs2taOqWSy6U
         afZmY5aNZ1jfoHFXkt7IGWmynP645aZnwWBL58ACQ4ANn1/jCTT9J+DUnE5BD3SMUz0J
         fBcA==
X-Gm-Message-State: AOAM530QcjucT2C1s6EXywsEFfqPTOZdSzg0W/UfLn9AUtZMRy2gpYUv
        DCFI6sHNKJji+xoc9Mb4Ny1xT3z9Vw==
X-Google-Smtp-Source: ABdhPJxRGFl7/TuYODUdC0OyJhloj38Cvr/IgqWq5bUIDnUkSaz8Q/Vd7zdWNvdsGQ+H/NDCpJzSSA==
X-Received: by 2002:a05:6808:20a5:: with SMTP id s37mr28661250oiw.127.1639427841508;
        Mon, 13 Dec 2021 12:37:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d8sm2915081oiw.24.2021.12.13.12.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:37:20 -0800 (PST)
Received: (nullmailer pid 1529335 invoked by uid 1000);
        Mon, 13 Dec 2021 20:37:19 -0000
Date:   Mon, 13 Dec 2021 14:37:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
        tony@atomide.com
Subject: Re: [PATCH 3/4] ASoC: fsl-asoc-card: Add optional dt property for
 setting mclk-id
Message-ID: <Ybeu/1vsUzvAg2Ya@robh.at.kernel.org>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
 <20211203134930.128703-4-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203134930.128703-4-ariel.dalessandro@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:49:29AM -0300, Ariel D'Alessandro wrote:
> Sound cards may allow using different main clock inputs. In the generic
> fsl-asoc-card driver, these values are hardcoded for each specific card
> configuration.
> 
> Let's make it more flexible, allowing setting mclk-id from the
> device-tree node. Otherwise, the default value for each card
> configuration is used.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 1 +
>  sound/soc/fsl/fsl-asoc-card.c                             | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> index 23d83fa7609f..b219626a5403 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -82,6 +82,7 @@ Optional properties:
>    - dai-format		: audio format, for details see simple-card.yaml.
>    - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
>    - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
> +  - mclk-id		: main clock id, specific for each card configuration.

Ahh, there it is. This change and the header defines should be 1 patch 
and driver changes another.

>  
>  Optional unless SSI is selected as a CPU DAI:
>  
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 90cbed496f98..bb962e04d40b 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -693,6 +693,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  		goto asrc_fail;
>  	}
>  
> +	/*
> +	 * Allow setting mclk-id from the device-tree node. Otherwise, the
> +	 * default value for each card configuration is used.
> +	 */
> +	of_property_read_u32(np, "mclk-id", &priv->codec_priv.mclk_id);
> +
>  	/* Format info from DT is optional. */
>  	snd_soc_daifmt_parse_clock_provider_as_phandle(np, NULL, &bitclkprovider, &frameprovider);
>  	if (bitclkprovider || frameprovider) {
> -- 
> 2.30.2
> 
> 
