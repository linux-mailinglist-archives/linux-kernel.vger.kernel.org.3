Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77546F62A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhLIVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhLIVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:50:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B200C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:47:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g18so6636837pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3N2jiGWgxs5xgqtqhRLupRBvzYgm+RjsEtpOg8EXqs=;
        b=enyd+qmb3GxVxb0FT7me7Azc4OJFiaNffNOEm3gYE0eMMn3SlTr43jW2H+l7/6PRtf
         0NWvF5YKym1Z44c5zmTKILXuT5blhC0z3B88MKAoRGYdbu4J/9bk7ZXTniku4uFPK05S
         8CP9Ei+DNgt34lzh9J4aDwG5HaGyBjiXdiqhMVWa6uChlb73hzc00Ouyy0fR16aButmh
         xLhtll7yD9fFnHIncI6QIMGtxNy4TnSgGc/a7uonaX5GWuaGQCUj/NdZ1IVQBfRIy6xe
         Q67WfvDcCrBLzo0Vn6nG0/j3h/HcP2WPaXi8U6kWEBzbtJR+pgHg8sSao+ducGWSrBNs
         dZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o3N2jiGWgxs5xgqtqhRLupRBvzYgm+RjsEtpOg8EXqs=;
        b=v2T0JnbHN8gVDxoaGAYC30I/jvNePhAEh59oNnnT7TCdaUCKDxvoSb5fkCrkX/Stj5
         YBTXpK//quxk48cNrgmzy0Ux9pCO1qOLIi8UMa+6jbDBdeMJ4ECpbEkqjasgfJSW/NNP
         YrANdK4RR7LvHkAFFtBtg3QnNOrI5uk2tofr3JnG7yK0P+UKDOCMd8pScReD17ml13oB
         kFV2iDGPIsbuHSW9GC3RhN0Bc9zg2gVHSl+BxKFSH9BTKGcYos/IKaf8kF+LqPwPHBcF
         c847wL0ASXwU2OxpOAA3/JH1awpwZqLq94qo5BuN3Oyz8fQ5nRPs8DQZuSbIhsd/NZGV
         OOdg==
X-Gm-Message-State: AOAM530Xeq4pelHO8bcwklpb86UDS8Ub+U1yqqY2YlBoYh+jnAZwH7JW
        mbXt/OWm+S8rhYemYoxqMQ4=
X-Google-Smtp-Source: ABdhPJy4IaPfZMWnRvElQWC5smWnwdO8s4JBogWFmYs0KkzLXACjWZnB8Gz6LkscR6S6VbTRQgv6kg==
X-Received: by 2002:a05:6a00:1945:b0:44c:a955:35ea with SMTP id s5-20020a056a00194500b0044ca95535eamr14033824pfk.85.1639086442575;
        Thu, 09 Dec 2021 13:47:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u22sm675937pfk.148.2021.12.09.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:47:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] selftests: cgroup: Test open-time credential usage for migration checks
Date:   Thu,  9 Dec 2021 11:47:06 -1000
Message-Id: <20211209214707.805617-6-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209214707.805617-1-tj@kernel.org>
References: <20211209214707.805617-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is writing to an fd opened by a different task, the perm check
should use the credentials of the latter task. Add a test for it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/cgroup/test_core.c | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 3df648c37876..01b766506973 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -674,6 +674,73 @@ static int test_cgcore_thread_migration(const char *root)
 	return ret;
 }
 
+/*
+ * cgroup migration permission check should be performed based on the
+ * credentials at the time of open instead of write.
+ */
+static int test_cgcore_lesser_euid_open(const char *root)
+{
+	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
+	int ret = KSFT_FAIL;
+	char *cg_test_a = NULL, *cg_test_b = NULL;
+	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
+	int cg_test_b_procs_fd = -1;
+	uid_t saved_uid;
+
+	cg_test_a = cg_name(root, "cg_test_a");
+	cg_test_b = cg_name(root, "cg_test_b");
+
+	if (!cg_test_a || !cg_test_b)
+		goto cleanup;
+
+	cg_test_a_procs = cg_name(cg_test_a, "cgroup.procs");
+	cg_test_b_procs = cg_name(cg_test_b, "cgroup.procs");
+
+	if (!cg_test_a_procs || !cg_test_b_procs)
+		goto cleanup;
+
+	if (cg_create(cg_test_a) || cg_create(cg_test_b))
+		goto cleanup;
+
+	if (cg_enter_current(cg_test_a))
+		goto cleanup;
+
+	if (chown(cg_test_a_procs, test_euid, -1) ||
+	    chown(cg_test_b_procs, test_euid, -1))
+		goto cleanup;
+
+	saved_uid = geteuid();
+	if (seteuid(test_euid))
+		goto cleanup;
+
+	cg_test_b_procs_fd = open(cg_test_b_procs, O_RDWR);
+
+	if (seteuid(saved_uid))
+		goto cleanup;
+
+	if (cg_test_b_procs_fd < 0)
+		goto cleanup;
+
+	if (write(cg_test_b_procs_fd, "0", 1) >= 0 || errno != EACCES)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	if (cg_test_b_procs_fd >= 0)
+		close(cg_test_b_procs_fd);
+	if (cg_test_b)
+		cg_destroy(cg_test_b);
+	if (cg_test_a)
+		cg_destroy(cg_test_a);
+	free(cg_test_b_procs);
+	free(cg_test_a_procs);
+	free(cg_test_b);
+	free(cg_test_a);
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct corecg_test {
 	int (*fn)(const char *root);
@@ -689,6 +756,7 @@ struct corecg_test {
 	T(test_cgcore_proc_migration),
 	T(test_cgcore_thread_migration),
 	T(test_cgcore_destroy),
+	T(test_cgcore_lesser_euid_open),
 };
 #undef T
 
-- 
2.34.1

