Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C664FA7A0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiDIMYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiDIMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:24:09 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7CE3298F;
        Sat,  9 Apr 2022 05:21:59 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:51628.1449227777
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 53ECD28009D;
        Sat,  9 Apr 2022 20:21:50 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 6826f5d46ed048fcae8a3b2942c236e4 for rafael@kernel.org;
        Sat, 09 Apr 2022 20:21:58 CST
X-Transaction-ID: 6826f5d46ed048fcae8a3b2942c236e4
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     rafael@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, robert.moore@intel.com, tony.luck@intel.com,
        lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, ying.huang@intel.com,
        gong.chen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v5] ACPI: APEI: fix missing erst record id
Date:   Sat,  9 Apr 2022 20:21:31 +0800
Message-Id: <1649506891-27622-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read a record is cleared by others, but the deleted record cache entry is
still created by erst_get_record_id_next. When next enumerate the records,
get the cached deleted record, then erst_read return -ENOENT and try to
get next record, loop back to first ID will return 0 in function
__erst_record_id_cache_add_one and then set record_id as
APEI_ERST_INVALID_RECORD_ID, finished this time read operation.
It will result in read the records just in the cache hereafter.

This patch cleared the deleted record cache, fix the issue that
"./erst-inject -p" shows record counts not equal to "./erst-inject -n".

A reproducer of the problem(retry many times):

[root@localhost erst-inject]# ./erst-inject -c 0xaaaaa00011
[root@localhost erst-inject]# ./erst-inject -p
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00012
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00013
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00014
[root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000006
[root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000007
[root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000008
[root@localhost erst-inject]# ./erst-inject -p
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00012
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00013
rc: 273
rcd sig: CPER
rcd id: 0xaaaaa00014
[root@localhost erst-inject]# ./erst-inject -n
total error record count: 6

Changelog:
v1->v2  fix style problems
v2->v3  fix apei_read_mce called erst_get_record_id_next and modify
the commit message.
v3->v4  add erst_clear_cache in another retry.
v4->v5  implement a new function for looking for a specific record
 type, suggested by Luck Tony

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 arch/x86/kernel/cpu/mce/apei.c |  8 ++---
 drivers/acpi/apei/erst-dbg.c   |  3 +-
 drivers/acpi/apei/erst.c       | 62 ++++++++++++++++++++++++++++++++--
 include/acpi/apei.h            |  2 ++
 4 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0e3ae64d3b76..717192915f28 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -177,16 +177,14 @@ ssize_t apei_read_mce(struct mce *m, u64 *record_id)
 	/* no more record */
 	if (*record_id == APEI_ERST_INVALID_RECORD_ID)
 		goto out;
-	rc = erst_read(*record_id, &rcd.hdr, sizeof(rcd));
+	rc = erst_read_record(*record_id, &rcd.hdr, sizeof(rcd), sizeof(rcd),
+			&CPER_CREATOR_MCE);
 	/* someone else has cleared the record, try next one */
 	if (rc == -ENOENT)
 		goto retry;
 	else if (rc < 0)
 		goto out;
-	/* try to skip other type records in storage */
-	else if (rc != sizeof(rcd) ||
-		 !guid_equal(&rcd.hdr.creator_id, &CPER_CREATOR_MCE))
-		goto retry;
+
 	memcpy(m, &rcd.mce, sizeof(*m));
 	rc = sizeof(*m);
 out:
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index c740f0faad39..8bc71cdc2270 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -111,7 +111,8 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 		goto out;
 	}
 retry:
-	rc = len = erst_read(id, erst_dbg_buf, erst_dbg_buf_len);
+	rc = len = erst_read_record(id, erst_dbg_buf, erst_dbg_buf_len,
+			erst_dbg_buf_len, NULL);
 	/* The record may be cleared by others, try read next record */
 	if (rc == -ENOENT)
 		goto retry_next;
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 698d67cee052..1dc238783f63 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -856,6 +856,63 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 }
 EXPORT_SYMBOL_GPL(erst_read);
 
+static int erst_clear_cache(u64 record_id)
+{
+	int rc, i;
+	u64 *entries;
+
+	if (erst_disable)
+		return -ENODEV;
+
+	rc = mutex_lock_interruptible(&erst_record_id_cache.lock);
+	if (rc)
+		return rc;
+
+	entries = erst_record_id_cache.entries;
+	for (i = 0; i < erst_record_id_cache.len; i++) {
+		if (entries[i] == record_id)
+			entries[i] = APEI_ERST_INVALID_RECORD_ID;
+	}
+	__erst_record_id_cache_compact();
+
+	mutex_unlock(&erst_record_id_cache.lock);
+
+	return rc;
+}
+
+ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
+		size_t buflen, size_t recordlen, const guid_t *creatorid)
+{
+	ssize_t len;
+
+	/*
+	 * if creatorid is NULL, read any record for erst-dbg module
+	 */
+	if (creatorid == NULL) {
+		len = erst_read(record_id, record, buflen);
+		if (len == -ENOENT)
+			erst_clear_cache(record_id);
+
+		return len;
+	}
+
+	len = erst_read(record_id, record, buflen);
+	/*
+	 * if erst_read return value is -ENOENT or not equal to record length,
+	 * or not wanted creatorid, consider them as not found,
+	 * and clear the record_id cache.
+	 */
+	if (len == -ENOENT || len != recordlen ||
+			!guid_equal(&record->creator_id, creatorid)) {
+		len = -ENOENT;
+		erst_clear_cache(record_id);
+	}
+
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(erst_read_record);
+
 int erst_clear(u64 record_id)
 {
 	int rc, i;
@@ -996,7 +1053,8 @@ static ssize_t erst_reader(struct pstore_record *record)
 		goto out;
 	}
 
-	len = erst_read(record_id, &rcd->hdr, rcd_len);
+	len = erst_read_record(record_id, &rcd->hdr, rcd_len, rcd_len,
+			&CPER_CREATOR_PSTORE);
 	/* The record may be cleared by others, try read next record */
 	if (len == -ENOENT)
 		goto skip;
@@ -1004,8 +1062,6 @@ static ssize_t erst_reader(struct pstore_record *record)
 		rc = -EIO;
 		goto out;
 	}
-	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
-		goto skip;
 
 	record->buf = kmalloc(len, GFP_KERNEL);
 	if (record->buf == NULL) {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index afaca3a075e8..dc60f7db5524 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -46,6 +46,8 @@ int erst_get_record_id_next(int *pos, u64 *record_id);
 void erst_get_record_id_end(void);
 ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 		  size_t buflen);
+ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
+		size_t buflen, size_t recordlen, const guid_t *creatorid);
 int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
-- 
2.23.0

