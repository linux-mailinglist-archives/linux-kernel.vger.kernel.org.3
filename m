Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157256C38D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiGHU7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiGHU7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:59:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027776547;
        Fri,  8 Jul 2022 13:59:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i190so10693869pge.7;
        Fri, 08 Jul 2022 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/3oKcB1HpOXBSEaR0skiGfARHg3dQFArZCpwpkcA1o=;
        b=ERGg5YFQ6YWxFIGrUYJsMwmHWFy1ey5WdE8zNzL32fZaHt9sxRGywgvrxIUPbph//n
         lJVAVXfusGN7QiNz1dmzfxM1X9co3ET6Qf/utP087Hw2hvgCj4VzTvX7qtfQKMv7CGMy
         7GivN7D2G9ywC2/zlGQdf1ro9iDRK1BQYIC4ROgXUHVfBR+OhfcQOUSH/d8uzZh+sMIF
         3c0tOy0zHiRVeUKA7itNkPk510oNjr+86sEuDA96KXBRulGtu3NH+Dm4jz4kS48Hp62V
         eRBVaX1dDixzlrpBcvqzehzvYGkejDsB8VPP5df1aCei/GvS6lAXpt2yRoQVj5ujmb/l
         C0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/3oKcB1HpOXBSEaR0skiGfARHg3dQFArZCpwpkcA1o=;
        b=dAa0Ggga9G6mVro3xYW2fw/p5MTryyrD9/la21PTWXTXcyUwx2imZn/DKmIMCzShVQ
         V7PAyOzNj6Bs1YCc0UYFLW+LUM1FK5TGQOVV7GYxJwYtb8kKibTI1JXawELd3WdvCul3
         GpnkXlc2jU5eUmzJn1cG/VLfscYshWh5+laNcGCsvV9x+U6BdKsDMF/GEt9PwkNl4uiq
         LpxYoDVeKq1yeX/8EoGZZOPtc+jxvMxg6fNS1LLHfXTa7ThBSdY2mC0NcDUgWmi4rnjZ
         5kkqAs4iFMlrCYkhnAmSJSQZBfDsNzdm+JoJT/52SaSQNhx5zUZcW67BajMdNUDZQaJ5
         Cp6Q==
X-Gm-Message-State: AJIora/XVf6oe+i0NvNQ1nzbD6/7aLaFeAE47WIBkh4kF5pr/gK1QVpl
        Ax3VI42gJtr+lQif5rbDP+LY9XC2xOY=
X-Google-Smtp-Source: AGRyM1vLMjkdzPTs/IQ94lre7gNFopfB20P52k7OoZki89NasntfkzDs7TGQa9TfGfekErL80gh5Tg==
X-Received: by 2002:a05:6a00:c84:b0:528:a24f:60f3 with SMTP id a4-20020a056a000c8400b00528a24f60f3mr5830333pfv.66.1657313952513;
        Fri, 08 Jul 2022 13:59:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a0e0100b001eafa265869sm2043201pje.56.2022.07.08.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:59:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH v2 2/8] ARM: dts: Move BCM963138DVT board dts to ARCH_BCMBCA
Date:   Fri,  8 Jul 2022 13:59:10 -0700
Message-Id: <20220708205910.2422527-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707070037.261532-3-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com> <20220707070037.261532-3-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jul 2022 00:00:32 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Use CONFIG_ARCH_BCMBCA to build all the BCMBCA SoC dts and remove
> CONFIG_ARCH_BCM_63XX from the makefile
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
