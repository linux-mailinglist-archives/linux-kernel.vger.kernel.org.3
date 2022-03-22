Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C934E441B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiCVQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiCVQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:23:04 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E5240B2;
        Tue, 22 Mar 2022 09:21:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id D98B3C800A8;
        Tue, 22 Mar 2022 17:21:30 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1647966090; x=1649780491; bh=44
        Hrq2X2ixKEMAekiQyA1I/d2m0fPPILtxPrSJHc3l8=; b=CGnK6tHUO0Vlz7fRZn
        cN0G3OaeVW+Dej1F5mNJdZvO6rXztnLbMVK+Gzs/vv3gt2zWEcEGXnssCwE0Qo2l
        ilUlCobosxqBuitH5/X5rc2LYJeVqo9Oi2SofHI90mMyIaJQ2ZFHZQgNtRUh8sH9
        OqZTAyLcQBKWkC8kZMangBUss=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Nr0OEtkbtOcB; Tue, 22 Mar 2022 17:21:30 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (unknown [IPv6:2001:a61:6168:d301:4be4:641d:6061:c5dc])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 7D6ACC8009B;
        Tue, 22 Mar 2022 17:21:30 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Date:   Tue, 22 Mar 2022 17:21:24 +0100
Message-Id: <20220322162125.59838-4-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322162125.59838-1-wse@tuxedocomputers.com>
References: <20220322162125.59838-1-wse@tuxedocomputers.com>
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
 drivers/input/serio/i8042-x86ia64io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index dbfbd6a2763a..229d4936910f 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1494,6 +1494,23 @@ static int __init i8042_platform_init(void)
 
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
+		i8042_dritek ? " dritek" : "",
+		i8042_nopnp ? " nopnp" : "");
+
 	retval = i8042_pnp_init();
 	if (retval)
 		return retval;
-- 
2.25.1

