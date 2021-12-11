Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C52471384
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhLKK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:56:16 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57368 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhLKK4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:56:15 -0500
Received: from ip4d17a2ab.dynamic.kabel-deutschland.de ([77.23.162.171] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mw02p-0007zm-NW; Sat, 11 Dec 2021 11:55:59 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        - <opensource@rock-chips.com>, David Heidelberg <david@ixit.cz>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: convert power domain node for rockchip DW MIPI DSI
Date:   Sat, 11 Dec 2021 11:55:58 +0100
Message-ID: <26502781.jAYDHVeSjN@diego>
In-Reply-To: <20211206212651.126405-1-david@ixit.cz>
References: <20211206212651.126405-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Am Montag, 6. Dezember 2021, 22:26:50 CET schrieb David Heidelberg:
> Convert into YAML format into format, which can be validated.
> 
> Changes:
>  - drop panel from example

the patch subject is strange, talking about a "power domain node".
That needs a fix.

Some more things below.


> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - rockchip,px30-mipi-dsi
> +              - rockchip,rk3288-mipi-dsi
> +              - rockchip,rk3399-mipi-dsi
> +          - const: snps,dw-mipi-dsi

> +      - items:
> +          - const: rockchip,px30-mipi-dsi
> +      - items:
> +          - const: rockchip,rk3288-mipi-dsi
> +      - items:
> +          - const: rockchip,rk3399-mipi-dsi

what are these for?

I see that px30 uses the dsi without the snps part, but you
can also just add a patch adding that second compatible to px30.dtsi

I don't think we need to support both ways.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks: true
> +
> +  clock-names: true
> +
> +  phys:
> +    maxItems: 1
> +    description: The external PHY

make that "Optional external PHY perhaps"?

Heiko


