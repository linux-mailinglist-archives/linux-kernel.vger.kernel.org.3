Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45D55792C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiGSFwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiGSFwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:52:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079DF3AB1E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:52:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f65so12540985pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYMw3UQMSz3H3pEqKtwqntC2HWF3rF+h4WbG3jMpFW8=;
        b=Ha35QSpftuGLQEgXNNAQerfzHjm7SNUtqmiJlu+HQ4JKZOL078A8FiEHVY1wjQPomE
         Nap3STG9AOP31UUR26j8pED2v65uTxk3WkRxNTslHnzCcm8f+5bFjFD7rexkNI6VxwbW
         U8REa6SfrY4xTk9wEnQAHV32nW8xABWcKYJOAbAvDOwFfn1GGQhU0XsgMr2kyRbIMW/Y
         +kSmdki82dBxglNQv3RMKId4Ze2YW7atEFGB2wotwUbue6OrYwaTReuJ/fvVZtUosAuc
         gMkrh5gsiu8N99B4Rc+EAqupq4K+WDcWNSaNU8yWrxeFqkdQFZ64pWb6UXlS68JJuKhH
         l+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYMw3UQMSz3H3pEqKtwqntC2HWF3rF+h4WbG3jMpFW8=;
        b=rOPxBnPZwZgJl31GFsXZSA5fUmLEJKvDRENAJvZ8iJd6kCngcKi00j3d3of4V3ih89
         jnl6oqq1X/bWBgiWHCKUGdLcleTHng9PNYgyVeIVVXE++fRMxvH0gLfhG99JY6x7lWL4
         C2Eo6O4Fn0eQxXbdshkIvXIPHqFDEDj/kqgZMHWiKFx2Hewlh/A0yxn6eyRYQht6pCBi
         mMPUjE3i0d+KHRhHdkyyWtCgiVGFm3c3XFjAfhLAfMz23ziJxhlsZeIJVQETIUED+/fc
         WCl5E7mxDs6mg3P/qovOjnfJpKosN6e0qEA8gOCTB098VUZTg185ACODxpvpOA0kjVUi
         ohpA==
X-Gm-Message-State: AJIora9rPYcacujDI50QgJYElKHjDiAhOfA7z3v9+0ESgPDLhGTdf/Eu
        as6isfuawVPdIVX4/AJ7dzY=
X-Google-Smtp-Source: AGRyM1soukGXPltJ6ev+v2A3YybFvRSG3OnYXbvRS5nKZu3xhTcAgOOhJXtvZpPqKNtMxQ4hMjDMSQ==
X-Received: by 2002:a62:4e89:0:b0:52b:6c56:7aea with SMTP id c131-20020a624e89000000b0052b6c567aeamr9640831pfb.19.1658209950463;
        Mon, 18 Jul 2022 22:52:30 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:33db:e37c:7ee3:662b])
        by smtp.googlemail.com with ESMTPSA id a16-20020a170902ecd000b0016c20d40ee7sm10709338plh.174.2022.07.18.22.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:52:30 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     dan.carpenter@oracle.com, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 3/3] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
Date:   Mon, 18 Jul 2022 22:50:38 -0700
Message-Id: <20220719055047.322355-4-ztong0001@gmail.com>
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

This driver creates 4 debug files under [devname] folder. The devname
could be wlan0 initially, however it could be renamed later to e.g.
enx00e04c00000. This will cause problem during debug file teardown since
it uses  netdev->name which is no longer wlan0. To solve this problem,
add a notifier to handle device renaming.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h         |  1 +
 drivers/staging/rtl8192u/r8192U_core.c    | 35 ++++++++++++++++++++++-
 drivers/staging/rtl8192u/r8192U_debugfs.c | 13 +++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index e8860bb2b607..ccce37b7e2ae 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1122,4 +1122,5 @@ void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 
 void rtl8192_debugfs_init(struct net_device *dev);
 void rtl8192_debugfs_exit(struct net_device *dev);
+void rtl8192_debugfs_rename(struct net_device *dev);
 #endif
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index ac3716550505..5cc78c5bd706 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4606,6 +4606,30 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
 }
 
+static int rtl8192_usb_netdev_event(struct notifier_block *nb, unsigned long event,
+				    void *data)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(data);
+
+	if (netdev->netdev_ops != &rtl8192_netdev_ops)
+		goto out;
+
+	switch (event) {
+	case NETDEV_CHANGENAME:
+		rtl8192_debugfs_rename(netdev);
+		break;
+	default:
+		break;
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
 static int __init rtl8192_usb_module_init(void)
 {
 	int ret;
@@ -4615,10 +4639,16 @@ static int __init rtl8192_usb_module_init(void)
 	RT_TRACE(COMP_INIT, "Initializing module");
 	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
 
+	ret = register_netdevice_notifier(&rtl8192_usb_netdev_notifier);
+	if (ret) {
+		pr_err("register_netdevice_notifier failed %d\n", ret);
+		return ret;
+	}
+
 	ret = ieee80211_debug_init();
 	if (ret) {
 		pr_err("ieee80211_debug_init() failed %d\n", ret);
-		return ret;
+		goto unregister_notifier;
 	}
 
 	ret = ieee80211_crypto_init();
@@ -4660,6 +4690,8 @@ static int __init rtl8192_usb_module_init(void)
 	ieee80211_crypto_deinit();
 debug_exit:
 	ieee80211_debug_exit();
+unregister_notifier:
+	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
 	return ret;
 }
 
@@ -4671,6 +4703,7 @@ static void __exit rtl8192_usb_module_exit(void)
 	ieee80211_crypto_tkip_exit();
 	ieee80211_crypto_deinit();
 	ieee80211_debug_exit();
+	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
 	RT_TRACE(COMP_DOWN, "Exiting");
 }
 
diff --git a/drivers/staging/rtl8192u/r8192U_debugfs.c b/drivers/staging/rtl8192u/r8192U_debugfs.c
index 5c9376e50889..c94f5dfac96b 100644
--- a/drivers/staging/rtl8192u/r8192U_debugfs.c
+++ b/drivers/staging/rtl8192u/r8192U_debugfs.c
@@ -173,3 +173,16 @@ void rtl8192_debugfs_exit(struct net_device *dev)
 	priv->debugfs_dir = NULL;
 }
 
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
+		       priv->debugfs_dir->d_parent, dev->name);
+}
-- 
2.25.1

