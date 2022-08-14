Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9175925FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiHNSds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:33:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615D186D5;
        Sun, 14 Aug 2022 11:33:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy5so10262168ejc.3;
        Sun, 14 Aug 2022 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4+2ulhFVcoDAjZEoMthRjrOaXvnt89QHNhQtRqhHP4s=;
        b=fX9pi09EiTGFxwGOxA2V8wdc4cS8yTLAY5O+Lr6evH7WYQfLNkQPjwLA2TgtZPHOMh
         jxjpmtzkHC8K082p36rUUQDcHGYqPstimpHyacdkMk24iiQzLf37vOOGPjs8l4yVJe/w
         6wkT6xr5guhQGq/x5jslkQCMuRuMWfs1Hdo9pbcV1uEWsP3IKhq8CVlCZXaRjdLnKvaC
         J3lrFLEWJcRgoy1nFmi4hZ8muwNhyrYyAIJqCw5lHhcgfX7dE2IWmJtlS8NnYN2WbD9Y
         5MJQRql+oOAh8Wcw0rOhflL5YxgP26rXhTIWwCPM7JXreuXWjasSScqI9LPII9zRyfQF
         su7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4+2ulhFVcoDAjZEoMthRjrOaXvnt89QHNhQtRqhHP4s=;
        b=PboBR8xYEFPoPnz5zHsu/r8vAs+HsnEKKEG7lYsXdQwBAr9UdfWOUF7efGtkYfP/Vf
         CWQcCWuHz/3/Pd7ndGvlLaFQp9AA5JTqCr5OVkgS4CoGB9g9hPEhRUqlo2udRkZZO7wL
         dHuv4XwIZnKpiofndT/MROJyZZFYcmq68CisRnGVqXnNCWrml54jpCEFD/F4VaDWm4Ys
         bWgD38rUllZpF/X4x4ALLsJryCf/JuTCmbyfi668Cmeir0W/+6clFuyy37Lenc9VYXav
         Du7/FVJLY9lZyxMSWREQRQjy0himSk+i8AFKjcoLJ06kiqAvHpIld4yRNMJyjk5yDu81
         8k0g==
X-Gm-Message-State: ACgBeo1Lb1Zlv37louU36dVTGWxyC/1SZw7BTmsWGI8odeayX3rUks3w
        0ouU58nUNhmbNwVhqnSXGk49M1bt8INTsA==
X-Google-Smtp-Source: AA6agR4/M9HH2/f84AG8Fd/KLTX78rK74rtI0dDGgYRxggAqcMOivuaVI3DiNTELE+WqZshrf4D2Pw==
X-Received: by 2002:a17:906:8a73:b0:730:9af8:b335 with SMTP id hy19-20020a1709068a7300b007309af8b335mr8740361ejc.14.1660502022790;
        Sun, 14 Aug 2022 11:33:42 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id o19-20020a170906861300b0072eddcc807fsm3183679ejx.155.2022.08.14.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:33:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 9/9] soc: sunxi: sram: Add support for the D1 system control
Date:   Sun, 14 Aug 2022 20:33:41 +0200
Message-ID: <2310270.NG923GbCHz@jernej-laptop>
In-Reply-To: <20220801030509.21966-10-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-10-samuel@sholland.org>
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

Dne ponedeljek, 01. avgust 2022 ob 05:05:09 CEST je Samuel Holland napisal(a):
> D1 has a single EMAC and some LDOs that need to be exported.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


