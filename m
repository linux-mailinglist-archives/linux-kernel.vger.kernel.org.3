Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF60A4ACA07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiBGUGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240961AbiBGUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:05:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D1AC0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:05:52 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 794113F1B4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644264351;
        bh=goO8dK0SlEWSiUngcdZPkNQcEJKvK2Mh6ruM6f24zJE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=To0CoDBBVb5fAmfhqkcquaky3Bm8gn9hb9mGpsG3UPqalK++07RU4Q8PS0bPaW1BP
         nIpcv4/gtE0Ffl42C8tJKW4/rlcxf6eEYG75vjeZfbuv6aq9dPA41kIQXx9o0ZLFMw
         y39qiEEEDO8K29IarRzTd9l/obv/o5qdBp13JCJ1WNN63Cx1ZGpXyLLewrgstvIi3a
         QAcN1ek7/QVwaT918rQ/ep+PRzTWV7XsjT408Ej+vKIskKWouebsHOSHblikS2p4fh
         9n8dr6E98RaYIRqavQViJeG73Q/l3C4DApyLvtSMaYgza1TXo068Ttnm2DZVLm+svk
         heOTb5jw26feA==
Received: by mail-ed1-f70.google.com with SMTP id l19-20020a056402231300b0040f2d6b4ec4so4487900eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 12:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=goO8dK0SlEWSiUngcdZPkNQcEJKvK2Mh6ruM6f24zJE=;
        b=foZqf8Q38wIy0oVj4ff+E3XeW7EWdKPCwXbZGqXf3m9uwuACkw7d0m7iz5Qga0n2T6
         GIb+0ClE4RzncnRTqhsTrFv/o5jvpi6cfbQ6kumaw/BjsvOX/vNp6YuUZsYBaacw1iks
         FlRJJMfHgHtp64wXPf+Ct294rA2N8MpbQI0QbGdxBZj+Hb/18MaXTA+HTbAoGHMxtzWs
         1vVhtx8mipmMFo/2RUD92Pj3CTDLzylcCE1K3OID4eEIaqqqyfh1caLdVi/NCsMW8/Bf
         eE+JNSD2nBWybwb0zf5guSjtWlMKNYD9MeZdz3SyZQylT5KoEJ7KlvjTNsimWnvDeLAb
         Bgxw==
X-Gm-Message-State: AOAM532k+7HChB66zJHkciky/pzKg02jVBKvx3d99Fn4wTM7u0/lnIOY
        WDv57Ns5ohQ98Ui/wAIF2c5p2x31Cjxgb29IxFu1ouUXD9w+miIQAKJGylM2RNu7Z5I/7CXaScu
        Z3qF7zTKxPyQA7TxlSO+85pGVr2QcePIebAgqwetSeA==
X-Received: by 2002:a17:907:961c:: with SMTP id gb28mr1022319ejc.725.1644264351200;
        Mon, 07 Feb 2022 12:05:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypZvKL/91tZZbz/aGMp7O4C9ndtQieTeLuI9aGeY/ooMqevM1o1LH4cSTekd5klGaRV2Zg7Q==
X-Received: by 2002:a17:907:961c:: with SMTP id gb28mr1022302ejc.725.1644264350990;
        Mon, 07 Feb 2022 12:05:50 -0800 (PST)
Received: from [192.168.0.91] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w23sm4041672edt.88.2022.02.07.12.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 12:05:50 -0800 (PST)
Message-ID: <b3e95f28-ea7b-b410-b0ea-cf782283e19d@canonical.com>
Date:   Mon, 7 Feb 2022 21:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
 <20220207095832.1590225-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220207095832.1590225-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 10:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
> between Sentinel and Cortex-A cores from hardware design, it could not be
> reused for other purpose.
> 
> However i.MX93 S4 MU use seperate tx/rx interrupt, so update
> interrupts and add interrupt-names property.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.yaml        | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 713cb847cd8c..f99890ae1813 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -29,10 +29,11 @@ properties:
>        - const: fsl,imx8ulp-mu
>        - const: fsl,imx8-mu-scu
>        - const: fsl,imx8-mu-seco
> +      - const: fsl,imx93-mu-s4
>        - const: fsl,imx8ulp-mu-s4
>        - items:
> -          const: fsl,imx93-mu
> -          const: fsl,imx8ulp-mu
> +          - const: fsl,imx93-mu
> +          - const: fsl,imx8ulp-mu
>        - items:
>            - enum:
>                - fsl,imx7s-mu
> @@ -55,7 +56,14 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: txirq
> +      - const: rxirq

You miss 'if' block defining number of interrupts per compatibles.

>  
>    "#mbox-cells":
>      description: |


Best regards,
Krzysztof
