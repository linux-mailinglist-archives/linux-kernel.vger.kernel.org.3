Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022853C773
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiFCJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiFCJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:24:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3D3A1AD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:24:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m25so4521527lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTj12/bL8Ks9wyeFuZOFgtc55gz6WJEXzHCzDU5Mwv8=;
        b=s58s9gcP2ICb6pmBuT/iA+lLKec71oyTZyKnzN4B9tctIp0M3TOzKOAtI99ZC5pzKv
         kJwkOy/gfBSJbKjk9mRt0jJa9K848HAJ1R124LKnsuNnWm1m/trNnv9miFitNGDqkpVI
         ChySQr6AohG5QyeLQH15jJ7l2AHOy6VCKZ11t6CDq4rkE2M/RQkkCiU0iTbYor4nhNP7
         riM07J8ER+6iPE07DQyZX9vYVLtn+vU9EMF8zEA7LHU8LoIwGFSTnpcziPzWfwA5gKSW
         j0WQCtG+rgrvD+lufugXyfixGoZZU85NJgErd3M+CD+q1xr3jCCotYDM6wN31PRv3uS3
         oJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTj12/bL8Ks9wyeFuZOFgtc55gz6WJEXzHCzDU5Mwv8=;
        b=WmKQLS3KxMxZgss9J9NShwhlGLmiHxzv8ubjG/0/Sz8N6cdMh34l3EWeROFeeEEf77
         J3Ov2X+gW9FNMrOBrn/Aiw69chi273v6xenUt09IZeD480PzHucXLlE9RR/ApDbhXLcQ
         WxqOsBxDpjC/5D9LNc57FCkr1x9Ex/GyKI73vbEntUU7VkWQAv4WQ3GXBQ3+HX7xLIuL
         VAM48fWTi0L1GdVEo/ecvvSuhPbOwsk+edvs22hcrbBnBtsejakXM9AI2OGVSUmkzxeR
         1UeWzUgICRrstDcG7bM6JWtSICPU1UCFQDqQw1Lu3hD4EdQLkbM1ugoohZtd0aUMIQga
         yxxg==
X-Gm-Message-State: AOAM532Lozzxs4m49lUOsD0oHUlNOVT1ieA63/NN1Zr2B8d5brkFZndB
        YUO18HBdpic7+JxGw+79J5FYeQ==
X-Google-Smtp-Source: ABdhPJzkkPYkXusscMFaFZ+STbOz/0WgfHFuJZw9KWsNF+fTTBKIX49Mns2oemydeHSGbz7q0883Vw==
X-Received: by 2002:a2e:b994:0:b0:253:ec28:b0f4 with SMTP id p20-20020a2eb994000000b00253ec28b0f4mr33602880ljp.376.1654248271957;
        Fri, 03 Jun 2022 02:24:31 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id e10-20020a2e9e0a000000b002555dd9c20fsm1224434ljk.20.2022.06.03.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:24:31 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/5] ARM: dts: socfpga: Add atsha204a node to Mercury+ AA1 dts
Date:   Fri,  3 Jun 2022 11:23:52 +0200
Message-Id: <20220603092354.141927-4-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603092354.141927-1-pan@semihalf.com>
References: <20220603092354.141927-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add atsha204a node to Mercury+ AA1 dts

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
index b0d20101cd00..ad7cd14de6b6 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Google LLC
+ */
 
 #include "socfpga_arria10.dtsi"
 
@@ -54,6 +57,11 @@ phy3: ethernet-phy@3 {
 };
 
 &i2c1 {
+	atsha204a: crypto@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+
 	isl12022: isl12022@6f {
 		compatible = "isil,isl12022";
 		reg = <0x6f>;
-- 
2.36.1.255.ge46751e96f-goog

