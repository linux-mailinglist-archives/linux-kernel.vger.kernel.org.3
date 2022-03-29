Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FBE4EAF37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiC2O3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiC2O3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:29:12 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435178FF3;
        Tue, 29 Mar 2022 07:27:25 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 4A1B9C800A7;
        Tue, 29 Mar 2022 16:27:23 +0200 (CEST)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1648564043; x=1650378444; bh=gx
        lRIDgxKLsdoUywsgfRwpBLvbdm4hFIz7e223NWKDE=; b=ZkwkfWvoYnIJNihx7c
        6wrVQ0c8SwiUvEipnvJH23MolVwFP5aSlw20dQbTS5qIPdWCRDd0FirwM2sA//R1
        eJcPaeJY5trjoTFsxaK/11GMZl9ULb7cKtf+T8Auaa3ubCgBm3/x0KbwzPnyxL6T
        DKy/nqiRsaoLbdv4llOoh9dRw=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id y_skiZluGCFr; Tue, 29 Mar 2022 16:27:23 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id B7070C800A4;
        Tue, 29 Mar 2022 16:27:22 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Date:   Tue, 29 Mar 2022 16:27:17 +0200
Message-Id: <20220329142718.30921-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329142718.30921-2-wse@tuxedocomputers.com>
References: <20220329142718.30921-2-wse@tuxedocomputers.com>
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
---
 drivers/input/serio/i8042-x86ia64io.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 1d2b34aac0c7..5c0eb5594fb1 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1421,6 +1421,31 @@ static int __init i8042_platform_init(void)
 
 	i8042_check_quirks();
 
+	pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+		i8042_nokbd ? " nokbd" : "",
+		i8042_noaux ? " noaux" : "",
+		i8042_nomux ? " nomux" : "",
+		i8042_unlock ? " unlock" : "",
+		i8042_probe_defer ? "probe_defer" : "",
+		i8042_reset == I8042_RESET_DEFAULT ?
+			"" : i8042_reset == I8042_RESET_ALWAYS ?
+				" reset_always" : " reset_never",
+		i8042_direct ? " direct" : "",
+		i8042_dumbkbd ? " dumbkbd" : "",
+		i8042_noloop ? " noloop" : "",
+		i8042_notimeout ? " notimeout" : "",
+		i8042_kbdreset ? " kbdreset" : "",
+#ifdef CONFIG_X86
+		i8042_dritek ? " dritek" : "",
+#else
+		"",
+#endif
+#ifdef CONFIG_PNP
+		i8042_nopnp ? " nopnp" : "");
+#else
+		"");
+#endif
+
 	retval = i8042_pnp_init();
 	if (retval)
 		return retval;
-- 
2.25.1

