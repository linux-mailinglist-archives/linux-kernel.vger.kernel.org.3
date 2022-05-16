Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E95281ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiEPKYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiEPKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:24:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158AE0E7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w17-20020a17090a529100b001db302efed6so13870198pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66QHju611WH53dYegSIeTLMF0HCCMVlkCTvmtXu5zP0=;
        b=dbOdnoBhv8yDK+GYyHYeN5G+d7/MHd9XVwc4tEPW7W3O+cZRT3Wv7x+znTXvNtO+f3
         6bEsAy40OaeqAaep5aSPNUgrcDvjiV7Mbt0ptchb8A3pYElKJt1bNlTdgx7zFZ4MxyHX
         0B5xxhVpkjVQjpaCkqHkLxuE/ntC47wRcsxOZZAg+3yzJVnK0NBoVC5kQbXHy99msudO
         Oe6PF6U9kalMK2v1ZjOxyE9Jl0fXH67dfu4LtcJmdbOW8f8piy081NEqSkdF/H+wgM4B
         qYkLF9/8nR7Xdej7zfxtkgHwip0sZnt3tx+uk8zKb9pebOPiv1hSqyGFpMK/ACJwdU4+
         eKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66QHju611WH53dYegSIeTLMF0HCCMVlkCTvmtXu5zP0=;
        b=OloKGL4vMgMR8P1UbcKBXvWXu9mnndk2Cg9naBKExc3dYz+XWJJWd+QAI1a99H8DhZ
         GAGwMYzG3FuRIzTwNe3DpcTJ/4020m0zqlZVg1hiJ1R54j21kFVddpjSlrjXR5tEuY/M
         VcbQR6JYZZRpKbGthQ4UXmv8Zgi0luKfcQ3VRtTu1vE0BfqHJM6BJxEXxuDih+/AsIyB
         e5MjmUwoGOFVmDuCvZ0/h9bO9AfjkH5PQZdi8bq00HQLb0413oHncKvs1HlskZdsYokt
         m8mPdCzKuGb8RKc02nKnRvG5SVRaK88+32Tvne29tLLMAASTJ1yo1XolHnwAooNOVcA4
         SXPQ==
X-Gm-Message-State: AOAM531hbgipaVR/LDkJAnO4IH+HYNHYUcVAD3kX/zBLWMy+wkcfAD3n
        Z9rttiKU6cnp57+LvJQEVD61ZQ==
X-Google-Smtp-Source: ABdhPJx7T73yVTTd72pWQdg0tme4uuKLleJpMJUhliphuOjg/2KAtHyrnRxxoAQV31EyZlOMr2VLWg==
X-Received: by 2002:a17:902:ab8c:b0:15e:fd9f:3f39 with SMTP id f12-20020a170902ab8c00b0015efd9f3f39mr16805245plr.103.1652696618000;
        Mon, 16 May 2022 03:23:38 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0050dc76281e4sm6472731pfa.190.2022.05.16.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:23:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 6/7] sysctl: handle table->maxlen properly for proc_dobool
Date:   Mon, 16 May 2022 18:22:10 +0800
Message-Id: <20220516102211.41557-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220516102211.41557-1-songmuchun@bytedance.com>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
robustness, fix it by handling able->maxlen properly for proc_dobool in
__do_proc_dointvec().  In the next patch, we will use proc_dobool which
depends on this change.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Iurii Zaikin <yzaikin@google.com>
---
 fs/lockd/svc.c  |  2 +-
 kernel/sysctl.c | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 59ef8a1f843f..6e48ee787f49 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
 	{
 		.procname	= "nsm_use_hostnames",
 		.data		= &nsm_use_hostnames,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(nsm_use_hostnames),
 		.mode		= 0644,
 		.proc_handler	= proc_dobool,
 	},
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e52b6e372c60..353fb9093012 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -428,6 +428,8 @@ static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
 				int write, void *data)
 {
 	if (write) {
+		if (*negp || (*lvalp != 0 && *lvalp != 1))
+			return -EINVAL;
 		*(bool *)valp = *lvalp;
 	} else {
 		int val = *(bool *)valp;
@@ -489,17 +491,17 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 			      int write, void *data),
 		  void *data)
 {
-	int *i, vleft, first = 1, err = 0;
+	int vleft, first = 1, err = 0, size;
 	size_t left;
 	char *p;
-	
+
 	if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
-	
-	i = (int *) tbl_data;
-	vleft = table->maxlen / sizeof(*i);
+
+	size = conv == do_proc_dobool_conv ? sizeof(bool) : sizeof(int);
+	vleft = table->maxlen / size;
 	left = *lenp;
 
 	if (!conv)
@@ -514,7 +516,7 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 		p = buffer;
 	}
 
-	for (; left && vleft--; i++, first=0) {
+	for (; left && vleft--; tbl_data = (char *)tbl_data + size, first=0) {
 		unsigned long lval;
 		bool neg;
 
@@ -528,12 +530,12 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 					     sizeof(proc_wspace_sep), NULL);
 			if (err)
 				break;
-			if (conv(&neg, &lval, i, 1, data)) {
+			if (conv(&neg, &lval, tbl_data, 1, data)) {
 				err = -EINVAL;
 				break;
 			}
 		} else {
-			if (conv(&neg, &lval, i, 0, data)) {
+			if (conv(&neg, &lval, tbl_data, 0, data)) {
 				err = -EINVAL;
 				break;
 			}
@@ -708,8 +710,8 @@ int do_proc_douintvec(struct ctl_table *table, int write,
  * @lenp: the size of the user buffer
  * @ppos: file position
  *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string.
+ * Reads/writes up to table->maxlen/sizeof(bool) bool values from/to
+ * the user buffer, treated as an ASCII string.
  *
  * Returns 0 on success.
  */
-- 
2.11.0

