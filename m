Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C14C6613
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiB1Jtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiB1Jtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:49:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D5E23BC4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:49:11 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 27DA640303
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041750;
        bh=K8UVf48N+Jv0xX6sCbZYY6ItX765Q2FeYJ8hE11hC+Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qAFnIrX0Yg5Q0Es0yed+Q5pvV38WyylnFIFG7qPtSY6em75sxoP6IerOP+NsjciIx
         M+9sK4UmDDKJxRPAVWd6f9hlL4jM7R9IpoCdcg3tBpZ816+g7EAPrBl4rCliBodKBh
         x2gdRHgIE9Uyb6lR4vDc9dx4bc8o/1UNix3PKH6ADQlSgfEEohmHWtdkR8Awr6LgzA
         nyW9AQcKpeF4rol8kSwXkMqPI6lGYdBUWjb0EmRWPojbq0qrOJYIbMixmQMjWForQu
         qn5qQXExtGGidpsNWsNjbTKtFenxjRjfVQyHh5qPESz/+K6dSoIISGWesncmqubzqs
         KxuYGpGJkbYRA==
Received: by mail-ej1-f72.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo4875470ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K8UVf48N+Jv0xX6sCbZYY6ItX765Q2FeYJ8hE11hC+Y=;
        b=Z52R8tUxUO+jRAHATVt+Rdj4OJPnRADupPRJGfSfw9BwMINB+GY2UFqS6tS2z9oefL
         zbmS3lQsm5aIjV6hy5ZKd+iFl1g+L0NmjpYlggtbRzXcooXTIueo1sfeZNcx31z27wmY
         x/u1kux5MrpChNsO1q++ZUaHCgBzT9Zjjj7sfXOmrlJKaTVpJNwPkacTWtXwlV0Muy2d
         XIK2dhA40c8afB3kokOdg8y6fRcUGQ90NNzJCVk7pNJ0YyX4vQLYR2UrkvWevbW7lae1
         CUES0QGSXLL+HA7q1SUnL8RjhMP0W+PU9gW2Fyc5pVFcMO8COhQnVzKcJEwEsr92H4rT
         gX7A==
X-Gm-Message-State: AOAM533FVV7fLRTC2gGwCFigz3wqudpUUfsqmRZoM6hQ10bV47NtQe+D
        fTbMSMkm7TjyfZDqJbIldNLAkA+lV1Ej1a1KTE3wSmwN6E7pzrGw/MSnfhu7qgDfP/hfIFVCvgI
        gXMN+M+9MPg0fC9ZADBcMWVFtbbq31TLLQK2pFv6ugA==
X-Received: by 2002:a17:906:5a6e:b0:6d0:afaa:6ce9 with SMTP id my46-20020a1709065a6e00b006d0afaa6ce9mr14525317ejc.72.1646041749714;
        Mon, 28 Feb 2022 01:49:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiPlkY9rsiYiTnm/CU3aQEVQ1j+U9P0OWAKpk1KLMObh0w4NoWTo25mdmg/4GZXBmyUWBHrQ==
X-Received: by 2002:a17:906:5a6e:b0:6d0:afaa:6ce9 with SMTP id my46-20020a1709065a6e00b006d0afaa6ce9mr14525304ejc.72.1646041749549;
        Mon, 28 Feb 2022 01:49:09 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090624c500b006cee6661b6esm4241494ejb.10.2022.02.28.01.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:49:08 -0800 (PST)
Message-ID: <99a91e37-87fc-c0a3-8dec-20ebbba84f4d@canonical.com>
Date:   Mon, 28 Feb 2022 10:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document
 RZ/V2L USBPHY Control bindings
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20220227230302.30388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227230302.30388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 00:03, Lad Prabhakar wrote:
> Add device tree binding document for RZ/V2L USBPHY Control Device.
> RZ/V2L USBPHY Control Device is identical to one found on the RZ/G2L SoC.
> No driver changes are required as generic compatible string
> "renesas,rzg2l-usbphy-ctrl" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSi changes have been posted as part of series [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> cover/20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
