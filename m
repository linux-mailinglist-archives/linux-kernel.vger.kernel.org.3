Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778C34E881A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiC0Oey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiC0Oew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 10:34:52 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EA515A08
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OXkPs
        gGRUiHfR5qMvtpHCiBc2AmSTlfB4eNsd78fwGc=; b=dZjG+DwhhcvQJhSBwE3oA
        hAnJhExzjbP61U1c/eJ2xIExCCoe3DUV9z1x8s/N/JpyJbkvPeSSJuEnwRcIkMob
        kBKfZa+9vkteRYyiFrzEJWC8J9Rw9DrtG4abLYm19DaYZpsf9yJPZ4A0EvYuu1n+
        fyLIAvUIrEfO5qeWvBOUck=
Received: from localhost (unknown [223.74.106.110])
        by smtp10 (Coremail) with SMTP id DsCowAAXX4KddUBihmtuCw--.1830S2;
        Sun, 27 Mar 2022 22:33:03 +0800 (CST)
From:   wujunwen <wudaemon@163.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, wujunwen <wudaemon@163.com>
Subject: [PATCH v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro to simplify misc proc_fops
Date:   Sun, 27 Mar 2022 14:32:54 +0000
Message-Id: <20220327143254.226844-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAXX4KddUBihmtuCw--.1830S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF18Gw48Jr1UCF15JF48tFb_yoW5XFyfpF
        4fZry7JF4UJF4xWrW3ta1DuF9IqFnaqa4q9rnrG3ySvF1DZr12gFnrAa4xZFy5G3ykWrnx
        XFs0kry5Cw1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEEfYNUUUUU=
X-Originating-IP: [223.74.106.110]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbiLR-QbVSIoaYxTwAAsq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_PROC_SHOW_ATTRIBUTE is used to simply seq_file flow ,so
we can use it to simplify misc proc_fops.

Signed-off-by: wujunwen <wudaemon@163.com>
---
 drivers/char/misc.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ca5141ed5ef3..076b7f08aa7a 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -64,40 +64,23 @@ static DEFINE_MUTEX(misc_mtx);
 static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
 
 #ifdef CONFIG_PROC_FS
-static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	mutex_lock(&misc_mtx);
-	return seq_list_start(&misc_list, *pos);
-}
 
-static void *misc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+static int misc_show(struct seq_file *seq, void *v)
 {
-	return seq_list_next(v, &misc_list, pos);
-}
+	const struct miscdevice *p;
 
-static void misc_seq_stop(struct seq_file *seq, void *v)
-{
+	mutex_lock(&misc_mtx);
+	list_for_each_entry(p, &misc_list, list) {
+		seq_printf(seq, "%3i %s\n", p->minor, p->name ? p->name : "");
+	}
 	mutex_unlock(&misc_mtx);
-}
-
-static int misc_seq_show(struct seq_file *seq, void *v)
-{
-	const struct miscdevice *p = list_entry(v, struct miscdevice, list);
-
-	seq_printf(seq, "%3i %s\n", p->minor, p->name ? p->name : "");
 	return 0;
 }
 
-
-static const struct seq_operations misc_seq_ops = {
-	.start = misc_seq_start,
-	.next  = misc_seq_next,
-	.stop  = misc_seq_stop,
-	.show  = misc_seq_show,
-};
+DEFINE_PROC_SHOW_ATTRIBUTE(misc);
 #endif
 
-static int misc_open(struct inode *inode, struct file *file)
+static int misc_fops_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(inode);
 	struct miscdevice *c;
@@ -148,7 +131,7 @@ static struct class *misc_class;
 
 static const struct file_operations misc_fops = {
 	.owner		= THIS_MODULE,
-	.open		= misc_open,
+	.open		= misc_fops_open,
 	.llseek		= noop_llseek,
 };
 
@@ -266,9 +249,11 @@ static char *misc_devnode(struct device *dev, umode_t *mode)
 static int __init misc_init(void)
 {
 	int err;
+#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *ret;
 
-	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
+	ret = proc_create("misc", 0, NULL, &misc_proc_ops);
+#endif
 	misc_class = class_create(THIS_MODULE, "misc");
 	err = PTR_ERR(misc_class);
 	if (IS_ERR(misc_class))
@@ -284,8 +269,10 @@ static int __init misc_init(void)
 	pr_err("unable to get major %d for misc devices\n", MISC_MAJOR);
 	class_destroy(misc_class);
 fail_remove:
+#ifdef CONFIG_PROC_FS
 	if (ret)
 		remove_proc_entry("misc", NULL);
+#endif
 	return err;
 }
 subsys_initcall(misc_init);
-- 
2.25.1

