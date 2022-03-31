Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0794ED41A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiCaGtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiCaGto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:49:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AA1EDA21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:47:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b24so26993410edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1JtTmDSsjT/JKwoohwXjZdpIO33MVT5jjl60V1LMmQ=;
        b=OjcqCymz2Jqp4RIWZLuiV+tt/V0bIVyJjrGu5ftViQNgUXxcvp3sUA4kO2/Mwvpz0M
         CXUBXzmAn5bheg10sMnrIT+uG3DrIcjlUVUsBwXNXNsMNCHMpzFpiZ4oK+bkPqnBp7ZV
         g+9hyZJs88czgFL/PaKATyOq5FAj9B0O+25nvegHiNTIoRe+M44UtQtfk2wP63197LwV
         3j/CpZR/4E5qaXJTi9oAKlwF9muoaxQs2ls7ERTieUNPsil2f9vG31fdBuVCacxdNh/A
         MDpPAcstfrZRI2aEV/ypbq3LVopfMT5Y/ADtkbJENaKssUFhbGkvMEA12wSCkuSlHfGN
         5Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1JtTmDSsjT/JKwoohwXjZdpIO33MVT5jjl60V1LMmQ=;
        b=KMgWrqyDKnWJkWZN8TE/3hL8a295tv/6eAT9JlMeAxj/XYFVdVmqc7ekVqtD7ViARJ
         1A8B4/DuG9xDqS4fWgWQILOHpIZ7zfcBLzXsqcTpwNuxLB9p5a4nwpFwvKOyLzVWil+b
         kJ9ZuuA5bWr8aUmW0KkeseJiPlMvOBeK98GhWlD85FkJ7NDSxpv6iAswUC80qpT2mlz8
         bmJlUknE14/4slLPRgXfGFllmJpKIMh9sgKbZ/7qBXS6ZcGHOQ2X/B66mokqcRUQTfug
         KP06P6vkvg+zsl0QrnUxm0PMGLqW/OTrhhwV3kSR6HbBfKD2DlCT2EtTx0sOdkrsxTRt
         BBSg==
X-Gm-Message-State: AOAM531dQvVDkNr7nmzituo6cOoj9E4807SZ+MEiJ4VKPary/8cSFgQn
        DsVxuaFt8xREvojqYNjBxl0gPPeADLk=
X-Google-Smtp-Source: ABdhPJyvFOEjtIdxk3uQZ18fXFu/x90nFX3NmRWstUZSdw682pcmaa975KRBGhinfixwhwoeHO5C/g==
X-Received: by 2002:a05:6402:1107:b0:416:439a:6a9e with SMTP id u7-20020a056402110700b00416439a6a9emr14948578edv.382.1648709275569;
        Wed, 30 Mar 2022 23:47:55 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm9227155ejl.122.2022.03.30.23.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 23:47:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: unisys: Remove "struct dentry *eth_debugfs_dir"
Date:   Thu, 31 Mar 2022 08:47:51 +0200
Message-Id: <20220331064751.29634-1-fmdefrancesco@gmail.com>
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
everything related (i.e., creation and removal).

As a side effect of this change, the code has no more need of the
"cleanup_register_netdev" label, which can also be removed.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 - v2: Add a couple of "Suggested-by" tags which were forgotten. 
Thanks to Dan Carpenter and Greg Kroah-Hartman.

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

