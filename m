Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5438E57D355
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiGUSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGUSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D9D48C8E2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658428425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbIFjjgDA4ooaBqJdaxSYkeX6CtTRCPcitxkJ2jJ7zw=;
        b=fu2/XqBvmXDQ2TkRqQa8RnSAE3XepU07P6CCUQnUcg7npyhiu/BQ4CWQN/OeMjt56J+J0A
        jiroxlZRR9cMh6JRI1sX1hLI7JmuSpiuxLDyMQ2knljhi2SnPLhiePy0JBLl4DAccsiPMI
        poWyaT1R4CYf8uFsCSwLdpElzPunW68=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-aWOPC14IMYOFqesp56s6Dw-1; Thu, 21 Jul 2022 14:33:44 -0400
X-MC-Unique: aWOPC14IMYOFqesp56s6Dw-1
Received: by mail-qk1-f197.google.com with SMTP id bk21-20020a05620a1a1500b006b5c24695a4so1924838qkb.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbIFjjgDA4ooaBqJdaxSYkeX6CtTRCPcitxkJ2jJ7zw=;
        b=y6B08XesalBuaSj0WfQktwI00mSFFAyW1TmKOsktXA37A1e5oszQ476PIyyTLwXlXb
         PZ5BPjdGTiahmLgHDXzs9I9OFzTELnsMkdcdVfqAKUv7XKKz1FE0OwzApGev3xZraFzp
         +d/B/ligKOvr65JxL196wHu1dANQE0q3EEjWc+rHtMY2X5zP3CC1HTM/Tt2TEP14f5ph
         6agdkbaRGKavQEtrh749rGsoBzAShrK4kCgaaKAlMF6LsLfXgYWoRLxxjtNomtU9VVYb
         h2l73oizO7pitsFgtCnsPqtuA/MFClXjJLXZGA1LjMY/4u1AT0me0qTbVeyqwWCe5XQQ
         55FQ==
X-Gm-Message-State: AJIora/HpyqoT5OrKc5NWET5LdtF0ubyOQydtF3x7ifYu7OaX9arGMvX
        N+JpVGqjgpaMp++Wuz1wFX6/3XOqkWp1KwwssjkqDSlV09Pf/AKAtfkfnyuzUpJkB6MivWb2F7s
        CLiEYdz5/uEyzon8HIoqLZy9FEKXiVNxrqSvTAsdiAsxEApTMe0oS1PXHG5LX+cXANifvRBuFzQ
        ==
X-Received: by 2002:a05:620a:4512:b0:6b6:2fe:6dc3 with SMTP id t18-20020a05620a451200b006b602fe6dc3mr9582942qkp.124.1658428423988;
        Thu, 21 Jul 2022 11:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vyEE7j8jfEYZlnYclQKsnWvrL6a7mIg2DOWksGCUaTXhUXJZfkl0sPpefsfJuH4H4kzX7CcQ==
X-Received: by 2002:a05:620a:4512:b0:6b6:2fe:6dc3 with SMTP id t18-20020a05620a451200b006b602fe6dc3mr9582910qkp.124.1658428423448;
        Thu, 21 Jul 2022 11:33:43 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bj9-20020a05620a190900b006a6a7b4e7besm1878519qkb.109.2022.07.21.11.33.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Jul 2022 11:33:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 2/3] selftests: soft-dirty: Add test for mprotect
Date:   Thu, 21 Jul 2022 14:33:37 -0400
Message-Id: <20220721183338.27871-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220721183338.27871-1-peterx@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two soft-diryt test cases for mprotect() on both anon or file.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/soft-dirty.c | 69 ++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
index 08ab62a4a9d0..7d93906aa43f 100644
--- a/tools/testing/selftests/vm/soft-dirty.c
+++ b/tools/testing/selftests/vm/soft-dirty.c
@@ -121,13 +121,78 @@ static void test_hugepage(int pagemap_fd, int pagesize)
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
+		unlink(fname);
+		test_fd = open(fname, O_RDWR | O_CREAT);
+		if (test_fd < 0) {
+			ksft_test_result_skip("Test %s huge page allocation\n", __func__);
+			return;
+		}
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
+	if (!anon) {
+		close(test_fd);
+		unlink(fname);
+	}
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
@@ -138,6 +203,8 @@ int main(int argc, char **argv)
 	test_simple(pagemap_fd, pagesize);
 	test_vma_reuse(pagemap_fd, pagesize);
 	test_hugepage(pagemap_fd, pagesize);
+	test_mprotect_anon(pagemap_fd, pagesize);
+	test_mprotect_file(pagemap_fd, pagesize);
 
 	close(pagemap_fd);
 
-- 
2.32.0

