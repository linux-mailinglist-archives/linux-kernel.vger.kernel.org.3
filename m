Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36B484E75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiAEGnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:43:11 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:56306 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237734AbiAEGnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:43:06 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowABXXp7lPdVhJ0bQBQ--.60304S2;
        Wed, 05 Jan 2022 14:42:46 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] thunderbolt:  Check for null pointer after calling kmemdup
Date:   Wed,  5 Jan 2022 14:42:44 +0800
Message-Id: <20220105064244.2316847-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXXp7lPdVhJ0bQBQ--.60304S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18Cw47CF1DXw18tw1kXwb_yoW5JFWrpF
        WUJFyYy3Z5KFyUW3Z2krykAFyYv3s7Ka4jkrW7K39Y93ZIkr4rGFy5Aa4Yvr15GryxtFs3
        Aan2yFWfWFyqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUndb1UUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the allocation, kmemdup() may return NULL
pointer.
Like alloc_switch(), it might be better to check it.
Therefore, icm_icl_set_uuid() and icm_handle_event() should also check
the return value of kmemdup().
As for icm_icl_set_uuid(), which is assigned to icm->set_uuid, the
return value of icm->set_uuid needs to check.
And for icm_handle_event(), just free 'n' and directly return is enough,
same as the way to handle the failure of kmalloc().

Fixes: 3cdb9446a117 ("thunderbolt: Add support for Intel Ice Lake")
Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/thunderbolt/icm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 2f30b816705a..09ab31ea9128 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -109,7 +109,7 @@ struct icm {
 	int (*driver_ready)(struct tb *tb,
 			    enum tb_security_level *security_level,
 			    u8 *proto_version, size_t *nboot_acl, bool *rpm);
-	void (*set_uuid)(struct tb *tb);
+	int (*set_uuid)(struct tb *tb);
 	void (*device_connected)(struct tb *tb,
 				 const struct icm_pkg_header *hdr);
 	void (*device_disconnected)(struct tb *tb,
@@ -1643,7 +1643,7 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 	return 0;
 }
 
-static void icm_icl_set_uuid(struct tb *tb)
+static int icm_icl_set_uuid(struct tb *tb)
 {
 	struct tb_nhi *nhi = tb->nhi;
 	u32 uuid[4];
@@ -1654,6 +1654,10 @@ static void icm_icl_set_uuid(struct tb *tb)
 	uuid[3] = 0xffffffff;
 
 	tb->root_switch->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
+	if (!tb->root_switch->uuid)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static void
@@ -1739,6 +1743,11 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 
 	INIT_WORK(&n->work, icm_handle_notification);
 	n->pkg = kmemdup(buf, size, GFP_KERNEL);
+	if (!n->pkg) {
+		kfree(n);
+		return;
+	}
+
 	n->tb = tb;
 
 	queue_work(tb->wq, &n->work);
@@ -2152,8 +2161,11 @@ static int icm_start(struct tb *tb)
 	tb->root_switch->no_nvm_upgrade = !icm->can_upgrade_nvm;
 	tb->root_switch->rpm = icm->rpm;
 
-	if (icm->set_uuid)
-		icm->set_uuid(tb);
+	if (icm->set_uuid) {
+		ret = icm->set_uuid(tb);
+		if (ret)
+			return ret;
+	}
 
 	ret = tb_switch_add(tb->root_switch);
 	if (ret) {
-- 
2.25.1

