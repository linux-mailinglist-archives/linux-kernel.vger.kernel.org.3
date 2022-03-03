Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BF4CC03E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiCCOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCCOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:48:37 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0DE49F15
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:47:51 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0EF493F5FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646318870;
        bh=CxzFP3tGzxrqCnnX51QcUCT9fYSeSWG8X2huDv3i2u4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lHDG6IhfiNPmuzwUvILD8Tq9ZMew4wdjNyK6bdMx+r4gnfmYCV7m4wFjS0Lyht8ww
         bXWb6BF2Vw0t7QUL0OHaGb+AwI3K+09uiO/xthho4Jgoav4TgCSHxKk4PXBSIWslJD
         NmVffffIdf4W8dBJ0GytiwILq5tArZOp9t8UAQiJDI3JPC4DbTAFxkeSF3vFiQGvaj
         l4d/jOlPoFDisVyq7yBEuEVsV5IRKpeZ9DYWdIaQmUiblljQdbizlMuJE0Zc8VmGTZ
         iDJZBhKnyxwAdEpdUXXC0wdZKmQf0g3XHVR/ero2atkHGiZJsirVNddsxe6fMD579/
         a9fYvYOkXUrKA==
Received: by mail-ed1-f69.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso2052740edb.17
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 06:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CxzFP3tGzxrqCnnX51QcUCT9fYSeSWG8X2huDv3i2u4=;
        b=c5yDufilbQcaEblOaS74Vq8LKDbX0gC8y0ljhvXi9ynzaJueocdGMoSl51E/Cf7lc3
         U4MTsOg4TMW53l4rv1H2341uRmEMpdFiAS6OjfjyUi+srJFjjdphElpxh8IWr01z+fQb
         G6HPlrG3j1LYlZPClmHVqV1qlMTVNKWJjAcAgCch9FLzy4xhV2XAIXa8H/LKW2l8WmPY
         wkK8ih7Ca7B96X4wVrXk/jT11dErXSONUUh/CLRu3vD1r8WqzhXmljc4l0kBblHn7aAt
         KM55S5rw+SFfr1TRjRUUa7TJoafs+CHCM9hq7q24FywmgV7rb6x9WZ6YAGxFZsDJLACU
         r2Rg==
X-Gm-Message-State: AOAM530j2LrtC37FeUX6AkSKuuP2O8MMYPZOnztRod8udQxUKGKq3boG
        WpVU/lCOyuYLPN7bWleoTMQt/ixjb9wDUrhqvlMG7wsQwELK+PGdZtE+OVILHMRuCGLI18LYsHb
        jWRaxS++WNF61o3lXEpOln39oafIYsCqwj6ab05JA+w==
X-Received: by 2002:a50:da4b:0:b0:40f:28f0:c2c0 with SMTP id a11-20020a50da4b000000b0040f28f0c2c0mr34599580edk.374.1646318869541;
        Thu, 03 Mar 2022 06:47:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgdcMT370bTQ0EzwypM8MzX+F1/sOFiaay++W+IjgNwLT95VAPst9y79sRHA7O5pCw2Q1isA==
X-Received: by 2002:a50:da4b:0:b0:40f:28f0:c2c0 with SMTP id a11-20020a50da4b000000b0040f28f0c2c0mr34599577edk.374.1646318869389;
        Thu, 03 Mar 2022 06:47:49 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id gs39-20020a1709072d2700b006d3ed4f51c6sm818854ejc.0.2022.03.03.06.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 06:47:48 -0800 (PST)
Message-ID: <be111013-a726-629e-2ce8-fcab9d26a3a2@canonical.com>
Date:   Thu, 3 Mar 2022 15:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/5] ARM: dts: at91: Use the generic "rtc" node name
 for the rtt IPs
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
 <20220303140626.38129-4-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303140626.38129-4-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 15:06, Sergiu Moga wrote:
> As the DT specification recommends, the node names should be of a
> generic nature. Thus, the most appropriate generic node name for
> the at91 rtt IPs is the "rtc" node name.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  arch/arm/boot/dts/sam9x60.dtsi | 2 +-
>  arch/arm/boot/dts/sama7g5.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
