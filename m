Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C385AD02D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiIEK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiIEK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:29:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1118E07
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:29:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w5so10704071wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jzaEkhGhaU9DElAqpe5vD6QTjoX83D1mGC7h1exsoDk=;
        b=H86OWEDilTptWCkpWOWaYr+y/MAfHm+X6+MncMy/MB+OKFfeXGyJsWqqyH/LVcIXft
         Z73pRf3UC/ROZbIqkNgbIhtqxYEbW3+2QQRkyBNieUzx24IQLIPETzZijhSC770XmDtv
         z64ypOw5xL5J3oOsX9EOyeNfULNUe3I7oRv7FsrGd/NEM6f67uNhOZ57pb+ZV/+8YbOJ
         hJk9vLX8ZLwujcTKuqXIuPb/FY/8V/uuOVPBi3SkZIKLGoUbtDbo588Cve6CMZibbyF7
         u8PO/lOVnOWgZn/rv0IeuYhFC29Q9z+zUVaXtSLTBzaZnw1cFJO/j2U7qY6S/p0AAKje
         leKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jzaEkhGhaU9DElAqpe5vD6QTjoX83D1mGC7h1exsoDk=;
        b=hH+fGmb5C1AUPH8daevcFoMjC+h+VPRT3JyMeP8QX22Ac0MzgpOj8Gm6GTjtC5YeHg
         s3hJ/fuNRgskPa5q/QfgD2bkWaqfDEbkMVOKmlxanSKdo/KZOOpUM9WSVugljiKXTpQG
         DegsEFYqL9lfD2AJxjf+WZbJHSljuT95Oz+WDUMGllw66h3nrPzvA6ycVAJSyRzHYwQ7
         k4lm158GkSLYUoBAHt0ufoY2vKagHJDDwhCkxt5lL7brfLZzP6RGJ/u+GHPD2QKD7qrF
         grPcoQN2/7qguN1y+zjnBC0Kyb8BTLJRcjz9WXfcYHpBrX5+uWCVu205uBK6HcnxqJ8h
         zJjA==
X-Gm-Message-State: ACgBeo1Pd5gPlSQgx/sl75UrW9TKd4898BwUV8l0MH4xtY+i9b83EtxF
        OaKD4Csd26BnwBSXSBTCLFs2mw==
X-Google-Smtp-Source: AA6agR6IaKlG2O0oEFrOKfKifBhi+4/JajaQjEEv7xoGR52Onyf3fNkU14kvPuJ690JDtKpFO7Ja+w==
X-Received: by 2002:adf:f909:0:b0:225:c35:8242 with SMTP id b9-20020adff909000000b002250c358242mr23553078wrr.550.1662373743297;
        Mon, 05 Sep 2022 03:29:03 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a682354f63sm18334971wmb.11.2022.09.05.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:29:02 -0700 (PDT)
Date:   Mon, 5 Sep 2022 13:29:01 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v5 1/2] dt-bindings: misc: fastrpc convert bindings to
 yaml
Message-ID: <YxXPbZzm2snVjHI6@linaro.org>
References: <20220905095340.902390-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905095340.902390-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-05 12:53:39, Abel Vesa wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Use compute-cb@ subnodes instead of just cb@.
> 
> Also add qcom,non-secure-domain, qcom,glink-channels and
> qcom,smd-channels missing properties to make sure dtbs_check doesn't
> fail right off the bat.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v4:
>  * set global additionalProperties to false and removed the one for
>  patternProperties
>  * fixed compute-cb property to allow more than 9 nodes.
>  * added missing qcom,glink-channels, qcom,non-secure-domain and
>  qcom,smd-channels, without which the dtbs_check would fail
> 
>  .../bindings/misc/qcom,fastrpc.yaml           | 108 ++++++++++++++++++

Oups, forgot to drop the txt one. Will resend.

>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> new file mode 100644
> index 000000000000..3c11a3741994
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm FastRPC Driver
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  The FastRPC implements an IPC (Inter-Processor Communication)
> +  mechanism that allows for clients to transparently make remote method
> +  invocations across DSP and APPS boundaries. This enables developers
> +  to offload tasks to the DSP and free up the application processor for
> +  other tasks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,fastrpc
> +
> +  label:
> +    items:
> +      enum:
> +        - adsp
> +        - mdsp
> +        - sdsp
> +        - cdsp
> +
> +  qcom,glink-channels:
> +    description:
> +      A list of channels tied to this function, used for matching
> +      the function to a set of virtual channels.
> +    $ref: "/schemas/types.yaml#/definitions/string-array"
> +
> +  qcom,non-secure-domain:
> +    description:
> +      Used to mark the current domain as non-secure.
> +    type: boolean
> +
> +  qcom,smd-channels:
> +    description:
> +      Channel name used for the RPM communication
> +    $ref: "/schemas/types.yaml#/definitions/string-array"
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "(compute-)?cb@[0-9]*$":
> +    type: object
> +
> +    description: >
> +      Each subnode of the Fastrpc represents compute context banks available on the dsp.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,fastrpc-compute-cb
> +
> +      reg:
> +        maxItems: 1
> +
> +      qcom,nsession:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 1
> +        description: >
> +          A value indicating how many sessions can share this context bank.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +required:
> +  - compatible
> +  - label
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    smd-edge {
> +        label = "lpass";
> +        fastrpc {
> +            compatible = "qcom,fastrpc";
> +            label = "adsp";
> +            qcom,smd-channels = "fastrpcsmd-apps-dsp";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            compute-cb@1 {
> +                compatible = "qcom,fastrpc-compute-cb";
> +                reg = <1>;
> +            };
> +
> +            compute-cb@2 {
> +                compatible = "qcom,fastrpc-compute-cb";
> +                reg = <2>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
