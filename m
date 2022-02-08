Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A664AD800
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355946AbiBHLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351457AbiBHLzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:55:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13722C03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:55:36 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E598F3F1F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644321333;
        bh=o9lVwGLOMjBBC4tFHuuGDiFsf+0wof2yGLRdH2ujaps=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pMSbt0qjQGJhlXU0DJrmtpJnoCH+UOr5EpGVlBMxnj/kDdvgDymjS5NOtXSnUHsBB
         BwYGRP+Xpds4sGcgswWP4Z/kUPjehxu9gRbVAtEiE+xodatmzZX3CQtefd2lLotp8j
         hBYKP3J2zAkKEum4b7SUpDCO3vIgq42S6UEVNT8oIB/EuHsiICq30jxTYGQSQcdf6s
         fB8GP/GKptXTV+q12g9eA7BCmeXFFblDhBLvf7MjRcoPf+8ouzVAup+BtQnmG5//TL
         AqkGzWm3czfGFj11feMKn5zKhSh3TPFVRmApizYoZLjDKFPi9kK9p6XZNrpDilMQ18
         RrEbD/f8gdzCA==
Received: by mail-ej1-f69.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso5646860ejj.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o9lVwGLOMjBBC4tFHuuGDiFsf+0wof2yGLRdH2ujaps=;
        b=ZtWVga7JjV0ZJpoAFC8qx7u3Ye8BCc+O1BB7l7TUDFOd64plcmMSH00Lpqd0kytNe8
         mP8KAtD14TYM4EDA1aqj6f/ooh2fx42z62FKwzFldu6QK8/e9c4ZVhsi7ilbu9WWNmOt
         xUfu495la7wOltrneYT/SiJX4VOBwG1y61raMELj7h5crzxe3I0OxI/kXReJXWZ1h7z7
         csZU9zZaxcKmpD1SRiCt8c/LxEL84f7567E2Tn83D+0lADEKVu3cxOx0Z0js00aS2+Ze
         cG3cJMI8zxubqwudTiCdcUy9ZmIiXIApwNzGTxN818MsQ13abwRO60CD4C25JhSNseeJ
         33Ew==
X-Gm-Message-State: AOAM53111haIWyZk27pXwbXVV5pEV1ibOHx7Q6ffAuVB1AlyomhFfRn6
        O1vh/LMCnBA8BCAbqD78LeLSIGZzNGRwN3mbNPOypDMm2q9ZauJF/nGlLyZ6VSA7kM3/ljD8Q9B
        31+IIrF5eVY5mQCDNOHaT+EwUPI9lJR2m425/JaFGdA==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr3507969ejc.659.1644321333570;
        Tue, 08 Feb 2022 03:55:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJRKF31xIu6mS1pj+dMNV+8zV+4g6/YqHO7wOvj2ZzAgp/idanGTZW765Y8LXBDd4VTSMQVA==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr3507953ejc.659.1644321333380;
        Tue, 08 Feb 2022 03:55:33 -0800 (PST)
Received: from [192.168.0.93] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o11sm6780166edh.75.2022.02.08.03.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 03:55:32 -0800 (PST)
Message-ID: <d995fee3-c2ad-55d2-86a0-c8a27e459ff0@canonical.com>
Date:   Tue, 8 Feb 2022 12:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: Use the generic "crypto" node name for
 the crypto IPs
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kavyasree.kotagiri@microchip.com
References: <20220208111225.234685-1-tudor.ambarus@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208111225.234685-1-tudor.ambarus@microchip.com>
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

On 08/02/2022 12:12, Tudor Ambarus wrote:
> The DT specification recommeds that:
> "The name of a node should be somewhat generic, reflecting the function of
> the device and not its precise programming model. If appropriate, the name
> should be one of the following choices:"
> "crypto" being the recommendation for the crypto nodes. Follow the DT
> recommendation and use the generic "crypto" node name for the at91 crypto
> IPs. While at this, add labels to the crypto nodes where they missed, for
> easier reference purposes.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/sam9x60.dtsi | 6 +++---
>  arch/arm/boot/dts/sama5d2.dtsi | 6 +++---
>  arch/arm/boot/dts/sama5d3.dtsi | 6 +++---
>  arch/arm/boot/dts/sama5d4.dtsi | 6 +++---
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
