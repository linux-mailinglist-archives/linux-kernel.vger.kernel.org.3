Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A914539963
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbiEaWLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348321AbiEaWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:11:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B409CF68
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:11:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 161E41F43F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654035076;
        bh=7GkhGIgV6QxRJDZgvtuGPS8ymaPjeq6xkkd4vKksEos=;
        h=From:To:Cc:Subject:Date:From;
        b=nDxiGTMUmfSXuFXfDArQSK0bds+vw1O/iEsc1PF/dQpm5vwb56tsUdKVWPk6fos8q
         gltGapAkgry+Dld+Me3Rv4MeYPSQ3waYyDh08vkpoLCxxfJbIHOqrLXvjTZij7UZsd
         UvJh+Dr9gNe3yroDrvTy4dVRKdzVeaPmAs9r0NuTh80dw6TPUH5dTOa1Z06vgIZZpv
         ZrxeiZwl6JxWG58gor4iQQvaKoAmdId2KRfrEGaUfScF8WLDtUXdE3h6/caMs9Ofua
         E/Ort45uUwNOiVWi1bP3LV2YajdeRZPZpG8zvtHN+GsAGtxzBof3KDRjPTvBiJloFz
         Hfvf47u5t22gg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] kernel/reboot: Use static handler for register_platform_power_off()
Date:   Wed,  1 Jun 2022 01:11:02 +0300
Message-Id: <20220531221102.1112968-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register_platform_power_off() fails on m68k platform due to the
memory allocation error that happens at a very early boot time when
memory allocator isn't available yet. Fix it by using a static sys-off
handler for the platform-level power-off handlers.

Fixes: f0f7e5265b3b ("m68k: Switch to new sys-off handler API")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 kernel/reboot.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index a091145ee710..3b19b123efec 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -315,6 +315,37 @@ static int sys_off_notify(struct notifier_block *nb,
 	return handler->sys_off_cb(&data);
 }
 
+static struct sys_off_handler platform_sys_off_handler;
+
+static struct sys_off_handler *alloc_sys_off_handler(int priority)
+{
+	struct sys_off_handler *handler;
+
+	/*
+	 * Platforms like m68k can't allocate sys_off handler dynamically
+	 * at the early boot time because memory allocator isn't available yet.
+	 */
+	if (priority == SYS_OFF_PRIO_PLATFORM) {
+		handler = &platform_sys_off_handler;
+		if (handler->cb_data)
+			return ERR_PTR(-EBUSY);
+	} else {
+		handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+		if (!handler)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return handler;
+}
+
+static void free_sys_off_handler(struct sys_off_handler *handler)
+{
+	if (handler == &platform_sys_off_handler)
+		memset(handler, 0, sizeof(*handler));
+	else
+		kfree(handler);
+}
+
 /**
  *	register_sys_off_handler - Register sys-off handler
  *	@mode: Sys-off mode
@@ -345,9 +376,9 @@ register_sys_off_handler(enum sys_off_mode mode,
 	struct sys_off_handler *handler;
 	int err;
 
-	handler = kzalloc(sizeof(*handler), GFP_KERNEL);
-	if (!handler)
-		return ERR_PTR(-ENOMEM);
+	handler = alloc_sys_off_handler(priority);
+	if (IS_ERR(handler))
+		return handler;
 
 	switch (mode) {
 	case SYS_OFF_MODE_POWER_OFF_PREPARE:
@@ -364,7 +395,7 @@ register_sys_off_handler(enum sys_off_mode mode,
 		break;
 
 	default:
-		kfree(handler);
+		free_sys_off_handler(handler);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -391,7 +422,7 @@ register_sys_off_handler(enum sys_off_mode mode,
 	}
 
 	if (err) {
-		kfree(handler);
+		free_sys_off_handler(handler);
 		return ERR_PTR(err);
 	}
 
@@ -422,7 +453,7 @@ void unregister_sys_off_handler(struct sys_off_handler *handler)
 	/* sanity check, shall never happen */
 	WARN_ON(err);
 
-	kfree(handler);
+	free_sys_off_handler(handler);
 }
 EXPORT_SYMBOL_GPL(unregister_sys_off_handler);
 
-- 
2.35.3

