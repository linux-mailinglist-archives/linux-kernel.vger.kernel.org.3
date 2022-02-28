Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329AD4C660A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiB1JtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiB1JtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:49:13 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0BB22B09
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:48:35 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 019723F1DD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041714;
        bh=lhADqiiCNl+v4LvWzSVnM4zA8m7wbEVtsgLwiPo5Dak=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nCHo/yF4Hx75bzONYufgoScYB5A775CjE4BeDLS9HIf27VRPcqzhQrtbhH9BUyQnf
         27o5tORd/134puIla5CDsSuVMX0wPjvsfalUx1VwAE/oUY05+8HbXaJCuPNTHscyzW
         27dej5uvTm4/GKV/Z9ulrTKc5Xmy09S30IOq3NN7hHxoHs3vSJGcU0V4Tmqu31+VrX
         9jNDQyNlExRExSwN3cDvZsGUlUytNcFq3d4eL9W/eu8nmwe51eJ89wElkAtBmOQ5KY
         uvpJYhsBMR9EW8q9e6/u9iibJu8yzR1gmZl7O7p9yozJ8OhVY0GycnPbV+D0Gqy22T
         XefYRlbvlzl8A==
Received: by mail-wm1-f71.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so5014363wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lhADqiiCNl+v4LvWzSVnM4zA8m7wbEVtsgLwiPo5Dak=;
        b=gXxACwePWyo22ZhkY6Z38fLMlTQEMaoRluYJQd+LMdPhDdsH9FqxB17SJ11BuRuiSq
         3t9J0z8v7gWsS81x2hy10+nLhpunUdoS2qc0F1T7RwT0+UqveIa+CCPWqMP7fcezu/gb
         ffuz6P11j9T1V4a1hsGt5fMF7/g8Ihkczy3ux/+sToj1Peu7A/vnMFsOWeZm6vyUCRjh
         4YCWP0rOapO8cID7qp/YMmWZiGMzCKuTX262AXYEfty19XRkpvpeX4PhjbVMnVNMeNiD
         Z0rKTAJnwjvVlf+PzN2PUTYIGnaRwtuJZ5Cv6r1yzvFxMFacQaddgt6kHcH/XnR/xh2f
         /KZg==
X-Gm-Message-State: AOAM530TuYmXaegBPAPxoobYCZfyEpTWV6gy9xdPpKUO2JkYmH+ty4k3
        faZBgrYaDn/D5tdQG09wrE6CG6yUYpi4R8i97uFeNNOX4JjL+nSoA2qhifqXBqLv0M9FHJSwDyv
        N+KeYMEK/BkYtZn+4u08gzNygjID977TXPZTYSsKyZw==
X-Received: by 2002:a05:600c:3007:b0:381:271:49a1 with SMTP id j7-20020a05600c300700b00381027149a1mr12333365wmh.79.1646041713359;
        Mon, 28 Feb 2022 01:48:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTbCVneuqj/uDRq1eBco71uCyPYVBYE803Kec/okcfd4SBAVH6yz/3e368hmSg5gul/1nKMQ==
X-Received: by 2002:a05:600c:3007:b0:381:271:49a1 with SMTP id j7-20020a05600c300700b00381027149a1mr12333353wmh.79.1646041713220;
        Mon, 28 Feb 2022 01:48:33 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm9894594wrs.23.2022.02.28.01.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:48:32 -0800 (PST)
Message-ID: <93cc64a8-327c-379a-4af7-c8faa1191c39@canonical.com>
Date:   Mon, 28 Feb 2022 10:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        alsa-devel@alsa-project.org
References: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 27/02/2022 23:56, Lad Prabhakar wrote:
> Document RZ/V2L SSI bindings. RZ/V2L SSI is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-ssi" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSI changes have been posted as part of series [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20220227203744.18355-10-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
