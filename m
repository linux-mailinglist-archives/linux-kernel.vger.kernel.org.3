Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D744E4C65F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiB1JrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiB1JrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:47:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADAD6A002
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:46:36 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B4D893FC9E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041594;
        bh=vWRVPVArJCYlog6uyWwSBOO+0zNuAlMQrxtxYFl/jDE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TvGdh8PoahWzvpn7b6V3YD2eKGDapLZDyGdE5cHvc6Jw+YyakuAOdzSnsWc3wWgRD
         /xxcLzkwmFGug+QjvWzk50J+AXbETkGqCP9oTM2kuBek3+cNfvx+ISEw9EdOFBdjg5
         FLVE4IQA94uXdJRGGAbE/rKw6bFfUdouo/rrIKuM1dzsCr1OL7L3XN+9SNKAJHCYdw
         uZ+za7i2L6CYTq2a4kQiu2qLUJIvG1/4ZZJLCTQaxn5DpPQQwOzZMw4KICwh6Ml8f0
         EKtypy9zDu9vpSDwU5gDduxP1aahVPyKqQTvO1VzbAGWga8kSmC9TlyqCoRA9wR2ic
         gEjsCEKsh42gw==
Received: by mail-wr1-f69.google.com with SMTP id w2-20020adfbac2000000b001ea99ca4c50so1854143wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vWRVPVArJCYlog6uyWwSBOO+0zNuAlMQrxtxYFl/jDE=;
        b=hA3xrY4mN5+0Hmvl0f+1zoPAg8bnpmR3UKjFG08HoaAuKc+dqE01tX8rhGrsbJrHPn
         DYVzd+tPAhU9G6S63pnjeLFWGsLsu9FW5ev3Ep8T62uMW8o3ZmFbw7UaymmqxjKzuWXO
         9c/SPUrUXQRjCBwoc/EvGRXQZTQ7nuZhzJYpIHs+ivCqVJHdQ4wf2+c0LHsIqtWZBBPl
         3c8bz72h4R9X14cDYEI38XHT9bzgk5mpgLH5dAEfyvbwMZmVb7Zu0GSBT6LrZSquR1uz
         JbRLug/ipOP7hvbcv17+K5+8DiTlvjHrwfAMeaBk2PQe8RzEqCOA3/fGHsyMxhj0EQn+
         hymw==
X-Gm-Message-State: AOAM533HdybQR4LauhTCuLJLcysKh9CVurnC3QXWWpTqau37hVKazp9V
        XB8aFSrce+HLe6pE8hPkkE0+nW+6osqJhpZuy4sHtpD69ZvrwWNqKpEK1v6dlsXW3bvQk+De3Z/
        WszT4fqGpktnG/Z57y0pfVZvyQJc++pELV/NJvn6hZA==
X-Received: by 2002:a05:600c:1c29:b0:381:7667:ab69 with SMTP id j41-20020a05600c1c2900b003817667ab69mr1406261wms.142.1646041594385;
        Mon, 28 Feb 2022 01:46:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjgfHayCZ6lM4CIvn6f9h7ICOQlGN4pyToG5DkHnFk0Kst5sueKcEZizJeXImKTwcW83XFsw==
X-Received: by 2002:a05:600c:1c29:b0:381:7667:ab69 with SMTP id j41-20020a05600c1c2900b003817667ab69mr1406248wms.142.1646041594244;
        Mon, 28 Feb 2022 01:46:34 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m12-20020adfe0cc000000b001ede2dd604esm9807179wri.106.2022.02.28.01.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:46:33 -0800 (PST)
Message-ID: <5e15401e-761f-2135-7f3c-fd78a455e380@canonical.com>
Date:   Mon, 28 Feb 2022 10:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: net: can: renesas,rcar-canfd: Document
 RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220227213250.23637-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227213250.23637-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 27/02/2022 22:32, Lad Prabhakar wrote:
> Document RZ/V2L CANFD bindings. RZ/V2L CANFD is identical to one found on
> the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-canfd" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSI changes [0] have been posted as part of separate series.
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-4-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
