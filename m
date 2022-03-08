Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A64D1E20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbiCHRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiCHRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:06:34 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAD52B1F;
        Tue,  8 Mar 2022 09:05:36 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 9A5B6C80091;
        Tue,  8 Mar 2022 18:05:35 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1646759135; x=1648573536; bh=0H
        ytoimmUvvj3Cy+nirUyNg7gX0qQE3t17lhk5NwGII=; b=dpRKSdr0U+YJTUAOT3
        yCRmTkyOHnrYYgLIPKU0gBF+TeNvAQuNFOVW9fbNbX0Rzvmfl/8hyFNDGnVWwut9
        D3TQRD8ci5wpxRatqSeeMOgMN1cTfQHwAivZ7pmYFLfxuG+ajWdR1SP+tAePGuqK
        lLeMmXvtYz2fLWRFZlwdlAxC0=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id oHhqQqcvLpA1; Tue,  8 Mar 2022 18:05:35 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 25851C80062;
        Tue,  8 Mar 2022 18:05:35 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] input/i8042: Add debug output for quirks
Date:   Tue,  8 Mar 2022 18:05:22 +0100
Message-Id: <20220308170523.783284-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308170523.783284-1-wse@tuxedocomputers.com>
References: <20220308170523.783284-1-wse@tuxedocomputers.com>
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

Make new quirk table easily debugable with some debug output.

With no functional change, evaluation of i8042_reset_quirk and
i8042_reset_never_quirk had to be moved for this.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 33 +++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 689b9ee3e742..e41b0819277c 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1471,6 +1471,30 @@ static int __init i8042_platform_init(void)
 			i8042_nopnp = true;
 #endif
 	}
+	/* Honor module parameter when value is not default */
+	if (i8042_reset == I8042_RESET_DEFAULT) {
+		if (i8042_reset_always_quirk)
+			i8042_reset = I8042_RESET_ALWAYS;
+
+		if (i8042_reset_never_quirk)
+			i8042_reset = I8042_RESET_NEVER;
+	}
+	pr_debug("Active quirks:%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+			i8042_nokbd ? " nokbd" : "",
+			i8042_noaux ? " noaux" : "",
+			i8042_nomux ? " nomux" : "",
+			i8042_unlock ? " unlock" : "",
+			i8042_probe_defer ? "probe_defer" : "",
+			i8042_reset == I8042_RESET_DEFAULT ?
+				"" : i8042_reset == I8042_RESET_ALWAYS ?
+					" reset_always" : " reset_never",
+			i8042_direct ? " direct" : "",
+			i8042_dumbkbd ? " dumbkbd" : "",
+			i8042_noloop ? " noloop" : "",
+			i8042_notimeout ? " notimeout" : "",
+			i8042_kbdreset ? " kbdreset" : "",
+			i8042_dritek ? " dritek" : "",
+			i8042_nopnp ? " nopnp" : "");
 #endif
 
 	retval = i8042_pnp_init();
@@ -1482,15 +1506,6 @@ static int __init i8042_platform_init(void)
 #endif
 
 #ifdef CONFIG_X86
-	/* Honor module parameter when value is not default */
-	if (i8042_reset == I8042_RESET_DEFAULT) {
-		if (i8042_reset_always_quirk)
-			i8042_reset = I8042_RESET_ALWAYS;
-
-		if (i8042_reset_never_quirk)
-			i8042_reset = I8042_RESET_NEVER;
-	}
-
 	/*
 	 * A20 was already enabled during early kernel init. But some buggy
 	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
-- 
2.25.1

