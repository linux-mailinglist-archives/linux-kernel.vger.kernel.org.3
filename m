Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA04FC3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbiDKSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345108AbiDKSC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:02:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9AC34655
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:00:41 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u32-20020a634560000000b0039940fd2020so9238798pgk.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DJ4Nu7yeQzPIBeWZ/OUHX9Ih+tVIkR2u7MIpes1TbYg=;
        b=U1HrGRdF/DcfNx25R540JqgwiF6jiJIFY0lo51vYR5zRmd7Ee6GvZQx+BsvxCXZdCD
         Ibts10zHeKtsdrQm1l0s10GjAeTxXDjxTdNoOPP9LfxW+Zenmsx/2sXPy1X94RPpHgjG
         cnE03GOJWM+z4/tV90uhWtTXOiUzqZRRZ4kuEZTMFc1fTGpsyq8+vtlUQgDOMWEg4t+a
         Ha6g5sNa3OqtqcN+qg/vxr3C2eJW9Oj1Djs9BO9Si2/WCU4FOhqEccUXIjuKOSNGPopK
         Ggv0Zw/oUMxi8yk0klZqcom/GO1WabQAUhz+6wOCqxH4Ut+p/bhH6Y9/dm9HoY5OIotH
         ZLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DJ4Nu7yeQzPIBeWZ/OUHX9Ih+tVIkR2u7MIpes1TbYg=;
        b=KPVdRTXBPf8x1aqm2uqshPIe9KuZMPQ4tkf/v637jYLX6lasHzkENKHoM7oa0/usbw
         w3+ChAqClF3TWznwQwrFGZMm1fxPO0r4vse4bzsKvBKT4FJy2+ZW3zM0XfWnkqwI14H5
         nbO6xtLfYf5Wg/TNgV52byWT1BDJvltPdyfRhBsRxf0N2mXza2aUzEDmbvyu88qrQbk8
         5A4bmk4Gdh9naKB+KL5pev7QBgPaaPa6ZbmVbTuh8xcTvJ6NwDA5VKZKGKyL7jO/oqhA
         P6W+YgTzc9b1kHC/Ygs1am32ROZtnlM7TQezG+0OI0H6sMpNJAm0OEWyOaxHsAi0lEJV
         76yA==
X-Gm-Message-State: AOAM530A2Zey7Ih9pZnbTJkxMUkR6s3A2D5Qj3TBsOVrJXqGs7PeSmXS
        zdP3Hq6/m4pEtRM/+0f6u4Nr6dHmXKU=
X-Google-Smtp-Source: ABdhPJyBkI1R7smhNlPUQCI6QekCggtL//GX9vN4f51Y9CkbxIX5Kp68NuT5D+AdEna3Gzr6K/huqYOC0eP1
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a65:654f:0:b0:378:b8f6:ebe4 with SMTP id
 a15-20020a65654f000000b00378b8f6ebe4mr27192887pgw.399.1649700040430; Mon, 11
 Apr 2022 11:00:40 -0700 (PDT)
Date:   Mon, 11 Apr 2022 18:00:06 +0000
Message-Id: <20220411180006.4187548-1-jackyli@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] crypto: ccp - Fix the INIT_EX data file open failure
From:   Jacky Li <jackyli@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 common cases when INIT_EX data file might not be
opened successfully and fail the sev initialization:

1. In user namespaces, normal user tasks (e.g. VMM) can change their
   current->fs->root to point to arbitrary directories. While
   init_ex_path is provided as a module param related to root file
   system. Solution: use the root directory of init_task to avoid
   accessing the wrong file.

2. Normal user tasks (e.g. VMM) don't have the privilege to access
   the INIT_EX data file. Solution: open the file as root and
   restore permissions immediately.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6ab93dfd478a..3aefb177715e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -23,6 +23,7 @@
 #include <linux/gfp.h>
 #include <linux/cpufeature.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 
 #include <asm/smp.h>
 
@@ -170,6 +171,31 @@ static void *sev_fw_alloc(unsigned long len)
 	return page_address(page);
 }
 
+static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
+{
+	struct file *fp;
+	struct path root;
+	struct cred *cred;
+	const struct cred *old_cred;
+
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	cred = prepare_creds();
+	if (!cred)
+		return ERR_PTR(-ENOMEM);
+	cred->fsuid = GLOBAL_ROOT_UID;
+	old_cred = override_creds(cred);
+
+	fp = file_open_root(&root, filename, flags, mode);
+	path_put(&root);
+
+	revert_creds(old_cred);
+
+	return fp;
+}
+
 static int sev_read_init_ex_file(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -181,7 +207,7 @@ static int sev_read_init_ex_file(void)
 	if (!sev_init_ex_buffer)
 		return -EOPNOTSUPP;
 
-	fp = filp_open(init_ex_path, O_RDONLY, 0);
+	fp = open_file_as_root(init_ex_path, O_RDONLY, 0);
 	if (IS_ERR(fp)) {
 		int ret = PTR_ERR(fp);
 
@@ -217,7 +243,7 @@ static void sev_write_init_ex_file(void)
 	if (!sev_init_ex_buffer)
 		return;
 
-	fp = filp_open(init_ex_path, O_CREAT | O_WRONLY, 0600);
+	fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
 	if (IS_ERR(fp)) {
 		dev_err(sev->dev,
 			"SEV: could not open file for write, error %ld\n",
-- 
2.35.1.1178.g4f1659d476-goog

