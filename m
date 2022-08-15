Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47189592887
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiHOEPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbiHOEPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:15:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DFE14088
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660536913; x=1692072913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P+SYU9cTeui4ntbsYjOdd9WQd3XioWrSFFVkN1SOniI=;
  b=cQBPOsdlmNayMNpdOztA9Zw/Z37fKqM56jruxqlPG8Otz0yAmmdO8YAu
   xDd786FbkuZXZ/CaTRELtgJ0HfisukrqUt8nWMt2kXVjR9KKpA8ZQqlHH
   7rySO6Zu3w4c/ikafDdFt1jSWhmO3cQIFEo0sQzArsGCvj9pFgJy7jKMq
   oMvdTvaMnBkA+2kBzqpm4IjGJdcjSj+7SxAQNsl+bbSdyBhskFYdw5NIC
   OfNsnUoenYVMLNVAATan4tbp368X48kuaZHfmreHPKHbNzTMaZXQ9vI1+
   +ELONO5cH8PteII4IdFDBxr3cF7a6k5ob2ZrROKMdq4Ut19bIgsGFiY7I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317867219"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="317867219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="732818298"
Received: from dmalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.26])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:07 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 90A89104A6F; Mon, 15 Aug 2022 07:18:04 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weihong Zhang <weihong.zhang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 10/11] selftests/x86/lam: Add io_uring test cases for linear-address masking
Date:   Mon, 15 Aug 2022 07:18:02 +0300
Message-Id: <20220815041803.17954-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihong Zhang <weihong.zhang@intel.com>

LAM should be supported in kernel thread, using io_uring to verify LAM feature.
The test cases implement read a file through io_uring, the test cases choose an
iovec array as receiving buffer, which used to receive data, according to LAM
mode, set metadata in high bits of these buffer.

io_uring can deal with these buffers that pointed to pointers with the metadata
in high bits.

Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 tools/testing/selftests/x86/lam.c | 341 +++++++++++++++++++++++++++++-
 1 file changed, 339 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index e9e92ab7fea8..19208ba6047a 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -9,8 +9,12 @@
 #include <sys/mman.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <inttypes.h>
 
+#include <sys/uio.h>
+#include <linux/io_uring.h>
 #include "../kselftest.h"
 
 #ifndef __x86_64__
@@ -30,8 +34,9 @@
 #define FUNC_BITS               0x2
 #define FUNC_MMAP               0x4
 #define FUNC_SYSCALL            0x8
+#define FUNC_URING              0x10
 
-#define TEST_MASK               0xf
+#define TEST_MASK               0x1f
 
 #define LOW_ADDR                (0x1UL << 30)
 #define HIGH_ADDR               (0x3UL << 48)
@@ -40,6 +45,13 @@
 
 #define PAGE_SIZE               (4 << 10)
 
+#define barrier() ({						\
+		   __asm__ __volatile__("" : : : "memory");	\
+})
+
+#define URING_QUEUE_SZ 1
+#define URING_BLOCK_SZ 2048
+
 struct testcases {
 	unsigned int later;
 	int expected; /* 2: SIGSEGV Error; 1: other errors */
@@ -49,6 +61,33 @@ struct testcases {
 	const char *msg;
 };
 
+/* Used by CQ of uring, source file handler and file's size */
+struct file_io {
+	int file_fd;
+	off_t file_sz;
+	struct iovec iovecs[];
+};
+
+struct io_uring_queue {
+	unsigned int *head;
+	unsigned int *tail;
+	unsigned int *ring_mask;
+	unsigned int *ring_entries;
+	unsigned int *flags;
+	unsigned int *array;
+	union {
+		struct io_uring_cqe *cqes;
+		struct io_uring_sqe *sqes;
+	} queue;
+	size_t ring_sz;
+};
+
+struct io_ring {
+	int ring_fd;
+	struct io_uring_queue sq_ring;
+	struct io_uring_queue cq_ring;
+};
+
 int tests_cnt;
 jmp_buf segv_env;
 
@@ -285,6 +324,285 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
+{
+	return (int)syscall(__NR_io_uring_setup, entries, p);
+}
+
+int sys_uring_enter(int fd, unsigned int to, unsigned int min, unsigned int flags)
+{
+	return (int)syscall(__NR_io_uring_enter, fd, to, min, flags, NULL, 0);
+}
+
+/* Init submission queue and completion queue */
+int mmap_io_uring(struct io_uring_params p, struct io_ring *s)
+{
+	struct io_uring_queue *sring = &s->sq_ring;
+	struct io_uring_queue *cring = &s->cq_ring;
+
+	sring->ring_sz = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
+	cring->ring_sz = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
+
+	if (p.features & IORING_FEAT_SINGLE_MMAP) {
+		if (cring->ring_sz > sring->ring_sz)
+			sring->ring_sz = cring->ring_sz;
+
+		cring->ring_sz = sring->ring_sz;
+	}
+
+	void *sq_ptr = mmap(0, sring->ring_sz, PROT_READ | PROT_WRITE,
+			    MAP_SHARED | MAP_POPULATE, s->ring_fd,
+			    IORING_OFF_SQ_RING);
+
+	if (sq_ptr == MAP_FAILED) {
+		perror("sub-queue!");
+		return 1;
+	}
+
+	void *cq_ptr = sq_ptr;
+
+	if (!(p.features & IORING_FEAT_SINGLE_MMAP)) {
+		cq_ptr = mmap(0, cring->ring_sz, PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_POPULATE, s->ring_fd,
+			      IORING_OFF_CQ_RING);
+		if (cq_ptr == MAP_FAILED) {
+			perror("cpl-queue!");
+			munmap(sq_ptr, sring->ring_sz);
+			return 1;
+		}
+	}
+
+	sring->head = sq_ptr + p.sq_off.head;
+	sring->tail = sq_ptr + p.sq_off.tail;
+	sring->ring_mask = sq_ptr + p.sq_off.ring_mask;
+	sring->ring_entries = sq_ptr + p.sq_off.ring_entries;
+	sring->flags = sq_ptr + p.sq_off.flags;
+	sring->array = sq_ptr + p.sq_off.array;
+
+	/* Map a queue as mem map */
+	s->sq_ring.queue.sqes = mmap(0, p.sq_entries * sizeof(struct io_uring_sqe),
+				     PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+				     s->ring_fd, IORING_OFF_SQES);
+	if (s->sq_ring.queue.sqes == MAP_FAILED) {
+		munmap(sq_ptr, sring->ring_sz);
+		if (sq_ptr != cq_ptr) {
+			ksft_print_msg("failed to mmap uring queue!");
+			munmap(cq_ptr, cring->ring_sz);
+			return 1;
+		}
+	}
+
+	cring->head = cq_ptr + p.cq_off.head;
+	cring->tail = cq_ptr + p.cq_off.tail;
+	cring->ring_mask = cq_ptr + p.cq_off.ring_mask;
+	cring->ring_entries = cq_ptr + p.cq_off.ring_entries;
+	cring->queue.cqes = cq_ptr + p.cq_off.cqes;
+
+	return 0;
+}
+
+/* Init io_uring queues */
+int setup_io_uring(struct io_ring *s)
+{
+	struct io_uring_params para;
+
+	memset(&para, 0, sizeof(para));
+	s->ring_fd = sys_uring_setup(URING_QUEUE_SZ, &para);
+	if (s->ring_fd < 0)
+		return 1;
+
+	return mmap_io_uring(para, s);
+}
+
+/*
+ * Get data from completion queue. the data buffer saved the file data
+ * return 0: success; others: error;
+ */
+int handle_uring_cq(struct io_ring *s)
+{
+	struct file_io *fi = NULL;
+	struct io_uring_queue *cring = &s->cq_ring;
+	struct io_uring_cqe *cqe;
+	unsigned int head;
+	off_t len = 0;
+
+	head = *cring->head;
+
+	do {
+		barrier();
+		if (head == *cring->tail)
+			break;
+		/* Get the entry */
+		cqe = &cring->queue.cqes[head & *s->cq_ring.ring_mask];
+		fi = (struct file_io *)cqe->user_data;
+		if (cqe->res < 0)
+			break;
+
+		int blocks = (int)(fi->file_sz + URING_BLOCK_SZ - 1) / URING_BLOCK_SZ;
+
+		for (int i = 0; i < blocks; i++)
+			len += fi->iovecs[i].iov_len;
+
+		head++;
+	} while (1);
+
+	*cring->head = head;
+	barrier();
+
+	return (len != fi->file_sz);
+}
+
+/*
+ * Submit squeue. specify via IORING_OP_READV.
+ * the buffer need to be set metadata according to LAM mode
+ */
+int handle_uring_sq(struct io_ring *ring, struct file_io *fi, unsigned long lam)
+{
+	int file_fd = fi->file_fd;
+	struct io_uring_queue *sring = &ring->sq_ring;
+	unsigned int index = 0, cur_block = 0, tail = 0, next_tail = 0;
+	struct io_uring_sqe *sqe;
+
+	off_t remain = fi->file_sz;
+	int blocks = (int)(remain + URING_BLOCK_SZ - 1) / URING_BLOCK_SZ;
+
+	while (remain) {
+		off_t bytes = remain;
+		void *buf;
+
+		if (bytes > URING_BLOCK_SZ)
+			bytes = URING_BLOCK_SZ;
+
+		fi->iovecs[cur_block].iov_len = bytes;
+
+		if (posix_memalign(&buf, URING_BLOCK_SZ, URING_BLOCK_SZ))
+			return 1;
+
+		fi->iovecs[cur_block].iov_base = (void *)get_metadata((uint64_t)buf, lam);
+		remain -= bytes;
+		cur_block++;
+	}
+
+	next_tail = *sring->tail;
+	tail = next_tail;
+	next_tail++;
+
+	barrier();
+
+	index = tail & *ring->sq_ring.ring_mask;
+
+	sqe = &ring->sq_ring.queue.sqes[index];
+	sqe->fd = file_fd;
+	sqe->flags = 0;
+	sqe->opcode = IORING_OP_READV;
+	sqe->addr = (unsigned long)fi->iovecs;
+	sqe->len = blocks;
+	sqe->off = 0;
+	sqe->user_data = (uint64_t)fi;
+
+	sring->array[index] = index;
+	tail = next_tail;
+
+	if (*sring->tail != tail) {
+		*sring->tail = tail;
+		barrier();
+	}
+
+	if (sys_uring_enter(ring->ring_fd, 1, 1, IORING_ENTER_GETEVENTS) < 0)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Test LAM in async I/O and io_uring, read current binery through io_uring
+ * Set metadata in pointers to iovecs buffer.
+ */
+int do_uring(unsigned long lam)
+{
+	struct io_ring *ring;
+	struct file_io *fi;
+	struct stat st;
+	int ret = 1;
+	char path[PATH_MAX];
+
+	/* get current process path */
+	if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+		return 1;
+
+	int file_fd = open(path, O_RDONLY);
+
+	if (file_fd < 0)
+		return 1;
+
+	if (fstat(file_fd, &st) < 0)
+		return 1;
+
+	off_t file_sz = st.st_size;
+
+	int blocks = (int)(file_sz + URING_BLOCK_SZ - 1) / URING_BLOCK_SZ;
+
+	fi = malloc(sizeof(*fi) + sizeof(struct iovec) * blocks);
+	if (!fi)
+		return 1;
+
+	fi->file_sz = file_sz;
+	fi->file_fd = file_fd;
+
+	ring = malloc(sizeof(*ring));
+	if (!ring)
+		return 1;
+
+	memset(ring, 0, sizeof(struct io_ring));
+
+	if (setup_io_uring(ring))
+		goto out;
+
+	if (handle_uring_sq(ring, fi, lam))
+		goto out;
+
+	ret = handle_uring_cq(ring);
+
+out:
+	free(ring);
+
+	for (int i = 0; i < blocks; i++) {
+		if (fi->iovecs[i].iov_base) {
+			uint64_t addr = ((uint64_t)fi->iovecs[i].iov_base);
+
+			switch (lam) {
+			case LAM_U57_BITS: /* Clear bits 62:57 */
+				addr = (addr & ~(0x3fULL << 57));
+				break;
+			}
+			free((void *)addr);
+			fi->iovecs[i].iov_base = NULL;
+		}
+	}
+
+	free(fi);
+
+	return ret;
+}
+
+int handle_uring(struct testcases *test)
+{
+	int ret = 0;
+
+	if (test->later == 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			return 1;
+
+	if (sigsetjmp(segv_env, 1) == 0) {
+		signal(SIGSEGV, segv_handler);
+		ret = do_uring(test->lam);
+	} else {
+		ret = 2;
+	}
+
+	return ret;
+}
+
 static int fork_test(struct testcases *test)
 {
 	int ret, child_ret;
@@ -324,6 +642,22 @@ static void run_test(struct testcases *test, int count)
 	}
 }
 
+static struct testcases uring_cases[] = {
+	{
+		.later = 0,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_uring,
+		.msg = "URING: LAM_U57. Dereferencing pointer with metadata\n",
+	},
+	{
+		.later = 1,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_uring,
+		.msg = "URING:[Negtive] Disable LAM. Dereferencing pointer with metadata.\n",
+	},
+};
+
 static struct testcases malloc_cases[] = {
 	{
 		.later = 0,
@@ -394,7 +728,7 @@ static void cmd_help(void)
 {
 	printf("usage: lam [-h] [-t test list]\n");
 	printf("\t-t test list: run tests specified in the test list, default:0x%x\n", TEST_MASK);
-	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap; 0x8:syscall.\n");
+	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap; 0x8:syscall; 0x10:io_uring.\n");
 	printf("\t-h: help\n");
 }
 
@@ -440,6 +774,9 @@ int main(int argc, char **argv)
 	if (tests & FUNC_SYSCALL)
 		run_test(syscall_cases, ARRAY_SIZE(syscall_cases));
 
+	if (tests & FUNC_URING)
+		run_test(uring_cases, ARRAY_SIZE(uring_cases));
+
 	ksft_set_plan(tests_cnt);
 
 	return ksft_exit_pass();
-- 
2.35.1

