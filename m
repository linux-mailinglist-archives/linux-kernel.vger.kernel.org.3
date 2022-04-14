Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE82501931
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbiDNQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbiDNQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:54:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CEA13E432
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:23:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x10-20020a170902ec8a00b001585af19391so2951845plg.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lkcJCQOlm2DvsqWy2MKlxrSAJLim0ircZ4vwjXzXvbI=;
        b=hCNy1KMQ7JjgZ4WuXbtrx/T51qoLvLajJzC1K/yHLNkvWw+lwem1UlEPaV8SYkj2Wl
         ue/t0zAxe1uZM6XPv3QKIZkxQ0XeyRpHYHntGv2shl/x1ICJg1sBwkUjsVYriWi/LJId
         GRzCydsD7povLWp7OEltVgQlkd1Q5zerPmfNsrVXZPPIzBKp4bdrJveOHaiVy4li0UCn
         24OMzn3f8dIXFJ0v6SfCZTIBfjN2OxiC0vrue2s4FJDSisbZ5EjNSTgZVQPYuRK3FYoG
         7C6296YKureshdeoM02PEvVM/mABL8bjzFcY1LHQB87vRlVNfeVsliuE2PyvacRWO1QU
         +B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lkcJCQOlm2DvsqWy2MKlxrSAJLim0ircZ4vwjXzXvbI=;
        b=KuppDDGp7hTR416PgRcvW4tdvaO66brdPBj4kQcC9u9zrGJtgLpeYeOWHA7UXVjuPv
         YcMnvYQZeOnW8FDhDC7EXXNU3sOHiLjAr+wwgTDtgsXNEssUx+a8GzwaBuCXkTpS8Vr9
         Gx10LcZAXdY3GhSHaUpjkRioeb4NWB/i6YhOxjt1omWa7GJq0RYAjbFmMiUoa2TM2eyl
         WqQUnW4tVzj6rWtjviH312OzkjBOXHp8Efk7l5PIzpCAnxmTarzGkv5HFsq2LHDAaXLA
         q+WIqOa5L2wrGwq3HgHBik3Oqdwz7F3CaRU41W4ATLLHl7sUJFKB/Q3xp6iirRW0mXzn
         Omng==
X-Gm-Message-State: AOAM530TzmSRpzYzz746+s74yidqHYXCOWVeUtI/RxOs4vT+Jq4C/rJ/
        WEbL6fdpgdgu2QPKaiOyJbOFTJJ3R5U=
X-Google-Smtp-Source: ABdhPJx0wBN0movEBXl1rplnG+T/dJFn5xqS9a+dvsi2cDVnCxfhNdrOb/0tuqQOtQRGmEEN5zN+Psvj0/zO
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a17:90b:3613:b0:1cb:66f4:fcad with SMTP id
 ml19-20020a17090b361300b001cb66f4fcadmr5104050pjb.82.1649953420652; Thu, 14
 Apr 2022 09:23:40 -0700 (PDT)
Date:   Thu, 14 Apr 2022 16:23:25 +0000
Message-Id: <20220414162325.1830014-1-jackyli@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2] crypto: ccp - Fix the INIT_EX data file open failure
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
Signed-off-by: Jacky Li <jackyli@google.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
---
Changelog since v1:
- Added Fixes tag and Reviewed-By tag.

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
2.36.0.rc0.470.gd361397f0d-goog

