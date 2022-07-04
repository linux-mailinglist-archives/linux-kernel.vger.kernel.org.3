Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA6564DDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGDGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGDGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:44:18 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681F3899
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:44:16 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2646i7Ao029402;
        Mon, 4 Jul 2022 15:44:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 04 Jul 2022 15:44:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2646i7QA029398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jul 2022 15:44:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
Date:   Mon, 4 Jul 2022 15:44:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <000000000000d9ff3a05bb37069e@google.com>
Cc:     linux-kernel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d9ff3a05bb37069e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
misc_open() might sleep for long with misc_mtx held whereas userspace can
flood with concurrent misc_open() requests. Mitigate this problem by making
misc_open() and misc_register() killable.

Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/char/misc.c | 57 +++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cba19bfdc44d..b9a494bc4228 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -100,49 +100,39 @@ static const struct seq_operations misc_seq_ops = {
 static int misc_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(inode);
-	struct miscdevice *c = NULL, *iter;
+	struct miscdevice *iter;
 	int err = -ENODEV;
 	const struct file_operations *new_fops = NULL;
+	bool retried = false;
 
-	mutex_lock(&misc_mtx);
-
+ retry:
+	if (mutex_lock_killable(&misc_mtx))
+		return -EINTR;
 	list_for_each_entry(iter, &misc_list, list) {
 		if (iter->minor != minor)
 			continue;
-		c = iter;
 		new_fops = fops_get(iter->fops);
+		if (!new_fops)
+			break;
+		/*
+		 * Place the miscdevice in the file's
+		 * private_data so it can be used by the
+		 * file operations, including f_op->open below
+		 */
+		file->private_data = iter;
+
+		err = 0;
+		replace_fops(file, new_fops);
+		if (file->f_op->open)
+			err = file->f_op->open(inode, file);
 		break;
 	}
-
-	if (!new_fops) {
-		mutex_unlock(&misc_mtx);
+	mutex_unlock(&misc_mtx);
+	if (!new_fops && !retried) {
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
-		mutex_lock(&misc_mtx);
-
-		list_for_each_entry(iter, &misc_list, list) {
-			if (iter->minor != minor)
-				continue;
-			c = iter;
-			new_fops = fops_get(iter->fops);
-			break;
-		}
-		if (!new_fops)
-			goto fail;
+		retried = true;
+		goto retry;
 	}
-
-	/*
-	 * Place the miscdevice in the file's
-	 * private_data so it can be used by the
-	 * file operations, including f_op->open below
-	 */
-	file->private_data = c;
-
-	err = 0;
-	replace_fops(file, new_fops);
-	if (file->f_op->open)
-		err = file->f_op->open(inode, file);
-fail:
-	mutex_unlock(&misc_mtx);
 	return err;
 }
 
@@ -180,7 +170,8 @@ int misc_register(struct miscdevice *misc)
 
 	INIT_LIST_HEAD(&misc->list);
 
-	mutex_lock(&misc_mtx);
+	if (mutex_lock_killable(&misc_mtx))
+		return -EINTR;
 
 	if (is_dynamic) {
 		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
-- 
2.18.4


