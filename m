Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFAA4C2426
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiBXGlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBXGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:41:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A4B17E36A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:41:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so1203652pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2Yu6vn105/cZrtKT/D7SUb7oHxyN3TZXt+q1NqTNrw=;
        b=j5NxbfQvGYwJDYwnalaQOZdLuBJtbHYcL+EBMUujpQonlDIizgTV+6WTrh+3VEDKdP
         m+gjFxZYKHy+6f+mbcJ8b0rULw9JLPGDJMBUmnjUfhSPAz9zzG6F2z/cVx1o3r1EZ713
         Z97V9eJS7LG28GvUVvyuTEcIXN6UVhQTGcF3gMYJYlvLzuTbWpf7cN9dB3COw9AoImJU
         Bz9B6UbfS6C1OVMaUxjz205vOYH23bDUFXA9JLCQLe0B5dtFVoms2ELDlxGA2Xf7oNiv
         ma4M1PInIbOYH+1ZXRumCBLdyEmAi/wbFEl5H9d8SSlrdUlV38xKlc5GSyb0gJzoMxCX
         umMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2Yu6vn105/cZrtKT/D7SUb7oHxyN3TZXt+q1NqTNrw=;
        b=huKcTWjAFkUGmbYEvmwTsTO331mSFtDEXglJ07hql1YshGxpuPlUk0OeubpyQ7y32Q
         G9cUkRgijP4r6PX/92RLlBppo3bfYk0VntzJUABjMxjdPsuo3V+2siZXE3ERHhMQ0U33
         16nTi90zGfr/hPXuf9EG1FXnk7/e9Tqn75ffC+yhwtqthUsG+19PtQTpaFieS43U8CiZ
         2caML9sXKQ98TpK4AH8cPRzXLHE/UOiwY/g8J5Vr++g0lVgoK/Mrh17KOHTtKCuLliXV
         cpn6iA6hxpII1LVnHQbRKS/oOznYj7Sa+8Xt3ABnmDRIa1enfxTn+W0c7r9rAxLhk6vO
         WrzQ==
X-Gm-Message-State: AOAM533d1VSVAHn3xrO8eM+hZdkCSbfz+pA64sZmt5NsCF8qNdVj1mEd
        PbMg4U4BWUFTs6fHhCX9vOU=
X-Google-Smtp-Source: ABdhPJyA3/t3qPmprv8ezeHIxaEssPdJyy8WAKv4Lo5qfmobI5QaTb/cLJoU7f2K3tf3qjxCfE5nbw==
X-Received: by 2002:a17:90a:4042:b0:1bc:c408:e7b4 with SMTP id k2-20020a17090a404200b001bcc408e7b4mr1326828pjg.169.1645684871868;
        Wed, 23 Feb 2022 22:41:11 -0800 (PST)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:47fe:f358:be6:4577])
        by smtp.googlemail.com with ESMTPSA id j12sm1729109pfu.79.2022.02.23.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:41:11 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Johan Hovold <johan@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com
Subject: [PATCH v2 3/3] staging: rtl8192u: rework init and exit function
Date:   Wed, 23 Feb 2022 22:40:31 -0800
Message-Id: <20220224064033.1530924-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YhPI5iDRUpzYWDyY@kroah.com>
References: <YhPI5iDRUpzYWDyY@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init and exit functions are not releasing resource properly. An error
can be observed when we load/unload/load r8192u_usb module due to this
issue. This patch rework init and exit functions to do proper resource
release on init error and module unload.
The __exit attribute is stripped from some functions since they are now
being used by module init functions.

[  493.068012] proc_dir_entry 'net/ieee80211' already registered
[  493.271973]  proc_mkdir+0x18/0x20
[  493.272136]  ieee80211_debug_init+0x28/0xde8 [r8192u_usb]
[  493.272404]  rtl8192_usb_module_init+0x10/0x161 [r8192u_usb]

[   13.910616] proc_dir_entry 'net/rtl819xU' already registered
[   13.918931]  proc_mkdir+0x18/0x20
[   13.919098]  rtl8192_usb_module_init+0x142/0x16d [r8192u_usb]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |  2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |  2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |  2 +-
 .../rtl8192u/ieee80211/ieee80211_module.c     |  2 +-
 drivers/staging/rtl8192u/r8192U_core.c        | 45 ++++++++++++++-----
 6 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
index 01012dddcd73..840db6250b87 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
@@ -214,7 +214,7 @@ int __init ieee80211_crypto_init(void)
 	return ret;
 }
 
-void __exit ieee80211_crypto_deinit(void)
+void ieee80211_crypto_deinit(void)
 {
 	struct list_head *ptr, *n;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index ccff385cf1f8..101c28265e91 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -415,7 +415,7 @@ int __init ieee80211_crypto_ccmp_init(void)
 	return ieee80211_register_crypto_ops(&ieee80211_crypt_ccmp);
 }
 
-void __exit ieee80211_crypto_ccmp_exit(void)
+void ieee80211_crypto_ccmp_exit(void)
 {
 	ieee80211_unregister_crypto_ops(&ieee80211_crypt_ccmp);
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index e8fa1d385f24..689d8843f538 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -712,7 +712,7 @@ int __init ieee80211_crypto_tkip_init(void)
 	return ieee80211_register_crypto_ops(&ieee80211_crypt_tkip);
 }
 
-void __exit ieee80211_crypto_tkip_exit(void)
+void ieee80211_crypto_tkip_exit(void)
 {
 	ieee80211_unregister_crypto_ops(&ieee80211_crypt_tkip);
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index a41b6510481b..8a51ea1dd6e5 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -240,7 +240,7 @@ int __init ieee80211_crypto_wep_init(void)
 	return ieee80211_register_crypto_ops(&ieee80211_crypt_wep);
 }
 
-void __exit ieee80211_crypto_wep_exit(void)
+void ieee80211_crypto_wep_exit(void)
 {
 	ieee80211_unregister_crypto_ops(&ieee80211_crypt_wep);
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index c52540b734fd..b94fe9b449b6 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -276,7 +276,7 @@ int __init ieee80211_debug_init(void)
 	return 0;
 }
 
-void __exit ieee80211_debug_exit(void)
+void ieee80211_debug_exit(void)
 {
 	if (ieee80211_proc) {
 		remove_proc_entry("debug_level", ieee80211_proc);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 364e1ca94f70..ce807c9d4219 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4783,49 +4783,70 @@ static int __init rtl8192_usb_module_init(void)
 {
 	int ret;
 
-#ifdef CONFIG_IEEE80211_DEBUG
+	pr_info("\nLinux kernel driver for RTL8192 based WLAN cards\n");
+	pr_info("Copyright (c) 2007-2008, Realsil Wlan\n");
+	RT_TRACE(COMP_INIT, "Initializing module");
+	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
+
 	ret = ieee80211_debug_init();
 	if (ret) {
 		pr_err("ieee80211_debug_init() failed %d\n", ret);
 		return ret;
 	}
-#endif
+
 	ret = ieee80211_crypto_init();
 	if (ret) {
 		pr_err("ieee80211_crypto_init() failed %d\n", ret);
-		return ret;
+		goto debug_exit;
 	}
 
 	ret = ieee80211_crypto_tkip_init();
 	if (ret) {
 		pr_err("ieee80211_crypto_tkip_init() failed %d\n", ret);
-		return ret;
+		goto crypto_exit;
 	}
 
 	ret = ieee80211_crypto_ccmp_init();
 	if (ret) {
 		pr_err("ieee80211_crypto_ccmp_init() failed %d\n", ret);
-		return ret;
+		goto crypto_tkip_exit;
 	}
 
 	ret = ieee80211_crypto_wep_init();
 	if (ret) {
 		pr_err("ieee80211_crypto_wep_init() failed %d\n", ret);
-		return ret;
+		goto crypto_ccmp_exit;
 	}
 
-	pr_info("\nLinux kernel driver for RTL8192 based WLAN cards\n");
-	pr_info("Copyright (c) 2007-2008, Realsil Wlan\n");
-	RT_TRACE(COMP_INIT, "Initializing module");
-	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
 	rtl8192_proc_module_init();
-	return usb_register(&rtl8192_usb_driver);
+	ret = usb_register(&rtl8192_usb_driver);
+	if (ret)
+		goto rtl8192_proc_module_exit;
+	return ret;
+
+rtl8192_proc_module_exit:
+	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
+	ieee80211_crypto_wep_exit();
+crypto_ccmp_exit:
+	ieee80211_crypto_ccmp_exit();
+crypto_tkip_exit:
+	ieee80211_crypto_tkip_exit();
+crypto_exit:
+	ieee80211_crypto_deinit();
+debug_exit:
+	ieee80211_debug_exit();
+	return ret;
 }
 
 static void __exit rtl8192_usb_module_exit(void)
 {
 	usb_deregister(&rtl8192_usb_driver);
-
+	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
+	ieee80211_crypto_wep_exit();
+	ieee80211_crypto_ccmp_exit();
+	ieee80211_crypto_tkip_exit();
+	ieee80211_crypto_deinit();
+	ieee80211_debug_exit();
 	RT_TRACE(COMP_DOWN, "Exiting");
 }
 
-- 
2.25.1

