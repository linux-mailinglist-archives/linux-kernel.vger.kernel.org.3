Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727E148CBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiALT0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiALT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:26:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15614C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:26:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i81-20020a253b54000000b00611b1da1f8fso1550754yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=OVkw/OOQFATmzm1SJea+QKvbMcvbrUZuyRpLKQiqbaK5v2Tnvmu+BZ0ots7zJCdUHU
         z8ccxQc7x69F99FJgAIRsTcsBG1ISQK7GavxRUeCpdJp7zfJW1nCzASnhVjx4Ng0xmIe
         C44vlOxJa6I+pJxIfsk1hiZt+lu6sBOAUI3WPPBvbN6UiS7GG3CdDzAQ0O1c8uvnAXai
         O6Hd4heEx0/z5vJzDL1M5KdGMZttUn5ReRHQMQmSA+7ykquom4vhDJv0DStOsLAorR2N
         csWjLeU6++lgIkjcyWgPfzztPqg29O6fOEN4A+Bxq1bMisAZj/obE5R8IY0i+SKCxSbH
         WzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=y7uGJ38ja31wxc0UWPgOxG7nF1qzgnay4qjoRB0rUmFoiIIhU4SqPTZ8pLWgL6eQlc
         uhdAnq704iEV6udi0hyD+RvWtxuIauUWhaEuDZ0lzDJ9eh15q4gLtCGcWl0nbT8jtXi/
         PtaQQM7gJ6cPxXjEk18WFgp9DpVCHWfvv2tUQuXrh1ighdNjmck2bN1uGSB/NzoVd3rs
         EjFUnl3VXJg18+pNwXb6j8OzsoeVlOW7fLpL3l7kJsKHpMDx3Z4A7JI8HjNIW/Tvig9h
         iwcyYPjQgFT+zhKEm/9EMbYb+oqEYrTdC+li8ZOP6/1yKQV32Ta+1hb1X+TIFjK1k2VH
         70/A==
X-Gm-Message-State: AOAM530FLKPhMRDVQyx8qphrYeSQaUQ9rLb9+2QAYfCy11F3ZSodBjG6
        0K8gDjPV7e5BlQkBaZeYYygVJpWvjZg=
X-Google-Smtp-Source: ABdhPJxYm5u9VpP7OA8U6j16gepHc9xNcbC+H/aOGc5oUb0spGUr2hCdgYEzAcb2fZU4jMdkNLKi5RoNLG4=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:ac24:: with SMTP id w36mr656053ybi.610.1642015559343;
 Wed, 12 Jan 2022 11:25:59 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:25:43 -0800
In-Reply-To: <20220112192547.3054575-1-haoluo@google.com>
Message-Id: <20220112192547.3054575-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220112192547.3054575-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 4/8] bpf: Support removing kernfs entries
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, Joe@google.com,
        Burton@google.com, jevburton.kernel@gmail.com,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a bpf object has been exposed in kernfs, there should be a way
to remove it. Kernfs doesn't implement unlink, therefore one can not
remove the entry in a normal way. To remove the file, we can allow
writing a special command to the new entry, which can trigger a
remove_self() for removal.

So far there are two ways to remove an entry that is created by pinning
bpf objects in kernfs:

 1. unpin the object from bpffs.
 2. write a special command to the kernfs entry.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/kernfs_node.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/kernfs_node.c b/kernel/bpf/kernfs_node.c
index c1c45f7b948b..3d331d8357db 100644
--- a/kernel/bpf/kernfs_node.c
+++ b/kernel/bpf/kernfs_node.c
@@ -9,6 +9,9 @@
 
 /* file_operations for kernfs file system */
 
+/* Command for removing a kernfs entry */
+#define REMOVE_CMD "rm"
+
 /* Handler when the watched inode is freed. */
 static void kn_watch_free_inode(void *obj, enum bpf_type type, void *kn)
 {
@@ -22,8 +25,27 @@ static const struct notify_ops notify_ops = {
 	.free_inode = kn_watch_free_inode,
 };
 
+static ssize_t bpf_generic_write(struct kernfs_open_file *of, char *buf,
+				 size_t bytes, loff_t off)
+{
+	if (sysfs_streq(buf, REMOVE_CMD)) {
+		kernfs_remove_self(of->kn);
+		return bytes;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t bpf_generic_read(struct kernfs_open_file *of, char *buf,
+				size_t bytes, loff_t off)
+{
+	return -EIO;
+}
+
 /* Kernfs file operations for bpf created files. */
 static const struct kernfs_ops bpf_generic_ops = {
+	.write          = bpf_generic_write,
+	.read           = bpf_generic_read,
 };
 
 /* Test whether a given dentry is a kernfs entry. */
-- 
2.34.1.448.ga2b2bfdf31-goog

