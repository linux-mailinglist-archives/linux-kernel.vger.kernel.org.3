Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2104C4F929D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiDHKMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiDHKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:12:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345EA9940
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:10:08 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZYq76kfGzgYZZ;
        Fri,  8 Apr 2022 18:08:19 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 18:10:05 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <palmer@dabbelt.com>, <liaochang1@huawei.com>
CC:     <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <bjorn.topel@gmail.com>,
        <ebiederm@xmission.com>, <guoren@linux.alibaba.com>,
        <jszhang@kernel.org>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <mick@ics.forth.gr>, <paul.walmsley@sifive.com>,
        <penberg@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 -next 0/6] riscv: kexec: add kexec_file_load() support
Date:   Fri, 8 Apr 2022 18:09:08 +0800
Message-ID: <20220408100914.150110-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
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

This patchset implement kexec_file_load() support on riscv, Most of the
code is based on the kexec-tool-patch repo developed by Nick Kossifids.

This patch series enables us to load the riscv vmlinux by specifying
its file decriptor, instead of user-filled buffer via kexec_file_load()
syscall.
``
Contrary to kexec_load() system call, we reuse the dt blob of the first
kernel to the 2nd explicitly.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' options must be specified. The patch for kexec_tools has
to be apply to riscv architecture source like this:

int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
	...
	if (info->file_mode) {
		return prepare_kexec_file_options(info);
	}
	...

Add following routine to prepare cmdline_ptr, cmdline_len and initrd_fd
for syscall kexec_file_load:

int prepare_kexec_file_options(struct kexec_info *info)
{
	int fd;
	ssize_t result;
	struct stat stats;

	if (arch_options.cmdline) {
		info->command_line = (char *)arch_options.cmdline;
		info->command_line_len = strlen(info->command_line) + 1;
	}

	if (!arch_options.initrd_path) {
		info->initrd_fd = -1;
		return 0;
	}

	fd = open(arch_options.initrd_path, O_RDONLY | _O_BINARY);
	if (fd < 0) {
		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_path,
				strerror(errno));
		return -EINVAL;
	}
	result = fstat(fd, &stats);
	if (result < 0) {
		close(fd);
		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_path,
				strerror(errno));
		return -EINVAL;
	}
	info->initrd_fd = fd;
	return 0;
}

The basic usage of kexec_file is:
1) Reload capture kernel image:
$ kexec -s -l <riscv-vmlinux> --reuse-cmdline

2) Startup capture kernel:
$ kexec -e

For kdump:
1) Reload capture kernel image:
$ kexec -s -p <riscv-vmlinux> --reuse-cmdline

2) Do something to crash, like:
$ echo c > /proc/sysrq-trigger

v3:
 * Rebase on v5.18-rc1
 * Workaround for -Wmissing-prototypes

v2:
 * Support kdump
 * Support purgatory
 * Minor cleanups

Li Zhengyu (3):
  RISC-V: Support for kexec_file on panic
  RISC-V: Add purgatory
  RISC-V: Load purgatory in kexec_file

Liao Chang (3):
  kexec_file: Fix kexec_file.c build error for riscv platform
  RISC-V: use memcpy for kexec_file mode
  RISC-V: Add kexec_file support

 arch/riscv/Kbuild                      |   2 +
 arch/riscv/Kconfig                     |  17 +
 arch/riscv/include/asm/kexec.h         |   4 +
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/elf_kexec.c          | 448 +++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c      |   4 +-
 arch/riscv/kernel/machine_kexec_file.c |  14 +
 arch/riscv/purgatory/.gitignore        |   4 +
 arch/riscv/purgatory/Makefile          |  95 ++++++
 arch/riscv/purgatory/entry.S           |  47 +++
 arch/riscv/purgatory/purgatory.c       |  45 +++
 include/linux/kexec.h                  |   2 +-
 kernel/kexec_file.c                    |   4 +-
 13 files changed, 683 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/kernel/elf_kexec.c
 create mode 100644 arch/riscv/kernel/machine_kexec_file.c
 create mode 100644 arch/riscv/purgatory/.gitignore
 create mode 100644 arch/riscv/purgatory/Makefile
 create mode 100644 arch/riscv/purgatory/entry.S
 create mode 100644 arch/riscv/purgatory/purgatory.c

-- 
2.17.1

