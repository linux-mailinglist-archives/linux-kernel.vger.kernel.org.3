Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089C0493E05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356039AbiASQLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:11:38 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:45687 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbiASQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:11:37 -0500
Received: by mail-oo1-f44.google.com with SMTP id s13-20020a4aa38d000000b002e28c5100cbso865880ool.12;
        Wed, 19 Jan 2022 08:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qeGs2znfOYUJDV20djJhQbgb6BR7nof7Sr6XBdv7Rks=;
        b=zOkz3Zd1W3qu5Yz/cOCNiaiE0Stm26pM4ESpuPaCHrxjO9lZ47kEQIS/7nOY638F0L
         IAp4kTuh7wxjgdbLgOXzsbApB5Y78bKzQcHjZ03cGSS//Hcq/P8nVKsYYIDxxgwMvd9l
         0btxpPAV+V/J8sgZIXTvCo7NiGtMjOcIx1bq9zctq+0bnkxfeU7Vf+95P8DZzPWXV/5q
         iZPt7O5dp1VdOECMOcdu1FTeR5uQ119QuIr5vg2anVKzDJTyVkO8l5dv1wFVT3r4lStC
         JU6AgvxMMzT6YpUtxNOpMUTMVWgIWps8Suf1rYHxxj7pUNvAeIhhHXG39I7n/REiXzDh
         IF4g==
X-Gm-Message-State: AOAM532K05bH3H8Z5vh3fdNWIDx+9IvA6T3UOmcqLzO24eTcoM3U2xlD
        Dg2fnNtzKslyTzsCC230Lg==
X-Google-Smtp-Source: ABdhPJzI0d/xiZlJQGmn9s9YeQRGKDW0dZ/Xm2jNe7Av5k8UsWH1q5GQDLviqTYIHwryxVeRqKq4Ow==
X-Received: by 2002:a4a:d116:: with SMTP id k22mr18660045oor.80.1642608696519;
        Wed, 19 Jan 2022 08:11:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q15sm137490oiv.6.2022.01.19.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:11:35 -0800 (PST)
Received: (nullmailer pid 3681612 invoked by uid 1000);
        Wed, 19 Jan 2022 16:11:34 -0000
Date:   Wed, 19 Jan 2022 10:11:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Marek Belisko <marek@goldelico.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        devicetree@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        David Airlie <airlied@linux.ie>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dt-bindings: display: Add SPI peripheral schema to SPI
 based displays
Message-ID: <Yeg4NoFqgPIhbZov@robh.at.kernel.org>
References: <20211221125209.1195932-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221125209.1195932-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 08:52:09 -0400, Rob Herring wrote:
> With 'unevaluatedProperties' support enabled, several SPI based display
> binding examples have warnings:
> 
> Documentation/devicetree/bindings/display/panel/samsung,ld9040.example.dt.yaml: lcd@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
> Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 'spi-3wire' were unexpected)
> Documentation/devicetree/bindings/display/panel/ilitek,ili9322.example.dt.yaml: display@0: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.example.dt.yaml: display@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> Documentation/devicetree/bindings/display/panel/abt,y030xx067a.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> Documentation/devicetree/bindings/display/panel/sony,acx565akm.example.dt.yaml: panel@2: Unevaluated properties are not allowed ('spi-max-frequency', 'reg' were unexpected)
> Documentation/devicetree/bindings/display/panel/tpo,td.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
> Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('reg', 'spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
> Documentation/devicetree/bindings/display/panel/innolux,ej030na.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
> 
> Fix all of these by adding a reference to spi-peripheral-props.yaml.
> With this, the description that the binding must follow
> spi-controller.yaml is both a bit out of date and redundant, so remove
> it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This is dependent on spi-peripheral-props.yaml landing in 5.17-rc1.
> ---
>  .../devicetree/bindings/display/panel/abt,y030xx067a.yaml  | 5 +----
>  .../devicetree/bindings/display/panel/ilitek,ili9322.yaml  | 4 +---
>  .../devicetree/bindings/display/panel/innolux,ej030na.yaml | 5 +----
>  .../bindings/display/panel/kingdisplay,kd035g6-54nt.yaml   | 5 +----
>  .../bindings/display/panel/lgphilips,lb035q02.yaml         | 5 +----
>  .../devicetree/bindings/display/panel/samsung,ld9040.yaml  | 7 +------
>  .../devicetree/bindings/display/panel/samsung,s6e63m0.yaml | 1 +
>  .../bindings/display/panel/sitronix,st7789v.yaml           | 5 +----
>  .../devicetree/bindings/display/panel/sony,acx565akm.yaml  | 5 +----
>  .../devicetree/bindings/display/panel/tpo,td.yaml          | 5 +----
>  10 files changed, 10 insertions(+), 37 deletions(-)
> 

Applied, thanks!
