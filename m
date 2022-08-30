Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F615A6C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiH3SfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiH3SfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:35:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5D6338
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:34:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z6so16713241lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2qc4z4IniWo5S8Bjp3Lb04VkKR2XhFXi6h1hRVoeddw=;
        b=qpMHDsaE+ARKwZPkRz6IRLDlJ7VtqId5wp+4T6HGUEbCLJsbF5YP9gHCCdt9inih7s
         x8l6nXDAC9uWxI0rfem6ZOjMPmaIDBNy1GFefYAJz4QDhBT74NLhoZ0om1hKm08q7VHh
         +phR+Z/nkhWVZCFxk+/utrxnT2P+5pLMmEj510hC3Pvnqn7Bv1ecUW8ccMR7wnQvVHCm
         +9LykdEJTVS+39K0q97h0JuywbBdhsqtAgUL37dCHDHkoAnOwEFb4ZlPz5/5ZvJzXdRW
         ZeXFcYvmCqQW0rFb+cqoxg1K3p/yDdTIL/MyYcDrekEvdSAT31IAuNgSQKHDOKJXMVlk
         3F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2qc4z4IniWo5S8Bjp3Lb04VkKR2XhFXi6h1hRVoeddw=;
        b=HoROMw5xQKw86GdChuLWUwe4867oRYTAQ8G3Cq2p+IZH3WI1lVbR7k08gkGi2iL3Uu
         /zD40kdaSuFIeu+Bzd04On+T77k1lTZNxqP73VwmKhfacGE9SEkM4NT0LIMO0hLm158R
         CIv4x8RxjyEbknocyTdD2kvU6Nu8ZbZy2tIXZDYCo2+Jw4zfg3vhykxV+EJJtOJfXN5c
         2omxJeCPCLmKDKNnaq6HFFvxUxJdEEVRvQ42wubF+sFgoMP1w332hvAWjzz1oQWmplVs
         3h7NYuE1Fg1Do+sfWqpHcf/fHn/3tk+m0B95nIb6IybjzBPn3R0GRW31Z76IyW/Z0q5H
         XqvQ==
X-Gm-Message-State: ACgBeo1qYkzxyYzAGu2X0v8xPvNZlxxQPsfcIkkuylYzNFaK4fhgiLN/
        C+C/UcVLBUtTSuPGpCjNIGoM5Q==
X-Google-Smtp-Source: AA6agR4/olU/KNlq60S9dpcH9lGfvx1IyF/SOa/kzAEpuENf6xMvHJWfCxVaAYu+ZS8TKwbsWS/wbw==
X-Received: by 2002:a05:6512:3f14:b0:47d:e011:f19b with SMTP id y20-20020a0565123f1400b0047de011f19bmr7603468lfa.427.1661884494655;
        Tue, 30 Aug 2022 11:34:54 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b004945f2de7ebsm1224892lfq.262.2022.08.30.11.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:34:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: for v6.1
Date:   Tue, 30 Aug 2022 21:34:48 +0300
Message-Id: <20220830183448.18997-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi Stephen,

Samsung clocks from a new tree. I hope we can meet on some Linux conference for
a key signing. :)

Best regards,
Krzysztof


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.1

for you to fetch changes up to ef96c458888fa2a329b14efc7991530f645fbddb:

  clk: samsung: MAINTAINERS: add Krzysztof Kozlowski (2022-08-24 16:10:22 +0300)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.1

1. Exynos7885: add FSYS, TREX and MFC clock controllers.
2. Exynos850: add IS and AUD (audio) clock controllers with bindings.
3. ExynosAutov9: add FSYS clock controllers with bindings.
4. ExynosAutov9: correct clock IDs in bindings of Peric 0 and 1 clock
   controllers, due to duplicated entries.  This is an acceptable ABI
   break: recently developed/added platform so without legacies, acked
   by known users/developers.
5. ExynosAutov9: add few missing Peric 0/1 gates.
6. ExynosAutov9: correct register offsets of few Peric 0/1 clocks.
7. Minor code improvements (use of_device_get_match_data() helper, code
   style).
8. Add Krzysztof Kozlowski as co-maintainer of Samsung SoC clocks, as he
   already maintainers that architecture/platform.

----------------------------------------------------------------
Chanho Park (8):
      dt-bindings: clock: exynosautov9: correct clock numbering of peric0/c1
      dt-bindings: clock: exynosautov9: add fys0 clock definitions
      dt-bindings: clock: exynosautov9: add fsys1 clock definitions
      dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1
      clk: samsung: exynosautov9: add missing gate clks for peric0/c1
      clk: samsung: exynosautov9: correct register offsets of peric0/c1
      clk: samsung: exynosautov9: add fsys0 clock support
      clk: samsung: exynosautov9: add fsys1 clock support

David Virag (2):
      clk: samsung: exynos7885: Implement CMU_FSYS domain
      clk: samsung: exynos7885: Add TREX clocks

Krzysztof Kozlowski (2):
      Merge branch 'for-v6.0/samsung-clk-dt-bindings' into next/clk
      clk: samsung: MAINTAINERS: add Krzysztof Kozlowski

Minghao Chi (CGEL ZTE) (1):
      clk: samsung: exynos-clkout: Use of_device_get_match_data()

Sam Protsenko (7):
      dt-bindings: clock: exynos850: Add Exynos850 CMU_AUD
      dt-bindings: clock: exynos850: Add Exynos850 CMU_IS
      dt-bindings: clock: exynos850: Add Exynos850 CMU_MFCMSCL
      clk: samsung: exynos850: Style fixes
      clk: samsung: exynos850: Implement CMU_AUD domain
      clk: samsung: exynos850: Implement CMU_IS domain
      clk: samsung: exynos850: Implement CMU_MFCMSCL domain

 .../bindings/clock/samsung,exynos850-clock.yaml    |  69 +++
 .../bindings/clock/samsung,exynosautov9-clock.yaml |  44 ++
 MAINTAINERS                                        |   2 +
 drivers/clk/samsung/clk-exynos-clkout.c            |   6 +-
 drivers/clk/samsung/clk-exynos7885.c               | 207 ++++++-
 drivers/clk/samsung/clk-exynos850.c                | 682 ++++++++++++++++++++-
 drivers/clk/samsung/clk-exynosautov9.c             | 401 +++++++++++-
 include/dt-bindings/clock/exynos850.h              | 136 +++-
 include/dt-bindings/clock/samsung,exynosautov9.h   | 128 +++-
 9 files changed, 1620 insertions(+), 55 deletions(-)
