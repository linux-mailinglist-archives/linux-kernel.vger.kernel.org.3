Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAE52FE81
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbiEURJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiEURJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:09:48 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E13C735;
        Sat, 21 May 2022 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1653152985;
        bh=BAIFQcwMJ7DLc/RBkD3ukGwji+i0gCtJ47XlQDyBims=;
        h=Message-ID:Subject:From:To:Date:From;
        b=nNA5z+uBm8wPHdlBOcNmUppbBb/EDwqrY9+nLlGntHt2mPxEoptBZMezbXrAO9NAd
         sqXGGGYmMVfihfpD1Vg8VTitTwt+XpW+ZCy8pWSY5UDlP58sKIwUD00BUuv/UZywtd
         V0bkGYKwHv36QIlMZeQL8wygvIDaPxnDXw17NcD4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5D8B5128077C;
        Sat, 21 May 2022 13:09:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aXXdTgZN1c3u; Sat, 21 May 2022 13:09:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1653152985;
        bh=BAIFQcwMJ7DLc/RBkD3ukGwji+i0gCtJ47XlQDyBims=;
        h=Message-ID:Subject:From:To:Date:From;
        b=nNA5z+uBm8wPHdlBOcNmUppbBb/EDwqrY9+nLlGntHt2mPxEoptBZMezbXrAO9NAd
         sqXGGGYmMVfihfpD1Vg8VTitTwt+XpW+ZCy8pWSY5UDlP58sKIwUD00BUuv/UZywtd
         V0bkGYKwHv36QIlMZeQL8wygvIDaPxnDXw17NcD4=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C917412803C0;
        Sat, 21 May 2022 13:09:44 -0400 (EDT)
Message-ID: <333254c5b864c9c8bf50b895d99309b27065a487.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.18-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 21 May 2022 13:09:43 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches both in drivers.  The iscsi one is fixing the cpumask issue
you commented on and the ufs one is a late arriving fix for conditions
that can occur in Host Performance Booster reads.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Daejun Park (1):
      scsi: ufs: core: Fix referencing invalid rsp field

Mingzhe Zou (1):
      scsi: target: Fix incorrect use of cpumask_t

And the diffstat:

 drivers/scsi/ufs/ufshpb.c                    | 19 ++++++-----------
 drivers/target/iscsi/iscsi_target.c          | 32 +++++++++++++++++++---------
 drivers/target/iscsi/iscsi_target_configfs.c | 24 ++++++++++++---------
 3 files changed, 43 insertions(+), 32 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 81099b68bbfb..588c0329b80c 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1254,6 +1254,13 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	struct utp_hpb_rsp *rsp_field = &lrbp->ucd_rsp_ptr->hr;
 	int data_seg_len;
 
+	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
+		& MASK_RSP_UPIU_DATA_SEG_LEN;
+
+	/* If data segment length is zero, rsp_field is not valid */
+	if (!data_seg_len)
+		return;
+
 	if (unlikely(lrbp->lun != rsp_field->lun)) {
 		struct scsi_device *sdev;
 		bool found = false;
@@ -1288,18 +1295,6 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		return;
 	}
 
-	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
-		& MASK_RSP_UPIU_DATA_SEG_LEN;
-
-	/* To flush remained rsp_list, we queue the map_work task */
-	if (!data_seg_len) {
-		if (!ufshpb_is_general_lun(hpb->lun))
-			return;
-
-		ufshpb_kick_map_work(hpb);
-		return;
-	}
-
 	BUILD_BUG_ON(sizeof(struct utp_hpb_rsp) != UTP_HPB_RSP_SIZE);
 
 	if (!ufshpb_is_hpb_rsp_valid(hba, lrbp, rsp_field))
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

