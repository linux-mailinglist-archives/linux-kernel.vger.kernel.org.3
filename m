Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB98527D40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiEPF5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiEPF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:57:09 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 May 2022 22:57:07 PDT
Received: from mail-m2839.qiye.163.com (mail-m2839.qiye.163.com [103.74.28.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110C9B86D;
        Sun, 15 May 2022 22:57:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [218.94.118.90])
        by mail-m2839.qiye.163.com (Hmail) with ESMTPA id 2F8F5C0463;
        Mon, 16 May 2022 13:47:22 +0800 (CST)
From:   mingzhe.zou@easystack.cn
To:     torvalds@linux-foundation.org, zgrieee@gmail.com,
        martin.petersen@oracle.com, michael.christie@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, dongsheng.yang@easystack.cn,
        zoumingzhe@qq.com
Subject: [PATCH v2] scsi: target: fixup incorrect use of 'cpumask_t'
Date:   Mon, 16 May 2022 13:47:21 +0800
Message-Id: <20220516054721.1548-1-mingzhe.zou@easystack.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWUNDGEtWS00YSUpPGkgdQ0
        4eVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6Vio4DzIjCgxWUSIZSDAP
        Og0aCTFVSlVKTU5JTUNLS09JQ09IVTMWGhIXVRYSFRwBEx5VARQOOx4aCAIIDxoYEFUYFUVZV1kS
        C1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTktOTjcG
X-HM-Tid: 0a80cb6828168421kuqw2f8f5c0463
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mingzhe <mingzhe.zou@easystack.cn>

In commit d72d827f2f26, I used 'cpumask_t' incorrectly.
```
void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
{
        int ord, cpu;
        cpumask_t conn_allowed_cpumask;
        ......
}

static ssize_t lio_target_wwn_cpus_allowed_list_store(
               struct config_item *item, const char *page, size_t count)
{
        int ret;
        char *orig;
        cpumask_t new_allowed_cpumask;
        ......
}
```

So, that the correct pattern should be as follows:
```
cpumask_var_t mask;

if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
        return -ENOMEM;
... use 'mask' here as a  ...
free_cpumask_var(mask);
```

Fixes: d72d827f2f26 ("scsi: target: Add iscsi/cpus_allowed_list in configfs")
Reported-by: Test Bot <zgrieee@gmail.com>
Signed-off-by: mingzhe <mingzhe.zou@easystack.cn>
---
 drivers/target/iscsi/iscsi_target.c          | 32 ++++++++++++++------
 drivers/target/iscsi/iscsi_target_configfs.c | 24 +++++++++------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 6fe6a6bab3f4..ddf6c2a7212b 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -3596,10 +3596,7 @@ static int iscsit_send_reject(
 void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 {
 	int ord, cpu;
-	cpumask_t conn_allowed_cpumask;
-
-	cpumask_and(&conn_allowed_cpumask, iscsit_global->allowed_cpumask,
-		    cpu_online_mask);
+	cpumask_var_t conn_allowed_cpumask;
 
 	/*
 	 * bitmap_id is assigned from iscsit_global->ts_bitmap from
@@ -3609,13 +3606,28 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 	 * iSCSI connection's RX/TX threads will be scheduled to
 	 * execute upon.
 	 */
-	cpumask_clear(conn->conn_cpumask);
-	ord = conn->bitmap_id % cpumask_weight(&conn_allowed_cpumask);
-	for_each_cpu(cpu, &conn_allowed_cpumask) {
-		if (ord-- == 0) {
-			cpumask_set_cpu(cpu, conn->conn_cpumask);
-			return;
+	if (!zalloc_cpumask_var(&conn_allowed_cpumask, GFP_KERNEL)) {
+		ord = conn->bitmap_id % cpumask_weight(cpu_online_mask);
+		for_each_online_cpu(cpu) {
+			if (ord-- == 0) {
+				cpumask_set_cpu(cpu, conn->conn_cpumask);
+				return;
+			}
+		}
+	} else {
+		cpumask_and(conn_allowed_cpumask, iscsit_global->allowed_cpumask,
+			cpu_online_mask);
+
+		cpumask_clear(conn->conn_cpumask);
+		ord = conn->bitmap_id % cpumask_weight(conn_allowed_cpumask);
+		for_each_cpu(cpu, conn_allowed_cpumask) {
+			if (ord-- == 0) {
+				cpumask_set_cpu(cpu, conn->conn_cpumask);
+				free_cpumask_var(conn_allowed_cpumask);
+				return;
+			}
 		}
+		free_cpumask_var(conn_allowed_cpumask);
 	}
 	/*
 	 * This should never be reached..
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 0cedcfe207b5..57b4fd56d92a 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1137,23 +1137,27 @@ static ssize_t lio_target_wwn_cpus_allowed_list_show(
 static ssize_t lio_target_wwn_cpus_allowed_list_store(
 		struct config_item *item, const char *page, size_t count)
 {
-	int ret;
+	int ret = -ENOMEM;
 	char *orig;
-	cpumask_t new_allowed_cpumask;
+	cpumask_var_t new_allowed_cpumask;
+
+	if (!zalloc_cpumask_var(&new_allowed_cpumask, GFP_KERNEL))
+		goto out;
 
 	orig = kstrdup(page, GFP_KERNEL);
 	if (!orig)
-		return -ENOMEM;
+		goto out_free_cpumask;
 
-	cpumask_clear(&new_allowed_cpumask);
-	ret = cpulist_parse(orig, &new_allowed_cpumask);
+	ret = cpulist_parse(orig, new_allowed_cpumask);
+	if (!ret)
+		cpumask_copy(iscsit_global->allowed_cpumask,
+			     new_allowed_cpumask);
 
 	kfree(orig);
-	if (ret != 0)
-		return ret;
-
-	cpumask_copy(iscsit_global->allowed_cpumask, &new_allowed_cpumask);
-	return count;
+out_free_cpumask:
+	free_cpumask_var(new_allowed_cpumask);
+out:
+	return ret ? ret : count;
 }
 
 CONFIGFS_ATTR(lio_target_wwn_, cpus_allowed_list);
-- 
2.17.1

