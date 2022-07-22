Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909F557D79D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiGVALK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVALJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:11:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B308402C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:11:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w7so3272178plp.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PqbUV51qi52lrKQhfCf/gzD84m8gLhls7/B6ZdVqa/M=;
        b=ZTVeoyJ2YXiZu5jk15o9L1VobOx0d0pdDXua+aewXF/XkkApabUZE/5ZQ3TU+HUMZL
         EyBJ5rXuSCDN19gvV87EvXMAclujYjRBFFA7x/W9G258vZ3zmrL80a6RaR7yac1hz7e3
         wgDtuY0VvR/ZPdHb4/0aF7p0iygOc8Cly0ssFBHjlrIWWoSOulPh+Fqh02QP8xwhQmio
         kyOZDr2q0Hpeqk1OW26DohM+xN4/HxIdmoGvBzI4VDD1voJcWlXnwdOtxTs46tix4/nD
         SaGS5bBCoGmZ5SoyZS/Ic82U5DSrUJ8SwnlFqJICxKl+MGearAs63k7bI5XGQrSCmdr3
         E4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PqbUV51qi52lrKQhfCf/gzD84m8gLhls7/B6ZdVqa/M=;
        b=6Kcv4Gx8RZ3lgNUu8HfKEXtdSlScO5csYe6uCNUlIg43VqxyO+rOXocCkRBjY6U5b7
         u/NMB/E1zmYPvoKX3z3aOnp4Ug4s6rsUw+FGyos8HC1aSu5QSRx7SNPdjbpuoYTkeNGF
         1k2wJZXPkNpoVhxqmSqCLidcDiGz6sRYYaI1NNZeUaD5H2eEJSE0yl6uWhQdFQ423it0
         Am2cwYAf4ZVBa0bc7s7+xjOjopR9fgrSwCZ7f9DNMa0bCQ38MCUU8JfTF75rRQOAN8SP
         4gxH7OylcFdWhOxCGAwIlVAgjrwa6dJYXzvNxYK2xCBxkCOdVmTJ+vVWbho+GQzkgyeh
         uL0Q==
X-Gm-Message-State: AJIora/sYeImnahhpzHjBnr1IwVPa7i+VgmGZuke7PtdArCPPmUCodFm
        3bUPIirH8ZOm13D0jyFFkXHqGA==
X-Google-Smtp-Source: AGRyM1tXcBNLCwVKHbHbV7qjxyfn5Jjq2ISRTnE50I9Ilhew1GrpnrmxmKsZ28ecr1pCNFjI8UVxVQ==
X-Received: by 2002:a17:903:41c2:b0:16c:52f8:9240 with SMTP id u2-20020a17090341c200b0016c52f89240mr931214ple.161.1658448666805;
        Thu, 21 Jul 2022 17:11:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s29-20020a63215d000000b0041166bf9ca8sm2088739pgm.34.2022.07.21.17.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:11:06 -0700 (PDT)
Date:   Thu, 21 Jul 2022 17:11:06 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Jul 2022 16:52:31 PDT (-0700)
Subject:     Re: [RESEND PATCH v2] RISC-V: Add fast call path of crash_kexec()
In-Reply-To: <20220606082308.2883458-1-xianting.tian@linux.alibaba.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        wangkefeng.wang@huawei.com, philipp.tomsich@vrull.eu,
        ebiederm@xmission.com, heiko@sntech.de, vitaly.wool@konsulko.com,
        tongtiangen@huawei.com, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        xianting.tian@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xianting.tian@linux.alibaba.com
Message-ID: <mhng-c42cbd7f-4935-4d16-9150-5504fd06aedd@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jun 2022 01:23:08 PDT (-0700), xianting.tian@linux.alibaba.com wrote:
> Currently, almost all archs (x86, arm64, mips...) support fast call
> of crash_kexec() when "regs && kexec_should_crash()" is true. But
> RISC-V not, it can only enter crash system via panic(). However panic()
> doesn't pass the regs of the real accident scene to crash_kexec(),
> it caused we can't get accurate backtrace via gdb,
> 	$ riscv64-linux-gnu-gdb vmlinux vmcore
> 	Reading symbols from vmlinux...
> 	[New LWP 95]
> 	#0  console_unlock () at kernel/printk/printk.c:2557
> 	2557                    if (do_cond_resched)
> 	(gdb) bt
> 	#0  console_unlock () at kernel/printk/printk.c:2557
> 	#1  0x0000000000000000 in ?? ()
>
> With the patch we can get the accurate backtrace,
> 	$ riscv64-linux-gnu-gdb vmlinux vmcore
> 	Reading symbols from vmlinux...
> 	[New LWP 95]
> 	#0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/test_crash.c:81
> 	81             *(int *)p = 0xdead;
> 	(gdb)
> 	(gdb) bt
> 	#0  0xffffffe00064d5c0 in test_thread (data=<optimized out>) at drivers/test_crash.c:81
> 	#1  0x0000000000000000 in ?? ()
>
> Test code to produce NULL address dereference in test_crash.c,
> 	void *p = NULL;
> 	*(int *)p = 0xdead;
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
> Changes from v1:
> - simplify the commit message
> ---
>  arch/riscv/kernel/traps.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index fe92e119e6a3..e666ebfa2a64 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -16,6 +16,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/irq.h>
> +#include <linux/kexec.h>
>
>  #include <asm/asm-prototypes.h>
>  #include <asm/bug.h>
> @@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
>
>  	ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>
> +	if (regs && kexec_should_crash(current))
> +		crash_kexec(regs);
> +
>  	bust_spinlocks(0);
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>  	spin_unlock_irq(&die_lock);

Thanks, this is on for-next.
