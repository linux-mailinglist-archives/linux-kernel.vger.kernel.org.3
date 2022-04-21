Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316950A6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390687AbiDURVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390694AbiDURVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:21:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1149F34;
        Thu, 21 Apr 2022 10:18:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d15so5466628pll.10;
        Thu, 21 Apr 2022 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ie8jud3FYYf5Wz7Zl7N8CKl6mddxM0cyW5w/2Vyr8aI=;
        b=O/N7v2QDeT3TuGNAgA1nA2XRtydZpjQOl6cVuwK9FP6Jh+Tr4M/gG+C8O1+CdHmkwl
         OIxRdzhD9NKKIOdtoIqSCrxSqKtHuEdu97HDRWYEYin/l2MVJ4Jv9+uKPz9rTiXZbAaE
         vdReylPPlPsHwqeADU/E3V+Ecveeepiscgw71wzwLmb5fxFNlo1+0xp2roOozbifDvSq
         ZHM46k1tpzd+oCyVTb4b+cw1YbbqKKHDC0IoM0bHRHucm4zGQOTad2w4lOyQtkBx+thg
         f8zpKgMo3KOAAVM5QD2DlxzZ7OvLT2sYthCiRN/nkoutflW5O0vM+omGdJz2URBcPelj
         lhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ie8jud3FYYf5Wz7Zl7N8CKl6mddxM0cyW5w/2Vyr8aI=;
        b=m02VBN9nUkS13hxV/4wthDotSzRLUye0NMLS5ARtEeSeOD4YWw5YL0e7VI2VbzGuxk
         40Ocno1eXyjhsOKdlaH20effuGZRDYa+gZUPq6yHJYWpGt0ohlavn2a+PFWVfvue77m3
         qKu06jff+KGIiiGgR8m3By8t11sAa70Mo1yKl+9BUIsbKvpwUvcJi6ElC3eK2D7/kq6W
         Yih5DbqSNbGSGEXgsr3n4jZ1rd1e/RoyLHb1IlusxqxJuyuK/uBzdVJ2zAttX4XRP1e3
         KJXzL7POqjJcWe0T8XirxhqKzrRP2f7P3EGlMAtu6Hn9ayuJmmgm5mlSPMNSUc8ToURL
         inCA==
X-Gm-Message-State: AOAM531F/jNrSPkfOxAAixSMp++vtZqUFjMGygpKkHPpFo3eziE8fr8u
        VJ05jFzVRUPmKpQX1d8bmeg=
X-Google-Smtp-Source: ABdhPJxtP5eiYBNLRxK9dsdlfKa3Vv5QjclQqf8KfePxEWnnrCljvAZOXcLJugdd6l/7TjMLNw5h+g==
X-Received: by 2002:a17:90a:6d96:b0:1c9:c1de:ef2f with SMTP id a22-20020a17090a6d9600b001c9c1deef2fmr11477251pjk.210.1650561495760;
        Thu, 21 Apr 2022 10:18:15 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m12-20020a62a20c000000b0050af5c925c3sm2881373pff.132.2022.04.21.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:18:15 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Use generic dma node name for Qcom platforms
Date:   Thu, 21 Apr 2022 22:48:05 +0530
Message-Id: <20220421171809.32722-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is changed from previous version as there's an
alternate contribution to convert BAM to DT schema. This patchset now
defines generic dma node name for Qualcomm armv7 based platforms.

Looking forward towards review comments. Thanks!

---
v4:
- Drop 3/6 and 6/6 patch from v3 series
- s/User/Use in commit description of all patches
- Didn't drop Krzysztof's R-b tag as I fixed a simple typo
- Alternate contribution for BAM:
  https://lore.kernel.org/lkml/20220211214941.f55q5yksittut3ep@amazon.com/T/#m6700c2695ee78e79060ac338d208ffd08ac39%20+592
- Keep only armv7 based dts patches now
---
v3:
- https://lore.kernel.org/linux-devicetree/20220417210436.6203-1-singh.kuldeep87k@gmail.com/
- Add Krzysztof's R-b tags for dts changes
- Add qcom,ee as required property(Krzysztof)
- Use type as boolean
- Add min/max to qcom,ee
- Clocks are required ones, skip them as it's users are not fixed.
---
v2:
- https://lore.kernel.org/linux-devicetree/20220410175056.79330-1-singh.kuldeep87k@gmail.com/
- Add more variants of ip4019-ap/dk-{01/04/07} for dma node rename
- Add #dma-cells in binding file
- use additionalproperties as false
---
v1:
- https://lore.kernel.org/linux-devicetree/20220409184115.15612-1-singh.kuldeep87k@gmail.com/#t
---

Kuldeep Singh (4):
  ARM: dts: qcom: apq8064: Use generic node name for DMA
  ARM: dts: qcom: mdm9615: Use generic node name for DMA
  ARM: dts: qcom: ipq4019: Use generic node name for DMA
  ARM: dts: qcom: ipq8064: Use generic node name for DMA

 arch/arm/boot/dts/qcom-apq8064.dtsi             | 6 +++---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi             | 6 +++---
 arch/arm/boot/dts/qcom-ipq8064.dtsi             | 4 ++--
 arch/arm/boot/dts/qcom-mdm9615.dtsi             | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.25.1

