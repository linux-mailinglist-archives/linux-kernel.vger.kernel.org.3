Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC74CD432
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiCDMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiCDMZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:25:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3D1B01B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:25:03 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BA183F600
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646396701;
        bh=TY+lA6i8XxWtBRy+CXNMVFSE4D7AiD1N2aYEOcdmjms=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=TdV5B039W6BVETRjGNXr9xZLlfkCFhMRDU0ye62UlOf0bALlak65BthFUHt32qQSI
         yfoVkqsOaVLC35ufUeP8IE8Pb3x7VmL4RMQl8zI1zlcfpiHp1aA4zPg6uMw2PQ1HJU
         BCyJJbg4fiJ/iMQLCLZA/V0h1nL05h7p1fEYTpKRhLXikr02oUxHtTIgwfhnYmHxmr
         ChWIMg8cWNSOVNW2fZ5g5XPlTj0apf73tKxfLpGl27+P67vBmiHX4GEqLdImpQymYj
         MxqP37JeS19WRRzIglRfm9DLgLVMIIVqujKcbPMCWj+Wh09Pow2m2Qi5dapNmWlwGS
         8s+hP5Afl1L+Q==
Received: by mail-ej1-f71.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so4321137ejk.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TY+lA6i8XxWtBRy+CXNMVFSE4D7AiD1N2aYEOcdmjms=;
        b=JASdAtl6a08RHNrswT4Jb2eAFlcRMKNkIH8lbbCn97qDMTkft5FmK4wJ2T4PLM/7JZ
         yHiqBO8XPvbjWqp+q57uaNeE9JzhJsFLUXKOpLrwqcJRzxIs8jqjGktlATQl92atN3JZ
         sLiOtnlG+qAtLrLg5FQntW6FcgUOqu0SzlMWs2YMO/wH0smwX8WnNl5MNaOREQAJQS7+
         oOIQBBS3S6be6C5cpY6XGHb35J8PuODLklewx/Cp2jcGRxGwtnGCYf0nUrl/RoimCOC/
         bNF641VP00oepmsHZKvvURsoS9dBuqZ2JVTBImKrBCEun6OMdR6ywhZlBzhmeEsLyPcG
         BvGg==
X-Gm-Message-State: AOAM530oCwhX6XrQx1YzRqU1RLnZqKyz+E5In8U173/ojvc9Jq4mJG29
        G1Sg6T4taevHy9bZWsUS+p1zJQVUh4zmS6xK4Vw4e1vJANjFtRDx8AUY/hMJ7GVV8LLMqkOJEmO
        vqknUD6vcNjTl1AqXi4o+Cx6e+RuvussKHvbCuoS1+w==
X-Received: by 2002:a17:906:b207:b0:6da:81ba:3789 with SMTP id p7-20020a170906b20700b006da81ba3789mr8302678ejz.578.1646396700463;
        Fri, 04 Mar 2022 04:25:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWzK+iNBIRKwo4mH2PPJHmzHvNxYOtWvwU/P0Gkg3e+/8BPPc+9gd/RWrf4ekFqNBIo2I59Q==
X-Received: by 2002:a17:906:b207:b0:6da:81ba:3789 with SMTP id p7-20020a170906b20700b006da81ba3789mr8302658ejz.578.1646396700216;
        Fri, 04 Mar 2022 04:25:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00415a1431488sm2047368eds.4.2022.03.04.04.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 04:24:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/4] dt-bindings: timer: exynos4210-mct: describe known hardware and its interrupts
Date:   Fri,  4 Mar 2022 13:24:20 +0100
Message-Id: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Patch 1: Specify Tesla FSD interrupts.
2. New patch 4 for Tesla FSD.
3. Add review tags.

Merging/dependencies
====================
The dt-bindings (patch 1) can go via timer tree and I will take later DTS
patches via Samsung Soc.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: timer: exynos4210-mct: describe known hardware and its
    interrupts
  ARM: dts: exynos: add a specific compatible to MCT
  arm64: dts: exynos: add a specific compatible to MCT
  arm64: dts: tesla: add a specific compatible to MCT on FSD

 .../timer/samsung,exynos4210-mct.yaml         | 67 ++++++++++++++++++-
 arch/arm/boot/dts/exynos3250.dtsi             |  3 +-
 arch/arm/boot/dts/exynos5250.dtsi             |  3 +-
 arch/arm/boot/dts/exynos5260.dtsi             |  3 +-
 arch/arm/boot/dts/exynos54xx.dtsi             |  3 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  3 +-
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  3 +-
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  2 +-
 8 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.32.0

