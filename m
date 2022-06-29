Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E855FE78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiF2L1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiF2L1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:27:36 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02537A20;
        Wed, 29 Jun 2022 04:27:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id C0061C8012D;
        Wed, 29 Jun 2022 13:27:32 +0200 (CEST)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1656502052; x=1658316453; bh=IX
        cLqZpm5gjFAMU/3kg0x+inD5K0DDo2LXmgOVeDgsM=; b=aUa+swfpgrbLL1MXu+
        3lSMP7Njl81r010BmqYwE3v1Xd9JJlnsgLAgqfaAiGYj2AsUHTM02jZYF/jRCeLq
        jWbZoKJUcBjFOaxHb+k3mQsp+BxpQgIpBcKdfTV/rsH4WIksxLQ7tJWusLdDnVZQ
        BziejIUL+YvUzC9pxK/GMGCn4=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id xy_svzk96rJM; Wed, 29 Jun 2022 13:27:32 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 69985C80129;
        Wed, 29 Jun 2022 13:27:32 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] input/i8042: Add debug output for quirks
Date:   Wed, 29 Jun 2022 13:27:24 +0200
Message-Id: <20220629112725.12922-4-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629112725.12922-1-wse@tuxedocomputers.com>
References: <20220629112725.12922-1-wse@tuxedocomputers.com>
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

Make new quirk table easily debugable with some debug output.

With no functional change, evaluation of i8042_reset_quirk and
i8042_reset_never_quirk had to be moved for this.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
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
2.34.1

