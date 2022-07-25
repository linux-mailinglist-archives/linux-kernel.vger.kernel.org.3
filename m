Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981515800A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiGYOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiGYOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262C1120BA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658758855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STjP3t9YbLJwojrLrn71AA0kDkPsgXvwkazzQEZtuik=;
        b=W9qwHtu5pwIOVCHtHLG1jkinErxlRghnVWGEWHwA9OaBvGaZP9lJ54hpg4O8cSIhJmTkTx
        CIq0CTackZ/lJb5cxGdPCS41ml8y8MWZHAl/Cde86JgD4yF15Ud2LBS69QMwwfva5HFMPX
        mDJtOHo57aT9IJsfqSE+MFr3hTGcQ0M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-mVDlXmj-P9GfBzRBb5QZIQ-1; Mon, 25 Jul 2022 10:20:54 -0400
X-MC-Unique: mVDlXmj-P9GfBzRBb5QZIQ-1
Received: by mail-qk1-f200.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso9853015qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STjP3t9YbLJwojrLrn71AA0kDkPsgXvwkazzQEZtuik=;
        b=jmFHiXgYHnWmewBr0gAgZb9B7Sh9b9cjXo4vX4KYas8bf31CDgW9kPLiGXpQ4CTXmM
         QBNEXelr6uOxafw2YmFq6TsgyvLi8UiZLoymBG5pBzqY0dzxWVooKqi8Jx3KFkqSCwvz
         HMjBNGmu46NMHFyMJxYHuvDC1UevExDj/H4qzVlN6o+ZgjAju4iRy5dYFai7vsZi1udD
         QXZrOOcZTIFIlk7+f2RNq2ZPvy3UilCRBwgNCzNK4RGCqdRVMFnSnMznw1fQ8KgJHOX7
         aseMqbVxskrMOh9FlESjhNsOK2jZFaKNhvHjDQdb5SMcv724VwlU1s+O+B7WCiXAWfHt
         vyIw==
X-Gm-Message-State: AJIora9PJRgukL51wfAGOxj/n+QHaFcTJFKZeL0O5rxBpXSHaAtNWFt4
        UcvsfWQRu2vZ4svLI119Uky8RIuPOTX5jiHWyvGQw0L0VYtigNBJU4Mzx4dCrXrhQ0jaMMehFJN
        PCuVSZ0ZCW82RrrFY0fCdY3cZlfMXutu7LSBVytjOH8gboxW3MwwHo1ZXil9cD7Nswnp4C2WjGg
        ==
X-Received: by 2002:ac8:5c4d:0:b0:31e:f794:1b18 with SMTP id j13-20020ac85c4d000000b0031ef7941b18mr10146905qtj.282.1658758853449;
        Mon, 25 Jul 2022 07:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sStdRCgHvQrB2KOO87tQRFjODWSSk/7IEOUYRzTexVJXfNYA2gVOTDz2PPoGKw5RZmrvYmsQ==
X-Received: by 2002:ac8:5c4d:0:b0:31e:f794:1b18 with SMTP id j13-20020ac85c4d000000b0031ef7941b18mr10146880qtj.282.1658758853153;
        Mon, 25 Jul 2022 07:20:53 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b0031f0ab4eceasm7626071qtb.7.2022.07.25.07.20.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Jul 2022 07:20:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 2/3] selftests: soft-dirty: Add test for mprotect
Date:   Mon, 25 Jul 2022 10:20:47 -0400
Message-Id: <20220725142048.30450-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220725142048.30450-1-peterx@redhat.com>
References: <20220725142048.30450-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two soft-dirty test cases for mprotect() on both anon or file.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/soft-dirty.c | 67 ++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
index 08ab62a4a9d0..e3a43f5d4fa2 100644
--- a/tools/testing/selftests/vm/soft-dirty.c
+++ b/tools/testing/selftests/vm/soft-dirty.c
@@ -121,13 +121,76 @@ static void test_hugepage(int pagemap_fd, int pagesize)
 	free(map);
 }
 
+static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
+{
+	const char *type[] = {"file", "anon"};
+	const char *fname = "./soft-dirty-test-file";
+	int test_fd;
+	char *map;
+
+	if (anon) {
+		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
+			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+		if (!map)
+			ksft_exit_fail_msg("anon mmap failed\n");
+	} else {
+		test_fd = open(fname, O_RDWR | O_CREAT);
+		if (test_fd < 0) {
+			ksft_test_result_skip("Test %s open() file failed\n", __func__);
+			return;
+		}
+		unlink(fname);
+		ftruncate(test_fd, pagesize);
+		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
+			   MAP_SHARED, test_fd, 0);
+		if (!map)
+			ksft_exit_fail_msg("file mmap failed\n");
+	}
+
+	*map = 1;
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
+			 "Test %s-%s dirty bit of new written page\n",
+			 __func__, type[anon]);
+	clear_softdirty();
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 0,
+			 "Test %s-%s soft-dirty clear after clear_refs\n",
+			 __func__, type[anon]);
+	mprotect(map, pagesize, PROT_READ);
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 0,
+			 "Test %s-%s soft-dirty clear after marking RO\n",
+			 __func__, type[anon]);
+	mprotect(map, pagesize, PROT_READ|PROT_WRITE);
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 0,
+			 "Test %s-%s soft-dirty clear after marking RW\n",
+			 __func__, type[anon]);
+	*map = 2;
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
+			 "Test %s-%s soft-dirty after rewritten\n",
+			 __func__, type[anon]);
+
+	munmap(map, pagesize);
+
+	if (!anon)
+		close(test_fd);
+}
+
+static void test_mprotect_anon(int pagemap_fd, int pagesize)
+{
+	test_mprotect(pagemap_fd, pagesize, true);
+}
+
+static void test_mprotect_file(int pagemap_fd, int pagesize)
+{
+	test_mprotect(pagemap_fd, pagesize, false);
+}
+
 int main(int argc, char **argv)
 {
 	int pagemap_fd;
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(5);
+	ksft_set_plan(15);
 
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
@@ -138,6 +201,8 @@ int main(int argc, char **argv)
 	test_simple(pagemap_fd, pagesize);
 	test_vma_reuse(pagemap_fd, pagesize);
 	test_hugepage(pagemap_fd, pagesize);
+	test_mprotect_anon(pagemap_fd, pagesize);
+	test_mprotect_file(pagemap_fd, pagesize);
 
 	close(pagemap_fd);
 
-- 
2.32.0

