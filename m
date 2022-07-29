Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A4584A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiG2Dxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiG2Dx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:53:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51F7D1F7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:53:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r186so3084240pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CZItQLAW8Jh9MeJoBkGCq+PdE0G2KUuFj2lt1NOdTUA=;
        b=O3fFypORX/cqgzGrIUgf2Pot+Lkc7E0X+j2SmfEo1pxlmXacUYQKA/jPXr4xz76AA/
         Y1GQBfgPev+8r5TPqhRy7cxkrBLqZo65yt5if/r0pTCn7hbBbPqb5ugkg9/xqQTuUItN
         WH8X9dVRJyA6YgsRyXWmITaeZOQ7kHYF7jDZsm+n6ICT9DVEtYJMmbVySmeFx2FgxDJy
         eJRkyBjQmjdzFEMq/TPcvIwTMtKcOxr9HuKSIFeNfjr1eumylL3xhgZy5EMTlrtbkXEH
         JlSfqtnGwZM63uPfmqeAReLBttANrWzY2sXTcXyFrNaCFaQffNm10bIz54A5d5bFY11B
         oo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZItQLAW8Jh9MeJoBkGCq+PdE0G2KUuFj2lt1NOdTUA=;
        b=5NS4a5qdt7Cd6UHqKQM3UGWzwgt52O+DPxKSeD4m3p5/G03SpNwDEYjStToSB3DpD0
         oUrLF8hNuxWF9HURXDvNtJFpn44TUbKcVG11Z5pbvwaBCZKatDAo8S++wLtPnWZEhWNs
         Pznsk3OwYpGijGq9nTBR92NThnlTml+xqrHsRB4Y0thPyzAqlCR6UK0KuC0qIv+xCZiv
         7UqT0Sp/YmNiUlTEswIdnbMIMLuRk2YJgxhj2Ep8OpjiZY2hDSLMNUNAEQKxour1hY5s
         O3lsfWVLX5qKSOu1JojEZM0GQ1Q1Hm3X7a/Z9Q5hRrRAtkdvJbgwtTT7BsY+MjQxDnpk
         KPmg==
X-Gm-Message-State: AJIora/Dom1CAJ9wkdexogZG+LAEytAqSROPaRgIZCDzTTiIpT+TZ4qZ
        lefTIi2Kn/4qP0r1ARkIFNU=
X-Google-Smtp-Source: AGRyM1tcMTqsjkzewf+x3PSx0NmzvH8winSG1E5ZFeP9ujZHfP6V+TGdx3+kAOBPgDIsQ3Goa4yc+w==
X-Received: by 2002:a05:6a00:1806:b0:52a:ec5b:2263 with SMTP id y6-20020a056a00180600b0052aec5b2263mr1589220pfa.1.1659066779543;
        Thu, 28 Jul 2022 20:52:59 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:a06b:5560:ec65:277f])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902680e00b0016d2d2c7df1sm2135478plk.188.2022.07.28.20.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:52:59 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 1/3] staging: rtl8192u: move debug stuff to its own file
Date:   Thu, 28 Jul 2022 20:52:18 -0700
Message-Id: <20220729035230.226172-2-ztong0001@gmail.com>
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

This is to prepare for moving them to debugfs and fix rmmod warn issue
when wlan0 is renamed to something else.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/Makefile        |   1 +
 drivers/staging/rtl8192u/r8192U.h        |   4 +
 drivers/staging/rtl8192u/r8192U_core.c   | 173 ----------------------
 drivers/staging/rtl8192u/r8192U_procfs.c | 176 +++++++++++++++++++++++
 4 files changed, 181 insertions(+), 173 deletions(-)
 create mode 100644 drivers/staging/rtl8192u/r8192U_procfs.c

diff --git a/drivers/staging/rtl8192u/Makefile b/drivers/staging/rtl8192u/Makefile
index 0be7426b6ebc..5aef46cc90ef 100644
--- a/drivers/staging/rtl8192u/Makefile
+++ b/drivers/staging/rtl8192u/Makefile
@@ -8,6 +8,7 @@ ccflags-y += -DTHOMAS_BEACON -DTHOMAS_TASKLET -DTHOMAS_SKB -DTHOMAS_TURBO
 r8192u_usb-y := r8192U_core.o r8180_93cx6.o r8192U_wx.o		\
 		  r8190_rtl8256.o r819xU_phy.o r819xU_firmware.o	\
 		  r819xU_cmdpkt.o r8192U_dm.o r819xU_firmware_img.o	\
+		  r8192U_procfs.o					\
 		  ieee80211/ieee80211_crypt.o				\
 		  ieee80211/ieee80211_crypt_tkip.o			\
 		  ieee80211/ieee80211_crypt_ccmp.o			\
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 14ca00a2789b..e8b6da2adc4d 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1117,4 +1117,8 @@ void EnableHWSecurityConfig8192(struct net_device *dev);
 void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 	    const u8 *MacAddr, u8 DefaultKey, u32 *KeyContent);
 
+void rtl8192_proc_module_init(void);
+void rtl8192_proc_init_one(struct net_device *dev);
+void rtl8192_proc_remove_one(struct net_device *dev);
+
 #endif
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 2ca925f35830..9e0861fdc64e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -452,179 +452,6 @@ static struct net_device_stats *rtl8192_stats(struct net_device *dev);
 static void rtl8192_restart(struct work_struct *work);
 static void watch_dog_timer_callback(struct timer_list *t);
 
-/****************************************************************************
- *   -----------------------------PROCFS STUFF-------------------------
- ****************************************************************************/
-
-static struct proc_dir_entry *rtl8192_proc;
-
-static int __maybe_unused proc_get_stats_ap(struct seq_file *m, void *v)
-{
-	struct net_device *dev = m->private;
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-	struct ieee80211_device *ieee = priv->ieee80211;
-	struct ieee80211_network *target;
-
-	list_for_each_entry(target, &ieee->network_list, list) {
-		const char *wpa = "non_WPA";
-
-		if (target->wpa_ie_len > 0 || target->rsn_ie_len > 0)
-			wpa = "WPA";
-
-		seq_printf(m, "%s %s\n", target->ssid, wpa);
-	}
-
-	return 0;
-}
-
-static int __maybe_unused proc_get_registers(struct seq_file *m, void *v)
-{
-	struct net_device *dev = m->private;
-	int i, n, max = 0xff;
-	u8 byte_rd;
-
-	seq_puts(m, "\n####################page 0##################\n ");
-
-	for (n = 0; n <= max;) {
-		seq_printf(m, "\nD:  %2x > ", n);
-
-		for (i = 0; i < 16 && n <= max; i++, n++) {
-			read_nic_byte(dev, 0x000 | n, &byte_rd);
-			seq_printf(m, "%2x ", byte_rd);
-		}
-	}
-
-	seq_puts(m, "\n####################page 1##################\n ");
-	for (n = 0; n <= max;) {
-		seq_printf(m, "\nD:  %2x > ", n);
-
-		for (i = 0; i < 16 && n <= max; i++, n++) {
-			read_nic_byte(dev, 0x100 | n, &byte_rd);
-			seq_printf(m, "%2x ", byte_rd);
-		}
-	}
-
-	seq_puts(m, "\n####################page 3##################\n ");
-	for (n = 0; n <= max;) {
-		seq_printf(m, "\nD:  %2x > ", n);
-
-		for (i = 0; i < 16 && n <= max; i++, n++) {
-			read_nic_byte(dev, 0x300 | n, &byte_rd);
-			seq_printf(m, "%2x ", byte_rd);
-		}
-	}
-
-	seq_putc(m, '\n');
-	return 0;
-}
-
-static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
-{
-	struct net_device *dev = m->private;
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-
-	seq_printf(m,
-		   "TX VI priority ok int: %lu\n"
-		   "TX VI priority error int: %lu\n"
-		   "TX VO priority ok int: %lu\n"
-		   "TX VO priority error int: %lu\n"
-		   "TX BE priority ok int: %lu\n"
-		   "TX BE priority error int: %lu\n"
-		   "TX BK priority ok int: %lu\n"
-		   "TX BK priority error int: %lu\n"
-		   "TX MANAGE priority ok int: %lu\n"
-		   "TX MANAGE priority error int: %lu\n"
-		   "TX BEACON priority ok int: %lu\n"
-		   "TX BEACON priority error int: %lu\n"
-		   "TX queue resume: %lu\n"
-		   "TX queue stopped?: %d\n"
-		   "TX fifo overflow: %lu\n"
-		   "TX VI queue: %d\n"
-		   "TX VO queue: %d\n"
-		   "TX BE queue: %d\n"
-		   "TX BK queue: %d\n"
-		   "TX VI dropped: %lu\n"
-		   "TX VO dropped: %lu\n"
-		   "TX BE dropped: %lu\n"
-		   "TX BK dropped: %lu\n"
-		   "TX total data packets %lu\n",
-		   priv->stats.txviokint,
-		   priv->stats.txvierr,
-		   priv->stats.txvookint,
-		   priv->stats.txvoerr,
-		   priv->stats.txbeokint,
-		   priv->stats.txbeerr,
-		   priv->stats.txbkokint,
-		   priv->stats.txbkerr,
-		   priv->stats.txmanageokint,
-		   priv->stats.txmanageerr,
-		   priv->stats.txbeaconokint,
-		   priv->stats.txbeaconerr,
-		   priv->stats.txresumed,
-		   netif_queue_stopped(dev),
-		   priv->stats.txoverflow,
-		   atomic_read(&(priv->tx_pending[VI_PRIORITY])),
-		   atomic_read(&(priv->tx_pending[VO_PRIORITY])),
-		   atomic_read(&(priv->tx_pending[BE_PRIORITY])),
-		   atomic_read(&(priv->tx_pending[BK_PRIORITY])),
-		   priv->stats.txvidrop,
-		   priv->stats.txvodrop,
-		   priv->stats.txbedrop,
-		   priv->stats.txbkdrop,
-		   priv->stats.txdatapkt
-		);
-
-	return 0;
-}
-
-static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
-{
-	struct net_device *dev = m->private;
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-
-	seq_printf(m,
-		   "RX packets: %lu\n"
-		   "RX urb status error: %lu\n"
-		   "RX invalid urb error: %lu\n",
-		   priv->stats.rxoktotal,
-		   priv->stats.rxstaterr,
-		   priv->stats.rxurberr);
-
-	return 0;
-}
-
-static void rtl8192_proc_module_init(void)
-{
-	RT_TRACE(COMP_INIT, "Initializing proc filesystem");
-	rtl8192_proc = proc_mkdir(RTL819XU_MODULE_NAME, init_net.proc_net);
-}
-
-static void rtl8192_proc_init_one(struct net_device *dev)
-{
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
-}
-
-static void rtl8192_proc_remove_one(struct net_device *dev)
-{
-	remove_proc_subtree(dev->name, rtl8192_proc);
-}
-
 /****************************************************************************
  *  -----------------------------MISC STUFF-------------------------
  *****************************************************************************/
diff --git a/drivers/staging/rtl8192u/r8192U_procfs.c b/drivers/staging/rtl8192u/r8192U_procfs.c
new file mode 100644
index 000000000000..cc69d78d5152
--- /dev/null
+++ b/drivers/staging/rtl8192u/r8192U_procfs.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/****************************************************************************
+ *   -----------------------------PROCFS STUFF-------------------------
+ ****************************************************************************/
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include "r8192U.h"
+
+static struct proc_dir_entry *rtl8192_proc;
+static int __maybe_unused proc_get_stats_ap(struct seq_file *m, void *v)
+{
+	struct net_device *dev = m->private;
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct ieee80211_device *ieee = priv->ieee80211;
+	struct ieee80211_network *target;
+
+	list_for_each_entry(target, &ieee->network_list, list) {
+		const char *wpa = "non_WPA";
+
+		if (target->wpa_ie_len > 0 || target->rsn_ie_len > 0)
+			wpa = "WPA";
+
+		seq_printf(m, "%s %s\n", target->ssid, wpa);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused proc_get_registers(struct seq_file *m, void *v)
+{
+	struct net_device *dev = m->private;
+	int i, n, max = 0xff;
+	u8 byte_rd;
+
+	seq_puts(m, "\n####################page 0##################\n ");
+
+	for (n = 0; n <= max;) {
+		seq_printf(m, "\nD:  %2x > ", n);
+
+		for (i = 0; i < 16 && n <= max; i++, n++) {
+			read_nic_byte(dev, 0x000 | n, &byte_rd);
+			seq_printf(m, "%2x ", byte_rd);
+		}
+	}
+
+	seq_puts(m, "\n####################page 1##################\n ");
+	for (n = 0; n <= max;) {
+		seq_printf(m, "\nD:  %2x > ", n);
+
+		for (i = 0; i < 16 && n <= max; i++, n++) {
+			read_nic_byte(dev, 0x100 | n, &byte_rd);
+			seq_printf(m, "%2x ", byte_rd);
+		}
+	}
+
+	seq_puts(m, "\n####################page 3##################\n ");
+	for (n = 0; n <= max;) {
+		seq_printf(m, "\nD:  %2x > ", n);
+
+		for (i = 0; i < 16 && n <= max; i++, n++) {
+			read_nic_byte(dev, 0x300 | n, &byte_rd);
+			seq_printf(m, "%2x ", byte_rd);
+		}
+	}
+
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
+{
+	struct net_device *dev = m->private;
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+
+	seq_printf(m,
+		   "TX VI priority ok int: %lu\n"
+		   "TX VI priority error int: %lu\n"
+		   "TX VO priority ok int: %lu\n"
+		   "TX VO priority error int: %lu\n"
+		   "TX BE priority ok int: %lu\n"
+		   "TX BE priority error int: %lu\n"
+		   "TX BK priority ok int: %lu\n"
+		   "TX BK priority error int: %lu\n"
+		   "TX MANAGE priority ok int: %lu\n"
+		   "TX MANAGE priority error int: %lu\n"
+		   "TX BEACON priority ok int: %lu\n"
+		   "TX BEACON priority error int: %lu\n"
+		   "TX queue resume: %lu\n"
+		   "TX queue stopped?: %d\n"
+		   "TX fifo overflow: %lu\n"
+		   "TX VI queue: %d\n"
+		   "TX VO queue: %d\n"
+		   "TX BE queue: %d\n"
+		   "TX BK queue: %d\n"
+		   "TX VI dropped: %lu\n"
+		   "TX VO dropped: %lu\n"
+		   "TX BE dropped: %lu\n"
+		   "TX BK dropped: %lu\n"
+		   "TX total data packets %lu\n",
+		   priv->stats.txviokint,
+		   priv->stats.txvierr,
+		   priv->stats.txvookint,
+		   priv->stats.txvoerr,
+		   priv->stats.txbeokint,
+		   priv->stats.txbeerr,
+		   priv->stats.txbkokint,
+		   priv->stats.txbkerr,
+		   priv->stats.txmanageokint,
+		   priv->stats.txmanageerr,
+		   priv->stats.txbeaconokint,
+		   priv->stats.txbeaconerr,
+		   priv->stats.txresumed,
+		   netif_queue_stopped(dev),
+		   priv->stats.txoverflow,
+		   atomic_read(&(priv->tx_pending[VI_PRIORITY])),
+		   atomic_read(&(priv->tx_pending[VO_PRIORITY])),
+		   atomic_read(&(priv->tx_pending[BE_PRIORITY])),
+		   atomic_read(&(priv->tx_pending[BK_PRIORITY])),
+		   priv->stats.txvidrop,
+		   priv->stats.txvodrop,
+		   priv->stats.txbedrop,
+		   priv->stats.txbkdrop,
+		   priv->stats.txdatapkt
+		);
+
+	return 0;
+}
+
+static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
+{
+	struct net_device *dev = m->private;
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+
+	seq_printf(m,
+		   "RX packets: %lu\n"
+		   "RX urb status error: %lu\n"
+		   "RX invalid urb error: %lu\n",
+		   priv->stats.rxoktotal,
+		   priv->stats.rxstaterr,
+		   priv->stats.rxurberr);
+
+	return 0;
+}
+
+void rtl8192_proc_module_init(void)
+{
+	RT_TRACE(COMP_INIT, "Initializing proc filesystem");
+	rtl8192_proc = proc_mkdir(RTL819XU_MODULE_NAME, init_net.proc_net);
+}
+
+void rtl8192_proc_init_one(struct net_device *dev)
+{
+	struct proc_dir_entry *dir;
+
+	if (!rtl8192_proc)
+		return;
+
+	dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
+	if (!dir)
+		return;
+
+	proc_create_single("stats-rx", S_IFREG | 0444, dir,
+			   proc_get_stats_rx);
+	proc_create_single("stats-tx", S_IFREG | 0444, dir,
+			   proc_get_stats_tx);
+	proc_create_single("stats-ap", S_IFREG | 0444, dir,
+			   proc_get_stats_ap);
+	proc_create_single("registers", S_IFREG | 0444, dir,
+			   proc_get_registers);
+}
+
+void rtl8192_proc_remove_one(struct net_device *dev)
+{
+	remove_proc_subtree(dev->name, rtl8192_proc);
+}
+
-- 
2.25.1

