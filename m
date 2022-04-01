Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41B4EFCA0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353262AbiDAWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353234AbiDAWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:10:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAEB3B564
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:08:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bo5so3835668pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2dIS9P9cYggnNka+4k4Gn63M8GjebQJazBSK4gQ59E=;
        b=Cr8pY9ZyZkOJCluc/iz4NzKGM5yjTCERCc07lJqJ64lxXC8WM7aZ3lRaioUTSrh1uP
         fnNA8gzv7T3fB/mIuXCSe/fDWMjiR+M9lYmcB1a56kj/OmmUyAJKjnV/XNb8nJ4v2hbZ
         upohpJPABZs86wqi/TJXNyrjsZ+clUnpfPNhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2dIS9P9cYggnNka+4k4Gn63M8GjebQJazBSK4gQ59E=;
        b=4C7E+u8yvIleBX0hKp1v/eAypkadLzvtQhKI40yfIt6syxzYjOEc+RTakkvLVuX5tV
         axriPu81tu8LJNKXQ167FPjfP6U5R+CeqXM439AkjBOfNvvcii6B38zryl9hlRLUeWoF
         9JMetRgeagCmcHIxDCVnVMqaeEf45O1D3SnD/XR0J6nmHUIKqweYdz746xG4VGf9lLms
         SfiGjWeWkl7t06ydd3vP+QmBUBxYU8Ks3I9BnLqzdG1gqGpS+YR4Gjcg5w8KkeSOhapL
         sH2NduWkr4PKpPieAGJl55BfRZdgIEUYw6+nHs5+3+Qi1W7G+Q/jVHSH6dEbtgsGxQM7
         FSqQ==
X-Gm-Message-State: AOAM532mOkE9z8NkxxV3r6gTgmYblotzSgonZkncSoi3nnUkoVancA/7
        mtLDUPlX1TuhAGskpJQpmqmZOA==
X-Google-Smtp-Source: ABdhPJzxAVHoX6VACxIQgKkefSjLO46zf4cJLaQQXIcLa57xWR5jeIRu2USsxHabbOHOptJtDZDWeg==
X-Received: by 2002:a05:6a00:1488:b0:4fa:ac61:8b11 with SMTP id v8-20020a056a00148800b004faac618b11mr13204273pfu.58.1648850934155;
        Fri, 01 Apr 2022 15:08:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:72c9:527e:d936:c24b])
        by smtp.gmail.com with UTF8SMTPSA id oc10-20020a17090b1c0a00b001c7510ed0c8sm14841905pjb.49.2022.04.01.15.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 15:08:53 -0700 (PDT)
From:   Daniel Verkamp <dverkamp@chromium.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH 3/4] selftests/memfd: add tests for F_SEAL_EXEC
Date:   Fri,  1 Apr 2022 15:08:33 -0700
Message-Id: <20220401220834.307660-4-dverkamp@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220401220834.307660-1-dverkamp@chromium.org>
References: <20220401220834.307660-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic tests to ensure that user/group/other execute bits cannot be
changed after applying F_SEAL_EXEC to a memfd.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..fdb0e46e9df9 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -28,6 +28,10 @@
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
 
+#ifndef F_SEAL_EXEC
+#define F_SEAL_EXEC	0x0020
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -594,6 +598,48 @@ static void mfd_fail_grow_write(int fd)
 	}
 }
 
+static void mfd_assert_mode(int fd, int mode)
+{
+	struct stat st;
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%d) failed: %m\n", fd);
+		abort();
+	} else if ((st.st_mode & 07777) != mode) {
+		printf("wrong file mode 0%04o, but expected 0%04o\n",
+		       (int)st.st_mode & 07777, mode);
+		abort();
+	}
+}
+
+static void mfd_assert_chmod(int fd, int mode)
+{
+	if (fchmod(fd, mode) < 0) {
+		printf("fchmod(0%04o) failed: %m\n", mode);
+		abort();
+	}
+
+	mfd_assert_mode(fd, mode);
+}
+
+static void mfd_fail_chmod(int fd, int mode)
+{
+	struct stat st;
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%d) failed: %m\n", fd);
+		abort();
+	}
+
+	if (fchmod(fd, mode) == 0) {
+		printf("fchmod(0%04o) didn't fail as expected\n");
+		abort();
+	}
+
+	/* verify that file mode bits did not change */
+	mfd_assert_mode(fd, st.st_mode & 07777);
+}
+
 static int idle_thread_fn(void *arg)
 {
 	sigset_t set;
@@ -880,6 +926,39 @@ static void test_seal_resize(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_EXEC
+ * Test that chmod() cannot change x bits after sealing
+ */
+static void test_seal_exec(void)
+{
+	int fd;
+
+	printf("%s SEAL-EXEC\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0777);
+
+	mfd_assert_chmod(fd, 0644);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+
+	mfd_assert_chmod(fd, 0600);
+	mfd_fail_chmod(fd, 0777);
+	mfd_fail_chmod(fd, 0670);
+	mfd_fail_chmod(fd, 0605);
+	mfd_fail_chmod(fd, 0700);
+	mfd_fail_chmod(fd, 0100);
+	mfd_assert_chmod(fd, 0666);
+
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1059,6 +1138,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
-- 
2.35.1.1094.g7c7d902a7c-goog

