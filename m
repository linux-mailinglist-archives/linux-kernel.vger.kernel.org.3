Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6344E3ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiCVIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiCVIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:40:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5F17AB9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:39:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h1so20752279edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X99bYtMPXK/lUQRyXYEMc82PYA/a9iPeIbyvT5Yw/Y4=;
        b=kjzsyGVFO7n/ps8vT3T+52rxTOI3jY2t4UGftFX6Dtm8CrsMtWfqW64D0NbY1KpUuR
         jdxGVxIa88gbx79Sk52K8S8NW2HRlfKnjYPVqvF8NYUPt+I3CEtqMyxVhYYuW5W+vm37
         TgSCx1X8nvHFVASN7iSujEpSLkonNCyxDyUi30caOnYTIo1WWoHgKoxRviJpAVa1TdH8
         hh3/+J3r2akg4O/LDR7iHSIDypgp6iGeiX68pb4XD8EPB7vNijFw/2YUo4+Zg7RKIjua
         1ZvETy+DeS/IcM+O3CUR+AOnxe7HaBuGeZTcyfp6U+MzK7FS9MVRGwc0WOFqu8N7y6dE
         Ny6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X99bYtMPXK/lUQRyXYEMc82PYA/a9iPeIbyvT5Yw/Y4=;
        b=7tPNdLZH0mhHSZJerVjRPGpFHmqnC/WTtlA4vjhOyzNRiGfPNclf0Znh9Y5QHArCpA
         lDLs91OykNhPHAsDdep6hs71boA91WkBg+man2ulNPYzqqYvgLlay8ztmC1kNRDQoZd6
         irnQQgVA5hRohOBzNbM0j7esnIG6akgvYEW0dtuyqZIAZ1cNbJ9wehMtNO8zXtgFE7W+
         huKf1znEnPk4/cq74NvF4OSIE1j7Nk6IiiOD0sS/uZcyTDRLIsgJZZq4nTC22YH6FBZ6
         jNJt3spwxZQnoyevor2tRTRL/56Y0ZEAYCxjf/IQVbmj7xmvoHY6oKq39CyH24LtSQ4c
         0bgg==
X-Gm-Message-State: AOAM5329DHSaheyhdvNtn7CIH+qkLcKIqA3ixb7fgT2VExCv0my/zivb
        aX7w/DpOnxNPRnWzS14gstM7PWLc+xI=
X-Google-Smtp-Source: ABdhPJxXDtRJWchyCbVOGD2wwIGmi4wLssoOiyYgO2VoKtkzls9TLlTHQKUP8kctT6dQwoJcuefSAA==
X-Received: by 2002:a05:6402:280f:b0:419:4c6f:a91b with SMTP id h15-20020a056402280f00b004194c6fa91bmr6438066ede.84.1647938342706;
        Tue, 22 Mar 2022 01:39:02 -0700 (PDT)
Received: from localhost.localdomain (host-79-37-100-169.retail.telecomitalia.it. [79.37.100.169])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm3631131ejc.61.2022.03.22.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:39:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: unisys: Properly test debugfs_create_dir() return values
Date:   Tue, 22 Mar 2022 09:38:58 +0100
Message-Id: <20220322083858.16887-1-fmdefrancesco@gmail.com>
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

debugfs_create_dir() returns a pointers to a dentry objects. On failures
it returns errors. Currently the values returned to visornic_probe()
seem to be tested for being equal to NULL in case of failures.

Properly test with "if (IS_ERR())" and then assign the correct error 
value to the "err" variable.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 643432458105..58d03f3d3173 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *dev)
 	/* create debug/sysfs directories */
 	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
 						      visornic_debugfs_dir);
-	if (!devdata->eth_debugfs_dir) {
+	if (IS_ERR(devdata->eth_debugfs_dir)) {
 		dev_err(&dev->device,
 			"%s debugfs_create_dir %s failed\n",
 			__func__, netdev->name);
-		err = -ENOMEM;
+		err = PTR_ERR(devdata->eth_debugfs_dir);
 		goto cleanup_register_netdev;
 	}
 
-- 
2.34.1

