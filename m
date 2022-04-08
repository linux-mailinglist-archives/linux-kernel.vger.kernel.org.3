Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD924F929E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiDHKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiDHKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:12:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB4AAB49
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:10:10 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZYrf4MJYzdZnh;
        Fri,  8 Apr 2022 18:09:38 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 18:10:07 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <palmer@dabbelt.com>, <liaochang1@huawei.com>
CC:     <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <bjorn.topel@gmail.com>,
        <ebiederm@xmission.com>, <guoren@linux.alibaba.com>,
        <jszhang@kernel.org>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <mick@ics.forth.gr>, <paul.walmsley@sifive.com>,
        <penberg@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 -next 4/6] RISC-V: Support for kexec_file on panic
Date:   Fri, 8 Apr 2022 18:09:12 +0800
Message-ID: <20220408100914.150110-5-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220408100914.150110-1-lizhengyu3@huawei.com>
References: <20220408100914.150110-1-lizhengyu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for loading a kexec on panic (kdump) kernel.
It has been tested with vmcore-dmesg on riscv64 QEMU on both an smp
and a non-smp system.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 arch/riscv/kernel/elf_kexec.c | 119 +++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 2d442a849871..911d65d5a123 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -18,6 +18,8 @@
 #include <linux/of.h>
 #include <linux/libfdt.h>
 #include <linux/types.h>
+#include <linux/memblock.h>
+#include <asm/setup.h>
 
 static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 				struct kexec_elf_info *elf_info, unsigned long old_pbase,
@@ -97,6 +99,79 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	return ret;
 }
 
+static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
+{
+	unsigned int *nr_ranges = arg;
+
+	(*nr_ranges)++;
+	return 0;
+}
+
+static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
+{
+	struct crash_mem *cmem = arg;
+
+	cmem->ranges[cmem->nr_ranges].start = res->start;
+	cmem->ranges[cmem->nr_ranges].end = res->end;
+	cmem->nr_ranges++;
+
+	return 0;
+}
+
+static int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	unsigned int nr_ranges;
+	int ret;
+
+	nr_ranges = 1; /* For exclusion of crashkernel region */
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+
+	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
+	if (!cmem)
+		return -ENOMEM;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
+	if (ret)
+		goto out;
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (!ret)
+		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+out:
+	kfree(cmem);
+	return ret;
+}
+
+static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
+				 unsigned long cmdline_len)
+{
+	int elfcorehdr_strlen;
+	char *cmdline_ptr;
+
+	cmdline_ptr = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
+	if (!cmdline_ptr)
+		return NULL;
+
+	elfcorehdr_strlen = sprintf(cmdline_ptr, "elfcorehdr=0x%lx ",
+		image->elf_load_addr);
+
+	if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
+		pr_err("Appending elfcorehdr=<addr> exceeds cmdline size\n");
+		kfree(cmdline_ptr);
+		return NULL;
+	}
+
+	memcpy(cmdline_ptr + elfcorehdr_strlen, cmdline, cmdline_len);
+	/* Ensure it's nul terminated */
+	cmdline_ptr[COMMAND_LINE_SIZE - 1] = '\0';
+	return cmdline_ptr;
+}
+
 static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 			    unsigned long kernel_len, char *initrd,
 			    unsigned long initrd_len, char *cmdline,
@@ -106,10 +181,12 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	unsigned long old_kernel_pbase = ULONG_MAX;
 	unsigned long new_kernel_pbase = 0UL;
 	unsigned long initrd_pbase = 0UL;
-	void *fdt;
+	unsigned long headers_sz;
+	void *fdt, *headers;
 	struct elfhdr ehdr;
 	struct kexec_buf kbuf;
 	struct kexec_elf_info elf_info;
+	char *modified_cmdline = NULL;
 
 	ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
 	if (ret)
@@ -130,6 +207,45 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	kbuf.image = image;
 	kbuf.buf_min = new_kernel_pbase + kernel_len;
 	kbuf.buf_max = ULONG_MAX;
+
+	/* Add elfcorehdr */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&headers, &headers_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out;
+		}
+
+		kbuf.buffer = headers;
+		kbuf.bufsz = headers_sz;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		kbuf.memsz = headers_sz;
+		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(headers);
+			goto out;
+		}
+		image->elf_headers = headers;
+		image->elf_load_addr = kbuf.mem;
+		image->elf_headers_sz = headers_sz;
+
+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		/* Setup cmdline for kdump kernel case */
+		modified_cmdline = setup_kdump_cmdline(image, cmdline,
+						       cmdline_len);
+		if (!modified_cmdline) {
+			pr_err("Setting up cmdline for kdump kernel failed\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		cmdline = modified_cmdline;
+	}
+
 	/* Add the initrd to the image */
 	if (initrd != NULL) {
 		kbuf.buffer = initrd;
@@ -170,6 +286,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 out_free_fdt:
 	kvfree(fdt);
 out:
+	kfree(modified_cmdline);
 	kexec_free_elf_info(&elf_info);
 	return ret ? ERR_PTR(ret) : NULL;
 }
-- 
2.17.1

