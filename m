Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6795880AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiHBRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiHBRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:02:27 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB21F607;
        Tue,  2 Aug 2022 10:02:25 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id h145so11082451iof.9;
        Tue, 02 Aug 2022 10:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zd2vKlsbpX4kSUurJItYz1iOedbxqkmyfZZ+qbhotp4=;
        b=wfci4/5SssFggsyoNnMDTCplWz+DDp1dWEIkvNxls5oRE9PY8rW8J/mgRDGGYA8kcS
         TvAzYemmaQ8iOD0ZCOggltY4vCkRvzWrOS0x8vAHaDE2JhgDpLWF6rlQxBFxrcvWnPQ/
         IN/Lkq6FmsflmdrLA0vZ34Q34SpR4Sv0AnDOGsWsZjJ39iN+1pBdP09PFEAJ2FBl3MSN
         n12lqdFSFSGwnnsF/bcZ+s925M6NJERdwVcr3dQfBk8m9+e/DhS9FHEx2C5Hie4rnjkf
         /tnBCmJvrrB5Ebq7xBRyTqzwN1o9eldZHPNX28IIKl9Gf7X0rCIthN0t17so5ppuFutA
         GIvQ==
X-Gm-Message-State: AJIora+MBoVcfQp3zZPlsVWFY7tY775Mf6pkVMc/a0Xie/nu6EUHYgRS
        RXqjIC5iBANm35KwhLus6w==
X-Google-Smtp-Source: AGRyM1svEWFBOHGvFaTQr5tLMFsgPS+M1FKnnU2ObSjmb7UeBz5CbIEByI/m2ubKaDbg7SO8wQ2fMA==
X-Received: by 2002:a05:6638:3010:b0:341:dda0:dcc5 with SMTP id r16-20020a056638301000b00341dda0dcc5mr8246995jak.210.1659459744832;
        Tue, 02 Aug 2022 10:02:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w28-20020a02b0dc000000b00342781cfd1fsm2347709jah.15.2022.08.02.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:02:24 -0700 (PDT)
Received: (nullmailer pid 296519 invoked by uid 1000);
        Tue, 02 Aug 2022 17:02:21 -0000
Date:   Tue, 2 Aug 2022 11:02:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        "Andrew F. Davis" <afd@ti.com>,
        David Lechner <david@lechnology.com>,
        Hector Martin <marcan@marcan.st>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Michael Klein <michael@fossekall.de>,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-arm-kernel@lists.infradead.org, Dan Murphy <dmurphy@ti.com>,
        linux-amlogic@lists.infradead.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Tony Lindgren <tony@atomide.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-pm@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Sebastian Reichel <sre@kernel.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sven Peter <sven@svenpeter.dev>,
        Artur Rojek <contact@artur-rojek.eu>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: drop quotes when not needed
Message-ID: <20220802170221.GA279692-robh@kernel.org>
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Tue, 26 Jul 2022 13:57:46 +0200, Krzysztof Kozlowski wrote:
> Id and schema fields do not need quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 4 ++--
>  .../devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml     | 4 ++--
>  .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml        | 2 +-
>  .../devicetree/bindings/power/brcm,bcm63xx-power.yaml         | 4 ++--
>  Documentation/devicetree/bindings/power/renesas,apmu.yaml     | 4 ++--
>  .../devicetree/bindings/power/renesas,rcar-sysc.yaml          | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 

Applied, thanks!
