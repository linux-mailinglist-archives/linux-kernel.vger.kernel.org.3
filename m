Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4156AA42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiGGSKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiGGSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:10:02 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F24F237FF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:10:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id F3539C8009A;
        Thu,  7 Jul 2022 20:09:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1657217397; x=1659031798; bh=dJ
        JoXrGDVHikR0rNuf8Zm1ygRJi+F4cuAxXmhFMTy3Y=; b=O8hKuRvOCpAZr1Kakl
        maXNIf5t5Fc0MxjPOgDdusIhRJGJwIT1ume5bF9eeHUG0yugKqPPNfNxbt9OfAoN
        UnJhOqKLkZYGOpESci86qUjOXrU3NGVaTPdsjbxQ77lPb0vp1O3CvY5fzedF39Vq
        76lDEdhOubc3nWTb5QLSOPUmA=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id bx4ZQWgbx0Un; Thu,  7 Jul 2022 20:09:57 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 9F02AC8009E;
        Thu,  7 Jul 2022 20:09:57 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: video: Shortening quirk list by identifying Clevo by board_name only
Date:   Thu,  7 Jul 2022 20:09:53 +0200
Message-Id: <20220707180953.605246-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707180953.605246-1-wse@tuxedocomputers.com>
References: <20220707180953.605246-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking a recent change in the i8042 quirklist to this one: Clevo
board_names are somewhat unique, and if not: The generic Board_-/Sys_Vendor
string "Notebook" doesn't help much anyway. So identifying the devices just
by the board_name helps keeping the list significantly shorter and might
even hit more devices requiring the fix.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Fixes: c844d22fe0c0 ("ACPI: video: Force backlight native for Clevo NL5xRU and NL5xNU")
Cc: stable@vger.kernel.org
---
 drivers/acpi/video_detect.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index cdde2e069d63..6615f59ab7fd 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -430,23 +430,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	.callback = video_detect_force_native,
 	.ident = "Clevo NL5xRU",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
 		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
 		},
 	},
@@ -470,23 +453,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	.callback = video_detect_force_native,
 	.ident = "Clevo NL5xNU",
 	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xNU",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xNU",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
 		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
 		},
 	},
-- 
2.34.1

