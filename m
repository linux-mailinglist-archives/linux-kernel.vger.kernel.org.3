Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3045880B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiHBRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiHBRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:02:37 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04102E9F7;
        Tue,  2 Aug 2022 10:02:34 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id o2so11084110iof.8;
        Tue, 02 Aug 2022 10:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0574V06d4DveCOys7RsnN5l2UlxXC7328YWoYfFQnSM=;
        b=qcKOrFSeDZK0NgWKsLiuRHjKHSGxy7P7Yu7KcIbl5zPDxyaWE6SW9socfPfAXdgSVI
         beGJQEW4oPf+hrfwnNTA7srY1mHo1r6dfvHObeIu41auXZYhgmCq2Dx+x9BCUiA52yVV
         VXa8LvPgD736LizH/M+J2v89kWVGNJ0AYwP0s5ly28FWjz3yNtGA9Orqd83fJcWwWcoX
         7XdmE87cpwoSeY4IngyE/W5GoF+4Ky4NTIER4Qmh75NE/USa3u0/VlRzl4PqAoB00PcE
         +jY5OJ2V7/KdT7wsZezOnPW0qCSucTp8U9mAje/7l5B14pIlIVUZObz2rILYCTKK/mkJ
         CQ1g==
X-Gm-Message-State: AJIora/sfjPvPpK2yFE6K177AoltUwLoKO/gB7nr1oNjjZ2tGGttImwG
        TaRYl5K/u+qpA3Pf46YnBQ==
X-Google-Smtp-Source: AGRyM1s18wdUJAam3DTxeqhloATZSlewRzhbV3ZnSE3O1/2Mo0z69lxMSUjKhD9vcc3Nre0Ez9a1mA==
X-Received: by 2002:a05:6602:29d1:b0:669:428e:8c59 with SMTP id z17-20020a05660229d100b00669428e8c59mr7584524ioq.85.1659459753890;
        Tue, 02 Aug 2022 10:02:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b15-20020a026f4f000000b003427f2c25b7sm471289jae.68.2022.08.02.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:02:33 -0700 (PDT)
Received: (nullmailer pid 296764 invoked by uid 1000);
        Tue, 02 Aug 2022 17:02:30 -0000
Date:   Tue, 2 Aug 2022 11:02:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Michael Klein <michael@fossekall.de>,
        David Heidelberg <david@ixit.cz>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Purism Kernel Team <kernel@puri.sm>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Matheus Castello <matheus@castello.eng.br>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        David Lechner <david@lechnology.com>,
        Hector Martin <marcan@marcan.st>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] dt-bindings: power: supply: drop quotes when not
 needed
Message-ID: <20220802170230.GC279692-robh@kernel.org>
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
 <20220726115748.101015-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726115748.101015-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 13:57:48 +0200, Krzysztof Kozlowski wrote:
> Id and schema fields do not need quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/supply/active-semi,act8945a-charger.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq2415x.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq24257.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq24735.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq2515x.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq256xx.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq25890.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq25980.yaml   | 4 ++--
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml   | 4 ++--
>  .../devicetree/bindings/power/supply/cpcap-battery.yaml       | 4 ++--
>  .../devicetree/bindings/power/supply/cpcap-charger.yaml       | 4 ++--
>  .../devicetree/bindings/power/supply/dlg,da9150-charger.yaml  | 4 ++--
>  .../bindings/power/supply/dlg,da9150-fuel-gauge.yaml          | 4 ++--
>  .../devicetree/bindings/power/supply/ingenic,battery.yaml     | 4 ++--
>  Documentation/devicetree/bindings/power/supply/isp1704.yaml   | 4 ++--
>  .../devicetree/bindings/power/supply/lego,ev3-battery.yaml    | 4 ++--
>  .../devicetree/bindings/power/supply/lltc,lt3651-charger.yaml | 4 ++--
>  .../devicetree/bindings/power/supply/lltc,ltc294x.yaml        | 4 ++--
>  Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml | 4 ++--
>  .../devicetree/bindings/power/supply/maxim,ds2760.yaml        | 4 ++--
>  .../devicetree/bindings/power/supply/maxim,max14656.yaml      | 4 ++--
>  .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 4 ++--
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 ++--
>  .../devicetree/bindings/power/supply/maxim,max8903.yaml       | 4 ++--
>  .../devicetree/bindings/power/supply/nokia,n900-battery.yaml  | 4 ++--
>  .../devicetree/bindings/power/supply/olpc-battery.yaml        | 4 ++--
>  .../devicetree/bindings/power/supply/power-supply.yaml        | 4 ++--
>  .../bindings/power/supply/richtek,rt5033-battery.yaml         | 4 ++--
>  .../devicetree/bindings/power/supply/richtek,rt9455.yaml      | 4 ++--
>  .../devicetree/bindings/power/supply/sc2731-charger.yaml      | 4 ++--
>  Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml | 4 ++--
>  .../bindings/power/supply/stericsson,ab8500-btemp.yaml        | 4 ++--
>  .../bindings/power/supply/stericsson,ab8500-chargalg.yaml     | 4 ++--
>  .../bindings/power/supply/stericsson,ab8500-charger.yaml      | 4 ++--
>  .../bindings/power/supply/stericsson,ab8500-fg.yaml           | 4 ++--
>  .../bindings/power/supply/summit,smb347-charger.yaml          | 4 ++--
>  .../devicetree/bindings/power/supply/tps65090-charger.yaml    | 4 ++--
>  .../devicetree/bindings/power/supply/tps65217-charger.yaml    | 4 ++--
>  .../devicetree/bindings/power/supply/twl4030-charger.yaml     | 4 ++--
>  .../power/supply/x-powers,axp20x-ac-power-supply.yaml         | 4 ++--
>  .../power/supply/x-powers,axp20x-battery-power-supply.yaml    | 4 ++--
>  .../power/supply/x-powers,axp20x-usb-power-supply.yaml        | 4 ++--
>  43 files changed, 86 insertions(+), 86 deletions(-)
> 

Applied, thanks!
