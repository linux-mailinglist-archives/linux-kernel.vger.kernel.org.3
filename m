Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8E4ACB48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiBGV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiBGV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:28:41 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C169C043182;
        Mon,  7 Feb 2022 13:28:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u6so8455029lfc.3;
        Mon, 07 Feb 2022 13:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2zd9qSMx7SACXDQ3TCJWSxyhyik37cN7ytcy2kkvgM=;
        b=W4rJWInqPQLoRJwxqUdM++mooZfTQzFc7hnkmWoKDU5K3SRLMe6O2IKOe55XtyXdr8
         8sToojRW+aO3/pUmO8bg8yAAHBEwV2Z9Sl9xRk/wSrqVf/9fEzjxGHD9vD7+49T7OHnT
         vGT6snfaiTCXNBTbjgU/RF0BzrItwGGe3vF2TIODPvwwrGqHZ/BuDJVJPuSBYpGJ4VR2
         2lSD+qIbivy1Scox1rQ9gHILSYVUPPHfSpegGhbzVJgNjhiYATOjAaxb2Q8UYrYPTzAX
         C4yjOUz16iol6qa2dUxm3nbfR4UEd9Z6P23lKzKHGlw7B04qudAqpIt9jGCMF6anEfhw
         2Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2zd9qSMx7SACXDQ3TCJWSxyhyik37cN7ytcy2kkvgM=;
        b=xHMS3plLDWnxiNs18npVW8h+JvywYGmJOuYX3v2XGlBgCBWMiH/tPQ5uWJNGwVWqGi
         87BRbKoHT3cSemsN5R8jDdxCAL0kKoH2UeAPb2PcuSLNaUB5KdEDSjAzE5DfnevzS1GD
         w5hirRjCaMOoa9ttvrSlvbT7FOsJ/YyWSLgOSFRXFY8P4Uk8GKaBuFNfYcOX4IXgJXs1
         N3uQFyDQIYL4IF0+SBMHep+fqJJD6Bd71yAniiCI1tmbE4/R91/ui0csVlstLaFoewn5
         kt1gVapc5cjTtLCsAx9UeJHRllARtJbW+uPqtPArfXfEO/sy9+/LyyyietaD9gEBAZMK
         YMHA==
X-Gm-Message-State: AOAM53182vaXUx3sua9rB6roDm4jvwYpK+ear0d91T/dGscWWUA8kOBm
        AL2wji21wjRbaggxm2fW31y9yNcN+Qw=
X-Google-Smtp-Source: ABdhPJxXLXAxKtMWq6WRLQeB8t6rVF8KYPPA6CJK3xKXepxOhU0hwVLrjf9RUml1sK/qjcNZJoRcbg==
X-Received: by 2002:a05:6512:238c:: with SMTP id c12mr913797lfv.333.1644269318526;
        Mon, 07 Feb 2022 13:28:38 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id i3sm1650867lfj.144.2022.02.07.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:28:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Robert Eckelmann <longnoserob@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] ARM: tegra: transformer: Drop reg-shift for Tegra HS UART
Date:   Tue,  8 Feb 2022 00:28:24 +0300
Message-Id: <20220207212826.10307-3-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207212826.10307-1-digetx@gmail.com>
References: <20220207212826.10307-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

When the Tegra High-Speed UART is used instead of the regular UART, the
reg-shift property is implied from the compatible string and should not
be explicitly listed.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts               | 2 ++
 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi | 2 ++
 arch/arm/boot/dts/tegra30-pegatron-chagall.dts         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 68b0fdb89aa6..f95e84fbb20a 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -450,11 +450,13 @@ i2s@70002800 {
 
 	serial@70006040 {
 		compatible = "nvidia,tegra20-hsuart";
+		/delete-property/ reg-shift;
 		/* GPS BCM4751 */
 	};
 
 	serial@70006200 {
 		compatible = "nvidia,tegra20-hsuart";
+		/delete-property/ reg-shift;
 		status = "okay";
 
 		/* Azurewave AW-NH615 BCM4329B1 */
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 85b43a86a26d..c662ab261ed5 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -1080,6 +1080,7 @@ drive_sdio1 {
 
 	serial@70006040 {
 		compatible = "nvidia,tegra30-hsuart";
+		/delete-property/ reg-shift;
 		status = "okay";
 
 		/* Broadcom GPS BCM47511 */
@@ -1087,6 +1088,7 @@ serial@70006040 {
 
 	serial@70006200 {
 		compatible = "nvidia,tegra30-hsuart";
+		/delete-property/ reg-shift;
 		status = "okay";
 
 		nvidia,adjust-baud-rates = <0 9600 100>,
diff --git a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
index f4b2d4218849..8ce61035290b 100644
--- a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
@@ -1103,6 +1103,7 @@ drive_lcd2 {
 
 	uartb: serial@70006040 {
 		compatible = "nvidia,tegra30-hsuart";
+		/delete-property/ reg-shift;
 		status = "okay";
 
 		/* Broadcom GPS BCM47511 */
@@ -1110,6 +1111,7 @@ uartb: serial@70006040 {
 
 	uartc: serial@70006200 {
 		compatible = "nvidia,tegra30-hsuart";
+		/delete-property/ reg-shift;
 		status = "okay";
 
 		nvidia,adjust-baud-rates = <0 9600 100>,
-- 
2.34.1

