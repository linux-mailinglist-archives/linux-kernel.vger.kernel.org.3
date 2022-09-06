Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1A5AF71B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIFVlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIFVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:41:07 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFE85FD5;
        Tue,  6 Sep 2022 14:41:04 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1279948d93dso11677550fac.10;
        Tue, 06 Sep 2022 14:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ilmIFpp02DJKfy4hWzLv/HAXaykhKwVnxsnGzhzWDPs=;
        b=t89n0BoI8jHYYRDj4clcL4l3vIu2y0RD/v6tR54awi44jouFChCkTvPmqykArJ01fg
         5whFdvdYo7t6MQxkb7H4hjnl6RJ7iqasDf9/+2T8WAq/qJVb+nsCLWjkBvOAVEC3xXsu
         GRTBFXk3o+dqkbktXpwOBtcbXokGm7TTXFimeYJjfnwwFZthXEB7U3nKT80joU+b1TVF
         OUM/+gwLvitkWSwbmARl6KAyivYjSXYGvG8hmbG+BL76MZ3F84bbfnS4PvfZVGS953yV
         pP2k8PW+si1JWwiQloskMiaHSeR0MaN2bbKIE1Qd9YE422RoYpwGVGgyz47b55lNoAkn
         HoNA==
X-Gm-Message-State: ACgBeo0s9z31GubTv6jJzlrwfulmp1Exyy37cIYZeyKVG9sLPhfzS9mf
        m+HeMARwKPlkAxMDcVrTXQ==
X-Google-Smtp-Source: AA6agR4UWMyFrZbMkGxOO4Lkk8XCHTaOdRfOr3JUxL7bjDehDbVxUjjoDVSMOKm+4qcR7U3b0mAJtQ==
X-Received: by 2002:a05:6870:461a:b0:127:8ca9:21a7 with SMTP id z26-20020a056870461a00b001278ca921a7mr5043248oao.87.1662500463765;
        Tue, 06 Sep 2022 14:41:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i81-20020acaea54000000b00344aa3f17d9sm5881136oih.10.2022.09.06.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:41:02 -0700 (PDT)
Received: (nullmailer pid 1224961 invoked by uid 1000);
        Tue, 06 Sep 2022 21:41:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     mturquette@baylibre.com, jirislaby@kernel.org,
        richard.genoud@gmail.com, claudiu.beznea@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, radu_nicolae.pirea@upb.ro,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        broonie@kernel.org, kavyasree.kotagiri@microchip.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        linux-spi@vger.kernel.org, alexandre.belloni@bootlin.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        admin@hifiphile.com, linux-serial@vger.kernel.org, lee@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com
In-Reply-To: <20220906135511.144725-2-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com> <20220906135511.144725-2-sergiu.moga@microchip.com>
Subject: Re: [PATCH v2 01/13] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
Date:   Tue, 06 Sep 2022 16:41:00 -0500
Message-Id: <1662500460.128889.1224960.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Sep 2022 16:55:00 +0300, Sergiu Moga wrote:
> The DT nodes of the SPI IP's may contain DMA related properties so
> make sure that the binding is able to properly validate those as
> well by making it aware of these optional properties.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before
> 
> 
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


spi@400: dma-names:0: 'tx' was expected
	arch/arm/boot/dts/at91-sama7g5ek.dtb

spi@400: dma-names:1: 'rx' was expected
	arch/arm/boot/dts/at91-sama7g5ek.dtb

spi@400: Unevaluated properties are not allowed ('dma-names' was unexpected)
	arch/arm/boot/dts/at91-sama7g5ek.dtb

