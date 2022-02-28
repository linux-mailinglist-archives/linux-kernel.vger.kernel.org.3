Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5574C6248
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiB1FBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiB1FBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:01:05 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3C466FAF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:00:26 -0800 (PST)
X-QQ-mid: bizesmtp65t1646024415tgb8fz03
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 28 Feb 2022 13:00:13 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: F3yR32iATbiob0GwumxSEecyqtbY2ZSDQEfiAHX9Jy4WUUwlk/vzNs9XabPiU
        3sU/gC1KLfAtN0c0h6J/3ARq4Dn6YVqOqRl+78uSQq9JkA0KZIav/4yv62k6ERNm6FbOxLZ
        1rfoiLiWAJi0FsF4DQRCK0Z0PalGZUkIFFX4TuMqTa16RvtGEkhxr05v2QPNQ17TapcAH3P
        ozeKVgqzGszy2SXixvrznqbM6R3hyb5urNIag/uI5RIXrXa1HmbvmhtIbYiIglVW3hhVYjA
        3ozIqcMuTXLEfAeitWHjkbhoYJ2orxNvZn+i8Id3iLEZTNoRMXX8Q79CYGlsbN5QuUSMzx0
        ZqjXd6XMM3+gmCzjnqiqHJKAbhnNyj/f3rRDndlyq2/LoWKCkg=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>,
        JOE Perches <joe@perches.com>
Subject: [PATCH v3 2/2] ALSA: core: Remove redundant variable and return the last statement
Date:   Mon, 28 Feb 2022 13:00:03 +0800
Message-Id: <20220228050003.32509-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220228050003.32509-1-tangmeng@uniontech.com>
References: <20220228050003.32509-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the result from file->f_op->open() directly instead of
taking this in another redundant variable. Make the typical
return the last statement, return early and reduce the indentation
too.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
Signed-off-by: JOE Perches <joe@perches.com>
---
 sound/sound_core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index aa4a57e488e5..3332fe321737 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -577,20 +577,20 @@ static int soundcore_open(struct inode *inode, struct file *file)
 			new_fops = fops_get(s->unit_fops);
 	}
 	spin_unlock(&sound_loader_lock);
-	if (new_fops) {
-		/*
-		 * We rely upon the fact that we can't be unloaded while the
-		 * subdriver is there.
-		 */
-		int err = 0;
-		replace_fops(file, new_fops);
 
-		if (file->f_op->open)
-			err = file->f_op->open(inode,file);
+	if (!new_fops)
+		return -ENODEV;
 
-		return err;
-	}
-	return -ENODEV;
+	/*
+	 * We rely upon the fact that we can't be unloaded while the
+	 * subdriver is there.
+	 */
+	replace_fops(file, new_fops);
+
+	if (!file->f_op->open)
+		return -ENODEV;
+
+	return file->f_op->open(inode, file);
 }
 
 MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
-- 
2.20.1



