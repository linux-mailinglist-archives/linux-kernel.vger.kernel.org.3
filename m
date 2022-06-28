Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6B55D4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbiF1HZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiF1HY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:24:58 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1617D2CCB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:24:57 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-48-211-nat.elisa-mobile.fi [85.76.48.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id DF5E820093;
        Tue, 28 Jun 2022 10:24:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1656401093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=iFaQS2VyLMAPPXHYcemADy1NqRMYS42uiQUFNL56HE4=;
        b=KZ0UG/YHoWR2MASiBWgxT37sa6tK7qX3Vfrf9Hxi3k6Umd0Wnm3nZLvBZiRpxOvO6Dtq3n
        +7TEK3kKDS/iUyx1YSjGyp4PoLy/uKQAeRdX1k5Zz5Feo85mjLs2AERdks9jmNvlIV6WBA
        9MnTgOFPGNt5tKYNa3vGKi3ordBDr9M=
Date:   Tue, 28 Jun 2022 10:24:51 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] pstore: ramoops: allow to have multiple user space
 message logs
Message-ID: <20220628072451.GC3601@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1656401093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=iFaQS2VyLMAPPXHYcemADy1NqRMYS42uiQUFNL56HE4=;
        b=U+T3HdMYRclo1rBK1xB1GqKR1ixUoglOLLMDFsRF1i0QEfm+LES2kulZpJhZCRhC4mfI7y
        VxaZLvk0b2pRqQ5/CGD1f3xz10yWZar/anCeqqvpSnenLjQXGqrwGX73aqecJG/LpEDmb+
        3vfSWy3loHVIu1dapGwuEm6Y/c/P/UU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1656401093; a=rsa-sha256; cv=none;
        b=LKWxMQWli2MIRfZG+e6cNhAKOxbCA4P6MeKqDCQ3pVtD804+mF+5dBHR1SGxMi/ioWesNK
        6BhK0J1uXXuSxRSdkoGtlnab0mBKEfdVwx7EKe4WxSi5IfTOaXDXtIAbGfoupktxxB6VkJ
        jobD00ynqQInRLdIwzRE8PnP4/eh8RM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Allow to have multiple user space message logs by dividing the pmsg buffer
into multiple areas. This is useful when there are e.g. two loggers and
interleaved logs are not desired.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../bindings/reserved-memory/ramoops.yaml     |  5 ++
 fs/pstore/internal.h                          |  4 +-
 fs/pstore/platform.c                          |  2 +-
 fs/pstore/pmsg.c                              | 17 ++++---
 fs/pstore/ram.c                               | 48 ++++++++++++++-----
 include/linux/pstore.h                        |  3 ++
 include/linux/pstore_ram.h                    |  1 +
 7 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index 0391871cf44d..42ddb0a37120 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -61,6 +61,11 @@ properties:
     description: size in bytes of log buffer reserved for userspace messages
     default: 0
 
+  pmsg-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: divide the userspace log buffer into this many areas
+    default: 1
+
   mem-type:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: if present, sets the type of mapping is to be used to map the reserved region.
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 801d6c0b170c..8acdd6344f47 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -26,10 +26,10 @@ pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
 #endif
 
 #ifdef CONFIG_PSTORE_PMSG
-extern void pstore_register_pmsg(void);
+extern void pstore_register_pmsg(int max_id);
 extern void pstore_unregister_pmsg(void);
 #else
-static inline void pstore_register_pmsg(void) {}
+static inline void pstore_register_pmsg(int max_id) {}
 static inline void pstore_unregister_pmsg(void) {}
 #endif
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index e26162f102ff..ce3a063db551 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -608,7 +608,7 @@ int pstore_register(struct pstore_info *psi)
 	if (psi->flags & PSTORE_FLAGS_FTRACE)
 		pstore_register_ftrace();
 	if (psi->flags & PSTORE_FLAGS_PMSG)
-		pstore_register_pmsg();
+		pstore_register_pmsg(psi->max_id);
 
 	/* Start watching for new records, if desired. */
 	pstore_timer_kick();
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index d8542ec2f38c..13c0f1714624 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -23,6 +23,7 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	pstore_record_init(&record, psinfo);
 	record.type = PSTORE_TYPE_PMSG;
 	record.size = count;
+	record.id   = iminor(file->f_inode);
 
 	/* check outside lock, page in any data. write_user also checks */
 	if (!access_ok(buf, count))
@@ -53,9 +54,10 @@ static char *pmsg_devnode(struct device *dev, umode_t *mode)
 	return NULL;
 }
 
-void pstore_register_pmsg(void)
+void pstore_register_pmsg(int max_id)
 {
 	struct device *pmsg_device;
+	int i;
 
 	pmsg_major = register_chrdev(0, PMSG_NAME, &pmsg_fops);
 	if (pmsg_major < 0) {
@@ -70,11 +72,14 @@ void pstore_register_pmsg(void)
 	}
 	pmsg_class->devnode = pmsg_devnode;
 
-	pmsg_device = device_create(pmsg_class, NULL, MKDEV(pmsg_major, 0),
-					NULL, "%s%d", PMSG_NAME, 0);
-	if (IS_ERR(pmsg_device)) {
-		pr_err("failed to create device\n");
-		goto err_device;
+	for (i = 0; i <= max_id; i++) {
+		pmsg_device = device_create(pmsg_class, NULL,
+					    MKDEV(pmsg_major, i), NULL, "%s%d",
+					    PMSG_NAME, i);
+		if (IS_ERR(pmsg_device)) {
+			pr_err("failed to create device\n");
+			goto err_device;
+		}
 	}
 	return;
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fefe3d391d3a..8ed2c90a26a6 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -41,7 +41,11 @@ MODULE_PARM_DESC(ftrace_size, "size of ftrace log");
 
 static ulong ramoops_pmsg_size = MIN_MEM_SIZE;
 module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
-MODULE_PARM_DESC(pmsg_size, "size of user space message log");
+MODULE_PARM_DESC(pmsg_size, "total size of user space message logs");
+
+static uint ramoops_pmsg_count = 1;
+module_param_named(pmsg_count, ramoops_pmsg_count, int, 0400);
+MODULE_PARM_DESC(pmsg_count, "number of user space message logs");
 
 static unsigned long long mem_address;
 module_param_hw(mem_address, ullong, other, 0400);
@@ -79,7 +83,7 @@ struct ramoops_context {
 	struct persistent_ram_zone **dprzs;	/* Oops dump zones */
 	struct persistent_ram_zone *cprz;	/* Console zone */
 	struct persistent_ram_zone **fprzs;	/* Ftrace zones */
-	struct persistent_ram_zone *mprz;	/* PMSG zone */
+	struct persistent_ram_zone **mprzs;	/* PMSG zones */
 	phys_addr_t phys_addr;
 	unsigned long size;
 	unsigned int memtype;
@@ -96,6 +100,7 @@ struct ramoops_context {
 	unsigned int console_read_cnt;
 	unsigned int max_ftrace_cnt;
 	unsigned int ftrace_read_cnt;
+	unsigned int max_pmsg_cnt;
 	unsigned int pmsg_read_cnt;
 	struct pstore_info pstore;
 };
@@ -210,8 +215,12 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	if (!prz_ok(prz) && !cxt->console_read_cnt++)
 		prz = ramoops_get_next_prz(&cxt->cprz, 0 /* single */, record);
 
-	if (!prz_ok(prz) && !cxt->pmsg_read_cnt++)
-		prz = ramoops_get_next_prz(&cxt->mprz, 0 /* single */, record);
+	while (cxt->pmsg_read_cnt < cxt->max_pmsg_cnt && !prz) {
+		prz = ramoops_get_next_prz(cxt->mprzs, cxt->pmsg_read_cnt++,
+					   record);
+		if (!prz_ok(prz))
+			continue;
+	}
 
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
@@ -395,9 +404,10 @@ static int notrace ramoops_pstore_write_user(struct pstore_record *record,
 	if (record->type == PSTORE_TYPE_PMSG) {
 		struct ramoops_context *cxt = record->psi->data;
 
-		if (!cxt->mprz)
+		if (record->id >= cxt->max_pmsg_cnt)
 			return -ENOMEM;
-		return persistent_ram_write_user(cxt->mprz, buf, record->size);
+		return persistent_ram_write_user(cxt->mprzs[record->id], buf,
+						 record->size);
 	}
 
 	return -EINVAL;
@@ -423,7 +433,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 		prz = cxt->fprzs[record->id];
 		break;
 	case PSTORE_TYPE_PMSG:
-		prz = cxt->mprz;
+		if (record->id >= cxt->max_pmsg_cnt)
+			return -EINVAL;
+		prz = cxt->mprzs[record->id];
 		break;
 	default:
 		return -EINVAL;
@@ -467,6 +479,14 @@ static void ramoops_free_przs(struct ramoops_context *cxt)
 		kfree(cxt->fprzs);
 		cxt->max_ftrace_cnt = 0;
 	}
+
+	/* Free pmsg PRZs */
+	if (cxt->mprzs) {
+		for (i = 0; i < cxt->max_pmsg_cnt; i++)
+			persistent_ram_free(cxt->mprzs[i]);
+		kfree(cxt->mprzs);
+		cxt->max_pmsg_cnt = 0;
+	}
 }
 
 static int ramoops_init_przs(const char *name,
@@ -675,6 +695,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parse_u32("console-size", pdata->console_size, 0);
 	parse_u32("ftrace-size", pdata->ftrace_size, 0);
 	parse_u32("pmsg-size", pdata->pmsg_size, 0);
+	parse_u32("pmsg-count", pdata->pmsg_count, 1);
 	parse_u32("ecc-size", pdata->ecc_info.ecc_size, 0);
 	parse_u32("flags", pdata->flags, 0);
 	parse_u32("max-reason", pdata->max_reason, pdata->max_reason);
@@ -790,10 +811,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init_fprz;
 
-	err = ramoops_init_prz("pmsg", dev, cxt, &cxt->mprz, &paddr,
-				cxt->pmsg_size, 0);
+	err = ramoops_init_przs("pmsg", dev, cxt, &cxt->mprzs, &paddr,
+				cxt->pmsg_size, -1, &pdata->pmsg_count, 0, 0);
 	if (err)
 		goto fail_init_mprz;
+	cxt->max_pmsg_cnt = pdata->pmsg_count;
 
 	cxt->pstore.data = cxt;
 	/*
@@ -811,8 +833,10 @@ static int ramoops_probe(struct platform_device *pdev)
 		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
 	if (cxt->max_ftrace_cnt)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
-	if (cxt->pmsg_size)
+	if (cxt->pmsg_size) {
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
+		cxt->pstore.max_id = cxt->max_pmsg_cnt - 1;
+	}
 
 	/*
 	 * Since bufsize is only used for dmesg crash dumps, it
@@ -845,6 +869,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_max_reason = pdata->max_reason;
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
+	ramoops_pmsg_count = pdata->pmsg_count;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
@@ -857,7 +882,6 @@ static int ramoops_probe(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 fail_clear:
 	cxt->pstore.bufsize = 0;
-	persistent_ram_free(cxt->mprz);
 fail_init_mprz:
 fail_init_fprz:
 	persistent_ram_free(cxt->cprz);
@@ -876,7 +900,6 @@ static int ramoops_remove(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 	cxt->pstore.bufsize = 0;
 
-	persistent_ram_free(cxt->mprz);
 	persistent_ram_free(cxt->cprz);
 	ramoops_free_przs(cxt);
 
@@ -925,6 +948,7 @@ static void __init ramoops_register_dummy(void)
 	pdata.console_size = ramoops_console_size;
 	pdata.ftrace_size = ramoops_ftrace_size;
 	pdata.pmsg_size = ramoops_pmsg_size;
+	pdata.pmsg_count = ramoops_pmsg_count;
 	/* If "max_reason" is set, its value has priority over "dump_oops". */
 	if (ramoops_max_reason >= 0)
 		pdata.max_reason = ramoops_max_reason;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index e97a8188f0fd..9713a055def9 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -102,6 +102,8 @@ struct pstore_record {
  *		printk.always_kmsg_dump boot param" (which is either
  *		KMSG_DUMP_OOPS when false, or KMSG_DUMP_MAX when
  *		true); see printk.always_kmsg_dump for more details.
+ * @max_id:	Used when PSTORE_FLAGS_PMSG is set. Contains the maximum
+ *		identifer of different pmsg buffers.
  * @data:	backend-private pointer passed back during callbacks
  *
  * Callbacks:
@@ -186,6 +188,7 @@ struct pstore_info {
 
 	int		flags;
 	int		max_reason;
+	unsigned int	max_id;
 	void		*data;
 
 	int		(*open)(struct pstore_info *psi);
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9f16afec7290..2fa403235bee 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -133,6 +133,7 @@ struct ramoops_platform_data {
 	unsigned long	console_size;
 	unsigned long	ftrace_size;
 	unsigned long	pmsg_size;
+	unsigned int	pmsg_count;
 	int		max_reason;
 	u32		flags;
 	struct persistent_ram_ecc_info ecc_info;
-- 
