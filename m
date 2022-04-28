Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13A3513ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353118AbiD1XB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353087AbiD1XB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:01:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A292F5A153
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:58:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y21so7160915edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5/7OCxhqk5o9giaTDUQztGpi5IgQbeepSeYSbhWdII=;
        b=BZQqEcfqgYTQ01yTJ3p6tPu0vaoYxHxTZYXAPCQDyng2F9JErAwf+wBYyeCYL3jbyn
         fu7P7HVw2JjagdSunf6J7t0o3nqtfHGPh/ZLJHzYdg1s5shotJ5wMbZpAHCMdC4+K+BV
         uL4JNuQnZmCRBiUFM+rtrpfaTepwEclOBBGoL9iE+tm/pWzx/WIR5WB9W8CutqsrDxF5
         8r5IwxNz3GLYfDgZMejyxQ0BjUIeQeCMTqhf73P19V3Bgg4MUbJ2q163D/OWSpHCbJdH
         OfKEAdrVw4U7Rx0/SOnvPBxeiyCVH2uAkdPiFk+O3ZvsaiODty7uqGGjbN4chYEWRdp+
         7WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5/7OCxhqk5o9giaTDUQztGpi5IgQbeepSeYSbhWdII=;
        b=Jz51K48sHrXFgK3AqMlyrMwbfrQrBunRD9OVkqlIrVFFccMj4pBoDdECEcXrN9Fwzk
         tYK37dsh1ZV8HVaSzNyjlzRxAJWtMKEG3v/7CSdxtcrfPYIKgQWjl4LuYAJcEuSXha1S
         rhT3lWmHoa3jG2W3pGDpn5HswIOXvE6Ld/FUMUfMNq1FVVbxF5qqHfK9+CTC3CvHT2LL
         GPBvdM+FDWG4OsgRIa0gUVZDPOB5a530HjVJJRjwEvJPM38alYzmFa0lhhlsqK41NR6f
         Ma2EaiwxsOhH3DVfvMPdd6Uta/C7pZTiPNnwwLFXoPkVP0p32RE/DniwcFwUtfonNfMq
         ZG2w==
X-Gm-Message-State: AOAM532OvwoKxYHwXfKcdA6YJsVJhQWE8zU6xyZvJs1sHiDONjX7aaW/
        2rbddRZtIF9KNrxotz/rFw==
X-Google-Smtp-Source: ABdhPJyLbUuBj/1YYm+3qmglf7zy9b/YbbcMub3/HL40okdVxkr6/TVxIZulAoEV9PjbfrGkO2N3Bw==
X-Received: by 2002:a05:6402:2920:b0:425:d7c7:41f with SMTP id ee32-20020a056402292000b00425d7c7041fmr29248373edb.370.1651186687432;
        Thu, 28 Apr 2022 15:58:07 -0700 (PDT)
Received: from crystalwell.adg.lan (a109-49-0-175.cpe.netcabo.pt. [109.49.0.175])
        by smtp.gmail.com with ESMTPSA id a25-20020a056402169900b0042617ba63c8sm2219102edv.82.2022.04.28.15.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 15:58:06 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, ryder.lee@mediatek.com,
        daniel@makrotopia.org, Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] arm64: dts: mt7622: specify the L2 cache topology
Date:   Thu, 28 Apr 2022 23:57:55 +0100
Message-Id: <20220428225755.785153-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.36.0
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

On an MT7622 system, the kernel complains of not being able to detect the cache
hierarchy of CPU 0. Specify the shared L2 cache node in the device tree, in
order to fix this.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6f8cb3ad1e84..3d6eaf6dd078 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -80,6 +80,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
 			cci-control-port = <&cci_control2>;
+			next-level-cache = <&L2>;
 		};
 
 		cpu1: cpu@1 {
@@ -94,6 +95,12 @@ cpu1: cpu@1 {
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
 			cci-control-port = <&cci_control2>;
+			next-level-cache = <&L2>;
+		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.36.0

