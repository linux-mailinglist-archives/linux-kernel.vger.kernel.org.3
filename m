Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4DA4ED40A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiCaGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiCaGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:43:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F8ABF5A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:41:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b15so27020267edn.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRVZfZhek/ld27PxqrvAQx7maxQWJQLXz5r4N00GOvw=;
        b=Xi15f2aQFwUqwT9TRfxb1qLZvAF/UDB1Tt0O9qg5coX6j0xbBItJGn1yVFfRp2bGWs
         CyISIlUzkJxbvKCdz+xyfNlp4GXb9ZaA2NELq4JW91qbOeZTPzWd4iZY6XL9JPC9P+1t
         +TIQoHlEn5SxgLYrk4/UK4irrscHYYlOJOv5Fjm61PDQyTpJfOLjJ3VcMc2kAxBwETUO
         xa8EE6m9WBm2PqMFCF6SMxNdalTNQzljyMoUOC/4BLfWqfeqjmyvoKfgHh2MtKAbJH9N
         UWRqJLBk+Nvrn8+5LValSaXCvoxz9R0Usfvuhx3gKu9XNZI/16lDqDAdL6APKiLxTOZF
         V9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRVZfZhek/ld27PxqrvAQx7maxQWJQLXz5r4N00GOvw=;
        b=BkHagszybgYgWHeRvdL4XJmnnxhaTSOqMPjZ3P+dmR0QRQMTAZxIfmVnE/XbU8599C
         E8gHYmIvWrmXXohMy5+K4tYG3P7fJx69cvu+Mktkuqq0PJjztD4Yll0NA2p/FkngTqPN
         c7l/9CXLudmv8zXeHz2+nJCLUa5NVZZcwJ71la17HMpn8jjyjbu+F4tIHLr3JBsFFYc8
         llWhGilu3LCS4P+aUIppb7OeQUl+bLUd/D6ijLPluyxqH6h7VIIcEeTiiqXvNnPLcpHj
         twMOxPh6z+s5lABzZZGCqGiEco4FDz8IErc4cjPtaQN8PbjF4CPzn3y6vfrFhvVHKjHZ
         CYSg==
X-Gm-Message-State: AOAM531s5xlJ60duiwsISubx7mPMTfPzyhH8npQ/iYr6veOvIMIXacVq
        rrtEWlPxmWcMJNQhExXeHBY=
X-Google-Smtp-Source: ABdhPJzhFtKO5Fs8WACAacp4q9R9a24cKA+TW99SvZ81BfLY1EtflbXpMX6JRr/ibKETH7Zt2DpGMw==
X-Received: by 2002:aa7:d58e:0:b0:419:c121:ea33 with SMTP id r14-20020aa7d58e000000b00419c121ea33mr14939013edq.256.1648708880560;
        Wed, 30 Mar 2022 23:41:20 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm5368593edb.39.2022.03.30.23.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 23:41:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: unisys: Remove "struct dentry *eth_debugfs_dir"
Date:   Thu, 31 Mar 2022 08:41:15 +0200
Message-Id: <20220331064115.29345-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for "struct dentry *eth_debugfs_dir" which is used for
debug / sysfs directories. Therefore, remove this "struct dentry" and
everything related (i.e., creation, test, removal).

As a side effect of this change, the code has no more need of the
"cleanup_register_netdev" label, which can also be removed.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/unisys/visornic/visornic_main.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 643432458105..bb7ec492503e 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -103,7 +103,6 @@ struct chanstat {
  * @server_down:                    IOPART is down.
  * @server_change_state:            Processing SERVER_CHANGESTATE msg.
  * @going_away:                     device is being torn down.
- * @struct *eth_debugfs_dir:
  * @interrupts_rcvd:
  * @interrupts_notme:
  * @interrupts_disabled:
@@ -157,7 +156,6 @@ struct visornic_devdata {
 	bool server_down;
 	bool server_change_state;
 	bool going_away;
-	struct dentry *eth_debugfs_dir;
 	u64 interrupts_rcvd;
 	u64 interrupts_notme;
 	u64 interrupts_disabled;
@@ -1919,24 +1917,10 @@ static int visornic_probe(struct visor_device *dev)
 		goto cleanup_napi_add;
 	}
 
-	/* create debug/sysfs directories */
-	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
-						      visornic_debugfs_dir);
-	if (!devdata->eth_debugfs_dir) {
-		dev_err(&dev->device,
-			"%s debugfs_create_dir %s failed\n",
-			__func__, netdev->name);
-		err = -ENOMEM;
-		goto cleanup_register_netdev;
-	}
-
 	dev_info(&dev->device, "%s success netdev=%s\n",
 		 __func__, netdev->name);
 	return 0;
 
-cleanup_register_netdev:
-	unregister_netdev(netdev);
-
 cleanup_napi_add:
 	visorbus_disable_channel_interrupts(dev);
 	netif_napi_del(&devdata->napi);
@@ -2002,7 +1986,6 @@ static void visornic_remove(struct visor_device *dev)
 	/* going_away prevents new items being added to the workqueues */
 	cancel_work_sync(&devdata->timeout_reset);
 
-	debugfs_remove_recursive(devdata->eth_debugfs_dir);
 	/* this will call visornic_close() */
 	unregister_netdev(netdev);
 
-- 
2.34.1

