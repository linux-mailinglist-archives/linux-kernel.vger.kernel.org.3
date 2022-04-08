Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068084F90BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiDHI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiDHI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:29:47 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68F024F8B1;
        Fri,  8 Apr 2022 01:27:43 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:49474.967726217
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 9E0302800F9;
        Fri,  8 Apr 2022 16:27:21 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 7ad1d1860fd746e492a0b7b9acd2ba5b for rafael@kernel.org;
        Fri, 08 Apr 2022 16:27:42 CST
X-Transaction-ID: 7ad1d1860fd746e492a0b7b9acd2ba5b
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
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
Subject: [PATCH v4] ACPI: APEI: fix missing erst record id
Date:   Fri,  8 Apr 2022 16:27:07 +0800
Message-Id: <1649406427-9357-1-git-send-email-liuxp11@chinatelecom.cn>
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

v1->v2  fix style problems
v2->v3  fix apei_read_mce called erst_get_record_id_next and modify
the commit message.
v3->v4  add erst_clear_cache in another retry.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 arch/x86/kernel/cpu/mce/apei.c |  9 ++++++---
 drivers/acpi/apei/erst-dbg.c   |  4 +++-
 drivers/acpi/apei/erst.c       | 34 +++++++++++++++++++++++++++++++---
 include/acpi/apei.h            |  1 +
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0e3ae64d3b76..d77de72a91d2 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -179,14 +179,17 @@ ssize_t apei_read_mce(struct mce *m, u64 *record_id)
 		goto out;
 	rc = erst_read(*record_id, &rcd.hdr, sizeof(rcd));
 	/* someone else has cleared the record, try next one */
-	if (rc == -ENOENT)
+	if (rc == -ENOENT) {
+		erst_clear_cache(*record_id);
 		goto retry;
-	else if (rc < 0)
+	} else if (rc < 0)
 		goto out;
 	/* try to skip other type records in storage */
 	else if (rc != sizeof(rcd) ||
-		 !guid_equal(&rcd.hdr.creator_id, &CPER_CREATOR_MCE))
+		 !guid_equal(&rcd.hdr.creator_id, &CPER_CREATOR_MCE)) {
+		erst_clear_cache(*record_id);
 		goto retry;
+	}
 	memcpy(m, &rcd.mce, sizeof(*m));
 	rc = sizeof(*m);
 out:
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index c740f0faad39..5b8164280a17 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -113,8 +113,10 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 retry:
 	rc = len = erst_read(id, erst_dbg_buf, erst_dbg_buf_len);
 	/* The record may be cleared by others, try read next record */
-	if (rc == -ENOENT)
+	if (rc == -ENOENT) {
+		erst_clear_cache(id);
 		goto retry_next;
+	}
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 698d67cee052..07d69dc7fd62 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -856,6 +856,31 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 }
 EXPORT_SYMBOL_GPL(erst_read);
 
+int erst_clear_cache(u64 record_id)
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
+EXPORT_SYMBOL_GPL(erst_clear_cache);
+
 int erst_clear(u64 record_id)
 {
 	int rc, i;
@@ -998,14 +1023,17 @@ static ssize_t erst_reader(struct pstore_record *record)
 
 	len = erst_read(record_id, &rcd->hdr, rcd_len);
 	/* The record may be cleared by others, try read next record */
-	if (len == -ENOENT)
+	if (len == -ENOENT) {
+		erst_clear_cache(record_id);
 		goto skip;
-	else if (len < 0 || len < sizeof(*rcd)) {
+	} else if (len < 0 || len < sizeof(*rcd)) {
 		rc = -EIO;
 		goto out;
 	}
-	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
+	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE)) {
+		erst_clear_cache(record_id);
 		goto skip;
+	}
 
 	record->buf = kmalloc(len, GFP_KERNEL);
 	if (record->buf == NULL) {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index afaca3a075e8..f8c11ff4115a 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -47,6 +47,7 @@ void erst_get_record_id_end(void);
 ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 		  size_t buflen);
 int erst_clear(u64 record_id);
+int erst_clear_cache(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
-- 
2.23.0

