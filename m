Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D874E3044
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352327AbiCUSzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiCUSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:54:59 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E401E3CF;
        Mon, 21 Mar 2022 11:53:32 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w127so17187695oig.10;
        Mon, 21 Mar 2022 11:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a7Xyf2QArSyizp0F9X7a7N1r4113OGPHtnk41fQc9lc=;
        b=aV2yM1r0WWvSwXYRBg7uM6+gGIxDQVX11JTcT1uxi9UfjB48Z7GE83boFwsXca1wk8
         rQJVucvUgZP9gEQo7lSBwkD93xrceFN4lLasU0bY8mn6A3sCiwnXUva8lrhiEeJQnQqj
         FMV5qxI7t0rwcmInMvFcavIz2+NjXy05f2fXp7pxI/DmxB/0edXZDgIpFYXEI5hqNcqG
         eB8LEtS9SbEiaLOHGEkr7wTgf8yre6luXN3TGKOHHWgBHZrBhWBdSppPvPvegu1dBOCs
         zlDrx450R7YehlhFGlJqfcU8PfxCnjOy0PH4MEkipfS0q3HdCh2URu5JO3j1KKg/imKi
         V0Ew==
X-Gm-Message-State: AOAM531JQuLjXDk3QH9enP9s1KMfX3DI1g4NM1GhGJCbqBKLTzk4cAkL
        toWoYWhGK2Y0lKaGfjO13A==
X-Google-Smtp-Source: ABdhPJym1cVJ6hIiuqEDxMhZRQrspeqqkZR5PA/kFVaC8hdwQ5SdvwfkufWH3kcX6wu+LcnGMs9IxQ==
X-Received: by 2002:a05:6808:f88:b0:2da:850d:18f0 with SMTP id o8-20020a0568080f8800b002da850d18f0mr270615oiw.19.1647888810502;
        Mon, 21 Mar 2022 11:53:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d63c8000000b005b235a56831sm7783461otl.49.2022.03.21.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:53:29 -0700 (PDT)
Received: (nullmailer pid 359469 invoked by uid 1000);
        Mon, 21 Mar 2022 18:53:27 -0000
Date:   Mon, 21 Mar 2022 13:53:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Subject: Re: [PATCH 00/18] dt-bindings: irqchip: include generic schema
Message-ID: <YjjJpxLWJ/YOe0OX@robh.at.kernel.org>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:55:24PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> The DTS patches can be picked up independently.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (18):
>   ARM: dts: nspire: use lower case hex addresses in node unit addresses
>   ARM: dts: ox820: align interrupt controller node name with dtschema
>   ARM: dts: socfpga: align interrupt controller node name with dtschema
>   dt-bindings: irqchip: actions,owl-sirq: include generic schema
>   dt-bindings: irqchip: fsl: include generic schema
>   dt-bindings: irqchip: ingenic: include generic schema
>   dt-bindings: irqchip: intel,ixp4xx: include generic schema
>   dt-bindings: irqchip: kontron,sl28cpld: include generic schema
>   dt-bindings: irqchip: loongson: include generic schema
>   dt-bindings: irqchip: microchip,eic: include generic schema
>   dt-bindings: irqchip: mrvl,intc: include generic schema
>   dt-bindings: irqchip: mstar,mst-intc: include generic schema
>   dt-bindings: irqchip: mti,gic: include generic schema
>   dt-bindings: irqchip: nuvoton,wpcm450-aic: include generic schema
>   dt-bindings: irqchip: realtek,rtl-intc: include generic schema
>   dt-bindings: irqchip: renesas: include generic schema
>   dt-bindings: irqchip: sifive: include generic schema
>   dt-bindings: irqchip: ti: include generic schema

I'm somewhat on the fence about these. Originally only devices with a 
bus or child nodes included a common schema. For 'simple' providers 
with mainly a '#<provider>-cells' property, we had to set the 
constraints on the number of cells anyways, so referencing another 
schema doesn't save anything. It is nice to declare the 'class' of the 
device though.

It makes the schema be applied twice (if the node name matches). That's 
not all bad because it finds cases of wrong node name. However, 
sometimes we have devices which are multiple providers and can't set the 
node name. So those can't reference interrupt-controller.yaml.

It also means that 'interrupt-map' for example is now valid. That could 
be fixed by splitting 'interrupt-map' related properties to its own 
schema. 

Rob
