Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2924C5879
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiBZWCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiBZWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:02:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF281AE662
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:01:24 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E8493F1BE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 22:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645912883;
        bh=wEJI0tsPJ58dwyE9Xp27AwQHbd9ZGSbsPqkX6S6UniU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=gMQKDLtIpkrsrkBTeJuWzdwteXI488j2vZsFYzU5XX6oDRVX3DDQ/ZdxZUrfPiUlA
         5SlI3m1Qe6+0zZdW0K0E+9SGPB7uEnXlPB73KatmRDKwOwln98BoQ8+9UGue11MMLc
         SVfFxMTGVWsaW1ByymfwdFVQidBr+6QyndCln8EjXLoqxO+RhTtPQ8yn8zJawOfF6l
         wt2At1hsVdTQmcLGgqcHgt5ITKMgFPl9Xn/Elw6DgKUnjLUq1qz6ESfZ8im5wFffLB
         QOtm1LMz14RRFu+jQyFumrpS7IVfcD1ZMLsDQuEhMEbLzFXogLaT0c99IbV41UsTXy
         I01E9ktWjgy/Q==
Received: by mail-ed1-f71.google.com with SMTP id m11-20020a056402430b00b00410678d119eso3390411edc.21
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEJI0tsPJ58dwyE9Xp27AwQHbd9ZGSbsPqkX6S6UniU=;
        b=7H1FT9ekoWM/3GT/31T+Bg45LzH2xnTGo0PuBuBxSLMeA6zodSNWPyxGGBrtsgT45k
         VrFW5WdZ6rNIslliZ7fkiwJXUAGYdVCDBiteX/xWT/jPUq4TTaL3aobrKv0ZU2AAlh18
         yq2SOkEr8vwHgE0zsZLfzzqTV5z9rgf2mDHl5qnHypRd1dqbjU7lhEauN3tLAogAnFKb
         fndy9H2jcmifrpvp4/N+2AIFM0foiqzK1gq5yw8hXX885vgBOnj0sSm6k8jL00Wa7Odp
         kNFt5djyfnr9OEmX9cNexjqgv9EqMoOcCV8Unnr29011XRCQ+4Fm6sXGtbCVx4kpBw/7
         LUew==
X-Gm-Message-State: AOAM533G3egUDjexWaj2HmGPzrm76WPwwTIptPm1JKQZfzfuOz24e8Ew
        VMY8UEmkPeMEf1MD/GSewVZKIzRKsTwMMdKSp2JzYEq4zi39uJRxFboY0n9P/z+KsLymHSNikeQ
        Ty38N8p8wEgpTznnXAYPG/bmUQ/Tu54LLEmPECh7STQ==
X-Received: by 2002:a50:fb89:0:b0:413:94d8:7c56 with SMTP id e9-20020a50fb89000000b0041394d87c56mr3352372edq.143.1645912882477;
        Sat, 26 Feb 2022 14:01:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEBhuaA6wu2knYliwBM0vfBK3OqsI4wC3+TjCY0HhYvYRPRyZBWMQcEQwW1VhP271dIbvvaw==
X-Received: by 2002:a50:fb89:0:b0:413:94d8:7c56 with SMTP id e9-20020a50fb89000000b0041394d87c56mr3352361edq.143.1645912882295;
        Sat, 26 Feb 2022 14:01:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402014200b0041285556b7csm3497424edu.72.2022.02.26.14.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 14:01:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] ARM: dts: samsung: Second round for v5.18
Date:   Sat, 26 Feb 2022 23:01:14 +0100
Message-Id: <20220226220116.13452-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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


The following changes since commit f5b721d2c91144b7c494a05003fc840f1607e876:

  ARM: dts: exynos: use generic node name for LPDDR3 timings in Odroid (2022-02-05 13:04:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.18-2

for you to fetch changes up to 7cdfe3b3b60c89f0e12e8ee194a7cfbfd46515dd:

  ARM: dts: exynos: align PPMU event node names with dtschema (2022-02-18 14:17:40 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.18, part two

Various cleanups after introducing DT schema: adding missing HDMI
supplies and aligning PPMU event node names with DT schema.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: dts: exynos: add missing HDMI supplies on SMDK5250
      ARM: dts: exynos: add missing HDMI supplies on SMDK5420
      ARM: dts: exynos: align PPMU event node names with dtschema

 arch/arm/boot/dts/exynos5250-smdk5250.dts |  3 +++
 arch/arm/boot/dts/exynos5420-smdk5420.dts |  3 +++
 arch/arm/boot/dts/exynos5420.dtsi         | 16 ++++++++--------
 3 files changed, 14 insertions(+), 8 deletions(-)
