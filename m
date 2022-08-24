Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0159FB59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiHXN1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiHXN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:27:01 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB416DAC8;
        Wed, 24 Aug 2022 06:27:00 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id r124so4018302oig.11;
        Wed, 24 Aug 2022 06:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ktGy9A9XV3SpXhrZvoOafpIvMXJDuPCUWT9oK6aEr9s=;
        b=LSyyL49u1RgDQKjqi9rSI6WeXguTgUijZXsZSOgIlubX0K87aYorLJbP/WMJeT8Xnm
         LOwbS5ShAmLR6u70Al5KMjJi3JsZmtYLWmeSjgqI/waEFTfrdwVpQ5TN/3LNsGABfO/F
         CLh8bfB5rESp2AD6x9LqZusWOEh+rwS9DHjCihrVCzTQFG6ocXKp0hQpQpvyeG72snGm
         K547v8XeWX6cTujq5MZTFU5FMBQPAPiBPneBaUTDVnuyNsY0YW/JkpdsmDv1/69NXgsS
         RDOY53mJuEhnDLAMKR5XGy3T4+F9RtCsFlooFpdG3nTCNc0wNRRzOZBM9eRHzzg6qQ+b
         Nf7A==
X-Gm-Message-State: ACgBeo0kQOMHZPxBK3ycASnr5UJD8JWa9MhGO2jwb0HuAFff7bTHgSOd
        ej4q29XQQiBGnxnGuy/m6h53SuVfWA==
X-Google-Smtp-Source: AA6agR5ms3ON8Vh/oDOST3Ke4xTn6XxSBGMAbAH3e9OGnQCwx420hXtmZVz7wI6Nr9p/dwomCjTgWg==
X-Received: by 2002:a54:4790:0:b0:343:46c5:9b8e with SMTP id o16-20020a544790000000b0034346c59b8emr3333571oic.251.1661347619386;
        Wed, 24 Aug 2022 06:26:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n128-20020aca4086000000b0034564365bf2sm1890725oia.17.2022.08.24.06.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:26:58 -0700 (PDT)
Received: (nullmailer pid 2098942 invoked by uid 1000);
        Wed, 24 Aug 2022 13:26:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com> <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
Date:   Wed, 24 Aug 2022 08:26:57 -0500
Message-Id: <1661347617.019832.2098941.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 11:43:24 +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


spi@e6c00000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-cat874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77970-eagle.dtb
	arch/arm64/boot/dts/renesas/r8a77970-v3msk.dtb
	arch/arm64/boot/dts/renesas/r8a77980-condor.dtb
	arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dtb
	arch/arm64/boot/dts/renesas/r8a77990-ebisu.dtb
	arch/arm64/boot/dts/renesas/r8a77995-draak.dtb
	arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb

spi@e6c10000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-cat874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77970-eagle.dtb
	arch/arm64/boot/dts/renesas/r8a77970-v3msk.dtb
	arch/arm64/boot/dts/renesas/r8a77980-condor.dtb
	arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dtb
	arch/arm64/boot/dts/renesas/r8a77990-ebisu.dtb
	arch/arm64/boot/dts/renesas/r8a77995-draak.dtb
	arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb

spi@e6c20000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb

spi@e6c28000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb

spi@e6c90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7742-iwg21d-q7.dtb
	arch/arm/boot/dts/r8a7790-lager.dtb
	arch/arm/boot/dts/r8a7790-stout.dtb

spi@e6c90000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm/boot/dts/sh73a0-kzm9g.dtb

spi@e6e00000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7742-iwg21d-q7.dtb
	arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb
	arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb
	arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7744-iwg20d-q7.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dtb
	arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb
	arch/arm/boot/dts/r8a7790-lager.dtb
	arch/arm/boot/dts/r8a7790-stout.dtb
	arch/arm/boot/dts/r8a7791-koelsch.dtb
	arch/arm/boot/dts/r8a7791-porter.dtb

spi@e6e00000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm/boot/dts/sh73a0-kzm9g.dtb

spi@e6e10000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7742-iwg21d-q7.dtb
	arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb
	arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb
	arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7744-iwg20d-q7.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dtb
	arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb
	arch/arm/boot/dts/r8a7790-lager.dtb
	arch/arm/boot/dts/r8a7790-stout.dtb
	arch/arm/boot/dts/r8a7791-koelsch.dtb
	arch/arm/boot/dts/r8a7791-porter.dtb
	arch/arm/boot/dts/r8a7792-blanche.dtb
	arch/arm/boot/dts/r8a7792-wheat.dtb

spi@e6e10000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm/boot/dts/sh73a0-kzm9g.dtb

spi@e6e20000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7742-iwg21d-q7.dtb
	arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb
	arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb
	arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dtb
	arch/arm/boot/dts/r8a7744-iwg20d-q7.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dtb
	arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb
	arch/arm/boot/dts/r8a7790-lager.dtb
	arch/arm/boot/dts/r8a7790-stout.dtb
	arch/arm/boot/dts/r8a7791-koelsch.dtb
	arch/arm/boot/dts/r8a7791-porter.dtb
	arch/arm/boot/dts/r8a7792-blanche.dtb
	arch/arm/boot/dts/r8a7792-wheat.dtb

spi@e6e20000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	arch/arm/boot/dts/sh73a0-kzm9g.dtb

spi@e6e90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-cat874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77970-eagle.dtb
	arch/arm64/boot/dts/renesas/r8a77970-v3msk.dtb
	arch/arm64/boot/dts/renesas/r8a77980-condor.dtb
	arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dtb
	arch/arm64/boot/dts/renesas/r8a77990-ebisu.dtb
	arch/arm64/boot/dts/renesas/r8a77995-draak.dtb
	arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb

spi@e6ea0000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-cat874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77970-eagle.dtb
	arch/arm64/boot/dts/renesas/r8a77970-v3msk.dtb
	arch/arm64/boot/dts/renesas/r8a77980-condor.dtb
	arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dtb
	arch/arm64/boot/dts/renesas/r8a77990-ebisu.dtb
	arch/arm64/boot/dts/renesas/r8a77995-draak.dtb
	arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb

