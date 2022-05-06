Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36251D31B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389999AbiEFISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389927AbiEFISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:18:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30B67D37
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:14:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i5so8968362wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlnEP2sEnpgHaHWLHUGilGQAFmisSdzAhYbMeYmMi38=;
        b=HqSMS5/QlpxxyQty/G7buZbiKC5JZBv493X9X2wC0oEUBsDKonsGh5N+pJWAqUlriL
         4jbbBCHGNWI4fTFip4nCrlLzTFclcrwmUKq426LSzcP9HdAOo4MO6fkoV71h7VM4Y5GJ
         hGGfoINQ/AsPkTBqg/RSyIX4rTNSGNWHkTN2m/sIbeaqJzaFq0fL0s2Ub9lKrMNJObqT
         mINHjAY5qaruojjVCNnYRQsgfwtt129XbEifzC5LiYdNSZdPTv9G3+kIFl/aFpRXx3hf
         y5z7LMANXEbOGvWsayJ+GdBPonvtH+/xgfP6oNBaJhlMKZ0FG0lkAsrWmUXHY44l1Okm
         agvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlnEP2sEnpgHaHWLHUGilGQAFmisSdzAhYbMeYmMi38=;
        b=h2vQaBU+SdoNXeNePJ+gyAXGWhKXYB3Dri3Du9GUUnfnIPxm5xGlHr1SzTHedeN4dN
         IXkpuBsMw9fkYu+FVFNIT0cn2tmnMBshcRL5CxoIfA1Sg8MXIaGOHgcS9Hd8AsvbxjQZ
         I58Wimi+fbDwyHRHu8w6QBGiKMW9vrViRSeki+tw3U3Hy3xLp5qaglvQETDuXniTqJc9
         F6RMCMsR2aViRdWPZvuSk85+d1mVPl5Ipw9z+5QtlnU7vVy/P2Xelm32PmAKSgi0/Poz
         69VUvB7Q8gVdwj/3Zt7dr3ClGK1DT5wbz6f5ceS8dK4h60mE5Zb5QsrNBPA0phliIs58
         u4xw==
X-Gm-Message-State: AOAM5317CTm8OFE4bnh7InMCPuYnDeynMAWPZip69HGG6Pz8inHfKpGp
        bVpcWTslc0f6OK6i+HokUi2ELYRcLHBBhIt5
X-Google-Smtp-Source: ABdhPJxXi6eJey+rbbTnYO7gBOA1PeS4alROquDDvhJbrStjJoPV9oexn9EDcYsYdGvcpMk/Lvd0lw==
X-Received: by 2002:a5d:6949:0:b0:20a:e021:f8e0 with SMTP id r9-20020a5d6949000000b0020ae021f8e0mr1720729wrw.231.1651824889058;
        Fri, 06 May 2022 01:14:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b0020c6fa5a797sm3059657wrr.91.2022.05.06.01.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:14:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 6/6] ARM: soc: samsung: for v5.19
Date:   Fri,  6 May 2022 10:14:38 +0200
Message-Id: <20220506081438.149192-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
References: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.19

for you to fetch changes up to 170a0c56c5ec597fa15447e63272827a80a19be1:

  ARM: s3c: fix typos in comments (2022-04-04 18:57:34 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.19

Cleanup: drop unneeded CONFIG_S3C24XX_PWM and fix some typos.

----------------------------------------------------------------
Julia Lawall (1):
      ARM: s3c: fix typos in comments

Uwe Kleine-König (1):
      ARM: s3c: Drop config symbol S3C24XX_PWM

 arch/arm/configs/mini2440_defconfig  | 3 ++-
 arch/arm/configs/s3c2410_defconfig   | 2 ++
 arch/arm/mach-s3c/Kconfig            | 8 --------
 arch/arm/mach-s3c/Kconfig.s3c24xx    | 2 --
 arch/arm/mach-s3c/iotiming-s3c2410.c | 2 +-
 arch/arm/mach-s3c/pm-s3c64xx.c       | 2 +-
 arch/arm/mach-s3c/s3c24xx.c          | 2 +-
 7 files changed, 7 insertions(+), 14 deletions(-)
