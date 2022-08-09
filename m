Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8A58D81C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbiHILde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiHILd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:33:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85623173
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:33:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f22so14684211edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xR5rzFsIQ1UDoQHJneEWBtnsGAQZ3fnWRdL921S7Ltk=;
        b=EBUcAinbqq6KcB+13temagJZdXpcX/+1T1934su+5uCU0jZBMR5iNXVC8KF3Vuu+Oi
         SmSNPhyrEe9vSYhJAmmvFG4dwacq5s12FnQwmw7mIHEqFVMZynjlCR7DvISClCGj4M0+
         rv2uDQNpr90n3KDgLailQCK2bN14g6JRd45AXmNSIoqBtt1Vzzm0N7NI+k2mknl/WqFP
         uZHXEJ8Bly1/ORTgvwnZinKd6cmBm3dlYO16Sa+iV1iCIwwFnfGTrDHFc3q+25Z5GJkA
         BjK0qxIih+DB63WInTHbWg3WbxpcmIUPZitxKGKRURRWXIKHtCH3llskh8XPnDo7mHCz
         r1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xR5rzFsIQ1UDoQHJneEWBtnsGAQZ3fnWRdL921S7Ltk=;
        b=v5ANGMIZI5gnnz4nod9ZK3XOsd/ibUfaT/8rHdKr0rJTMbINeenHNYNGf5R2CQDQrI
         D8H3lNn0r1/lxWMB21mU4tcFXP8lULH5nvrCjFYfMJiTlwSNOt3I+eeNgqj3oGKuRj9n
         EHWNGFS8mvco5XIg6JeOlyXBAjElzFa1JGk5etusRGtcR6RJzTjZpQoWskXtZHvIdLiH
         5Cbt9vIQuTuf6u1v0KNGTYSzVoYkzVKWApWRQCOFrHMBevAO5wB0ri6TJB5csuYvOGPT
         DdO1f6EzQJmCp4t44bQ5MsEBEjtX+yPs0esKQsHZHr8JFKfnAI7qaU2IIPDgeQoEitT+
         o+1A==
X-Gm-Message-State: ACgBeo34AwGMLLA2AOUWIY2h7pkxThcgePVQKMwMCFttRmL2GM3FTKhR
        Z3MrWTqngKdv+0TzBOXIRsEbNA==
X-Google-Smtp-Source: AA6agR5lXIV0eR+0FAoTZLmeCH2/8SkXvUoI7PDSooWFU6O8m3Y3IC1SGC/47MRrF0yjMfBvJCn1OA==
X-Received: by 2002:a05:6402:4507:b0:43b:b8df:571d with SMTP id ez7-20020a056402450700b0043bb8df571dmr21617690edb.230.1660044804413;
        Tue, 09 Aug 2022 04:33:24 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id r12-20020a1709064d0c00b0072f42ca292bsm1007898eju.129.2022.08.09.04.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:33:24 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/9] exynos850: Add cmu and sysmmu nodes
Date:   Tue,  9 Aug 2022 14:33:14 +0300
Message-Id: <20220809113323.29965-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

Now that the basic SysMMU v7 support is ready [1,2], all SysMMU nodes
can be added to Exynos850 SoC device tree. This series includes next
changes:

  1. Add all missing clock domains needed for SysMMU clocks
  2. Add corresponding CMU nodes in device tree
  3. Add all SysMMU nodes in device tree

All SysMMU instances were tested with "emulated translation" driver [3]
on E850-96 board: both the emulated translation and fault handling were
verified.

[1] https://lkml.org/lkml/2022/7/14/1215
[2] https://lkml.org/lkml/2022/7/26/950
[3] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Changes in v2:
  - Joined CMU and DTS patch series patches into one
  - Sorted sysmmu nodes by unit address

Sam Protsenko (9):
  dt-bindings: clock: Add bindings for Exynos850 CMU_AUD
  dt-bindings: clock: Add bindings for Exynos850 CMU_IS
  dt-bindings: clock: Add bindings for Exynos850 CMU_MFCMSCL
  clk: samsung: exynos850: Style fixes
  clk: samsung: exynos850: Implement CMU_AUD domain
  clk: samsung: exynos850: Implement CMU_IS domain
  clk: samsung: exynos850: Implement CMU_MFCMSCL domain
  arm64: dts: exynos: Add CMU_AUD, CMU_IS and CMU_MFCMSCL for Exynos850
  arm64: dts: exynos: Add SysMMU nodes for Exynos850

 .../clock/samsung,exynos850-clock.yaml        |  69 ++
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  83 +++
 drivers/clk/samsung/clk-exynos850.c           | 682 +++++++++++++++++-
 include/dt-bindings/clock/exynos850.h         | 136 +++-
 4 files changed, 966 insertions(+), 4 deletions(-)

-- 
2.30.2

