Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110A4B5839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356952AbiBNRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:13:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiBNRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:13:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28F4C43C;
        Mon, 14 Feb 2022 09:13:05 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qk11so18481492ejb.2;
        Mon, 14 Feb 2022 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Fk8twNCDj+wvRPPnauS0r1tDhPrGepWuPsXEFLTKTk=;
        b=NDAe7fCLf6sA/zxhNxQ77owR34T8UGjUGbAzZikk4FcorqiCJK7lWuW/PEigNr6TDZ
         tT+BBY45s4+cKDEYBWfD61KxSAsdIsalAEo26xD37BJMrWH8ichvKOaVbNtpNSG3e+O1
         OFP+uRStpbszEyHXQH4E7zmSB5F1o/g9/1OcJ1LJVXVSMwfpJC+Z7QdB7457m+aeGtss
         eVwivFzm1n31yfxocGOGwnuiv73LrZIksNQx/Ko+HDM3JZihJpE08XV1/n7RXrZzlXG2
         2RZ0Gc0PSH9UXf5IY4wI7xqoRzyIs1C6YZXHdi7T1aQs2LLpwFGUkRVN5dA09LDjTVQJ
         7gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Fk8twNCDj+wvRPPnauS0r1tDhPrGepWuPsXEFLTKTk=;
        b=mmJfe2Efw3IQnpfuF4CRcQxbupONM2YBkmpyz7WHfVDdNAksv5fNAUGaeQrgPmcnfg
         9yBKWt0uKJ1Y1MnsrGraTvFIjh6naRkPEmlPegM3Jw5VW8G6Y3h9N3fK1pF/Sp6REYED
         aUSLe2saoXf6iSQQfNjNORdw+cCnG+HCz2LpEa+YRgMnfjGIXbEp//FNrnTog/iwn8aP
         TadmX3c8MGtGbG516NtJNNi5p/7XXPAhUI4r9xyusVNcsuaFc1TGNS8yWJfo5oWgtoAg
         ftxJYTl0fA4d5IriI2pM1f4fkXcZ7WnhXziIvko95q76TFb9pzLgSsAdencRibXg8oPv
         Dldg==
X-Gm-Message-State: AOAM533nEVoDfWgxhpVPibIcUmnCrnOwXU3NselTXojEeUP9QXL89SJc
        xmMz4XSueYsb/TxRdmJCXLY=
X-Google-Smtp-Source: ABdhPJzg4slRDT/mw7ZOBMAOQzMQYAcNt8auS9xTWhsl5NDb/5V8h4eVpjx6YXnsY8ve32KgLbEa+A==
X-Received: by 2002:a17:907:a428:: with SMTP id sg40mr512036ejc.128.1644858784198;
        Mon, 14 Feb 2022 09:13:04 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id 23sm2427068ejg.209.2022.02.14.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:13:03 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 01/15] dt-bindings: pwm: allwinner,sun4i-a10: include generic pwm schema
Date:   Mon, 14 Feb 2022 18:13:01 +0100
Message-ID: <3485219.R56niFO833@kista>
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 14. februar 2022 ob 09:15:51 CET je Krzysztof Kozlowski 
napisal(a):
> Include generic pwm.yaml schema, which enforces PWM node naming and
> brings pwm-cells requirement.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 53 ++++++++++---------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-
pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 800d511502c4..e93e935564fb 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -52,33 +52,36 @@ properties:
>    resets:
>      maxItems: 1
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: allwinner,sun50i-h6-pwm
> -
> -then:
> -  properties:
> -    clocks:
> -      maxItems: 2
> -
> -    clock-names:
> -      items:
> -        - const: mod
> -        - const: bus
> -
> -  required:
> -    - clock-names
> -    - resets
> -
> -else:
> -  properties:
> -    clocks:
> -      maxItems: 1
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h6-pwm
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: mod
> +            - const: bus
> +
> +      required:
> +        - clock-names
> +        - resets
> +
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
>  
>  required:
> -  - "#pwm-cells"
>    - compatible
>    - reg
>    - clocks
> -- 
> 2.32.0
> 
> 


