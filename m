Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA358B26E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbiHEWWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiHEWVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C11CFD1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:21:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s14-20020a5b044e000000b00672caf96368so3119629ybp.21
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5E4PGAWMReAFHkj0eA7xzWpJk8N5M4FgV4LT8CvMVPA=;
        b=TDuzZmP48qciezv1MXsf3LVuEa0sxCTwiXmz3GaFb6bY9Qtk1DrEr4hk/hgSUCSU9D
         AfNdO6ggJ2vgmMWeMOlX/leMgSXGcQVjNK0zYR0phfm+32xYcPAHGvQSYoqPiNbxudnk
         HvE2bkCtTLZ4+b3Ay+j53c5ejYOvr0jzKdc8h62ng9xyA/YGHmq7HQjrLzA1ZaYH+BV9
         0FZ6JoFGedju30kgJTOIXqXWVdCHFjQ55uchR5QBZO9lhMl46oSxaKE6Z0a+P78bLdDl
         tNj+/17Hexg7tUbRBM+OCbb+sqB6gZJt9lxBqysd3REOSfOgCXMUXOEiZd1Awo0K8DSt
         9wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5E4PGAWMReAFHkj0eA7xzWpJk8N5M4FgV4LT8CvMVPA=;
        b=vkSddsHy996CBN8ekXqt4p5n68JpjcfKNzxLfCtm5xCclqEV6vcxYUPD1DK9W32wQb
         35o8+f+VH8/ALyoFYVrNtP5R1gm5ARRuGCIkwwtaFYEy4ZIUBx1KpVI9WtBHxuxh2OyD
         eEJviGm0Inzd18be4w3U5KvF6352cDzUiqC9mWc/x5Fgedl5yDGW5VlqQe0djwI95ttj
         9xEW2xmcTQpod/Tb4uTgfyDSI72FIkth9jUAAYoMAMtRyq/pyUjzEbmxeObrr1pVJhs5
         PcdtMt5BdoLIi/NsS7AWE/YL8E+BxagXBvT6/yK4NQVK6O95yppeBj3eX73ktcaFcz22
         m+ag==
X-Gm-Message-State: ACgBeo20dgyf+xsVcO5QA0T9Rxn2vjW8KxoLAHnIIHenskhkvZoUUQFT
        hF57S3HmHtmDiRMBIJ4nZElJx/FkZSc=
X-Google-Smtp-Source: AA6agR55Nd+GF+Zicb9UzLXVsBAJG/nkDrQRMgHX77YRUR2vsXmmAEpB7Hc955x1MuY3F3Ah7dc0fEbCssM=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a25:9c87:0:b0:671:82fd:9106 with SMTP id
 y7-20020a259c87000000b0067182fd9106mr7167620ybo.546.1659738110679; Fri, 05
 Aug 2022 15:21:50 -0700 (PDT)
Date:   Fri,  5 Aug 2022 22:21:23 +0000
In-Reply-To: <20220805222126.142525-1-jeffxu@google.com>
Message-Id: <20220805222126.142525-3-jeffxu@google.com>
Mime-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 2/5] mm/memfd: add MFD_NOEXEC flag to memfd_create
From:   <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
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

From: Daniel Verkamp <dverkamp@chromium.org>

The new MFD_NOEXEC flag allows the creation of a permanently
non-executable memfd. This is accomplished by creating it with a
different set of file mode bits (0666) than the default (0777) and
applying the F_SEAL_EXEC seal at creation time, so there is no window
between memfd creation and seal application.

Unfortunately, the default for memfd must remain executable, since
changing this would be an API break, and some programs depend on being
able to exec code from a memfd directly. However, this new flag will
allow programs to create non-executable memfds, and a distribution may
choose to enforce use of this flag in memfd_create calls via other
security mechanisms.

Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..140e125c9f65 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,7 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_NOEXEC              0x0008U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 4ebeab94aa74..b841514eb0fd 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -263,7 +263,7 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -333,6 +333,14 @@ SYSCALL_DEFINE2(memfd_create,
 		*file_seals &= ~F_SEAL_SEAL;
 	}
 
+	if (flags & MFD_NOEXEC) {
+		struct inode *inode = file_inode(file);
+
+		inode->i_mode &= ~0111;
+		file_seals = memfd_file_seals_ptr(file);
+		*file_seals |= F_SEAL_EXEC;
+	}
+
 	fd_install(fd, file);
 	kfree(name);
 	return fd;
-- 
2.37.1.559.g78731f0fdb-goog

