Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9DA51D320
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbiEFISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244890AbiEFISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:18:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A576831B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:14:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so9000715wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPR6X1/5iNCBXtbnX66uCQIutWnYnxxfF1cQKI0F89Q=;
        b=WkgG6WSI+10URWnnxADk2gnFNJ7bptdLwRVp9djlHAJC/eaWKg+rXuPJzFeQPcUeHl
         SHeiu6I3qjq+3S2C3cHTMGmjMtaSjtzM6AUGz3j+6feJSWcS1V8tocQrlzRQiPUWCZPj
         A4QMzUMgK4vgIxb6Th1x+SuKo3MpBBoYOqPE973ci0+XE2odjSfElW+xsTMCEn1MB/51
         z3kSIDhW+Oogj9KYFayjIRwjW+sWf3slUb0V5Nhw9MGo4H4pyI8Z7PBDrtrRb2d3WMg6
         30Ro0MpSLWlBluimv7AU1fxMvVbfFx+avJzVYX/n8Co07R48PseO7Q2FxwI4lOfupNM2
         u8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPR6X1/5iNCBXtbnX66uCQIutWnYnxxfF1cQKI0F89Q=;
        b=ojbGdun3fu0W5DdYKRrcI+hRt6BShdjSO5TZ1dCr6Lmxut0B+eqD67iWEbYAv6QJ8b
         3YoaQZcF8KPeRl9K7U5Gh0zOZ3vDaDAQkFhKom+RiqH+Pm3dtKAVAv5ngkRAGuVSgB5t
         VOzx5yfRUxKdCzUOmDwLk4lXnIXe0jtZEbuGdUNZf7IwWq/7LGsr+WJ9m5QgkBubKzGT
         NcH0GBa8gMuWwwiAUfFC1wxlW1aISmt1V+9wTR8zqmbugYX4jEitKLv3BPp+tQ3bSiIw
         pDR47pKOGRtrT9QlKz/t5yUC7NHUBHtEHQZxndnKXivc0oAYbz4qIovXxydofguBYqjH
         JMTQ==
X-Gm-Message-State: AOAM530uhv6tlZs5Y29TuyS3LObXtCR/NzB1U+HiSDYnLs/+GvzMgS6T
        gwh+XDOCcv6SCvCvOsYAyg0npg==
X-Google-Smtp-Source: ABdhPJxCwSWKm1pKbetAWMNdn/ekJKOLq/QpcIQOJBTr93TqXwZyP5/HYHS/ZW6GosYHPQbbllOCgQ==
X-Received: by 2002:adf:dc0e:0:b0:20c:8a3f:b523 with SMTP id t14-20020adfdc0e000000b0020c8a3fb523mr1673836wri.201.1651824887180;
        Fri, 06 May 2022 01:14:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b0020c6fa5a797sm3059657wrr.91.2022.05.06.01.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:14:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 4/6] ARM: dts: samsung: pull for v5.19, part two
Date:   Fri,  6 May 2022 10:14:36 +0200
Message-Id: <20220506081438.149192-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
References: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
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

On top of previous pull.

Best regards,
Krzysztof


The following changes since commit 9e916fb9bc3d16066286f19fc9c51d26a6aec6bd:

  ARM: dts: s5pv210: align DMA channels with dtschema (2022-04-09 18:50:05 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.19-2

for you to fetch changes up to d414b7a3f370d640cff544a3aa3a41abf34fd5d6:

  ARM: dts: exynos: drop useless 'dma-channels/requests' properties (2022-05-04 10:23:27 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.19, part two

1. Cleanups: unused and undocumented dma-channels and dma-requests.
2. Correct compatible of Samsung EEPROM on S5PV210.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
      ARM: dts: s5pv210: drop useless 'dma-channels/requests' properties
      ARM: dts: exynos: drop useless 'dma-channels/requests' properties

 arch/arm/boot/dts/exynos3250.dtsi               |  4 ----
 arch/arm/boot/dts/exynos4.dtsi                  |  6 ------
 arch/arm/boot/dts/exynos4210-universal_c210.dts |  2 --
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |  4 ++--
 arch/arm/boot/dts/exynos5250.dtsi               |  8 --------
 arch/arm/boot/dts/exynos5410.dtsi               |  4 ----
 arch/arm/boot/dts/exynos5420.dtsi               | 10 ----------
 arch/arm/boot/dts/s5pv210.dtsi                  |  6 ------
 8 files changed, 2 insertions(+), 42 deletions(-)
