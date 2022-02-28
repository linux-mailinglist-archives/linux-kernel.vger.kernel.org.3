Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303BB4C66E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiB1KK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiB1KK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:10:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8AD38D9A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:09:49 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C4EC405D7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646042988;
        bh=kIx+raZUijStrCGB7mdJrowRwtVAuHPRA5AhR/2Nd0I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=h16cGE9/4tO4PD+LhgAFF9+cpJDNPDoIBE+iE5q7iNwEXaeJP3smBMw/8lA28dqe4
         BC/iQ8uUSmnY9UZew0uxEg5sGnstQHHHnA2IX5RJoXnA67rtfFp6FBeE+M3LrSE35J
         a2Kvd6fCDqV8Z9bgy4yC3T0L7PE9NoQnUxVPW6EMJnB3PKciBM9F95V/QLaxwx4Jg8
         oR4b9qMR5kkKK2AeUCHAdY31B59+RRxIftgXIgK24qR4j92GGEdBgnh2rI4qgBdjyd
         4iVeHnXSxj9sgEzdx8wNjVP5mp+J6ZoQTciyT7gZPbDxOeuQH7/64qFPUL/j6P2nry
         4tEmyUPjZ4sIg==
Received: by mail-wr1-f69.google.com with SMTP id b7-20020a05600003c700b001efac398af7so545481wrg.22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kIx+raZUijStrCGB7mdJrowRwtVAuHPRA5AhR/2Nd0I=;
        b=2XWoDGPQEe/g9zXyvLM1Zcq229uWHLxtbHDJhA040ARqwnrYbAi97O+/ScQv8lIGTS
         dTSzAG18Sdw5EbAeoJGPTAtN8fmTsrgnUdETNLInhc7MJDkOmyfQszhzz4GXE6sFWRZB
         WpEqo3i8DZw7wDHMvR79BYH16u/PvAiVemyHLfS1vguGeGiwRVZvupXGNNz+yNM8tcXV
         E2s/gp363BWUrsyJy88GngbaWZsBjfNWIn7xpW/NpprtuU/O/YAsv/hdQDUcRlTMcVEJ
         gINisAYsFSuSZvsB5QldTYEy3GiPj44HoKjTYZ+Xav4QNXYFTK3lChFIIV0I+4xW8VQ1
         DuIw==
X-Gm-Message-State: AOAM530FuICKdQfWK6cn2L0H4uKbVPodSwC44fywQE+SiroaF9p+kdpJ
        /Htv2O8eR1lPRD9RruZRa0MlnSBu4LMdWIImdwu8p/8ozUN5HJH5BBgXKGg/0qs6oVJ4t0qs+UN
        YBodDq9gxs1EwLTnqx+bkRfWQsgr8QSr0dGCcAceRIw==
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id y1-20020adfd081000000b001ef9378b7ccmr6526408wrh.407.1646042987421;
        Mon, 28 Feb 2022 02:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt5qm49T+l3aWQPrCdhZj4vQvOAlvEwnYbWhxw24cBValwEqncUUoWR+qNsHkBBdWdo63G6A==
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id y1-20020adfd081000000b001ef9378b7ccmr6526391wrh.407.1646042987208;
        Mon, 28 Feb 2022 02:09:47 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm22228541wmk.9.2022.02.28.02.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 02:09:46 -0800 (PST)
Message-ID: <cbca5f7a-de4f-1559-92fc-45c6d037a6d1@canonical.com>
Date:   Mon, 28 Feb 2022 11:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: Add power-domains property to
 ahci-platform
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        "devicetree @ vger . kernel . org Damien Le Moal" 
        <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227182800.275572-3-linux@fw-web.de>
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

On 27/02/2022 19:27, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Some SoC using power-domains property so add it here

Full stop.

Subject: "dt-bindings: ata: ahci-platform: Add power-domains property"

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v3:
>   - new patch
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index cc246b312c59..cc3710fe4fd4 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -67,6 +67,9 @@ properties:
>        some embedded SoCs.
>      minItems: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    resets:
>      minItems: 1
>  


Best regards,
Krzysztof
