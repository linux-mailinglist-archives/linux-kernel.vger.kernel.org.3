Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B324EE61B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbiDACjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiDACjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:39:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0152597F7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:37:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j13so1266308plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gBYCYz1bkk39xbyKo7MQ2WtVL9iFT5vSKgfWp7aQhV8=;
        b=BkEA7+Zl5MzzUQCvqogIhTJYYPvdJTk6PT+6zs0MxnDjQH+YH2K1/6WTZ/eunZ5MR0
         ZamaMNF/WT6f0OEZ7ZVanIV/AjhGLn5C6QKEGptHg13wc6+pqvTZk2nx9SVgCk2n8ul1
         tljAEF2v/OfMVEzet6sntz/e0xR7a2+S+VYZoROSrj8Gyutq8kKLKhJEN1UyLP0rbQy2
         MmD9yc7afum0nmGu9QpMBpWRgX9lMwnyXW7Ti5obmKnExR97CTP60yiHH9iZVf4piq+8
         Q32wbs5ftGOOhWsEPNIVNCzt3g8nNCzgPdC2LvKIjiBeCQc1Ec6D6fgZI3KwX13HaTYj
         l0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gBYCYz1bkk39xbyKo7MQ2WtVL9iFT5vSKgfWp7aQhV8=;
        b=6+dFM93A6JUskY4L6h6MHnStbqfjyXz1nUrbNEdut9u0hnsXH12m+w2VIyYm/q0K+T
         nhBalt/8gTQnK1ywpeAdRIYkR761i7/Ke75g7Ozp64aD6i1RkRBa6vLrBOzWIA8ely1x
         xtIQ6RJC5xgQhroAHszxZGoUMhQDQ62DQ+NpRUlNivNbSEO0KAj14AVKIMDLDKNm9up6
         ZoCJ3zw0/A9AWrzUv0BxqKVzAhJDIWv2Jal2ek5bjln6ogXmBPWdn/OmAUAAfTHvLTDV
         Pwq3KbikYHTv8KzYzUZ8xw1wtdutkod4wF4vTbicHbcHlIqqsCmWBJbD+u59M2LI0epy
         i1wQ==
X-Gm-Message-State: AOAM533O1UVnX/lj0+6dr84QtPS89XkW2k2Zrnue+qME8YRQIVszA/2n
        8K3OtmZBrzjGlfxbEPEYuvbV0A==
X-Google-Smtp-Source: ABdhPJygRK5APdtCoRrX/Zr1FLzYP83LYp5QO731w2mnNyypKr2ZxCP7OepqG94hBINlAwJrZsxTKA==
X-Received: by 2002:a17:902:be18:b0:153:2444:9c1a with SMTP id r24-20020a170902be1800b0015324449c1amr8465054pls.152.1648780654348;
        Thu, 31 Mar 2022 19:37:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b001c7c2919453sm10973632pjb.33.2022.03.31.19.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 19:37:33 -0700 (PDT)
Date:   Thu, 31 Mar 2022 19:37:33 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 17:13:10 PDT (-0700)
Subject:     Re: [PATCH v2 -next 0/6] riscv: kexec: add kexec_file_load() support
In-Reply-To: <20220330081701.177026-1-lizhengyu3@huawei.com>
CC:     liaochang1@huawei.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
        Bjorn Topel <bjorn.topel@gmail.com>, changbin.du@intel.com,
        ebiederm@xmission.com, guoren@linux.alibaba.com,
        jszhang@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        penberg@kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     lizhengyu3@huawei.com
Message-ID: <mhng-1152c6f3-80c2-4409-848b-b882bbe2cbb8@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 01:16:55 PDT (-0700), lizhengyu3@huawei.com wrote:
> This patchset implement kexec_file_load() support on riscv, Most of the
> code is based on the kexec-tool-patch repo developed by Nick Kossifids.
>
> This patch series enables us to load the riscv vmlinux by specifying
> its file decriptor, instead of user-filled buffer via kexec_file_load()
> syscall.
> ``
> Contrary to kexec_load() system call, we reuse the dt blob of the first
> kernel to the 2nd explicitly.
>
> To use kexec_file_load() system call, instead of kexec_load(), at kexec
> command, '-s' options must be specified. The patch for kexec_tools has
> to be apply to riscv architecture source like this:
>
> int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
> 	...
> 	if (info->file_mode) {
> 		return prepare_kexec_file_options(info);
> 	}
> 	...
>
> Add following routine to prepare cmdline_ptr, cmdline_len and initrd_fd
> for syscall kexec_file_load:
>
> int prepare_kexec_file_options(struct kexec_info *info)
> {
> 	int fd;
> 	ssize_t result;
> 	struct stat stats;
>
> 	if (arch_options.cmdline) {
> 		info->command_line = (char *)arch_options.cmdline;
> 		info->command_line_len = strlen(info->command_line) + 1;
> 	}
>
> 	if (!arch_options.initrd_path) {
> 		info->initrd_fd = -1;
> 		return 0;
> 	}
>
> 	fd = open(arch_options.initrd_path, O_RDONLY | _O_BINARY);
> 	if (fd < 0) {
> 		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_path,
> 				strerror(errno));
> 		return -EINVAL;
> 	}
> 	result = fstat(fd, &stats);
> 	if (result < 0) {
> 		close(fd);
> 		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_path,
> 				strerror(errno));
> 		return -EINVAL;
> 	}
> 	info->initrd_fd = fd;
> 	return 0;
> }
>
> The basic usage of kexec_file is:
> 1) Reload capture kernel image:
> $ kexec -s -l <riscv-vmlinux> --reuse-cmdline
>
> 2) Startup capture kernel:
> $ kexec -e
>
> For kdump:
> 1) Reload capture kernel image:
> $ kexec -s -p <riscv-vmlinux> --reuse-cmdline
>
> 2) Do something to crash, like:
> $ echo c > /proc/sysrq-trigger
>
> v2:
>  * Support kdump
>  * Support purgatory
>  * Minor cleanups
>
> Li Zhengyu (3):
>   RISC-V: Support for kexec_file on panic
>   RISC-V: Add purgatory
>   RISC-V: Load purgatory in kexec_file
>
> Liao Chang (3):
>   kexec_file: Fix kexec_file.c build error for riscv platform
>   RISC-V: use memcpy for kexec_file mode
>   RISC-V: Add kexec_file support
>
>  arch/riscv/Kbuild                      |   2 +
>  arch/riscv/Kconfig                     |  17 +
>  arch/riscv/include/asm/kexec.h         |   4 +
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/elf_kexec.c          | 448 +++++++++++++++++++++++++
>  arch/riscv/kernel/machine_kexec.c      |   4 +-
>  arch/riscv/kernel/machine_kexec_file.c |  14 +
>  arch/riscv/purgatory/.gitignore        |   4 +
>  arch/riscv/purgatory/Makefile          |  95 ++++++
>  arch/riscv/purgatory/entry.S           |  47 +++
>  arch/riscv/purgatory/purgatory.c       |  42 +++
>  include/linux/kexec.h                  |   2 +-
>  kernel/kexec_file.c                    |   4 +-
>  13 files changed, 680 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/kernel/elf_kexec.c
>  create mode 100644 arch/riscv/kernel/machine_kexec_file.c
>  create mode 100644 arch/riscv/purgatory/.gitignore
>  create mode 100644 arch/riscv/purgatory/Makefile
>  create mode 100644 arch/riscv/purgatory/entry.S
>  create mode 100644 arch/riscv/purgatory/purgatory.c

This seems like a reasonable way to do things, but I haven't looked over 
the code yet.  Looks like the autobuilders are finding some failures, 
and it's way too late for 5.18.  If you have time to fix the failures 
then it'd be great to have a version based on rc1 with these fixed, so 
we can target the next merge window.  That'll also make it easier to 
look this over on my end.

Thanks!
