Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF554FF8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiDMOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiDMOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:11:07 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D656D61A3A;
        Wed, 13 Apr 2022 07:08:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g17-20020a9d6191000000b005e8d8583c36so1239188otk.8;
        Wed, 13 Apr 2022 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V7pjazVef+DOYF0C0vXfWeCRJdWePXo1vwtP6FRieUk=;
        b=RRzY9iqiEBjIxfZsXWX6JNs/IOVhZyL1kBtF1NGpWtG4WfeiwwPg+yZg7jqvF4aWHf
         CMy3Ckx7Pu8VMWoTiuYMakxw9j660enbSyf5rBCO8cl4XEDu/HOI7ryp0R3s+ZBp2qEX
         SNL7Qmd1z3nZJ1qbD8HDItvjHgfVXakCyAVBywLbN7X/FGlFyaJz+d5PvjzH7vXK3muk
         BcNJqkLOSMIoEoniBn0G3tXC1wV+S5rJeXYXqjTBbTq5FQzOG/VKpuk450N5A9OQ8wj1
         gmbEipZle3FVAK2RGuLGhZgYCp2sjt/Rjtff2xiD4VDqrUFKGeVdf6XrQyjalqlg/nvU
         2A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V7pjazVef+DOYF0C0vXfWeCRJdWePXo1vwtP6FRieUk=;
        b=HzZWm2sNdv+OAQc97obKDg/IYWewasLaA2426rxGsTHrn53PHjd71avdpKGM8TOrrS
         yaTuoeuSe1RYetaOwCxG0WgQ373Kb4ScBDQC7/0haqXWh34M8eyKiuR3CgnQRqtqoCs2
         Ej8PZ6WyHr2e+h2x1JkJhLbIuCMa5L1JDZwEIW/FRbqnLYrQGaRaNaAONh6eTX4rhE+k
         w+StdTYS5yhR9pFzGqORBI9iz4aEE1psVNBVhMeq0iFmS/ZIC8XvB4Mjd5LVNV943C0N
         Ns67np77QFzeD0TmYpj3RmmeEPYlhwuFRBX+nFOJHrlaKYSvtgITPCZjtsxUUbp+7tZ5
         ZK0g==
X-Gm-Message-State: AOAM532FSHNVwN5knPWjhX2TnH23BV3kPS2NCKS83ewOUtlHEiTVZWUn
        YSWQNdbHd8KpfBjiXy7GU8E=
X-Google-Smtp-Source: ABdhPJy1DrnrepGB5CIyKFQ9qwuH9a+TUnwLgD7Bxt7ac/cp5F6MDKiCm/tj1hqMjocWbdXBVgAwmA==
X-Received: by 2002:a05:6830:1012:b0:5b2:36d1:f15d with SMTP id a18-20020a056830101200b005b236d1f15dmr14494741otp.219.1649858922171;
        Wed, 13 Apr 2022 07:08:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9-20020aca3709000000b002ed1930b253sm13604917oia.30.2022.04.13.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:08:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Apr 2022 07:08:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-hwmon@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix array constraints on scalar properties
Message-ID: <20220413140839.GA2398533@roeck-us.net>
References: <20220413140121.3132837-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413140121.3132837-1-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:01:21AM -0500, Rob Herring wrote:
> Scalar properties shouldn't have array constraints (minItems, maxItems,
> items). These constraints can simply be dropped with any constraints under
> 'items' moved up a level.
> 
> Cc: Agathe Porte <agathe.porte@nokia.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-hwmon@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml       | 5 ++---

Acked-by: Guenter Roeck <linux@roeck-us.net>

>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml      | 4 +---
>  Documentation/devicetree/bindings/media/coda.yaml            | 1 -
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml   | 2 --
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml   | 2 --
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml       | 1 -
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml | 4 +---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml  | 2 --
>  8 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> index 801ca9ba7d34..e7493e25a7d2 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> @@ -58,9 +58,8 @@ patternProperties:
>            The value (two's complement) to be programmed in the channel specific N correction register.
>            For remote channels only.
>          $ref: /schemas/types.yaml#/definitions/int32
> -        items:
> -          minimum: -128
> -          maximum: 127
> +        minimum: -128
> +        maximum: 127
>  
>      required:
>        - reg
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index 7c260f209687..952bc900d0fa 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> @@ -108,9 +108,7 @@ patternProperties:
>            - [1-5]: order 1 to 5.
>            For audio purpose it is recommended to use order 3 to 5.
>          $ref: /schemas/types.yaml#/definitions/uint32
> -        items:
> -          minimum: 0
> -          maximum: 5
> +        maximum: 5
>  
>        "#io-channel-cells":
>          const: 1
> diff --git a/Documentation/devicetree/bindings/media/coda.yaml b/Documentation/devicetree/bindings/media/coda.yaml
> index 36781ee4617f..c9d5adbc8c4a 100644
> --- a/Documentation/devicetree/bindings/media/coda.yaml
> +++ b/Documentation/devicetree/bindings/media/coda.yaml
> @@ -65,7 +65,6 @@ properties:
>    iram:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: phandle pointing to the SRAM device node
> -    maxItems: 1
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index 9b179bb44dfb..aa55ca65d6ed 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -63,13 +63,11 @@ properties:
>  
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to vpu.
>  
>    mediatek,scp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to scp.
>  
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index e7b65a91c92c..2746dea3ce79 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -55,13 +55,11 @@ properties:
>  
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to vpu.
>  
>    mediatek,scp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to scp.
>  
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index 7687be0f50aa..c73bf2352aca 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -61,7 +61,6 @@ properties:
>  
>    mediatek,scp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description: |
>        The node of system control processor (SCP), using
>        the remoteproc & rpmsg framework.
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> index 2424de733ee4..d99a729d2710 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> @@ -104,8 +104,7 @@ properties:
>    qcom,smem-state-names:
>      $ref: /schemas/types.yaml#/definitions/string
>      description: The names of the state bits used for SMP2P output
> -    items:
> -      - const: stop
> +    const: stop
>  
>    glink-edge:
>      type: object
> @@ -130,7 +129,6 @@ properties:
>        qcom,remote-pid:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: ID of the shared memory used by GLINK for communication with WPSS
> -        maxItems: 1
>  
>      required:
>        - interrupts
> diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> index b104899205f6..5de710adfa63 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -124,7 +124,6 @@ properties:
>      description: |
>        Override the default TX fifo size.  Unit is words.  Ignored if 0.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    maxItems: 1
>      default: 64
>  
>    renesas,rx-fifo-size:
> @@ -132,7 +131,6 @@ properties:
>      description: |
>        Override the default RX fifo size.  Unit is words.  Ignored if 0.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    maxItems: 1
>      default: 64
>  
>  required:
