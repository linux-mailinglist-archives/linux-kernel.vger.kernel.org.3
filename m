Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3749B684
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388462AbiAYOhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389067AbiAYOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:33:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35396C06173B;
        Tue, 25 Jan 2022 06:33:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c24so61217072edy.4;
        Tue, 25 Jan 2022 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLGRSDBqt3CI9o30EqMaKBgi/Og7jvCpHq0R8ShXmFM=;
        b=Mn4PK6g/oizWyfQ/FlsNpx8KUGy4lvZNH4Q44yveFyG6XwfO4vkxu5X4ytfU6J68Jp
         t/Ep8y+dU+4NrFLJMNh5dhoE3ITMKtr8o4VcdBESKAXHbnpqb0CjYOyMH+JgwlHcFxUg
         SdYu2BojdjheT8JGAjkEWzq6FCuwKY1y7yWHJguJTGz1GcYRHYZkH++kWEoZ0Pvrl0EM
         TNidQED+LEGzAweI2o8TceH5KTyp97FCGQZyfp44hk6hrSdAJIzr1V/CxQJtFyfq8bnP
         oy9Avv4wKRXUE6cJtJrAk60hQGmhsPB+EiNE1/cwxu7YTSuMAE9EwA6e/ZhT9IOo9xYz
         OTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLGRSDBqt3CI9o30EqMaKBgi/Og7jvCpHq0R8ShXmFM=;
        b=mCeSOG42rHLmdlqIFonaAw/LVJGsOJVJUGUbEoi371kQt8tCnpbqWBr0OpDAKA4Km5
         dTA3UUB+E5L4U7TwbRa6PCrHk18+wk4wGViYQGu4UWuNGjPKu/iV4bRXwETkP9ipzuzp
         UZs9rshkgoL7hex1gUJxxXwEBoqCYE0wrxUW38zKMXlNfg5hgNechwPMdkNzyeBPJAoG
         Kjz3tuXf1b6cMmddrvbOLy23gDWDQAaE0UMtpGyPyMYBCt97phaflruOQPyT9wX+lCVr
         N2ToCYS+QDfij6hQjuqNC8S3+jcNiwH2DPvSjd1SFtT7u/DtaBjttx0L8ViiF6E3Xext
         yAaA==
X-Gm-Message-State: AOAM531Y2srWANeW/QtBz/6X4vAk9SGw5PYNolzTI9C8TD6fL/mvCi2a
        z5hf6nSINNTSbn2yLE4ZIo9oGMAYj4dDkg==
X-Google-Smtp-Source: ABdhPJw2WjOewfY30kV7zrgPQ4uGjfJlfejcSiIazlBcEOdPGrjUrMOyvy+xfpRlBK6bRy0afqR1Uw==
X-Received: by 2002:a17:906:7306:: with SMTP id di6mr16139066ejc.93.1643121205668;
        Tue, 25 Jan 2022 06:33:25 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id gz12sm6291530ejc.124.2022.01.25.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:33:25 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: create security context for memfd_secret inodes
Date:   Tue, 25 Jan 2022 15:33:04 +0100
Message-Id: <20220125143304.34628-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a security context for the inodes created by memfd_secret(2) via
the LSM hook inode_init_security_anon to allow a fine grained control.
As secret memory areas can affect hibernation and have a global shared
limit access control might be desirable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
An alternative way of checking memfd_secret(2) is to create a new LSM
hook and e.g. for SELinux check via a new process class permission.
---
 mm/secretmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 22b310adb53d..b61cd2f661bc 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -164,11 +164,20 @@ static struct file *secretmem_file_create(unsigned long flags)
 {
 	struct file *file = ERR_PTR(-ENOMEM);
 	struct inode *inode;
+	const char *anon_name = "[secretmem]";
+	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
+	int err;
 
 	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
+	err = security_inode_init_security_anon(inode, &qname, NULL);
+	if (err) {
+		file = ERR_PTR(err);
+		goto err_free_inode;
+	}
+
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-- 
2.34.1

