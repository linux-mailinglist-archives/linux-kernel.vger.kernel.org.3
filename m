Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011B58CF05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiHHURi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiHHUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:17:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0461A3AF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:17:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j1so12127060wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vGj2Bb5L9+7NMTTYbD14Ip89h8qRunV+1yfxzA8G/sQ=;
        b=esymICCs8SCBzsCp5qKs+HX4CVh3Br9azs/Wh+m0cBJHFtCPan/gFKvtYA1n942dsZ
         zmaHIPBJ08pXkB1Gp6uToR7fOAq0lbJ49wjV8cxL+CTvqXmDNd8ATVq1AIdVRaegx9pm
         65An1dlP/sAG5oV1NTZ/0+p9FuaDILYEuRf4VRAVC1OvmNX3AfVOTTA1LbigV7fuzTt9
         OKb0cNsIXMTY6ExjtHKf2KmUCYAIVxKL9Rk+iyKxkBHQvgw44WurvtwKfzZhgJ0mFLmO
         cWiN+836mtdKxTE/asNlcUXPyYf2diIL3s3UqefwBrtWmZl7icWkwtwXrtfTEjKKh/wZ
         JxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vGj2Bb5L9+7NMTTYbD14Ip89h8qRunV+1yfxzA8G/sQ=;
        b=JfGJIFeNWQ9BG7GR/e4zmd0gazRt/puCUptYE67hamCASkODa9IO4sMoi//ecWIloa
         Lqlfvwu5csiPiCSoDicqKskoJW5jFM5N4yiyDG0sMDNxxwlgtwgtotjIW/JS7DQpyVwH
         vyyeD6QFMxz6bBUXqSYk+4WyYZDIBEM9pUOzkzkCBn7EV1OWz2287lKSfKE0DQqq/eQb
         sljsbYmKG16H1qOVZtjcDevl2ZhUjR9IKwgU36lCZM/CoUhCwtl8oTYgKOguwJoN5YsG
         zTjs5/jKSxPWzAqerTBVnvroJQHRkumMZmTPVB6K1OXX5/0e3fUapbfaHzYi80eeYYg2
         67Qg==
X-Gm-Message-State: ACgBeo27vgRp+xghSFtJIzdvp+9wFKxPnS0tHU+gduhvLxh3okhJwer5
        8QkwwmqvNxz6ahx7kpIgmZRd9g==
X-Google-Smtp-Source: AA6agR4mP4bc40EK/gFwKYGWHP5+iz33mqkaGVmznELuOo+WmfkPApX/bXu6XMnp0NqdtlQ+I+aTtg==
X-Received: by 2002:a5d:6da8:0:b0:221:7db8:de0a with SMTP id u8-20020a5d6da8000000b002217db8de0amr8088080wrs.405.1659989845995;
        Mon, 08 Aug 2022 13:17:25 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p29-20020a1c545d000000b003a54f5fcc5dsm2059702wmi.10.2022.08.08.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:17:25 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: exynos850: Add cmu and sysmmu nodes
Date:   Mon,  8 Aug 2022 23:17:22 +0300
Message-Id: <20220808201724.27831-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
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

Now that all clock domains needed for SysMMUs are implemented [1]
(pending), and the basic SysMMU v7 support is ready as well [2], let's
add all related CMU and SysMMU nodes to Exynos850 SoC device tree.

All those SysMMU instances were tested with "emulated translation"
driver [4] on E850-96 board: both the emulated translation and fault
handling were verified.

This patch series depends on [1], so it must be taken into the account
when merging it.

[1] https://lkml.org/lkml/2022/8/8/752
[2] https://lkml.org/lkml/2022/7/14/1215
[3] https://lkml.org/lkml/2022/7/26/950
[4] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Sam Protsenko (2):
  arm64: dts: exynos: Add CMU_AUD, CMU_IS and CMU_MFCMSCL for Exynos850
  arm64: dts: exynos: Add SysMMU nodes for Exynos850

 arch/arm64/boot/dts/exynos/exynos850.dtsi | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

-- 
2.30.2

