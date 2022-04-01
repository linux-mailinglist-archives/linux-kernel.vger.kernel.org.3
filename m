Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1C4EEDEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346260AbiDANPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiDANPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:15:19 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB483EA9D;
        Fri,  1 Apr 2022 06:13:30 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id b188so2722518oia.13;
        Fri, 01 Apr 2022 06:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Dt6DUcWZe68wNzFOcmf1w5pbg157v95Sfa3KdIbLtuY=;
        b=ygOs0ijOlu9kSRz6xLgL2o974GzCt2H6RZXZM+SrE1kgXmwzlRoosKtRS4k16XRY4Y
         IBflj+MZOAsUk+CuLbKNoeuMk/uCldAQgT0ARtcn5N/l6/9WezAacs//wB11c0+ctEso
         tlmw4qk6gxEHbzZ8apRmQjRESTz4o7PtXAYuuE/ngoeuD23sQzrnxFw5EDebjDDvpdPU
         lfN5sEhGNmpy7mAnbDUadLqqt7/JAOdrUz9FTVTX1Mi6P2ceAWHJoF1QebNdfip9YPVr
         7NPkFPxNsB7mo7MIqR1EbHkYuN9CHRORhdKcwPTjzPJsI3R9xlpjGErrQgkb3Bdikg+B
         x3Bw==
X-Gm-Message-State: AOAM530mLzKRgZ1btgoSco0haNcq4G7/CR/F1RO5oomg6gl3TaWJuYJJ
        p6aoInN5y9oYroWAG8m2rg==
X-Google-Smtp-Source: ABdhPJx0RcNvDjmuubFatcz4ZzB3jxBfl9sx/UlLM31HKdGp5LJoSd3+/HrnySHLnCdBMlFeh+WiWA==
X-Received: by 2002:aca:1303:0:b0:2ec:cae7:acc4 with SMTP id e3-20020aca1303000000b002eccae7acc4mr4664170oii.179.1648818809222;
        Fri, 01 Apr 2022 06:13:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020acaa813000000b002ed02ca6a3fsm981706oie.1.2022.04.01.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 06:13:27 -0700 (PDT)
Received: (nullmailer pid 2864971 invoked by uid 1000);
        Fri, 01 Apr 2022 13:13:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
References: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: gpio: add common consumer GPIO lines
Date:   Fri, 01 Apr 2022 08:13:26 -0500
Message-Id: <1648818806.914066.2864970.nullmailer@robh.at.kernel.org>
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

On Fri, 01 Apr 2022 09:27:14 +0200, Krzysztof Kozlowski wrote:
> Typical GPIO lines like enable, powerdown, reset or wakeup are not
> documented as common, which leads to new variations of these (e.g.
> pwdn-gpios).  Add a common schema which serves also as a documentation
> for preferred naming.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Correct email.
> 
> Changes since v1:
> 1. Select-true, add maxItems and description for each entry (Rob).
> 2. Mention ACTIVE_LOW in bindings description (Linus).
> 3. Add allOf for pwrseq reset-gpios case.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/gpio/gpio-consumer-common.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dt.yaml: rt4801@73: enable-gpios: [[4294967295, 2, 0], [4294967295, 3, 0]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

