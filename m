Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231465792C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiGSFwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiGSFwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:52:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE63AB1E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:52:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so20256615pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqhdb3/2rdTXU2DMrR5JDzTqb8Ywu73La3zbaly2kEw=;
        b=ZL/t+30gju8Gtm3GPUZwhjyYHuiMifPg77qDdGPM0mDwvtggiZEb+pMdqLYzGXEiqX
         M1BpL1m5dAckDSBCI5JoQ+PRZeNQu35KKbiplmiFz89sn1dZH4r2E8VIamWBz5DrlcpC
         FQSDjJs/uJVKEzP77w2Nh+iZndcQl85yQqJfTaiYnkb9MSmCZn/JkgiRQvXY1BMJ+V4T
         zuyICJb+UYDbhMqpW0q5+c3eOje9n8tpKaMUVKti/X72P0fAnvpXeoAFMTij5eSEw4ku
         PpDnnX0tuhsMasgZ9TTLzMsWC4S2RM2kcFC1jk3kXhgwe/lcoNvQrQ+mo7bGkF7XGN06
         vU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqhdb3/2rdTXU2DMrR5JDzTqb8Ywu73La3zbaly2kEw=;
        b=lTc5K5M+dEJu2qU/LBEG5H0mNqPqYxP+uxOzcR5QsBzNIReRBpPmVGOi6kVO5MrnsU
         gxuKtDUQq27/GURvtpSjyd1tKBGyeAaoJohKdo9B/OzkaHK2qSDjsQowcudX3g7c7KUh
         rl9iRLUVZ6lojTgw+ccimtiae+JGPFY8TJrt6dHInO94FqLDWzGkAa2tyjtzVLTdJ2S+
         RvRh2AoRpDn+Ox55NEopquUvCaE9kpcpEgkBuABFWMnchsHHih7kol+OYbsueTfTH1/A
         yhUQJ+GaMIV/teeZPxozu1VPESHV4scaoIq/svcbXTtOcmx6z+h8InwraAv5ghgB3r0q
         iuOw==
X-Gm-Message-State: AJIora8G3Gvgko2FZj/LCf9YJlHXWK9/v7GL93uUywT1BwtA1F67HRjC
        YEgso07iPtn3O70HjxbsOiQ=
X-Google-Smtp-Source: AGRyM1vBfcwlXG3gZT6jk4owjM3a5yNa/Av4+KWszMk4cmSk+izz/emQhreUSqEWCbhRzv4BXrKN5A==
X-Received: by 2002:a17:902:ef47:b0:16c:60df:3a7c with SMTP id e7-20020a170902ef4700b0016c60df3a7cmr31576265plx.9.1658209927942;
        Mon, 18 Jul 2022 22:52:07 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:33db:e37c:7ee3:662b])
        by smtp.googlemail.com with ESMTPSA id a16-20020a170902ecd000b0016c20d40ee7sm10709338plh.174.2022.07.18.22.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:52:07 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     dan.carpenter@oracle.com
Subject: [PATCH v2 1/3] staging: rtl8192u: move debug stuff to its own file
Date:   Mon, 18 Jul 2022 22:50:36 -0700
Message-Id: <20220719055047.322355-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120149.GD2338@kadam>
References: <20220718120149.GD2338@kadam>
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

