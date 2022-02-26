Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AB4C586C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiBZWCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiBZWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:02:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C727144E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:01:29 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C989F40017
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645912884;
        bh=xV/5bMwc5qAM+A4IvuW3pBdozLYDEc1r9Q3hw04Dixk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VE/fUGW0KSTweZ7t4JsHvA44LFSfo4TuDaPbM17ddbeM68k1XP3AQ3ZQSudhKZ3de
         zZC7SfLvTjAW587xOLRwDAIAiRvxBaWC3Y9ADaB9QSzIzXYGH6wThPXkqkQI7t2cgw
         TxKLwuCsP4gUQI9sz0xsNo7CwnyXEYrdte0SuNgQAciInQFh9ByOmOCpILUbtApV4o
         A9EcbEGLxfCKOPaCL5Euwup9NQZm84p83W9dfXx9Eaxn0TFKadPunD7OzlSgdvfJ4u
         oHwPGNDP43v95OCuyKDkmk3BVMwLs8+JdS9Jj7Nn1g9M+fPxEx50TtiGl2UljTUGlS
         JsgFFOk8SleWA==
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso3427103edh.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xV/5bMwc5qAM+A4IvuW3pBdozLYDEc1r9Q3hw04Dixk=;
        b=dfGcr6lUHhKlUsKSI9UFQqVXxkpPvFlcFp55kln8XsL7TRsK4evsuw8EX0pqy49iY0
         L2qqXaEXaQeQooRG9T0gu6fj1+s8deNi0n1Tcws7ypfnFLhmWCEdv9F3XrH4jJ9l94iu
         AahuxmmenQwEwDvN3wDQmRzM4o8DXXhbVoufSh8GCX/h8D499l/6TWTN3q0iQdikiPzj
         3Qx3yP03jODecFLqgsD61aCA1d5YTyWwZSJobvc1nQakbvS0F67mmz1E7bBnUhLuGY5H
         +kxHWxzaBgG7sq5UvCai/8SSyUn2TEpJpVI1CZUFUQFTcHi5l8GFbicyp/vdmmwC1Pw4
         L90g==
X-Gm-Message-State: AOAM530glqZdzuYgdE5ob7KKSS9piUMSiHPPlZGF54ReuCEZFbIPXgX3
        k4+500lmaIe9ZDuAepXZ/M7ZSI9YxKXQFBlb37ufgGYg6sllR6+yjks9pnBnY/VcHtWRjDajiDw
        Nb+CQRUh4aQablSPPHOakfAxD/H13bjWlZB/aMB0YCQ==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr10407901ejg.413.1645912883765;
        Sat, 26 Feb 2022 14:01:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxs93C93YzMJrP3OiKQ/sgLNFsaAgYmkcNTN7UpTw7SIF6jbShVHGKqvZnBavwKBdlkJ/mhZw==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr10407892ejg.413.1645912883577;
        Sat, 26 Feb 2022 14:01:23 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402014200b0041285556b7csm3497424edu.72.2022.02.26.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 14:01:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/3] arm64: dts: samsung: Second round for v5.18
Date:   Sat, 26 Feb 2022 23:01:15 +0100
Message-Id: <20220226220116.13452-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220226220116.13452-1-krzysztof.kozlowski@canonical.com>
References: <20220226220116.13452-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit a0d5455330ece6f50ddf9e71d530f91c302803e9:

  arm64: dts: exynos: adjust USB DRD clocks with dtschema in Exynos7 (2022-02-01 09:17:16 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.18-2

for you to fetch changes up to 06874015327ba7bf6aae49ca825a492a2679237f:

  arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC (2022-02-23 14:08:04 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.18, part two

1. Minor fixes and cleanups in newly introduced support for Exynos850.
2. Add basic support for Exynos7885 and  Samsung Galaxy A8 (2018):
   SM-A530F.

----------------------------------------------------------------
David Virag (1):
      arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC

Krzysztof Kozlowski (3):
      arm64: dts: exynos: drop incorrectly placed wakeup interrupts in Exynos850
      arm64: dts: exynos: align pinctrl with dtschema in Exynos850
      arm64: dts: exynos: use dedicated wake-up pinctrl compatible in Exynos850

 arch/arm64/boot/dts/exynos/Makefile                |   9 +-
 .../boot/dts/exynos/exynos7885-jackpotlte.dts      |  92 +++
 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi | 855 +++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi         | 423 ++++++++++
 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi  |  56 +-
 arch/arm64/boot/dts/exynos/exynos850.dtsi          |  44 +-
 6 files changed, 1405 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
