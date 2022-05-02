Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65251695E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356781AbiEBCST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353279AbiEBCSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:18:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C842393F4
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:14:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z16so11282304pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 19:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9Zc9nR5HF3q1y+Yx3OL+fSqNywovBTwxuLs72zTvHg=;
        b=1vU/4GAOi00mRtC5wHK/dRlqiqCE16izQuZx27fyqkwGLm+Mn+L1ANOqbblfrNSBsf
         G/x/JoiW+hDVz2XR8yDFEYQmevD+W1OJJzzBEjN2wNL2D4GTnE03fBzW+wQCCVM0mrnd
         3v/ONyDFirtcsQ8RUv/ZtTlAuTeb/xOuVMg3io7D85vdV1GqH4dOc3qM3KIT7FGHrTyp
         PEtYL/Id0khOvOr1gEze3kQO5PKbeRvBj3CHhMqfVr3LF/UqHDdndMKzOhzgCur0uZtb
         QvFa9w0lrKDVOKNxxIXBHShN1jDw8dtkfWrTz+EwOAm66q+pd5AXZxSvCQuLiRFEt1Bh
         MKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9Zc9nR5HF3q1y+Yx3OL+fSqNywovBTwxuLs72zTvHg=;
        b=D2tThjvLM+FhCx9rfYM3ocCXCqdudNW57KOwEjBzSIxcds/pm5jsCRjXVYa2y7/bW2
         F/LThcE95/l0eb67GYla4ehq8DPrT3WC8rLSs1FnGqGYh6OM3YkNDbRoEOhkz09NqxIM
         YYWyOnfT0H7xFbahk6EfPGWun2d6x98WIuHtIjg/YVMyx/PowWe8jSErfbYfV0cV2fSa
         65+z8k9jkwpk9WPwaP++pT5mbHTDXnYtl5b8T0KtilzZmwrmmCMQr0S6VeomXHyHflme
         kkWwsMEs7Vh1dgTaxoLtiC37QuNprvmMK6Pmidoh+hqK4kT8oUcJevbhR7CP0f3i2eRc
         U6PA==
X-Gm-Message-State: AOAM532QR6KBjYaoBmfU+vFu6y6jNPC4X8+0K5TU1VafRchQYG+amp9Q
        Te6v6ABtfmWoVZtI+/pPQ8CrCA==
X-Google-Smtp-Source: ABdhPJxuk0kNHg3iy/qNkBFhLB8Ijo3uvjEHYaPHRKXNcGcNZ/BS7H1rHSaYgrlk8JNdXXj403p62A==
X-Received: by 2002:a05:6a00:1354:b0:50d:bf8c:6657 with SMTP id k20-20020a056a00135400b0050dbf8c6657mr9477441pfu.45.1651457681756;
        Sun, 01 May 2022 19:14:41 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:c18e:6070:88f2:a04d])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a734200b001cd4989febcsm18714475pjs.8.2022.05.01.19.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 19:14:41 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH 3/3] ARM: dts: am43xx: Add i2c voltage scaling firmware to wkup_m3_ipc
Date:   Sun,  1 May 2022 19:15:09 -0700
Message-Id: <20220502021508.1342869-4-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502021508.1342869-1-dfustini@baylibre.com>
References: <20220502021508.1342869-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add appropriate firmware-name property for all am43xx platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
[dfustini: change property from 'ti,scale-data-fw' to 'firmware-name']
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 1 +
 arch/arm/boot/dts/am437x-sk-evm.dts  | 4 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 91b67b428a06..46d5361fe876 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -1129,6 +1129,7 @@ &cpu {
 
 &wkup_m3_ipc {
 	ti,set-io-isolation;
+	firmware-name = "am43x-evm-scale-data.bin";
 };
 
 &pruss1_mdio {
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 20a34d2d85df..e5a825a525f9 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -893,6 +893,10 @@ vpfe0_ep: endpoint {
 	};
 };
 
+&wkup_m3_ipc {
+	firmware-name = "am43x-evm-scale-data.bin";
+};
+
 &pruss1_mdio {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 4f9a7251a107..50c33418703a 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -1019,6 +1019,10 @@ &cpu {
 	cpu0-supply = <&dcdc2>;
 };
 
+&wkup_m3_ipc {
+	firmware-name = "am43x-evm-scale-data.bin";
+};
+
 &pruss1_mdio {
 	status = "disabled";
 };
-- 
2.32.0

