Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF915586C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiHANn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHANn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:43:56 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191495BB;
        Mon,  1 Aug 2022 06:43:55 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id y197so8360618iof.12;
        Mon, 01 Aug 2022 06:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=y4FlZrpOSW7bs3SSCv+hrJsY9DFSZ9IOQL9orespssM=;
        b=Ik785jSVPFDzG/p7l0S2V5IFBPshRlBBpt6joZhsiDiNEgFL69HhetKUWsj/xPbObo
         IeRHsgl5O4xG517UHWfWYvvnV0vDrJ9BgorzMRu+gyMxZFEAWR9EAu09gw6m2YkobZGF
         GH3ut+igD+xUmzrTEcOnm8tD6kjfked+++8OUpCeBATdIdChhdNxB3n2L7BR317tLDCU
         8TcEZjSEwvxq5AFsqZToTwVaTePtNUwHu5nROQRrTGNd+0hrUarMp/EWuq2OoXaZ/dxn
         70eQP92cS/TlJoL8rDk5uuzgQoBuDFE0KBuklPOsZ5h2yGojK56kL4XgFBt5flz5AyFw
         Oc7g==
X-Gm-Message-State: ACgBeo18QHrF8s150mTIOIfp288fdOayScqUCRoMcAZQx2wplSKSiIJH
        FxlJqZ7ISP16RrDwhGEyTQ==
X-Google-Smtp-Source: AA6agR6RXwK+cr0Hg80Gi5E4Kbz7VRmoTYTZl1KiiQk8aOjn7XSfaVSOFmc0ncyMLohxtFBWQRdjng==
X-Received: by 2002:a05:6638:ca:b0:342:7d2f:d882 with SMTP id w10-20020a05663800ca00b003427d2fd882mr528451jao.220.1659361434887;
        Mon, 01 Aug 2022 06:43:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t129-20020a025487000000b003415b95c097sm5294568jaa.42.2022.08.01.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:43:54 -0700 (PDT)
Received: (nullmailer pid 914818 invoked by uid 1000);
        Mon, 01 Aug 2022 13:43:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
In-Reply-To: <20220801044758.12679-1-samuel@sholland.org>
References: <20220801044758.12679-1-samuel@sholland.org>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: Add Allwinner D1 LDOs
Date:   Mon, 01 Aug 2022 07:43:53 -0600
Message-Id: <1659361433.069437.914817.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 23:47:57 -0500, Samuel Holland wrote:
> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
> for general purpose use. LDOA generally powers the board's 1.8 V rail.
> LDOB generally powers the in-package DRAM, where applicable.
> 
> The other pair of LDOs powers the analog power domains inside the SoC,
> including the audio codec, thermal sensor, and ADCs. These LDOs require
> a 0.9 V bandgap voltage reference. The calibration value for the voltage
> reference is stored in an eFuse, accessed via an NVMEM cell.
> 
> Neither LDO control register is in its own MMIO range; instead, each
> regulator device relies on a syscon exported by some "host" device node.
> Getting the register via a syscon avoids a dependency on the subsystem/
> driver for that host device (e.g. a functioning thermal sensor should
> not depend on having the audio codec driver loaded).
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 77 +++++++++++++++++++
>  .../allwinner,sun20i-d1-system-ldos.yaml      | 55 +++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.example.dts:24.27-28 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

