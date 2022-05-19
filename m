Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4352D317
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiESMzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiESMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:55:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1EA7E36
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:55:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 137so4993292pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiUsRi0TcKngRpQ/Aq2tkPZeo5Erutd/MtmCgm/5bYU=;
        b=MRvUskMS0dP9aYF0X75Mw2BIhDXmrUI5V2pM7+rkEZ158WuT9cZe4IexXcTj+ckM6i
         +iz8Rx1U7C3CnSE5DvvQPv9cnm7wPAnYi3p07DcDBhtTMuiZ6trrjNVBdEKWUXgBJm0D
         wxQLG3pJmHYv6LiStLin3J3zLFhidhzdyRuA2VtubHUeAfgtUKMsjeDCSokJoaLDnLke
         IGWzmoAgd9tqR/0J3vNW2mQJqh3Sg2aEdgo99EpPShPJhNszGRPIULjKkfTpChErPPuG
         sURwiVhnCKdDino+ptabRTeyYJwwSGLrNzYflyG8C/0073CdhdU+WnYgekHMXwL8uKt9
         7X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiUsRi0TcKngRpQ/Aq2tkPZeo5Erutd/MtmCgm/5bYU=;
        b=15n+9sFYPUQn+ENWMPyo2S0PtPYEFYilsYvRR7NgzlMhqcjzaTGZ9YwYZrskzjGsqe
         1UbYaFToelKmXFBECJumHdmXXnEE5aadMDOESGM5hcoz1CuceehaSB4nJf6W33BzRI1v
         BoWeuWDVqJknYICHjBS6CNb5rX9ZHwaWFn+rPjIrOPZsautN6S6Pr6lKILAHAEIyz9gl
         /AmO9hQujihJLRxUUNtYzMPGfZtIF97kA1fWrOH+N5YyhLmiugQIpoaZMLhxZqIn7I6k
         5fWybUGH5+2q4XphEL0HAflTbq+xxXRk+0T8RY6T7mxD3VU8twZBqYfvXy0ifOIsYy25
         sZ6w==
X-Gm-Message-State: AOAM5336tLiDOeNVPuMEXc/jS0P1Fpx+v+qf6+Bb255obU34Gd4ELnbc
        vO9apW//o7mMicOHGsue5Ql6DpFms2TI/A==
X-Google-Smtp-Source: ABdhPJxMmOwhWa8SHa/gVmsNZFJ9NCopj+W+34thmpChLqFM/4MyZoVb5YqSIWIq+rP6kZLzTnkSCA==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr4568784pfu.59.1652964927356;
        Thu, 19 May 2022 05:55:27 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id iz10-20020a170902ef8a00b0015e8d4eb1ddsm3664659plb.39.2022.05.19.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 05:55:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [PATCH] sysctl: handle table->maxlen properly for proc_dobool
Date:   Thu, 19 May 2022 20:55:05 +0800
Message-Id: <20220519125505.92400-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
robustness, fix it by handling able->maxlen properly for proc_dobool in
__do_proc_dointvec().

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

