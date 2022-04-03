Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853A4F083F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354112AbiDCHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiDCHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:16:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CE2A240;
        Sun,  3 Apr 2022 00:14:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s8so6161883pfk.12;
        Sun, 03 Apr 2022 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79ZQ4/IBxoYZy6JMRBmsM+bMHL7GqptUlX0BzrwDfvE=;
        b=I/ZvNlzZbFxrEu+M79OVcq8VYhyZQJXkrAXGGdRSnK5ghgvcX81I8xhdbyxRfFsRBz
         i8eH3kcRYCN6aOARAG+mSDL46r2b0w1qyCaptBvxbr43e/9GyZR2v3DoPN7qAB6GCaAR
         Jd7DOvOoqYXojGrlPQxBCE3hpf2SE3U3J6zbXs3PZQeWBgyLJ43PbmPiQevWvGun5wzk
         THH8FTR0vOkwJa2ydhylMPoxdYYnK5x0b/Z4WsT7qa15yQdijvkSZ6KLB6/MIpnjJnR3
         3mrU0BVBcfrIAXu/IPwbs+/pqj4c+TSZ7iDpdlDUQ8dRt5z0VSObZ2+zOLFfKoo+m/5e
         2SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79ZQ4/IBxoYZy6JMRBmsM+bMHL7GqptUlX0BzrwDfvE=;
        b=SjpMR8WizKZs9JAd5gkIXusBIW4scY65ClqbmKfC6nVA7pOYoIT6fLliMDPiJNmJsG
         gMxK9PuE4UfGd9ln4qkXWxaFHeeNWXHZeQXCBBsRwzA8grgLWbDyfB+XjJbofyAg/uiC
         Y1uKKKGMO0Ilp6ChdqcDUqJfv7SYQukvMrL3iV0UtvOWzc2aiRzJcyjOKDNdMV5uBii2
         YyvOmfobToe3WnmWYMxuAstA9wnUHmy65KhTvcusiaARUypyu45aAsfOXe9e0T/J+/y5
         D6PYtDZDcGhcW3AJXs+nxTAbE+Hqx/GWaO8MWFtH6V9+4naDhOXqFLvrCGWwfnchgzwc
         iyHQ==
X-Gm-Message-State: AOAM532dPxNh3yRS6+x6zGLZqHzFYpP6y8spR34Sr06Aj4nnm2vMRt5z
        mv7Fm5N3+FjMzjdxsfEnuUi/MPPMTigZ3g==
X-Google-Smtp-Source: ABdhPJxxLH5zEbxbEHe1+UDmlUduwVo27h+uiYdpReWNlzu4hDee9cH5o8oadLg00I6k7WqFuGXe9g==
X-Received: by 2002:a63:2cd5:0:b0:398:997f:a440 with SMTP id s204-20020a632cd5000000b00398997fa440mr20280038pgs.344.1648970073719;
        Sun, 03 Apr 2022 00:14:33 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001c746bfba10sm18324045pjb.35.2022.04.03.00.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 00:14:33 -0700 (PDT)
Date:   Sun, 3 Apr 2022 12:44:26 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Message-ID: <20220403071426.GA49153@9a2d8922b8f1>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401202643.877609-7-caleb.connolly@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:26:43PM +0100, Caleb Connolly wrote:
> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
> drivers.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../bindings/power/supply/qcom,smb2.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> new file mode 100644
> index 000000000000..1bea1fef78b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/qcom,smb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
> +
> +maintainers:
> +  - Caleb Connolly <caleb.connolly@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pmi8998-smb2

Since there's only 1 entry, please use const.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: usb plugin
> +
> +  interrupt-names:
> +    items:
> +      - const: usb-plugin
> +
> +  io-channels:
> +    items:
> +      - description: USB in current in uA
> +      - description: USB in voltage in uV
> +
> +  io-channel-names:
> +    items:
> +      - const: usbin_i
> +      - const: usbin_v
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - io-channels
> +  - io-channel-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>

New line here. Looks nice.

> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <4>;
> +
> +      smb2@1000 {
> +        compatible = "qcom,pmi8998-smb2";
> +        reg = <0x1000>;
> +
> +        interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
> +        interrupt-names = "usb-plugin";
> +

In-between new lines may not be required.
And DTs use tabs instead of 2 spaces, we can follow that here also.

> +        io-channels = <&pmi8998_rradc 3>,
> +                      <&pmi8998_rradc 4>;
> +        io-channel-names = "usbin_i",
> +                           "usbin_v";

Channel-names can be written in one line.

> +      };
> +    };
> -- 
> 2.35.1
> 
