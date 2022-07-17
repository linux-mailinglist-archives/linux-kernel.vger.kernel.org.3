Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5745B5774D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiGQHCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGQHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:02:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899214D38
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:02:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f11so6525508plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3YODaLg6IJtr4aTMOhqScTfY/2oANLKLGaNfhoRUIc=;
        b=XScVlpFgrOHVH/1Hcil2WK88W1vF6uginsZVeh9sGRQdk+FT+rZEHafd6aaeKQQ69d
         JjFMjksS9u2120H8UjqvfuOesuV4C0qBH4zrTbSXb0dgKDZb8k0+FpS+onh9TCOyFidW
         DhkjNE0HnyeKanr6wmauoKGdY3IVChJ9n1ZXu3i9DdLEBxgNifbC54vL2n/EqLx6ruB6
         eAAl1rPOwDbkRw20la320Q866H0U/fKOTLv823F1XnUkKGWP4apQK+yCnD1bV2cbTO7i
         rCIPVJBmqD3Co8iG3FEvJw/oSQDnviylU5haTiO+ruLEiKgucl8GatJ6BWtntmhaHG+k
         FODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3YODaLg6IJtr4aTMOhqScTfY/2oANLKLGaNfhoRUIc=;
        b=FuZbS0ixAAK/UnnngvdGujRp4Rh9CM8KMHZtKUnaHri9COUc3afwTmUxf5ONb+ABbf
         W9u0xqeVFdTZPAXIG69lrOT7KrSPPmU7vz/DzT/Dr3a7xUqNxxWQNQL+V8fx5oiVnNsU
         muUdDHWcqBwNaTXGT//L1o9AJeEd24e7QnmyldAQX4UeW35HdPnyaaj2i8+XJ1b3jYTX
         IeWJNtBB0FEP3auTqqb6R9P1rJuUHCKBFmRqA1gpvmbb6XagnL0F/2CHCZlPbiLEssTw
         cL56QbX07df0Vm/kqyWiMQPuj0GMliPmlzA966eacMG5JenSUp/OZTKrACtAyUtvrlfK
         5CLA==
X-Gm-Message-State: AJIora/B7ETf1rSt+yxd9BCnXChzJ1GLdyJgWOPYyyo/H2HeDFOvSXLL
        mwmH8t+5bxZn/WMszLLAhzA=
X-Google-Smtp-Source: AGRyM1s4PwUoTFRSrxhTcxwq44mg6LKRt+fNBv71lRKc5HjW5hIS7qMKlCv/x+iQ5F8c7y9+r/cZMg==
X-Received: by 2002:a17:902:e78f:b0:16c:8741:fea1 with SMTP id cp15-20020a170902e78f00b0016c8741fea1mr20659262plb.89.1658041350571;
        Sun, 17 Jul 2022 00:02:30 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:d88:de1e:b1c6:418b])
        by smtp.googlemail.com with ESMTPSA id e4-20020a170902784400b0016ccbc9db0fsm4274487pln.5.2022.07.17.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 00:02:30 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
Date:   Sun, 17 Jul 2022 00:01:57 -0700
Message-Id: <20220717070204.705878-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
References: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
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

There are 4 debug files created under /proc/net/[Devname]. Devname could
be wlan0 initially, however it could be renamed later to e.g. enx00e04c000002.
This will cause problem during debug file teardown since it uses
netdev->name which is no longer wlan0. To solve this problem, add a
notifier to handle device renaming.

Also, due to this is purely for debuging as files are created read only,
move this to debugfs like other NIC drivers do instead of using procfs.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/Makefile         |   1 +
 drivers/staging/rtl8192u/r8192U.h         |   7 +
 drivers/staging/rtl8192u/r8192U_core.c    | 220 ++++------------------
 drivers/staging/rtl8192u/r8192U_debugfs.c | 185 ++++++++++++++++++
 4 files changed, 230 insertions(+), 183 deletions(-)
 create mode 100644 drivers/staging/rtl8192u/r8192U_debugfs.c

diff --git a/drivers/staging/rtl8192u/Makefile b/drivers/staging/rtl8192u/Makefile
index 0be7426b6ebc..d32dfd89a606 100644
--- a/drivers/staging/rtl8192u/Makefile
+++ b/drivers/staging/rtl8192u/Makefile
@@ -8,6 +8,7 @@ ccflags-y += -DTHOMAS_BEACON -DTHOMAS_TASKLET -DTHOMAS_SKB -DTHOMAS_TURBO
 r8192u_usb-y := r8192U_core.o r8180_93cx6.o r8192U_wx.o		\
 		  r8190_rtl8256.o r819xU_phy.o r819xU_firmware.o	\
 		  r819xU_cmdpkt.o r8192U_dm.o r819xU_firmware_img.o	\
+		  r8192U_debugfs.o					\
 		  ieee80211/ieee80211_crypt.o				\
 		  ieee80211/ieee80211_crypt_tkip.o			\
 		  ieee80211/ieee80211_crypt_ccmp.o			\
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 14ca00a2789b..34ed013aabf1 100644
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
@@ -1117,4 +1120,8 @@ void EnableHWSecurityConfig8192(struct net_device *dev);
 void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 	    const u8 *MacAddr, u8 DefaultKey, u32 *KeyContent);
 
+void rtl8192_debugfs_init(struct net_device *dev);
+void rtl8192_debugfs_exit(struct net_device *dev);
+void rtl8192_debugfs_rename(struct net_device *dev);
+
 #endif
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 2ca925f35830..2fba1cf59372 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -56,7 +56,6 @@ double __extendsfdf2(float a)
 #include "r8192U_dm.h"
 #include <linux/usb.h>
 #include <linux/slab.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 /* FIXME: check if 2.6.7 is ok */
 
@@ -452,179 +451,6 @@ static struct net_device_stats *rtl8192_stats(struct net_device *dev);
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
@@ -4730,7 +4556,7 @@ static int rtl8192_usb_probe(struct usb_interface *intf,
 		goto fail2;
 
 	RT_TRACE(COMP_INIT, "dev name=======> %s\n", dev->name);
-	rtl8192_proc_init_one(dev);
+	rtl8192_debugfs_init(dev);
 
 	RT_TRACE(COMP_INIT, "Driver probe completed\n");
 	return 0;
@@ -4764,11 +4590,9 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 	struct net_device *dev = usb_get_intfdata(intf);
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	unregister_netdev(dev);
-
 	RT_TRACE(COMP_DOWN, "=============>wlan driver to be removed\n");
-	rtl8192_proc_remove_one(dev);
-
+	rtl8192_debugfs_exit(dev);
+	unregister_netdev(dev);
 	rtl8192_down(dev);
 	kfree(priv->pFirmware);
 	priv->pFirmware = NULL;
@@ -4779,6 +4603,32 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
 }
 
+static int rtl8192_usb_netdev_event(struct notifier_block *nb, unsigned long event,
+		void *data)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(data);
+
+	if (netdev->netdev_ops != &rtl8192_netdev_ops)
+		goto out;
+
+	switch (event) {
+		case NETDEV_CHANGENAME:
+			rtl8192_debugfs_rename(netdev);
+			break;
+
+		default:
+			break;
+	}
+
+out:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rtl8192_usb_netdev_notifier = {
+	.notifier_call = rtl8192_usb_netdev_event,
+};
+
+
 static int __init rtl8192_usb_module_init(void)
 {
 	int ret;
@@ -4788,10 +4638,14 @@ static int __init rtl8192_usb_module_init(void)
 	RT_TRACE(COMP_INIT, "Initializing module");
 	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
 
+	ret = register_netdevice_notifier(&rtl8192_usb_netdev_notifier);
+	if (ret)
+		return ret;
+
 	ret = ieee80211_debug_init();
 	if (ret) {
 		pr_err("ieee80211_debug_init() failed %d\n", ret);
-		return ret;
+		goto debug_init;
 	}
 
 	ret = ieee80211_crypto_init();
@@ -4818,14 +4672,12 @@ static int __init rtl8192_usb_module_init(void)
 		goto crypto_ccmp_exit;
 	}
 
-	rtl8192_proc_module_init();
 	ret = usb_register(&rtl8192_usb_driver);
 	if (ret)
 		goto rtl8192_proc_module_exit;
 	return ret;
 
 rtl8192_proc_module_exit:
-	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
 	ieee80211_crypto_wep_exit();
 crypto_ccmp_exit:
 	ieee80211_crypto_ccmp_exit();
@@ -4835,18 +4687,20 @@ static int __init rtl8192_usb_module_init(void)
 	ieee80211_crypto_deinit();
 debug_exit:
 	ieee80211_debug_exit();
+debug_init:
+	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
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
+	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
 	RT_TRACE(COMP_DOWN, "Exiting");
 }
 
diff --git a/drivers/staging/rtl8192u/r8192U_debugfs.c b/drivers/staging/rtl8192u/r8192U_debugfs.c
new file mode 100644
index 000000000000..96cdc245bd03
--- /dev/null
+++ b/drivers/staging/rtl8192u/r8192U_debugfs.c
@@ -0,0 +1,185 @@
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include "r8192U.h"
+
+static int rtl8192_usb_stats_rx_show(struct seq_file *m, void *v)
+{
+	struct net_device *dev = m->private;
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+
+	seq_printf(m,
+			"RX packets: %lu\n"
+			"RX urb status error: %lu\n"
+			"RX invalid urb error: %lu\n",
+			priv->stats.rxoktotal,
+			priv->stats.rxstaterr,
+			priv->stats.rxurberr);
+
+	return 0;
+}
+
+static int rtl8192_usb_stats_tx_show(struct seq_file *m, void *v)
+{
+	struct net_device *dev = m->private;
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+
+	seq_printf(m,
+			"TX VI priority ok int: %lu\n"
+			"TX VI priority error int: %lu\n"
+			"TX VO priority ok int: %lu\n"
+			"TX VO priority error int: %lu\n"
+			"TX BE priority ok int: %lu\n"
+			"TX BE priority error int: %lu\n"
+			"TX BK priority ok int: %lu\n"
+			"TX BK priority error int: %lu\n"
+			"TX MANAGE priority ok int: %lu\n"
+			"TX MANAGE priority error int: %lu\n"
+			"TX BEACON priority ok int: %lu\n"
+			"TX BEACON priority error int: %lu\n"
+			"TX queue resume: %lu\n"
+			"TX queue stopped?: %d\n"
+			"TX fifo overflow: %lu\n"
+			"TX VI queue: %d\n"
+			"TX VO queue: %d\n"
+			"TX BE queue: %d\n"
+			"TX BK queue: %d\n"
+			"TX VI dropped: %lu\n"
+			"TX VO dropped: %lu\n"
+			"TX BE dropped: %lu\n"
+			"TX BK dropped: %lu\n"
+			"TX total data packets %lu\n",
+		priv->stats.txviokint,
+		priv->stats.txvierr,
+		priv->stats.txvookint,
+		priv->stats.txvoerr,
+		priv->stats.txbeokint,
+		priv->stats.txbeerr,
+		priv->stats.txbkokint,
+		priv->stats.txbkerr,
+		priv->stats.txmanageokint,
+		priv->stats.txmanageerr,
+		priv->stats.txbeaconokint,
+		priv->stats.txbeaconerr,
+		priv->stats.txresumed,
+		netif_queue_stopped(dev),
+		priv->stats.txoverflow,
+		atomic_read(&(priv->tx_pending[VI_PRIORITY])),
+		atomic_read(&(priv->tx_pending[VO_PRIORITY])),
+		atomic_read(&(priv->tx_pending[BE_PRIORITY])),
+		atomic_read(&(priv->tx_pending[BK_PRIORITY])),
+		priv->stats.txvidrop,
+		priv->stats.txvodrop,
+		priv->stats.txbedrop,
+		priv->stats.txbkdrop,
+		priv->stats.txdatapkt
+			);
+
+	return 0;
+}
+
+static int rtl8192_usb_stats_ap_show(struct seq_file *m, void *v)
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
+static int rtl8192_usb_registers_show(struct seq_file *m, void *v)
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
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_stats_rx);
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_stats_tx);
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_stats_ap);
+DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_registers);
+
+void rtl8192_debugfs_init(struct net_device *dev)
+{
+	struct dentry *dir;
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+
+	dir = debugfs_create_dir(dev->name, NULL);
+	if (IS_ERR_OR_NULL(dir))
+		return;
+
+	debugfs_create_file("stats-rx", 0444, dir, dev, &rtl8192_usb_stats_rx_fops);
+	debugfs_create_file("stats-tx", 0444, dir, dev, &rtl8192_usb_stats_tx_fops);
+	debugfs_create_file("stats-ap", 0444, dir, dev, &rtl8192_usb_stats_ap_fops);
+	debugfs_create_file("registers", 0444, dir, dev, &rtl8192_usb_registers_fops);
+
+	priv->debugfs_dir = dir;
+}
+
+void rtl8192_debugfs_exit(struct net_device *dev)
+{
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	if (!priv->debugfs_dir)
+		return;
+	debugfs_remove_recursive(priv->debugfs_dir);
+	priv->debugfs_dir = NULL;
+}
+
+void rtl8192_debugfs_rename(struct net_device *dev)
+{
+	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+
+	if (!priv->debugfs_dir)
+		return;
+
+	if (!strcmp(priv->debugfs_dir->d_name.name, dev->name))
+		return;
+
+	debugfs_rename(priv->debugfs_dir->d_parent, priv->debugfs_dir,
+			priv->debugfs_dir->d_parent, dev->name);
+}
+
-- 
2.25.1

