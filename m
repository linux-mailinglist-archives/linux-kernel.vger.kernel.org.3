Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4B4D7600
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiCMPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiCMPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:07:18 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F558E4E;
        Sun, 13 Mar 2022 08:06:07 -0700 (PDT)
Received: from frank-virtual-machine.lan ([172.16.0.254])
        (user=mx_xiang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 22DF4sL0020655-22DF4sL3020655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 13 Mar 2022 23:05:09 +0800
From:   Mingxuan Xiang <mx_xiang@hust.edu.cn>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rafi Rubin <rafi@seas.upenn.edu>
Cc:     Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-ntrig: fix the error handling code in ntrig_probe
Date:   Sun, 13 Mar 2022 23:02:37 +0800
Message-Id: <20220313150237.1214062-1-mx_xiang@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: mx_xiang@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sysfs_create_group in ntrig_probe fails, sysfs_remove_group in
ntrig_remove would hit WARN().

Fix this by returning err in ntrig_probe rather than ignoring the
failure of sysfs_create_group.

CC: Dongliang Mu <dzm91@hust.edu.cn>
Fixes: eab32f5f6557 ("HID: ntrig: add sysfs access to filter parameters")
Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
---
 drivers/hid/hid-ntrig.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index b5d26f03fe6b..f49427815d98 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -951,10 +951,14 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
-	if (ret)
+	if (ret) {
 		hid_err(hdev, "cannot create sysfs group\n");
+		goto err_sysfs_create;
+	}
 
 	return 0;
+err_sysfs_create:
+	hid_hw_stop(hdev);
 err_free:
 	kfree(nd);
 	return ret;
-- 
2.25.1

