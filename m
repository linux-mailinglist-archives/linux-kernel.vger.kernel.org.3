Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412AF4DA2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbiCOTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351203AbiCOTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:03:49 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA25A158
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 21598C80086;
        Tue, 15 Mar 2022 20:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1647370954; x=1649185355; bh=/C
        tyqonaRe/riSXpivY2YclaCoAzQl/UiLRYi2p2aic=; b=ZrRUgOgMGee9TNJdBD
        h8h2M/h9MWQtCwEq3igZ84LLBw+j8LHMQ0aEYdd978nTpgubnVk4U5hzpberQ4j0
        nsoB9MPCxZD0a+sNP91n+UZhYL6rhNQk8r8DFbi+ya/L1fyjp0+GSb/8WuRJoh+3
        6J0iaLGMuJ3wyNmVrP2rcZlIg=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 1HZuBv7NgUgS; Tue, 15 Mar 2022 20:02:34 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id C204BC8008D;
        Tue, 15 Mar 2022 20:02:34 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/backlight: Force backlight native for Clevo NL5xRU and NL5xNU
Date:   Tue, 15 Mar 2022 20:02:28 +0100
Message-Id: <20220315190228.1503866-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315190228.1503866-1-wse@tuxedocomputers.com>
References: <20220315190228.1503866-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a working
native and video interface. However the default detection mechanism first
registers the video interface before unregistering it again and switching
to the native interface during boot. This results in a dangling SBIOS
request for backlight change for some reason, causing the backlight to
switch to ~2% once per boot on the first power cord connect or disconnect
event. Setting the native interface explicitly circumvents this buggy
behaviour by avoiding the unregistering process.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/video_detect.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4f64713e9917..becc198e4c22 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -415,6 +415,81 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
 		},
 	},
+	/*
+	 * Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a
+	 * working native and video interface. However the default detection
+	 * mechanism first registers the video interface before unregistering
+	 * it again and switching to the native interface during boot. This
+	 * results in a dangling SBIOS request for backlight change for some
+	 * reason, causing the backlight to switch to ~2% once per boot on the
+	 * first power cord connect or disconnect event. Setting the native
+	 * interface explicitly circumvents this buggy behaviour, by avoiding
+	 * the unregistering process.
+	 */
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xNU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xNU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xNU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+	},
 
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
-- 
2.25.1

