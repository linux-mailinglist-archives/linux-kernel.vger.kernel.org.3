Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420F3559509
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiFXII4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiFXIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:08:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD779297
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:07:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sb34so3043959ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3ke34b4cDdKP8BuzxSOi78JgE06gxAc6TUkX4cmsZ4=;
        b=A+uDdmAZi12ZjPIEvjhqc0qsqIssqQRyf5S4TrxBebRr0lIwrWjnFabzQwwtQJ632a
         L2uUeg+OxKFRE7iE56Yg8quIvAdRabWj5WnR/u9rWkqkiOTaQFpO3Z35pUg4fWKc9v3n
         zB+iGL6+di1nh0AxAldNjYT53rZ4Aib4izGXQPpu1XMOYJOa0+ZV4d7ClxSw8mdCL93B
         f0phNcsdIo50wbqN7gTgUauASc2zKszufO+ixNw7sXl+YPI5lUGUjaATbtGzRs5jItns
         onXHtHJEevF8e1l3+qFIsB9pOy4DpaoO9D41LXCgAoDKjXej4lMNKfibGCz7CDn/wn3C
         Lhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3ke34b4cDdKP8BuzxSOi78JgE06gxAc6TUkX4cmsZ4=;
        b=NlwqO/5bq3dDgbF9GfbE8HXVs4vm1LDu2/RQOOc7fOyX3QYhrUFHMeVyRtZLc2Lqb/
         VFQ3flfoBZwgIJc4TmgnMgojVQbI+k6zPDsRw1t8UYft1AswpuGt3zQksMZ74cCLglyr
         pCvCmdCwSdEs2eMcgl5JYXS9vcwvwJR2dhsCzbf3W8RkW+xqCKoAoC1LDB5A5RG5gG+S
         1mf+zNXieXhDaFLFNxyOfBBqlH5mMjx5OQ5o4DWhZr6it+s/5cJhKF2OrKFFRDbcFqqT
         E9EGPM8/Nf9Ii4H8oVq3JS/mavYIin9ZmROcNTB6nKW+QnEyLKTIgMh4+8e1GHb5nbK/
         Hf9A==
X-Gm-Message-State: AJIora/tOB+cBFvO2jcjgHpnSQilONlRSLmg11wBTDCpBq7IfUXX5Wdb
        yU34rYGYY/Op+Kkxygd9sVyl0Q==
X-Google-Smtp-Source: AGRyM1tq7NkXMJBQnC7xYZQAE5QB8ihpO5WhMQvkJ8X1H9TpPtpdmkP512zLWBKoSoZOg5QKrvqTTw==
X-Received: by 2002:a17:907:30cb:b0:722:e898:c9c8 with SMTP id vl11-20020a17090730cb00b00722e898c9c8mr12054781ejb.465.1656058070532;
        Fri, 24 Jun 2022 01:07:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7ca4f000000b0043559d9e8b9sm1363573edt.53.2022.06.24.01.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:07:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [GIT PULL 2/3] arm64: dts: samsung: dts for v5.20
Date:   Fri, 24 Jun 2022 10:07:45 +0200
Message-Id: <20220624080746.31947-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624080746.31947-1-krzysztof.kozlowski@linaro.org>
References: <20220624080746.31947-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes bindings headers which were shared with Samsung clk tree (Sylwester).

Best regards,
Krzysztof


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.20

for you to fetch changes up to 1a4f20cab6411c6e73dd22d28b6595b728cc2829:

  Merge branch 'for-v5.20/exynos7885-emmc-clk' into next/dt64 (2022-06-24 09:12:47 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.20

1. Add CPU cache, UFS to Tesla FSD.
2. Add reboot-mode (boot into specific bootloader mode) to ExynosAutov9.
3. Add watchdogs to ExynosAutov9.
4. Add eMMC to Exynos7885 JackpotLTE (Samsung Galaxy A8).
5. DTS cleanup: white-spaces, node names, LED color/function.
6. Switch to DTS-local header for pinctrl register values instead of
   bindings header.  The bindings header is being deprecated because it
   does not reflect the purpose of bindings.

----------------------------------------------------------------
Alim Akhtar (2):
      arm64: dts: fsd: Add cpu cache information
      arm64: dts: fsd: add ufs device node

Chanho Park (6):
      dt-bindings: soc: add samsung,boot-mode definitions
      arm64: dts: exynos: add syscon reboot/reboot_mode support in ExynosAutov9
      arm64: dts: exynos: add watchdog in ExynosAutov9
      arm64: dts: exynos: adjust DT style of ufs nodes in ExynosAutov9
      arm64: dts: exynos: add secondary ufs devices in ExynosAutov9
      arm64: dts: exynos: enable secondary ufs devices ExynosAutov9 SADK

David Virag (3):
      dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS
      dt-bindings: clock: Add indices for Exynos7885 TREX clocks
      arm64: dts: exynos: Add internal eMMC support to jackpotlte

Krzysztof Kozlowski (5):
      arm64: dts: exynos: adjust whitespace around '='
      arm64: dts: exynos: align MMC node name with dtschema
      arm64: dts: exynos: use local header for pinctrl register values
      arm64: dts: fsd: use local header for pinctrl register values
      Merge branch 'for-v5.20/exynos7885-emmc-clk' into next/dt64

 .../bindings/clock/samsung,exynos7885-clock.yaml   |  27 +++++
 arch/arm64/boot/dts/exynos/exynos-pinctrl.h        |  79 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |   2 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |   6 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   6 +-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |  72 ++++++-------
 .../boot/dts/exynos/exynos7885-jackpotlte.dts      |  20 ++++
 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi |   2 +-
 arch/arm64/boot/dts/exynos/exynos7885.dtsi         |  32 ++++++
 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi  |   2 +-
 .../boot/dts/exynos/exynosautov9-pinctrl.dtsi      |   2 +-
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts   |  18 ++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |  83 ++++++++++++--
 arch/arm64/boot/dts/tesla/fsd-evb.dts              |   4 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi         | 106 ++++++++++--------
 arch/arm64/boot/dts/tesla/fsd-pinctrl.h            |  33 ++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi                 | 120 +++++++++++++++++++++
 include/dt-bindings/clock/exynos7885.h             |  54 ++++++++--
 include/dt-bindings/soc/samsung,boot-mode.h        |  18 ++++
 19 files changed, 578 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos-pinctrl.h
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.h
 create mode 100644 include/dt-bindings/soc/samsung,boot-mode.h
