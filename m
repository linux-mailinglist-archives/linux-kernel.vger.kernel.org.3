Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C73E4E7FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiCZHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCZHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:52:56 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2001:41d0:d:357f:aaaa::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2578315404C;
        Sat, 26 Mar 2022 00:51:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D999D33EE8;
        Sat, 26 Mar 2022 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648281079; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=+tJf8nuvvl/dWidepuoxkeSZGp/4QTaRXiz6nB50fKI=;
        b=D3PhJBVmrglUJCndiHebInOqkMMUQ/iUWFBhuGk/b7bYlp99g+WN7GzNgU/jgelSLqrBAB
        fpaGXDRqIym47zCqGrhirZUfNuwXzZD1M/h9u4jTfOfIdPGBG8AVamX7bpPLTTQFCsIEn0
        mm8KSfBrVdDsl71gwbfeFEE4Xh9P0phSxFBUkJUtoekxNBGBAP3FvuYTZ9ISJ0fVyhjdwN
        X+Dp7WE6kBFIB99nHbpa9EJqtYfzR1Z5vvJMKPfE09kZIxl7zPS5TGllBGeR2hG+PK7FsE
        FpAPN8Psxi2VL9WkiMc+wE00hFP7fLHHm4KTc4lD71A73o5pDXnQWB/QqZj1lQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: meson: add dts bluetooth node for JetHub H1
Date:   Sat, 26 Mar 2022 10:51:07 +0300
Message-Id: <20220326075110.1462301-2-adeep@lexina.in>
In-Reply-To: <20220326075110.1462301-1-adeep@lexina.in>
References: <20220326075110.1462301-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bluetooth node for RTL8822CS uart to JetHub H1 dts file.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index 6eafb908695f..fcb304c5a40f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -213,6 +213,12 @@ &uart_A {
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
 	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "realtek,rtl8822cs-bt";
+		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
+       };
 };
 
 &uart_C {
-- 
2.30.2

