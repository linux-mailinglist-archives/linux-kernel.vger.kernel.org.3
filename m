Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801A453E22D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiFFHNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFFHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:13:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5563A736
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:13:11 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGl5k2LY8zgYp0;
        Mon,  6 Jun 2022 15:11:22 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 15:13:08 +0800
Subject: Re: [PATCH] riscv: kexec: build
 {kexec_relocate,crash_save_regs,machine_kexec}.c as kexec core files
To:     Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Changbin Du <changbin.du@gmail.com>,
        Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220606035635.o52ja3bjpru3fqcf@M910t>
From:   "lizhengyu (E)" <lizhengyu3@huawei.com>
Message-ID: <56da43f4-605f-4d89-af7a-cdc7bc429f94@huawei.com>
Date:   Mon, 6 Jun 2022 15:13:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220606035635.o52ja3bjpru3fqcf@M910t>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but it has a solution already. See 
https://lore.kernel.org/all/20220601070204.26882-1-lizhengyu3@huawei.com/ .

On Mon, 06 Jun 2022 11:56:35 +0800, Changbin Du <changbin.du@huawei.com> 
wrote:
> This fixes below linking errors when building with CONFIG_KEXEC_FILE=y &&
> CONFIG_KEXEC=n. The {kexec_relocate,crash_save_regs,machine_kexec}.c should
> be core kexec source files.
>
> riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `kimage_free':
> /home/changbin/work/linux-riscv/kernel/kexec_core.c:651: undefined reference to `machine_kexec_cleanup'
> riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `__crash_kexec':
> /home/changbin/work/linux-riscv/kernel/kexec_core.c:981: undefined reference to `machine_crash_shutdown'
> riscv64-linux-gnu-ld: /home/changbin/work/linux-riscv/kernel/kexec_core.c:982: undefined reference to `machine_kexec'
> riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `crash_setup_regs':
> /home/changbin/work/linux-riscv/./arch/riscv/include/asm/kexec.h:35: undefined reference to `riscv_crash_save_regs'
> riscv64-linux-gnu-ld: kernel/kexec_core.o: in function `kernel_kexec':
> /home/changbin/work/linux-riscv/kernel/kexec_core.c:1200: undefined reference to `machine_shutdown'
> riscv64-linux-gnu-ld: /home/changbin/work/linux-riscv/kernel/kexec_core.c:1204: undefined reference to `machine_kexec'
> riscv64-linux-gnu-ld: kernel/kexec_file.o: in function `__do_sys_kexec_file_load':
> /home/changbin/work/linux-riscv/kernel/kexec_file.c:363: undefined reference to `machine_kexec_prepare'
> riscv64-linux-gnu-ld: /home/changbin/work/linux-riscv/kernel/kexec_file.c:363: undefined reference to `machine_kexec_prepare'
> make: *** [Makefile:1160: vmlinux] Error 1
>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>   arch/riscv/kernel/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c71d6591d539..33bb60a354cd 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>   endif
>   obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>   obj-$(CONFIG_KGDB)		+= kgdb.o
> -obj-$(CONFIG_KEXEC)		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
> +obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>   obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
>   obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>   
