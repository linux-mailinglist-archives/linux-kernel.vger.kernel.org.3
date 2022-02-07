Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630094AC9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiBGUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbiBGT7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:59:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19810C0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:59:20 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 676D24003A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644263958;
        bh=SoJfnnJJW2QFhODDnPm1UyDvJMmMIk7F7kuEpKpNzms=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pCpCw4rLvH0FzMsatdmMM005iXIy/7UoBBo/eLb3Rw/s0PcgDz0gBWPnR4kp3JAm6
         3G23Xda6uSoDfsm1BgvL3byxmSqaxYktZTt2nTl4vWGzHlAHQ/0BkJAZXfvWOLZ07h
         5Eg5wFyS9KECbL1LWZhK7vak05ilBxpy26k4nZeRo5anBo66YQZ6hnFmb5NPy2X9kT
         ep86jo4GxJYQZtYpS5AcjEbkMGXVVrYH2nENCFvh8+4zYs/fSGTjIpP8LBHy444/Qi
         xgcMmVz1+07LHvEt55CAouNzq7rGaVac0bcsLharusj3vvxq4MqmgIUMRdCm6BZK3p
         YcE1hvMQKm1JQ==
Received: by mail-ej1-f71.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so4777188ejf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SoJfnnJJW2QFhODDnPm1UyDvJMmMIk7F7kuEpKpNzms=;
        b=rm7fcO9iWPlxTqCFc/E1e2e3HEA/wtcOpmCBJGuUZsNwZmfsnb1NlxK2QNQQE1seRR
         1efBuVy7tZhBxDV6MPvETv8hCYtCDK+JmG2X/wh2U6xVfEsxEkHJRifbah0b+NKYXKs6
         eHLUPmDuDul/LKoovxey99EOoD0/cX0mHxljPf4tF3I/Zrkl+g7qmTfpwBkYrQ6ZXCl2
         9W5dvpkDl2+WtuKYPayf8KU69wvldGgvqS2SIl3q8GVGpD0jRx7OAFGojHNq7iOLOVCq
         tSMJbzDfZad8NatdPq66Z3YCuC6xH7yekHDjCbMibEpvzf+l3sK2k238QOQW7BOmBPMY
         AHAw==
X-Gm-Message-State: AOAM533htBZM+Y+d2rvefokZAo1Drce7LBS/fmzrT+nHOIzga3CBX8mQ
        DUCgWFCU4hECzwa/PC7/aKH1q2tIa+xlarqYEm7JS2/qJFh+Yy7KMX80GKJuGUS5Z0fGlv+dugV
        kn0MdpnxPuI2CXUrqQ2GEmw2FW9qXoXet30hwZauBQQ==
X-Received: by 2002:a17:907:1627:: with SMTP id hb39mr1026552ejc.407.1644263956198;
        Mon, 07 Feb 2022 11:59:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUtxIF9E4YM94a/CEVCVH4ktjKMIEGy/luAXiUvmv2LyRtpgZvjz0rDDsCo/M7Wq+ELblwWQ==
X-Received: by 2002:a17:907:1627:: with SMTP id hb39mr1026547ejc.407.1644263956047;
        Mon, 07 Feb 2022 11:59:16 -0800 (PST)
Received: from [192.168.0.91] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c25sm5601630edu.103.2022.02.07.11.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 11:59:15 -0800 (PST)
Message-ID: <f2370538-6c87-c57f-ad4b-e1a77ebf5e69@canonical.com>
Date:   Mon, 7 Feb 2022 20:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
 <20220207095832.1590225-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220207095832.1590225-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 10:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 MU which derived from i.MX8ULP
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index f865b806ae6a..713cb847cd8c 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -30,6 +30,9 @@ properties:
>        - const: fsl,imx8-mu-scu
>        - const: fsl,imx8-mu-seco
>        - const: fsl,imx8ulp-mu-s4
> +      - items:
> +          const: fsl,imx93-mu
> +          const: fsl,imx8ulp-mu

This should be a list (' - const: ...').

>        - items:
>            - enum:
>                - fsl,imx7s-mu


Best regards,
Krzysztof
