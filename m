Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0748CC17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiALTfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344847AbiALTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8CC06175B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:34:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a84-20020a251a57000000b0061171f19f8dso6412508yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=eIszKj/bJsq4MSpl2KdXXCMpeInuz7TCbSlRyIMwFVY3bRNz/lntXbEFFUzB5A7Oun
         w10muHZYycXkBxUxsdAns4p1+uXvYqyCtRIGsLijOLRrI+0Fh3eN4qiELS/g6ETXmRcK
         /RmSO2k1jN+y5RN06/Wa+1gMuURB0kg2ZOLynuRlDuio4eazXgwAuCcnImse9BXSFlcH
         y0mZD3nBc/JZ1xUwsgButvxyiF6T069zbBnQSYR0t9c7KHCXnGUoWWgILlx2+Z7oVPjf
         VaspeQq488lLPI/Fw0IC6/Qi9eU3BSj31vKZiQRk9EDuMhwDQz256RadfKAGoSYq0/au
         C7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXsPIbfQ05P0repzOjAvu6+3E/heYEca8fbLMQGQFvE=;
        b=wCiddQ8HzAk5mSSk82OLXSNglb1+Lt+mL7lF1PZINrnuS2IOlFGcLgQBgpZWAobTP8
         cGaW5WwcNO/54UYcV3f0qbbrqjdKhLeM4PuUHj1mM/opK/dRl7Khi4wpi6fJoMCArym6
         Nr6Y/YbcN93DJP6vXslABCQReBRSA4oS7rJ5iV8U3AVXA/8YIYKx/UjCAAWrqHRNKQd9
         dSM742IDqsbu5Pjjft7Tl2EmbJd+H+TBnaOdCqxfYFTPiCBCq7LPr9Z8lflVASTd9VVG
         o+O0tLICSsJfzXv3waVrl8L9MFdJ+ILHL2/05MW+wUn0nARxOUahRY7rXJQyIOW3f1R1
         jgsg==
X-Gm-Message-State: AOAM531fglqbz7aVGWfi2vlOWHcvOzCvDQbB2B7mWd87I+GEAIrzUc0w
        Obc8mYvH/oDa5SMIIV4JrSfx3xK7bv0=
X-Google-Smtp-Source: ABdhPJw0zf1Y9MRjaIH7OfOhMBCdMo0tqMsEMEdjL2ycKYqwBGswR+jq+f6+ccR7WOXa+suYPw5Bz891o/I=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:b2a4:: with SMTP id k36mr1601492ybj.567.1642016072371;
 Wed, 12 Jan 2022 11:34:32 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:31:48 -0800
In-Reply-To: <20220112193152.3058718-1-haoluo@google.com>
Message-Id: <20220112193152.3058718-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220112193152.3058718-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 4/8] bpf: Support removing kernfs entries
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
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

