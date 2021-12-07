Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EB46BEF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhLGPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:17:35 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:45121 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhLGPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:17:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzneqvB_1638890029;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UzneqvB_1638890029)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 23:13:51 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] scripts: ftrace - move the sort-processing in ftrace_init
Date:   Tue,  7 Dec 2021 23:13:46 +0800
Message-Id: <20211207151348.54921-2-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211207151348.54921-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211207151348.54921-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel starts, the initialization of ftrace takes
up a portion of the time (approximately 6~8ms) to sort mcount
addresses. We can save this time by moving mcount-sorting to
compile time.

Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 kernel/trace/ftrace.c   |  11 +++-
 scripts/Makefile        |   6 +-
 scripts/link-vmlinux.sh |   6 +-
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 120 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30bc880c3849..9ca63df6553a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6406,8 +6406,15 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	sort(start, count, sizeof(*start),
-	     ftrace_cmp_ips, NULL);
+	/*
+	 * Sorting mcount in vmlinux at build time depend on
+	 * CONFIG_BUILDTIME_TABLE_SORT, while mcount loc in
+	 * modules can not be sorted at build time.
+	 */
+	if (!IS_ENABLED(CONFIG_BUILDTIME_TABLE_SORT) || mod) {
+		sort(start, count, sizeof(*start),
+		     ftrace_cmp_ips, NULL);
+	}
 
 	start_pg = ftrace_allocate_pages(count);
 	if (!start_pg)
diff --git a/scripts/Makefile b/scripts/Makefile
index 9adb6d247818..d27503469f4b 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -17,6 +17,7 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_SYSTEM_REVOCATION_LIST)	+= extract-cert
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
+HOSTLDLIBS_sorttable = -lpthread
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTCFLAGS_sign-file.o = $(CRYPTO_CFLAGS)
 HOSTLDLIBS_sign-file = $(CRYPTO_LIBS)
@@ -29,7 +30,10 @@ ARCH := x86
 endif
 HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
 HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
-HOSTLDLIBS_sorttable = -lpthread
+endif
+
+ifdef CONFIG_FUNCTION_TRACER
+HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
 # The following programs are only built on demand
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5cdd9bc5c385..dd9955f45774 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -400,6 +400,9 @@ if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
 	${RESOLVE_BTFIDS} vmlinux
 fi
 
+info SYSMAP System.map
+mksysmap vmlinux System.map
+
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	info SORTTAB vmlinux
 	if ! sorttable vmlinux; then
@@ -408,9 +411,6 @@ if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	fi
 fi
 
-info SYSMAP System.map
-mksysmap vmlinux System.map
-
 # step a (see comment above)
 if [ -n "${CONFIG_KALLSYMS}" ]; then
 	mksysmap ${kallsyms_vmlinux} .tmp_System.map
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index b7c2ad71f9cf..70bdc787ddfb 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -30,6 +30,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <errno.h>
+#include <pthread.h>
 
 #include <tools/be_byteshift.h>
 #include <tools/le_byteshift.h>
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..d1fbee1f81ef 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -19,6 +19,9 @@
 
 #undef extable_ent_size
 #undef compare_extable
+#undef get_mcount_loc
+#undef sort_mcount_loc
+#undef elf_mcount_loc
 #undef do_sort
 #undef Elf_Addr
 #undef Elf_Ehdr
@@ -41,6 +44,9 @@
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
 # define compare_extable	compare_extable_64
+# define get_mcount_loc		get_mcount_loc_64
+# define sort_mcount_loc	sort_mcount_loc_64
+# define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
 # define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
@@ -62,6 +68,9 @@
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
+# define get_mcount_loc		get_mcount_loc_32
+# define sort_mcount_loc	sort_mcount_loc_32
+# define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
 # define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
@@ -84,8 +93,6 @@
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 /* ORC unwinder only support X86_64 */
-#include <errno.h>
-#include <pthread.h>
 #include <asm/orc_types.h>
 
 #define ERRSTR_MAXSZ	256
@@ -191,7 +198,64 @@ static int compare_extable(const void *a, const void *b)
 		return 1;
 	return 0;
 }
+#ifdef MCOUNT_SORT_ENABLED
+struct elf_mcount_loc {
+	Elf_Ehdr *ehdr;
+	Elf_Shdr *init_data_sec;
+	uint_t start_mcount_loc;
+	uint_t stop_mcount_loc;
+};
+
+/* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
+static void *sort_mcount_loc(void *arg)
+{
+	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
+	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->sh_addr)
+					+ _r(&(emloc->init_data_sec)->sh_offset);
+	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	unsigned char *start_loc = (void *)emloc->ehdr + offset;
+
+	qsort(start_loc, count/sizeof(uint_t), sizeof(uint_t), compare_extable);
+	return NULL;
+}
+
+/* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
+static void get_mcount_loc(uint_t *_start, uint_t *_stop)
+{
+	FILE *file_start, *file_stop;
+	char start_buff[20];
+	char stop_buff[20];
+	int len = 0;
+
+	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
+	if (!file_start) {
+		fprintf(stderr, "get start_mcount_loc error!");
+		return;
+	}
+
+	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
+	if (!file_stop) {
+		fprintf(stderr, "get stop_mcount_loc error!");
+		pclose(file_start);
+		return;
+	}
+
+	while (fgets(start_buff, sizeof(start_buff), file_start) != NULL) {
+		len = strlen(start_buff);
+		start_buff[len - 1] = '\0';
+	}
+	*_start = strtoul(start_buff, NULL, 16);
+
+	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
+		len = strlen(stop_buff);
+		stop_buff[len - 1] = '\0';
+	}
+	*_stop = strtoul(stop_buff, NULL, 16);
 
+	pclose(file_start);
+	pclose(file_stop);
+}
+#endif
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
 		   table_sort_t custom_sort)
@@ -217,6 +281,12 @@ static int do_sort(Elf_Ehdr *ehdr,
 	int idx;
 	unsigned int shnum;
 	unsigned int shstrndx;
+#ifdef MCOUNT_SORT_ENABLED
+	struct elf_mcount_loc mstruct;
+	uint_t _start_mcount_loc = 0;
+	uint_t _stop_mcount_loc = 0;
+	pthread_t mcount_sort_thread;
+#endif
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
 	unsigned int orc_size = 0;
@@ -253,6 +323,17 @@ static int do_sort(Elf_Ehdr *ehdr,
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
 						      _r(&s->sh_offset));
 
+#ifdef MCOUNT_SORT_ENABLED
+		/* locate the .init.data section in vmlinux */
+		if (!strcmp(secstrings + idx, ".init.data")) {
+			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
+			mstruct.ehdr = ehdr;
+			mstruct.init_data_sec = s;
+			mstruct.start_mcount_loc = _start_mcount_loc;
+			mstruct.stop_mcount_loc = _stop_mcount_loc;
+		}
+#endif
+
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
@@ -294,6 +375,23 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 #endif
+
+#ifdef MCOUNT_SORT_ENABLED
+	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
+		fprintf(stderr,
+			"incomplete mcount's sort in file: %s\n",
+			fname);
+		goto out;
+	}
+
+	/* create thread to sort mcount_loc concurrently */
+	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
+		fprintf(stderr,
+			"pthread_create mcount_sort_thread failed '%s': %s\n",
+			strerror(errno), fname);
+		goto out;
+	}
+#endif
 	if (!extab_sec) {
 		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
 		goto out;
@@ -376,5 +474,23 @@ static int do_sort(Elf_Ehdr *ehdr,
 		}
 	}
 #endif
+
+#ifdef MCOUNT_SORT_ENABLED
+	if (mcount_sort_thread) {
+		void *retval = NULL;
+		/* wait for mcount sort done */
+		rc = pthread_join(mcount_sort_thread, &retval);
+		if (rc) {
+			fprintf(stderr,
+				"pthread_join failed '%s': %s\n",
+				strerror(errno), fname);
+		} else if (retval) {
+			rc = -1;
+			fprintf(stderr,
+				"failed to sort mcount '%s': %s\n",
+				(char *)retval, fname);
+		}
+	}
+#endif
 	return rc;
 }
-- 
2.27.0

