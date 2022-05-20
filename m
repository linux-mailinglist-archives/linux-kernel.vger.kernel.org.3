Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8F52EF88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351050AbiETPpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349477AbiETPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:45:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A471796FE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:45:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bh5so7683313plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TKNizaJK5LV6+xJVusK1AbXEur+gt5eyzd/+ohEFbaY=;
        b=cbN/jl0GfdcCtf/Azw/VXzbl8NsOZvJpRJyyTD+AbHq1BYKI3LM1h0PpeAlYhHq+n5
         FCJn6OcULWUXQIJHC41wz7U2Q986qMf3AkdouzPyfSkrTM7zmHNwr3q1TgXu9p7jhj84
         BZPcAzT+wCyCg/Ro6sIcdzv/RaJ0T8/iqhYK20uAlD2FXDg+M2Ednojx5ui6Xp3jfJYE
         PWLYnIVYnUw2nWa3ygJZ96nKj2ZdDtx1/lNGvWfXxprLFTPPstl5+4xS/tbUSivIw8MD
         dtvhtPix341ID51aOa/DfkHlqMU40lOlUsP1AJ67AGaD53eWuJNXQrEfVYiDRfXXIz/A
         jvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TKNizaJK5LV6+xJVusK1AbXEur+gt5eyzd/+ohEFbaY=;
        b=cZRb9UiaJrZdiRf8JSCvSFATzGz3p1ePvXYUhaMXJLB8eY4xA5Pj+zhK9EDFjGJ6a7
         +9DHmIDLWzyO2a/Imb/tepGAlX1yJNcsN1NWKCmwV+tb77/WvgsmtzWJQAyLx8NEDaSz
         j7ou/nuo8v705F3ZSyZPWkhfXLMtNYRhHe+o+hGK380ZfiZ1DL1Q/kVV6Nbzi5AlyG8P
         PU9CndIVA6gkH0f2KV7Fcqo3K2IyUuw5n2j8oBa5l8GpG45Q6nolMJIbw7C44Wd3lRt6
         E2OroufvkX3Cy5Qu4S30gTZ3dWcufvwjlKPh/x/0q3yB+Zu0X2eJnf0J1w1z/oWiE9ls
         v64Q==
X-Gm-Message-State: AOAM533iGMYll+JZaYcHfKuOEvR+90WyR3lBRdZbR+OJAkl0QAf/z6Sy
        IK2GJ1LDxKIUt1nOwiQ2s2RVug==
X-Google-Smtp-Source: ABdhPJymU5KjZ8xh9FuahgzKmV4QoYMqJBdt+CEAiub2X07vT+ut6dzIiIH/t7l8AltVjbDn7acZeg==
X-Received: by 2002:a17:90b:180f:b0:1df:cc0c:bbfd with SMTP id lw15-20020a17090b180f00b001dfcc0cbbfdmr11396565pjb.84.1653061522075;
        Fri, 20 May 2022 08:45:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090a1b8800b001d95cdb62d4sm1953007pjc.33.2022.05.20.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:21 -0700 (PDT)
Date:   Fri, 20 May 2022 08:45:21 -0700 (PDT)
X-Google-Original-Date: Fri, 20 May 2022 08:44:27 PDT (-0700)
Subject:     Re: [PATCH v3 -next 0/6] riscv: kexec: add kexec_file_load() support
In-Reply-To: <20220408100914.150110-1-lizhengyu3@huawei.com>
CC:     liaochang1@huawei.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
        Bjorn Topel <bjorn.topel@gmail.com>, ebiederm@xmission.com,
        guoren@linux.alibaba.com, jszhang@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mick@ics.forth.gr,
        Paul Walmsley <paul.walmsley@sifive.com>, penberg@kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     lizhengyu3@huawei.com
Message-ID: <mhng-86400921-7491-46ce-8248-d09a4d49f673@palmer-mbp2014>
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

On Fri, 08 Apr 2022 03:09:08 PDT (-0700), lizhengyu3@huawei.com wrote:
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
> v3:
>  * Rebase on v5.18-rc1
>  * Workaround for -Wmissing-prototypes
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
>  arch/riscv/purgatory/purgatory.c       |  45 +++
>  include/linux/kexec.h                  |   2 +-
>  kernel/kexec_file.c                    |   4 +-
>  13 files changed, 683 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/kernel/elf_kexec.c
>  create mode 100644 arch/riscv/kernel/machine_kexec_file.c
>  create mode 100644 arch/riscv/purgatory/.gitignore
>  create mode 100644 arch/riscv/purgatory/Makefile
>  create mode 100644 arch/riscv/purgatory/entry.S
>  create mode 100644 arch/riscv/purgatory/purgatory.c

This doesn't build on 32-bit, there's some issues both in the arch code 
and the generic code.  Looks like nobody else supports these bits on 
32-bit platforms, so I've restricted this to rv64 for now and sent along 
a patch set to fix everything up for 32-bit platforms.

This, with that minor Kconfig change just squashed in, is on for-next.  
It passes my tests, but I don't have anything specific to kexec_file() 
so that's probbaly not so exciting.

Thanks!
