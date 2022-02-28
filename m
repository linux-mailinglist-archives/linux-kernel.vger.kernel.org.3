Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8F4C6253
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiB1FEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiB1FD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:03:57 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F3DFDD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:03:18 -0800 (PST)
X-QQ-mid: bizesmtp89t1646024586thfoje1b
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 28 Feb 2022 13:03:03 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: F3yR32iATbg9d5KYQoSp6pbqoXLzpCAtG22FQb/l2d/WkjkQ8W2X83f0xqELi
        ioPVP2wdmyr+G9ms9m4klr5ImSsOwKlK9kljCNPU+W8BsEomi5gA7urgpjE8PxUUSi/7ZGx
        kFMIpTZ/0Hb6SoMWZVRuMhcbMjbCKISv+EFwLq1RO8bZEsedwO96RUfe4Z0uVr8RA4fb3J8
        jNyGaUjArZjHt808yF8FhsqAQU1JW3jNqqJEp4tF670bUJANIY29fNeMhL/AbPPsu365Nwb
        tIcvfX54Ah8Lc+vofq9eBCsdNTPFrkiH7u67Q/VKQwo80BetBDI47mo1aHj73Ayas0tlp01
        X6OIN1ITReTYFjWmbHIV8h+vCC7gI1OEfRmjTUBE/cxJRyvAL8=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v4 2/2] ALSA: core: Remove redundant variable and return the last statement
Date:   Mon, 28 Feb 2022 13:02:53 +0800
Message-Id: <20220228050253.1649-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220228050253.1649-1-tangmeng@uniontech.com>
References: <20220228050253.1649-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
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
Signed-off-by: Joe Perches <joe@perches.com>
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



