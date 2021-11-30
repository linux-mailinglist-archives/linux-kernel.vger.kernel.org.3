Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75F9464157
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbhK3Wfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:35:52 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42941 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbhK3Wfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:35:45 -0500
Received: by mail-oi1-f178.google.com with SMTP id n66so44278252oia.9;
        Tue, 30 Nov 2021 14:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5VC1NUcRNmVkUe9aAqXUwItF46vc+5pXXUf2XO/SoU=;
        b=CooOb+7N1pWDghI6IdmDu9naCHI/4LhjqxF7auQdBpS5nzuRoF3ALzUIAorAxCcrSD
         Grmk1yC2S48F6nHKw258skk4fww+r0f9lqObZ/RFr0rj2kjVNuEuSNS46tjz0/pw0tx3
         CChtdElkUFkmIKwbfvMjrWol5H9JJco/VB/MY9e/+bbNyyH72EzFnBFT3pf+Vl1dvajP
         sJZs++KlNONaYMMGJFhO7NOgvVVI6jY/8FZysJfrplte16VSlHeYTBjqvx+hwDoH0Kat
         Utm+jNIqtkL8/3ntfJ/ley7Ds1TUICOpWd8UusGAheyg68+oEpfQq93hPq1+a510wYgJ
         BZrw==
X-Gm-Message-State: AOAM533c4UPq8w3Rex9iF9MKuveBIjw3omPYZYXvM7sL67irBb9KwPtJ
        Cx5Tl7z037uKVw7LoMYnKA==
X-Google-Smtp-Source: ABdhPJzpBw6bDRVIdzvV2nbva5LK1vnrxKP22uuRmjtcMZj1eXaXLHNb+Q6Zlq/TdVQt6+KI/44i4Q==
X-Received: by 2002:aca:1b15:: with SMTP id b21mr2000925oib.64.1638311544918;
        Tue, 30 Nov 2021 14:32:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r22sm3901040oij.36.2021.11.30.14.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:32:24 -0800 (PST)
Received: (nullmailer pid 3130635 invoked by uid 1000);
        Tue, 30 Nov 2021 22:32:23 -0000
Date:   Tue, 30 Nov 2021 16:32:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC v3 07/12] dt-bindings: gpio: Add hardware-timestamp-engine
 property
Message-ID: <Yaamd11lUfjnhCbz@robh.at.kernel.org>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-8-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123193039.25154-8-dipenp@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:30:34AM -0800, Dipen Patel wrote:
> Some GPIO controllers can timestamp GPIO lines in real time using
> hardware timestamp engine. The optional property is added to facilitate
> this feature.
> 
> The nvidia GPIO controller has hardware timestamp engine as a backend
> to timestamp its GPIO lines in a real time. This change set adds
> hardware-timestamp-engine property to reflect that fact.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio.txt           | 8 ++++++++
>  .../devicetree/bindings/gpio/nvidia,tegra186-gpio.txt     | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
> index a8895d339bfe..c6ae2eaf5762 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -167,6 +167,13 @@ left to right from the passed array. An incomplete array (where the number
>  of passed named are less than ngpios) will still be used up until the last
>  provided valid line index.
>  
> +Optionally, a GPIO controller may have a "hardware-timestamp-engine" property.
> +This specifies the timestamp engine node. The property is only useful if the
> +hardware timestamp engine (HTE) serves as a back-end to support hardware
> +timestamp GPIO lines in a real time and GPIO controller has dependency on the
> +engine. It will be up to GPIO controller and HTE provider drivers to figure out
> +the mapping between GPIO controller and HTE namespaces of a given GPIO line.

This needs to be added to schema instead (in dtschema).

I find the 'hardware-' part to be redundant. What other type of 
timestamp engine are we going to have in the h/w description?

> +
>  Example:
>  
>  gpio-controller@00000000 {
> @@ -180,6 +187,7 @@ gpio-controller@00000000 {
>  		"LED G", "LED B", "Col A", "Col B", "Col C", "Col D",
>  		"Row A", "Row B", "Row C", "Row D", "NMI button",
>  		"poweroff", "reset";
> +	hardware-timestamp-engine = <&hadrware_ts_engine_node>;
>  }
>  
>  The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
> diff --git a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> index adff16c71d21..20f6c9e69839 100644
> --- a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> @@ -127,6 +127,12 @@ Required properties:
>              - 8: Active low level-sensitive.
>              Valid combinations are 1, 2, 3, 4, 8.
>  
> +Optional properties:
> +- hardware-timestamp-engine
> +    AON GPIO controller has timestamp engine which can hardware timestamp
> +    GPIO configured as input and IRQ. This property specifies hardware
> +    timestamp engine (HTE) device-tree node.
> +
>  Example:
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -162,4 +168,5 @@ gpio@c2f0000 {
>  	#gpio-cells = <2>;
>  	interrupt-controller;
>  	#interrupt-cells = <2>;
> +	hardware-timestamp-engine = <&tegra_hte_aon>;
>  };
> -- 
> 2.17.1
> 
> 
