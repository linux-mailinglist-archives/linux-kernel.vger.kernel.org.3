Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB14AA0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiBDUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiBDT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578BC06177B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n98nGVb9Cb+XvLGLcWCumBllUZqlAwFV4o2oMVvKDzc=; b=cOdXsc5mMVDJurAC+imkmuYttX
        3OQsK0McDFwlZIciCYO6E5DH/6M0d69UVVeEwve9KYcFdsYomkwTXHMooUxJu23oEE5tq22dV5GCk
        YHU1nqo+L6rTpOCkw+/X6IIn40ciY/QvKg3KTvrCpMU6XlL+gTCIb7hRryxSwLU+Gw9UjRKPz8M/S
        bLtuJ05gTy+4xt4bVVNjV0D5jI5tgs70cVGawKf3TE26pVLqDhWOsM3Sfft8HbvuZ1lke4y9xybpt
        AyuawnkdC0aDDayzxFsLPS6D6dyB0SZnyRHwppLdZd3S0IZqGMhNvnMbfbR9KMFGqpvsrjvvwyEmf
        QMPK21rA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jc-007Ls3-Hy; Fri, 04 Feb 2022 19:59:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 75/75] selftests/vm/transhuge-stress: Support file-backed PMD folios
Date:   Fri,  4 Feb 2022 19:58:52 +0000
Message-Id: <20220204195852.1751729-76-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a -f <filename> option to test PMD folios on files

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/selftests/vm/transhuge-stress.c | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index 5e4c036f6ad3..a03cb3fce1f6 100644
--- a/tools/testing/selftests/vm/transhuge-stress.c
+++ b/tools/testing/selftests/vm/transhuge-stress.c
@@ -26,15 +26,17 @@
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
 
 int pagemap_fd;
+int backing_fd = -1;
+int mmap_flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
+#define PROT_RW (PROT_READ | PROT_WRITE)
 
 int64_t allocate_transhuge(void *ptr)
 {
 	uint64_t ent[2];
 
 	/* drop pmd */
-	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
-				MAP_FIXED | MAP_ANONYMOUS |
-				MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
+	if (mmap(ptr, HPAGE_SIZE, PROT_RW, MAP_FIXED | mmap_flags,
+		 backing_fd, 0) != ptr)
 		errx(2, "mmap transhuge");
 
 	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
@@ -60,6 +62,8 @@ int main(int argc, char **argv)
 	size_t ram, len;
 	void *ptr, *p;
 	struct timespec a, b;
+	int i = 0;
+	char *name = NULL;
 	double s;
 	uint8_t *map;
 	size_t map_len;
@@ -69,13 +73,23 @@ int main(int argc, char **argv)
 		ram = SIZE_MAX / 4;
 	else
 		ram *= sysconf(_SC_PAGESIZE);
+	len = ram;
+
+	while (++i < argc) {
+		if (!strcmp(argv[i], "-h"))
+			errx(1, "usage: %s [size in MiB]", argv[0]);
+		else if (!strcmp(argv[i], "-f"))
+			name = argv[++i];
+		else
+			len = atoll(argv[i]) << 20;
+	}
 
-	if (argc == 1)
-		len = ram;
-	else if (!strcmp(argv[1], "-h"))
-		errx(1, "usage: %s [size in MiB]", argv[0]);
-	else
-		len = atoll(argv[1]) << 20;
+	if (name) {
+		backing_fd = open(name, O_RDWR);
+		if (backing_fd == -1)
+			errx(2, "open %s", name);
+		mmap_flags = MAP_SHARED;
+	}
 
 	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
 	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
@@ -86,8 +100,7 @@ int main(int argc, char **argv)
 		err(2, "open pagemap");
 
 	len -= len % HPAGE_SIZE;
-	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
+	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_RW, mmap_flags, backing_fd, 0);
 	if (ptr == MAP_FAILED)
 		err(2, "initial mmap");
 	ptr += HPAGE_SIZE - (uintptr_t)ptr % HPAGE_SIZE;
-- 
2.34.1

