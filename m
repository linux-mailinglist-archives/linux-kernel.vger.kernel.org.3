Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF54734D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbhLMTTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbhLMTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC20C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so13128534pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3N2jiGWgxs5xgqtqhRLupRBvzYgm+RjsEtpOg8EXqs=;
        b=cOxpxTHwQm+gY5ptQYH6zwc4T4dr79EPGK43U7hvYZLZtApSaUZgY4xB7C8g8iaqxQ
         pa7wmcJf1j3P41mYdBWaZI2eqv2u/lRzsgegth61bWyaWv0vsMU7ntJGM8uhSZtDbOGm
         Hgop8DncHYIO4LRfB7d7P+mhZ8aQtyLNyMhbXkzu1rM/mBLu+X7WDiiwu7V2h162XZjT
         DiPha/AvBwMEumlhUA8ZQXTWxi1mPwRzTNgyh6KV5/j/mSlGxlmoDOLgNsTD+P+C2e0f
         v69y/zfRCii0/t5eDubcmWitt7m6EYHw/+w1XsYn0Q27x0Hzzlbpvgshz2Q2x9cgl/Ip
         m/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o3N2jiGWgxs5xgqtqhRLupRBvzYgm+RjsEtpOg8EXqs=;
        b=N5WJLfdCs617Pfs6rfCb1kRQWrWme/wd6PlKjaD3AzcM7maM7hr1qzr7A2dhh62T7h
         hpqATrtb6MsOAfngDeNmHBro0LtY8UBoWUPtQvbLqMd/f3nKqeh0vMcxnGypSR5NCDK+
         Lw+FchgcCN2F/ZkkCx5twOChZntDU5HY8ZOuSvryLwkbe7/UKyaJmSt5qN1UzlhcSxBo
         AmC6t9voLnQZpfIuV9MHTmY9B1fFVe6vbpp7/bs2bGRnGM0V2jywLiO3d67RCUkJ0NAn
         L4BO+31/KSODyCv9CWXui7popLMRQ9NonAFg99T1bzPnzfH80vOMLvuAmf2IgqvWObL+
         bNJA==
X-Gm-Message-State: AOAM530U1IYD2hEXGcZVwI6Pg5lKjZv/ONDrB073M1oQK0MPt1wsGiNL
        4YYN/+NB/yDxqVmCwz28RyM=
X-Google-Smtp-Source: ABdhPJxQMKntZ1IQ4u6bfRC+tQAihXYD6Yxb1JnXSvZ5LzzTX3t9rBu9REmKmXHYjpDAZ66nil4zEQ==
X-Received: by 2002:a17:90b:f81:: with SMTP id ft1mr255804pjb.136.1639423129804;
        Mon, 13 Dec 2021 11:18:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mi18sm7726669pjb.13.2021.12.13.11.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:49 -0800 (PST)
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
Date:   Mon, 13 Dec 2021 09:18:32 -1000
Message-Id: <20211213191833.916632-6-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213191833.916632-1-tj@kernel.org>
References: <20211213191833.916632-1-tj@kernel.org>
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

