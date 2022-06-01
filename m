Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AEF53AA9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355945AbiFAQAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355997AbiFAQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:00:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E55DBD4;
        Wed,  1 Jun 2022 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NnrpreKpidqE44axlas7IG2FtD6kVX7jiGNsZlGRSdg=; b=GWo8xBBmfHNDPY3Fkj4OWs4PQX
        lcXWUplJvegZQ9aacMqx0YlweHe67SluYghTdn+kpfFSA9xdD404gCCpf1aZ1pJVwn1ij0ryH+HAW
        xZ+HvTcnp5SfvmMWR91+ZGqWIn28MAN8kYXYlq5/NxfYsXkIWgquQ0Phe6EyxWYSpRQK8zgIsREME
        yf2+8hQbxyoyrmfNAuyjeOMaG3rAI1etanTVPwEOS7JfWpkTR8m72oo4H4eEAyYceiQyKmIbLHQR7
        I+f5MWxDhp7IHzsvMEq7itda0dbOKKkk+tVRkt/rUdfZTlDUDPLunEHNWk5KrMvQQXyLGXcwV/sj0
        3vd+pikQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwQlK-003pGd-PA; Wed, 01 Jun 2022 15:59:59 +0000
Message-ID: <e507585a-574e-a217-479b-cb677d2df443@infradead.org>
Date:   Wed, 1 Jun 2022 08:59:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] RISC-V: kexec: Fix build error without CONFIG_KEXEC
Content-Language: en-US
To:     Li Zhengyu <lizhengyu3@huawei.com>, palmer@rivosinc.com,
        mick@ics.forth.gr
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-next@vger.kernel.org
References: <20220601070204.26882-1-lizhengyu3@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220601070204.26882-1-lizhengyu3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/22 00:02, Li Zhengyu wrote:
> When CONFIG_KEXEC_FILE=y but CONFIG_KEXEC is not set:
> 
> kernel/kexec_core.o: In function `kimage_free':
> kexec_core.c:(.text+0xa0c): undefined reference to `machine_kexec_cleanup'
> kernel/kexec_core.o: In function `.L0 ':
> kexec_core.c:(.text+0xde8): undefined reference to `machine_crash_shutdown'
> kexec_core.c:(.text+0xdf4): undefined reference to `machine_kexec'
> kernel/kexec_core.o: In function `.L231':
> kexec_core.c:(.text+0xe1c): undefined reference to `riscv_crash_save_regs'
> kernel/kexec_core.o: In function `.L0 ':
> kexec_core.c:(.text+0x119e): undefined reference to `machine_shutdown'
> kernel/kexec_core.o: In function `.L312':
> kexec_core.c:(.text+0x11b2): undefined reference to `machine_kexec'
> kernel/kexec_file.o: In function `.L0 ':
> kexec_file.c:(.text+0xb84): undefined reference to `machine_kexec_prepare'
> kernel/kexec_file.o: In function `.L177':
> kexec_file.c:(.text+0xc5a): undefined reference to `machine_kexec_prepare'
> Makefile:1160: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> These symbols should depend on CONFIG_KEXEC_CORE rather than CONFIG_KEXEC
> when kexec_file has been implemented on RISC-V, like the other archs have
> done.
> 
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  arch/riscv/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c71d6591d539..33bb60a354cd 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>  endif
>  obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>  obj-$(CONFIG_KGDB)		+= kgdb.o
> -obj-$(CONFIG_KEXEC)		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
> +obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>  obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>  

-- 
~Randy
