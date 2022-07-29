Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468FE584A69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiG2DyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiG2Dxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:53:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47317D1CA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:53:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b9so3566851pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+RQ5jl0QZSNw11sMEYyKmhqkb/IQTFMm9WWtDB/yiG4=;
        b=JKKq4lgBFOs5kA9DHxls2r0V0nUa9DgcuppsEOpgLbHO2asFLBvA4nlO0SLjfXYImx
         L4D9qo2TKzvcWPWtfVUpwy2c35yeS0rYIO9d9eCZFRqHZ0zbGNXJArPGnYY9PNlMEOdf
         bNjAWk8pr48FZgq1KIGAERU2WdPHjxwEN6oMWznvwTKSLVmGDkqizKhTOsWy+29KF3+9
         jAMjhixxbXebLzKckyNyrmwr8pzE1oB2MMSHw8tGTGcJDkybwpunkcbm9WJY36C7os3Q
         aaYDMhQxqOaVaACH6IueJxhdiCAlaFtPpe6nTio0UUhiNeSGNGSp8pT+FTB6pSIknM6m
         ajoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+RQ5jl0QZSNw11sMEYyKmhqkb/IQTFMm9WWtDB/yiG4=;
        b=g/6wrmhWJAAiKf/ZXeekzsilhrVPAL+w6Xz2nmz1u6A5/aEWhPXElVh6RWPwR5lOKw
         lh5oT3eiZSukwjo19h/j9lNN/T7CwHZnxvBdIyan+cWDS2XdPjXUB468YiAZc+atSQTk
         NxZBdY6+gzVTIMjMw/kszYohO6Po/DC/JL4ahsvvyincu1ZoMiD2GhKIF/rXiNJtHg1w
         cvbP2KkN8J1MfHXPXiC1uN93M5JCObxa5lDLloqeVjSsRhxnaWoSy2l+gWORw9C7b7M2
         Sq3XIIOvHFUpBvJJBO2t/HrlkpVDBL+fzo5zWkyuSJEHlPG9PkZ2hSt519C1XYUxl62J
         LXuQ==
X-Gm-Message-State: AJIora/6VrG8shskEBKoiF3lNUqU0zCrvBQU67dSt/PtQhSOE6Q2himX
        nuvGEPZMmU7bw1CQQ22NL10=
X-Google-Smtp-Source: AGRyM1sGqYdaiGUmCAdFLSmDl00nWSX1oXgslThHgn+h7hlMqMIT0F7c/8jYs6biiJ/yJjo6W+l8CA==
X-Received: by 2002:aa7:8d94:0:b0:52b:a70e:ae89 with SMTP id i20-20020aa78d94000000b0052ba70eae89mr1901086pfr.23.1659066801787;
        Thu, 28 Jul 2022 20:53:21 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:a06b:5560:ec65:277f])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902680e00b0016d2d2c7df1sm2135478plk.188.2022.07.28.20.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:53:21 -0700 (PDT)
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
Cc:     Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v3 3/3] staging: rtl8192u: fix rmmod warn when device is renamed
Date:   Thu, 28 Jul 2022 20:52:20 -0700
Message-Id: <20220729035230.226172-4-ztong0001@gmail.com>
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

This driver creates 4 debug files under [devname] folder. The devname
could be wlan0 initially, however it could be renamed later to e.g.
enx00e04c00000. This will cause problem during debug file teardown since
it uses netdev->name, which is no longer wlan0. To solve this problem,
add a notifier to handle device renaming. Also note that we cannot
simply do debugfs_lookup to find out old dentry since by the time the
notifier is called, netdev->name is already changed to new name.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h         |  1 +
 drivers/staging/rtl8192u/r8192U_core.c    | 32 +++++++++++++++++++++++
 drivers/staging/rtl8192u/r8192U_debugfs.c | 12 +++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 920a6a154860..420ab696fc3e 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1122,6 +1122,7 @@ void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 
 void rtl8192_debugfs_init_one(struct net_device *dev);
 void rtl8192_debugfs_exit_one(struct net_device *dev);
+void rtl8192_debugfs_rename_one(struct net_device *dev);
 void rtl8192_debugfs_init(void);
 void rtl8192_debugfs_exit(void);
 
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 865bc0dc7c71..0a60ef20107c 100644
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
+		rtl8192_debugfs_rename_one(netdev);
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
@@ -4615,6 +4639,12 @@ static int __init rtl8192_usb_module_init(void)
 	RT_TRACE(COMP_INIT, "Initializing module");
 	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
 
+	ret = register_netdevice_notifier(&rtl8192_usb_netdev_notifier);
+	if (ret) {
+		pr_err("register_netdevice_notifier failed %d\n", ret);
+		return ret;
+	}
+
 	rtl8192_debugfs_init();
 	ret = ieee80211_debug_init();
 	if (ret) {
@@ -4663,6 +4693,7 @@ static int __init rtl8192_usb_module_init(void)
 	ieee80211_debug_exit();
 debugfs_exit:
 	rtl8192_debugfs_exit();
+	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
 	return ret;
 }
 
@@ -4675,6 +4706,7 @@ static void __exit rtl8192_usb_module_exit(void)
 	ieee80211_crypto_deinit();
 	ieee80211_debug_exit();
 	rtl8192_debugfs_exit();
+	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
 	RT_TRACE(COMP_DOWN, "Exiting");
 }
 
diff --git a/drivers/staging/rtl8192u/r8192U_debugfs.c b/drivers/staging/rtl8192u/r8192U_debugfs.c
index 79cd095114ca..e80cfe24facf 100644
--- a/drivers/staging/rtl8192u/r8192U_debugfs.c
+++ b/drivers/staging/rtl8192u/r8192U_debugfs.c
@@ -150,7 +150,7 @@ DEFINE_SHOW_ATTRIBUTE(rtl8192_usb_registers);
 
 void rtl8192_debugfs_init_one(struct net_device *dev)
 {
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct r8192_priv *priv = ieee80211_priv(dev);
 	struct dentry *parent_dir = debugfs_lookup(R8192U_DEBUGFS_DIR_NAME, NULL);
 	struct dentry *dir = debugfs_create_dir(dev->name, parent_dir);
 
@@ -164,11 +164,19 @@ void rtl8192_debugfs_init_one(struct net_device *dev)
 
 void rtl8192_debugfs_exit_one(struct net_device *dev)
 {
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	debugfs_remove_recursive(priv->debugfs_dir);
 }
 
+void rtl8192_debugfs_rename_one(struct net_device *dev)
+{
+	struct r8192_priv *priv = ieee80211_priv(dev);
+	struct dentry *parent_dir = debugfs_lookup(R8192U_DEBUGFS_DIR_NAME, NULL);
+
+	debugfs_rename(parent_dir, priv->debugfs_dir, parent_dir, dev->name);
+}
+
 void rtl8192_debugfs_init(void)
 {
 	debugfs_create_dir(R8192U_DEBUGFS_DIR_NAME, NULL);
-- 
2.25.1

