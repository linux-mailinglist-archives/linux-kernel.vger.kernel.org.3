Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93869584A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiG2DyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiG2Dxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:53:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8087D7AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:53:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d7so36711pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B50b+uTrKKFimaEMaPsMfW1YYtJusLaGj9KK7WXDqKE=;
        b=aO36RuuCokBgjntt/kMhD9Q+4WEs7uzCFMMcsSYnt4tObZGBrDjLOqW8OeHcYWGgeI
         ZOKpdlx00xzVWCRRBJT8s4dBFEWVxkrZD6kfuk30iy1FlgHooiVVmMDjqIAQZL2ZCr6+
         Z3NaNboW6nXEqj/zl8SPjkwdp7r3ZYcGIvKYUFads0pCjRjBLad+uPpGHdPCMUeXO1Hf
         wR0DD0LIEwcH4ipuYyMeY5qBGK5bONHtzx6o19AuKdUI/1DiphFrvzeA9H8bQeQ2UnI2
         YuSkCcPkAwaBDC6cDYNwCQvBybiYC28EKB+VQk6ezTO7AYn3zpKqakat6A2FB8zEYON/
         V+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B50b+uTrKKFimaEMaPsMfW1YYtJusLaGj9KK7WXDqKE=;
        b=R16LCp6ApLRpenKV7WJbZHX7Rh4BXQBgoD0hth6BNeCSlmybk9czQozl/j/+rlQ8ZF
         8MKSaQ1MtiLbyyI6r8QNaoe0xQfvce+LTyrM+MvIKQWh+cVXQZvlsVbuQzs21dCTMLsQ
         9Qblhul00T4WWsqzpEIi5neoBqrdmEf83pTNo//KyX/yXwy4U8m9m7oB14oqy2zMBrFq
         hAqVyoop7cNjqsvydV+h4fh4KqFIM0csTRGZAVIjh/lPwiM9WwGVGD47UNa+2zU7VJxS
         UbXe47W0b1+qoFLS2kn0I97ZgdU6QlO43XmNBG1Tp8I0Z3iLO5iMnE2BM79vvUvGVo/0
         9RCA==
X-Gm-Message-State: AJIora9p4pFzS+2VC6tJ6LRq6ZkwOYETQDLa98kZvZ35rFYmGdr6J9HA
        rFxV+ygqEoIh8kjREwmpHFY=
X-Google-Smtp-Source: AGRyM1t85ewpow1d6Mn4lZuRAJnrTPp9BydAE7pvj8kTZimuc9jE565X0OFzrAxwsDv30UhP3Ferxg==
X-Received: by 2002:aa7:8e0e:0:b0:52b:49ca:a7d6 with SMTP id c14-20020aa78e0e000000b0052b49caa7d6mr1557903pfr.77.1659066790634;
        Thu, 28 Jul 2022 20:53:10 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:a06b:5560:ec65:277f])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902680e00b0016d2d2c7df1sm2135478plk.188.2022.07.28.20.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:53:10 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 2/3] staging: rtl8192u: move debug files to debugfs
Date:   Thu, 28 Jul 2022 20:52:19 -0700
Message-Id: <20220729035230.226172-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729035230.226172-1-ztong0001@gmail.com>
References: <YuDdHMaB6jWARQzA@kroah.com>
 <20220729035230.226172-1-ztong0001@gmail.com>
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
 rename drivers/staging/rtl8192u/{r8192U_procfs.c => r8192U_debugfs.c} (69%)

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
similarity index 69%
rename from drivers/staging/rtl8192u/r8192U_procfs.c
rename to drivers/staging/rtl8192u/r8192U_debugfs.c
index cc69d78d5152..79cd095114ca 100644
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
+#define R8192U_DEBUGFS_DIR_NAME "r8192u_usb"
+
+static int rtl8192_usb_stats_ap_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
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
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
@@ -126,7 +127,7 @@ static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
+static int rtl8192_usb_stats_rx_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
@@ -142,35 +143,39 @@ static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
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
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct dentry *parent_dir = debugfs_lookup(R8192U_DEBUGFS_DIR_NAME, NULL);
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
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
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
+	debugfs_create_dir(R8192U_DEBUGFS_DIR_NAME, NULL);
 }
 
-void rtl8192_proc_remove_one(struct net_device *dev)
+void rtl8192_debugfs_exit(void)
 {
-	remove_proc_subtree(dev->name, rtl8192_proc);
+	debugfs_remove_recursive(debugfs_lookup(R8192U_DEBUGFS_DIR_NAME, NULL));
 }
 
-- 
2.25.1

