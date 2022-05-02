Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30849516A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383223AbiEBEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350171AbiEBEh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:37:26 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31EF37A2C;
        Sun,  1 May 2022 21:33:59 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id f6-20020a4ace86000000b0035f083d2216so8961oos.4;
        Sun, 01 May 2022 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRy8BGFVOsH3NwPY+cuDEyAT7JO6RuxWNnTcte4Mmmk=;
        b=ltoOQ7OnsjxVwi274zDoEJkV9qcHZW95iX1x3/nVt9w6DgXQo7xmaHQOKPQHRkeEjB
         YthpZ9Ve7tS3x89yBzoxhFviUPZlQqReoqug5gwFsfRc2qxuf1NHfC2HT4f76u1a/sor
         GD9BNfpKN/YqXLFUTREouCN7ZMXDZyZHr29bSUg3aklg90K6lvVHi9iatmhVfuqSfsVm
         p1CJJP4r7fKodhsCbrjXjF4ZGjYBtxsD1dOz5isg4ilHw4c6WRNzKp+RILFioMVH2u0k
         q7cjZVJ2AxYphUhdzIKJ6Ngi/HxrFIxs6mnL2/dVyjwno0IiZKR00xRBD61BGtP0LFxf
         Xyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PRy8BGFVOsH3NwPY+cuDEyAT7JO6RuxWNnTcte4Mmmk=;
        b=PWIcoACf5nttrb9zm61T+draAxR2ofoqpsukMCp6wxHhcmg9dJdyFxhY7cMAeN8f5B
         pfrUbiSA+Cqc4KYMn02OkRFWQkmIGXe3qfM2uDUNSojxNN1ZpTxlJr6wgcvkTmyXuocK
         SQAXXmbwiC5yBu7dXeSBMc7va7Z4XVPSP4KzGDD7a418+mO9Rw2Fr9HuOdb4iN78qcd+
         zY7hmrIuOGrPwHhcUP1+UMHlU1dmekfptuTwYfyEjGGU4GvKw/PJCzoxkhgg6F0M+JMx
         DmAcTJCzj4Cll/x0pJWxkapLsg5EvCi8hDZ8UBr8D45YqDreOp5MaCJcACHBlOBn0bJL
         DGBQ==
X-Gm-Message-State: AOAM530P3ER1JUzn9hdNywL2gCG3o3p5jyA9c8S3j87rPrEgDVjqMcVm
        MB6zN1T5tTjkmIQkQaEDCw0=
X-Google-Smtp-Source: ABdhPJw+DZF9recnT2AtSNQuwFhQe4Aew6mjwI7JruXA2P6l0gNKEi60pDYWVpke/T63qakCZoXXnA==
X-Received: by 2002:a4a:c294:0:b0:329:2fed:ad3f with SMTP id b20-20020a4ac294000000b003292fedad3fmr3557284ooq.4.1651466039061;
        Sun, 01 May 2022 21:33:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k7-20020a4ad987000000b0035eb4e5a6c3sm3539357oou.25.2022.05.01.21.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:33:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 May 2022 21:33:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Walle <michael@walle.cc>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: hwmon: add Microchip LAN966x bindings
Message-ID: <20220502043357.GA1718901@roeck-us.net>
References: <20220401214032.3738095-1-michael@walle.cc>
 <20220401214032.3738095-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401214032.3738095-4-michael@walle.cc>
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

On Fri, Apr 01, 2022 at 11:40:31PM +0200, Michael Walle wrote:
> Add a binding for the temperature sensor and the fan controller on the
> Microchip LAN966x family.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/microchip,lan966x.yaml     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml b/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
> new file mode 100644
> index 000000000000..390dd6755ff5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,lan966x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966x Hardware Monitor
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  Microchip LAN966x temperature monitor and fan controller
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,lan9668-hwmon
> +
> +  reg:
> +    items:
> +      - description: PVT registers
> +      - description: FAN registers
> +
> +  reg-names:
> +    items:
> +      - const: pvt
> +      - const: fan
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hwmon: hwmon@e2010180 {
> +        compatible = "microchip,lan9668-hwmon";
> +        reg = <0xe2010180 0xc>,
> +              <0xe20042a8 0xc>;
> +        reg-names = "pvt", "fan";
> +        clocks = <&sys_clk>;
> +        #thermal-sensor-cells = <0>;
> +    };
