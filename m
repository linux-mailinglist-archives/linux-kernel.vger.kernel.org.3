Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22015590EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiHLKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiHLKNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:13:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3CABF11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so515166pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IpSj0Sq8UAMHTbMdNu1xXveZ87+P76UE2ASjQ2JMJlc=;
        b=Nzmqou1m1In9MEM2g6XrvC75pcAb7kJ7eyXkF5G3pNQ1KGFCkkyhZfm1FFOMzJL8Sb
         wEkhoXPBtVUH5kcH+b8mNITQ7WOfpj16nsHRj9Dv9HdQL05a9784KOy2dcDMhvU4wnNC
         PIyuwsvQq6NmuOO6Vv905QkLU48asuhCGtImT8342gCyX1tdxXfBGpoB5biLMsDGsDpE
         V309aXZ2t2fOPMlLSQIOqpHN0iOlzMy0nc+1GtU5K8KiAxv02k6asHbWnRKQ3wR8l3n1
         fcYDgMSqIhiTp5uihoTIi1u2SFhpVeIdtRfFP4z7ZxXmEuBaSCfF+/eOQy4DNTtbAz/u
         hqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IpSj0Sq8UAMHTbMdNu1xXveZ87+P76UE2ASjQ2JMJlc=;
        b=QOKH1euSjzWNn+jq59vVDFNnc8bYzeJ1vVNY4BQn1ImXLdLBqYPhXTg9Ht6JV/3MLe
         d+8R+hDe2NOZA6JUjXJXFueMjxK9TtClng6FNoDAombG6Gv0tTElcYxEZ1sPtiFM9T7x
         zLK382QXeH6GOZ4+aNDDsd/M+HDff8rBUQwW08b3qYW4mYLpTQTHkqpVA3n1VM1ZDzKW
         jMumFy+hXR+z0WObQ7C6/7RYGeZuWVSw1tTwYQk6CtUkai05R4XBgJSnTeAQSVLCHAdZ
         5MTG/V/voqE4FhAurHPt/CPpFUHh38NLX+b2S09VaXsPHXRnWS49jAhQT3aRT41TL8mB
         yWSA==
X-Gm-Message-State: ACgBeo0L2zCIOsf0tIgJyqspzZaEb2sF0WPrDtszgWj2kfvHY/3AHvDU
        h8M7a8Imw8KhDtbpiQ96ZY0=
X-Google-Smtp-Source: AA6agR5vit+nBjvOQAz7r9uQj9RxdtIsJCGv8WzecvBLL3ZBrv4ebR8a0On4oWsQTEsB6a1yW2o+sw==
X-Received: by 2002:a17:903:1104:b0:16c:2f71:7803 with SMTP id n4-20020a170903110400b0016c2f717803mr3415537plh.101.1660299158168;
        Fri, 12 Aug 2022 03:12:38 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v127-20020a626185000000b0052aaff953aesm1204839pfb.115.2022.08.12.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:12:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     hughd@google.com, izik.eidus@ravellosystems.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn, CGEL <cgel.zte@gmail.com>
Subject: [PATCH v2 5/5] ksm: add tests of ksm auto mode
Date:   Fri, 12 Aug 2022 10:12:33 +0000
Message-Id: <20220812101233.41695-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101102.41422-1-xu.xin16@zte.com.cn>
References: <20220812101102.41422-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add tests to verify the effectiveness and cpu consumption of auto
mode of KSM. The tests requires no other MERGEABLE-madvised vm areas
in system than the areas our testing process allocs.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: CGEL <cgel.zte@gmail.com>
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/test-ksm-auto.c | 273 +++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 tools/testing/selftests/vm/test-ksm-auto.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31e5eea2a9b9..1cd8816c055d 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -34,3 +34,4 @@ local_config.*
 soft-dirty
 split_huge_page_test
 ksm_tests
+test-ksm-auto
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d9fa6a9ea584..002d9482c37f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -54,6 +54,7 @@ TEST_GEN_FILES += userfaultfd
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
+TEST_GEN_FILES += test-ksm-auto
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/test-ksm-auto.c b/tools/testing/selftests/vm/test-ksm-auto.c
new file mode 100644
index 000000000000..0d71593e008e
--- /dev/null
+++ b/tools/testing/selftests/vm/test-ksm-auto.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ucontext.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+
+#define KSM_CLEAR_MODE  "2\n"
+#define KSM_NORMAL_MODE "1\n"
+#define KSM_AUTO_MODE   "8\n"
+
+#define PAGESIZE	(4*1024)
+/* Don't change the value, it will afffect the result */
+#define TOTAL_MADVISE_SIZE	(300*1024*1024)
+
+char *ksm_run_file = "/sys/kernel/mm/ksm/run";
+char *ksm_auto_threshold_file = "/sys/kernel/mm/ksm/auto_threshold";
+char *ksm_pages_volatile_file = "/sys/kernel/mm/ksm/pages_volatile";
+char *ksm_pages_sharing_file = "/sys/kernel/mm/ksm/pages_sharing";
+
+#define SHAPE_FULL          1
+#define SHAPE_SPARSE        2
+/* They are related to the shape of memory */
+int final_pages[3] = {0, 76500, 42};
+
+static char *mmap_and_madvise(long long size, int advise)
+{
+	char *ptr;
+	int err;
+
+	err = 0;
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (!ptr)
+		return NULL;
+
+	err = madvise(ptr, size, advise);
+	if (err) {
+		perror("Madvise failed\n");
+		free(ptr);
+		return NULL;
+	}
+
+	return ptr;
+}
+
+void make_samepage_ares(char *ptr, int size, int shape_type)
+{
+	int i, j;
+	char rnd_num;
+
+	switch (shape_type) {
+	case SHAPE_FULL:
+		for (i = 0; i < (size / PAGESIZE); i++)
+			memset(ptr + (i * PAGESIZE), 0x1, PAGESIZE);
+		break;
+	case SHAPE_SPARSE:
+		/* Make pages different */
+		j = 0;
+		for (i = 1; i < (size / PAGESIZE); i++) {
+			ptr[i * PAGESIZE + (j%PAGESIZE)] = j%127 + 1;
+			j++;
+		}
+		for (i = 0; i < (size / PAGESIZE); i += 1800)
+			memset(ptr + (i * PAGESIZE), -1, PAGESIZE);
+	}
+
+	return;
+}
+
+int read_file(char *file, char *buffer, int buf_len)
+{
+	FILE *fp;
+	size_t result;
+	long lSize;
+
+	fp = fopen(file, "r");
+	if (!fp)
+		return -1;
+
+	fseek(fp, 0, SEEK_END);
+	lSize = ftell(fp);
+	rewind(fp);
+
+	memset(buffer, 0, buf_len);
+	result = fread(buffer, 1, buf_len, fp);
+	if (result == 0)
+		return -1;
+
+	fclose(fp);
+
+	return 0;
+}
+
+int write_file(char *file, const char *buffer, int len)
+{
+	FILE *fp;
+	size_t result;
+
+	fp = fopen(file, "w+");
+	if (!fp)
+		return -1;
+
+	result = fwrite(buffer, len, 1, fp);
+	if (result == 0)
+		return -1;
+
+	fclose(fp);
+
+	return 0;
+}
+
+static inline void get_orig_info(int *run, int *auto_threshold)
+{
+	char buffer[50];
+
+	/* Read the original state of ksm/run */
+	if (read_file(ksm_run_file, buffer, sizeof(buffer))) {
+		printf("read file %s failed\n", ksm_run_file);
+		exit(1);
+	}
+	*run = atoi(buffer);
+
+	if (read_file(ksm_auto_threshold_file, buffer, sizeof(buffer))) {
+		printf("read file: %s failed\n", ksm_auto_threshold_file);
+		exit(1);
+	}
+	*auto_threshold = atoi(buffer);
+}
+
+static inline void restore_orig_state(int run, int auto_threshold)
+{
+	char buffer[50];
+
+	/* restore the original state */
+	memset(buffer, 0, sizeof(buffer));
+	snprintf(buffer, sizeof(buffer) - 1, "%d\n", run);
+	if (write_file(ksm_run_file, buffer, sizeof(buffer))) {
+		printf("write file %s failed\n", ksm_run_file);
+		exit(1);
+	}
+
+	memset(buffer, 0, sizeof(buffer));
+	snprintf(buffer, sizeof(buffer) - 1, "%d\n", auto_threshold);
+	if (write_file(ksm_auto_threshold_file, buffer, sizeof(buffer))) {
+		printf("write file %s failed\n", ksm_run_file);
+		exit(1);
+	}
+}
+
+void set_ksmd_run_mode(char *mode)
+{
+	if (write_file(ksm_run_file, mode, 2)) {
+		printf("Failed: write 1 to %s\n", ksm_auto_threshold_file);
+		exit(1);
+	}
+}
+
+static inline void wait_ksmpages_converged(int final_pages)
+{
+	int pages_sharing;
+	char buffer[50];
+
+	for (;;) {
+		if (read_file(ksm_pages_sharing_file, buffer, sizeof(buffer))) {
+			printf("read file %s failed\n", ksm_pages_sharing_file);
+			exit(1);
+		}
+
+		pages_sharing = atoi(buffer);
+		if (pages_sharing >= final_pages)
+			break;
+	}
+}
+
+void print_shape(int shape_type)
+{
+	switch (shape_type) {
+	case SHAPE_FULL:
+		printf("Now the shape of memory area is full-samepages:\n");
+		printf("[xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]\n\n");
+		break;
+	case SHAPE_SPARSE:
+		printf("Now the shape of memory area is sparse-samepages:\n");
+		printf("[xx]          [xx]          [xx]   \n\n");
+		break;
+	}
+}
+
+void print_ksmd_cpu_comsuption(void)
+{
+	system("(ps x| grep \"ksmd\" | grep -v grep | awk \'{print $1}\' |"
+	       " xargs -i cat /proc/{}/stat) | awk \'{print \"ksm current "
+		   "cpu total slice: \"  $14+$15+$16+$17}\'");
+}
+
+void test_ksmd_performance(char *madvise_area, int shape_type)
+{
+	struct timeval tv_start, tv_end;
+
+	make_samepage_ares(madvise_area, TOTAL_MADVISE_SIZE, shape_type);
+	print_shape(shape_type);
+
+	/********* Start to time ksmd's normal-run mode **********/
+	printf("Start to test normal-run ksmd...\n");
+
+	print_ksmd_cpu_comsuption();
+
+	set_ksmd_run_mode(KSM_CLEAR_MODE);
+	set_ksmd_run_mode(KSM_NORMAL_MODE);
+
+	gettimeofday(&tv_start, NULL);
+
+	wait_ksmpages_converged(final_pages[shape_type]);
+
+	gettimeofday(&tv_end, NULL);
+	printf("ksm normal-run's merging time: %lf seconds\n",
+	       ((tv_end.tv_sec * 1000000 + tv_end.tv_usec) -
+	       (tv_start.tv_sec * 1000000 + tv_start.tv_usec))/1000000.0);
+
+	/******* Start to time ksmd's auto-run mode **********/
+	print_ksmd_cpu_comsuption();
+
+	printf("Start to test auto-run ksmd...\n");
+	set_ksmd_run_mode(KSM_CLEAR_MODE);
+	set_ksmd_run_mode(KSM_AUTO_MODE);
+	if (write_file(ksm_auto_threshold_file, "99\n", 2))
+		printf("Failed: write 1 to %s\n", ksm_auto_threshold_file);
+
+	gettimeofday(&tv_start, NULL);
+
+	wait_ksmpages_converged(shape_type);
+
+	gettimeofday(&tv_end, NULL);
+	printf("ksm auto-run's merging time: %lf seconds\n",
+		((tv_end.tv_sec * 1000000 + tv_end.tv_usec) -
+		(tv_start.tv_sec * 1000000 + tv_start.tv_usec))/1000000.0);
+
+	print_ksmd_cpu_comsuption();
+}
+
+int main(int argc, char **argv)
+{
+	char *madvise_area;
+	int orig_run, orig_auto_threshold;
+
+	/* Get the original state of ksm */
+	get_orig_info(&orig_run, &orig_auto_threshold);
+	printf("Now we mmap 300MB anouymous memory for testing.\n"
+		"There are two type of TEST which have different shape of\n"
+		"samepage areas.\n"
+		"Note: the test requires no other MERGEABLE-madvised vm areas\n"
+		"in system than the areas our testing process allocs.\n");
+	madvise_area = mmap_and_madvise(TOTAL_MADVISE_SIZE, MADV_MERGEABLE);
+	if (!madvise_area) {
+		printf("madvise failed\n");
+		exit(1);
+	}
+
+	printf("\n****************** TEST 1 ******************\n");
+	test_ksmd_performance(madvise_area, SHAPE_FULL);
+	printf("\n****************** TEST 2 ******************\n");
+	test_ksmd_performance(madvise_area, SHAPE_SPARSE);
+
+	/* Restore the original state */
+	restore_orig_state(orig_run, orig_auto_threshold);
+
+	return 0;
+}
-- 
2.25.1

