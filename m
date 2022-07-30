Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CA58584C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiG3Dep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiG3Dei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:34:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32665EE2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:34:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o3so6123565ple.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=sWVWUhqcdjTjn/XryE0ybwUqgR6ac8JPEp76I3RywM4=;
        b=ZLIaVt0No+XAMHvy5NCxBPJozC7YOsAHMdlkIaMITMpNVtrO9Zw3c8IJv9EoteKpb5
         BLdl9FqMBq+rlbwAKFOZWhq1dNSLiOtuqxw7SUT0Ok02LNtnxyrWrq1Rjda+6l7kV8kI
         Mo1jQSWyhuoYjVFGRRapLiTAQedrzLzPTN5Z9yb8ZXw1vDlhZcwQVFIGn/SVuBUPOORo
         cHsYuAikF2JzO8VFnn+2SXeA+tQbDUzxJC/ci0u3AT1l/lZSNnMiCXEvGPHftJAXIQm8
         tGhDNlwzp9Gc/uYwSFgeuuu6ran5n5Fla970Yh+mzDGcFIYn2Nvebz97RcRHmu3pE19H
         Y3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=sWVWUhqcdjTjn/XryE0ybwUqgR6ac8JPEp76I3RywM4=;
        b=p21ummdyBoN7BDPshGh8xrvDP/WS4DaUcNJvRfYQ/SNIarNOcLETG6ZRNOh6yvrEz8
         GEzRvfDJgbJY9FpXsoz6c3pdEO6v1QtNWGYaSQWZEpJx1khFiLRaEyvzwB9HgRrmAMgF
         MSsVHXZimFHWyirthuDfz6xR2jU2NjUe33fxbFPMlw8NPrtJW6weVpBYAU5u4EL2AH0v
         ODkK0tTWv4lSvGmk/jYxOB6pvyO9mRtHArfDFHFPpeRqlq5yCnj/n6NYKoJX5uAFnxQx
         Dg/lZfIuhanvzCX860sxRj+/KRmhKbVyTbXjwokXmZhk3Ll/JFEJC1SQn2dsXa5z+zHk
         LNjg==
X-Gm-Message-State: ACgBeo2ojcR/8fb42rsScLaAXcO/bHqP1/vw0fOSjyzo+PeybIv2R+N2
        c7G+jBeRnhnTuujLlJ2MBUs=
X-Google-Smtp-Source: AA6agR4fnoP/qcqiYODV/d6F/CvciMjUaQf2AzTe5b/Wp12VZ/01uWYujQpNun7BNMG8WE+B4FaNWg==
X-Received: by 2002:a17:903:230c:b0:16d:8b52:e60b with SMTP id d12-20020a170903230c00b0016d8b52e60bmr6786925plh.160.1659152075562;
        Fri, 29 Jul 2022 20:34:35 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:f0d:9a23:40c8:9423])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170902f54300b0016a3248376esm4441555plf.181.2022.07.29.20.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 20:34:35 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v4 3/4] staging: rtl8192u: move debug files to debugfs
Date:   Fri, 29 Jul 2022 20:33:23 -0700
Message-Id: <20220730033335.74153-4-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YuOLybUZ8cBWntY/@kroah.com>
References: <YuOLybUZ8cBWntY/@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 debug files created under /proc/net/[Devname].
Due to this is purely for debuging as files are created read only,
move this to debugfs like other NIC drivers do instead of using procfs.
The directory structure will be like the following

  /sys/kernel/debug/r8192u_usb/wlan0/stats-rx
  /sys/kernel/debug/r8192u_usb/wlan0/stats-rx
  /sys/kernel/debug/r8192u_usb/wlan0/stats-ap
  /sys/kernel/debug/r8192u_usb/wlan0/registers

This is also to prepare for address rmmod warn issue.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/Makefile             |  2 +-
 drivers/staging/rtl8192u/r8192U.h             | 10 ++-
 drivers/staging/rtl8192u/r8192U_core.c        | 21 +++---
 .../{r8192U_procfs.c => r8192U_debugfs.c}     | 65 ++++++++++---------
 4 files changed, 54 insertions(+), 44 deletions(-)
 rename drivers/staging/rtl8192u/{r8192U_procfs.c => r8192U_debugfs.c} (70%)

diff --git a/drivers/staging/rtl8192u/Makefile b/drivers/staging/rtl8192u/Makefile
index 5aef46cc90ef..d32dfd89a606 100644
--- a/drivers/staging/rtl8192u/Makefile
+++ b/drivers/staging/rtl8192u/Makefile
@@ -8,7 +8,7 @@ ccflags-y += -DTHOMAS_BEACON -DTHOMAS_TASKLET -DTHOMAS_SKB -DTHOMAS_TURBO
 r8192u_usb-y := r8192U_core.o r8180_93cx6.o r8192U_wx.o		\
 		  r8190_rtl8256.o r819xU_phy.o r819xU_firmware.o	\
 		  r819xU_cmdpkt.o r8192U_dm.o r819xU_firmware_img.o	\
-		  r8192U_procfs.o					\
+		  r8192U_debugfs.o					\
 		  ieee80211/ieee80211_crypt.o				\
 		  ieee80211/ieee80211_crypt_tkip.o			\
 		  ieee80211/ieee80211_crypt_ccmp.o			\
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index e8b6da2adc4d..920a6a154860 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1061,6 +1061,9 @@ typedef struct r8192_priv {
 	struct delayed_work gpio_change_rf_wq;
 	struct delayed_work initialgain_operate_wq;
 	struct workqueue_struct *priv_wq;
+
+	/* debugfs */
+	struct dentry *debugfs_dir;
 } r8192_priv;
 
 /* For rtl8187B */
@@ -1117,8 +1120,9 @@ void EnableHWSecurityConfig8192(struct net_device *dev);
 void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 	    const u8 *MacAddr, u8 DefaultKey, u32 *KeyContent);
 
-void rtl8192_proc_module_init(void);
-void rtl8192_proc_init_one(struct net_device *dev);
-void rtl8192_proc_remove_one(struct net_device *dev);
+void rtl8192_debugfs_init_one(struct net_device *dev);
+void rtl8192_debugfs_exit_one(struct net_device *dev);
+void rtl8192_debugfs_init(void);
+void rtl8192_debugfs_exit(void);
 
 #endif
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 9e0861fdc64e..865bc0dc7c71 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -56,7 +56,6 @@ double __extendsfdf2(float a)
 #include "r8192U_dm.h"
 #include <linux/usb.h>
 #include <linux/slab.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 /* FIXME: check if 2.6.7 is ok */
 
@@ -4557,7 +4556,7 @@ static int rtl8192_usb_probe(struct usb_interface *intf,
 		goto fail2;
 
 	RT_TRACE(COMP_INIT, "dev name=======> %s\n", dev->name);
-	rtl8192_proc_init_one(dev);
+	rtl8192_debugfs_init_one(dev);
 
 	RT_TRACE(COMP_INIT, "Driver probe completed\n");
 	return 0;
@@ -4591,10 +4590,11 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 	struct net_device *dev = usb_get_intfdata(intf);
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	unregister_netdev(dev);
 
 	RT_TRACE(COMP_DOWN, "=============>wlan driver to be removed\n");
-	rtl8192_proc_remove_one(dev);
+	rtl8192_debugfs_exit_one(dev);
+
+	unregister_netdev(dev);
 
 	rtl8192_down(dev);
 	kfree(priv->pFirmware);
@@ -4615,10 +4615,11 @@ static int __init rtl8192_usb_module_init(void)
 	RT_TRACE(COMP_INIT, "Initializing module");
 	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
 
+	rtl8192_debugfs_init();
 	ret = ieee80211_debug_init();
 	if (ret) {
 		pr_err("ieee80211_debug_init() failed %d\n", ret);
-		return ret;
+		goto debugfs_exit;
 	}
 
 	ret = ieee80211_crypto_init();
@@ -4645,14 +4646,12 @@ static int __init rtl8192_usb_module_init(void)
 		goto crypto_ccmp_exit;
 	}
 
-	rtl8192_proc_module_init();
 	ret = usb_register(&rtl8192_usb_driver);
 	if (ret)
-		goto rtl8192_proc_module_exit;
+		goto crypto_wep_exit;
 	return ret;
 
-rtl8192_proc_module_exit:
-	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
+crypto_wep_exit:
 	ieee80211_crypto_wep_exit();
 crypto_ccmp_exit:
 	ieee80211_crypto_ccmp_exit();
@@ -4662,18 +4661,20 @@ static int __init rtl8192_usb_module_init(void)
 	ieee80211_crypto_deinit();
 debug_exit:
 	ieee80211_debug_exit();
+debugfs_exit:
+	rtl8192_debugfs_exit();
 	return ret;
 }
 
 static void __exit rtl8192_usb_module_exit(void)
 {
 	usb_deregister(&rtl8192_usb_driver);
-	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
 	ieee80211_crypto_wep_exit();
 	ieee80211_crypto_ccmp_exit();
 	ieee80211_crypto_tkip_exit();
 	ieee80211_crypto_deinit();
 	ieee80211_debug_exit();
+	rtl8192_debugfs_exit();
 	RT_TRACE(COMP_DOWN, "Exiting");
 }
 
diff --git a/drivers/staging/rtl8192u/r8192U_procfs.c b/drivers/staging/rtl8192u/r8192U_debugfs.c
similarity index 70%
rename from drivers/staging/rtl8192u/r8192U_procfs.c
rename to drivers/staging/rtl8192u/r8192U_debugfs.c
index d6f8401526c5..c64504346657 100644
--- a/drivers/staging/rtl8192u/r8192U_procfs.c
+++ b/drivers/staging/rtl8192u/r8192U_debugfs.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /****************************************************************************
- *   -----------------------------PROCFS STUFF-------------------------
+ *   -----------------------------DEGUGFS STUFF-------------------------
  ****************************************************************************/
-#include <linux/proc_fs.h>
+#include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include "r8192U.h"
 
-static struct proc_dir_entry *rtl8192_proc;
-static int __maybe_unused proc_get_stats_ap(struct seq_file *m, void *v)
+#define KBUILD_MODNAME "r8192u_usb"
+
+static int rtl8192_usb_stats_ap_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -26,7 +27,7 @@ static int __maybe_unused proc_get_stats_ap(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int __maybe_unused proc_get_registers(struct seq_file *m, void *v)
+static int rtl8192_usb_registers_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
 	int i, n, max = 0xff;
@@ -67,7 +68,7 @@ static int __maybe_unused proc_get_registers(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
+static int rtl8192_usb_stats_tx_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -126,7 +127,7 @@ static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
+static int rtl8192_usb_stats_rx_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -142,34 +143,38 @@ static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
 	return 0;
 }
 
-void rtl8192_proc_module_init(void)
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_stats_rx);
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_stats_tx);
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_stats_ap);
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_registers);
+
+void rtl8192_debugfs_init_one(struct net_device *dev)
+{
+	struct r8192_priv *priv = ieee80211_priv(dev);
+	struct dentry *parent_dir = debugfs_lookup(KBUILD_MODNAME, NULL);
+	struct dentry *dir = debugfs_create_dir(dev->name, parent_dir);
+
+	debugfs_create_file("stats-rx", 0444, dir, dev, &rtl8192_usb_stats_rx_fops);
+	debugfs_create_file("stats-tx", 0444, dir, dev, &rtl8192_usb_stats_tx_fops);
+	debugfs_create_file("stats-ap", 0444, dir, dev, &rtl8192_usb_stats_ap_fops);
+	debugfs_create_file("registers", 0444, dir, dev, &rtl8192_usb_registers_fops);
+
+	priv->debugfs_dir = dir;
+}
+
+void rtl8192_debugfs_exit_one(struct net_device *dev)
 {
-	RT_TRACE(COMP_INIT, "Initializing proc filesystem");
-	rtl8192_proc = proc_mkdir(RTL819XU_MODULE_NAME, init_net.proc_net);
+	struct r8192_priv *priv = ieee80211_priv(dev);
+
+	debugfs_remove_recursive(priv->debugfs_dir);
 }
 
-void rtl8192_proc_init_one(struct net_device *dev)
+void rtl8192_debugfs_init(void)
 {
-	struct proc_dir_entry *dir;
-
-	if (!rtl8192_proc)
-		return;
-
-	dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
-	if (!dir)
-		return;
-
-	proc_create_single("stats-rx", S_IFREG | 0444, dir,
-			   proc_get_stats_rx);
-	proc_create_single("stats-tx", S_IFREG | 0444, dir,
-			   proc_get_stats_tx);
-	proc_create_single("stats-ap", S_IFREG | 0444, dir,
-			   proc_get_stats_ap);
-	proc_create_single("registers", S_IFREG | 0444, dir,
-			   proc_get_registers);
+	debugfs_create_dir(KBUILD_MODNAME, NULL);
 }
 
-void rtl8192_proc_remove_one(struct net_device *dev)
+void rtl8192_debugfs_exit(void)
 {
-	remove_proc_subtree(dev->name, rtl8192_proc);
+	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODNAME, NULL));
 }
-- 
2.25.1

