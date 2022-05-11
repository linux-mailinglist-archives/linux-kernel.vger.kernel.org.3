Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB9522E67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiEKIay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbiEKIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:30:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CB0AC7E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:30:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC92106F;
        Wed, 11 May 2022 01:30:41 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE343F73D;
        Wed, 11 May 2022 01:30:39 -0700 (PDT)
Date:   Wed, 11 May 2022 09:30:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        broonie@kernel.org, pcc@google.com, keescook@chromium.org,
        daniel.kiss@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        gongruiqi1@huawei.com
Subject: Re: [PATCH -next] arm64: add missing header dependencies
Message-ID: <Ynt0J5daWq7swGP8@FVFF77S0Q05N>
References: <20220509061751.3434059-1-cuigaosheng1@huawei.com>
 <20220510104014.GA27557@willie-the-truck>
 <3b692d9f-0f76-33b8-0c22-909a24377e33@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b692d9f-0f76-33b8-0c22-909a24377e33@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:39:55AM +0800, cuigaosheng wrote:
>     Do you know which commit is causing this error?
> 
> 9cce7a435f89 arm64: CPU support I got the error when building a module with
> processor.h on arm64 and the module calls the KSTK_ESP macro,

I assume that's an out-of-tree module?

Looking at v5.18-rc5, the only users of KSTK_ESP() on arm64 are built in:

| [mark@lakrids:~/src/linux]% git grep KSTK_ESP
| arch/alpha/include/asm/processor.h:#define KSTK_ESP(tsk) \
| arch/arc/include/asm/processor.h:#define KSTK_ESP(tsk)   (task_pt_regs(tsk)->sp)
| arch/arm/include/asm/processor.h:#define KSTK_ESP(tsk)  task_pt_regs(tsk)->ARM_sp
| arch/arm64/include/asm/processor.h:#define KSTK_ESP(tsk)        user_stack_pointer(task_pt_regs(tsk))
| arch/csky/include/asm/processor.h:#define KSTK_ESP(tsk)         (task_pt_regs(tsk)->usp)
| arch/h8300/include/asm/processor.h:#define      KSTK_ESP(tsk)   ((tsk) == current ? rdusp() : (tsk)->thread.usp)
| arch/hexagon/include/asm/processor.h:#define KSTK_ESP(tsk) (pt_psp(task_pt_regs(tsk)))
| arch/ia64/include/asm/processor.h:#define KSTK_ESP(tsk)  ((tsk)->thread.ksp)
| arch/m68k/include/asm/processor.h:#define       KSTK_ESP(tsk)   ((tsk) == current ? rdusp() : (tsk)->thread.usp)
| arch/microblaze/include/asm/processor.h:#  define KSTK_ESP(task)        (task_sp(task))
| arch/mips/include/asm/processor.h:#define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
| arch/nios2/include/asm/processor.h:#define KSTK_ESP(tsk)        ((tsk)->thread.kregs->sp)
| arch/openrisc/include/asm/processor.h:#define KSTK_ESP(tsk)   (task_pt_regs(tsk)->sp)
| arch/parisc/include/asm/processor.h:#define KSTK_ESP(tsk)       ((tsk)->thread.regs.gr[30])
| arch/powerpc/include/asm/processor.h:#define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
| arch/riscv/include/asm/processor.h:#define KSTK_ESP(tsk)                (task_pt_regs(tsk)->sp)
| arch/s390/include/asm/processor.h:#define KSTK_ESP(tsk) (task_pt_regs(tsk)->gprs[15])
| arch/sh/include/asm/processor_32.h:#define KSTK_ESP(tsk)  (task_pt_regs(tsk)->regs[15])
| arch/sparc/include/asm/processor_32.h:#define KSTK_ESP(tsk)  ((tsk)->thread.kregs->u_regs[UREG_FP])
| arch/sparc/include/asm/processor_64.h:#define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
| arch/um/include/asm/stacktrace.h:       return (unsigned long *)KSTK_ESP(task);
| arch/x86/include/asm/processor.h:#define KSTK_ESP(task)         (task_pt_regs(task)->sp)
| arch/x86/include/asm/processor.h:extern unsigned long KSTK_ESP(struct task_struct *task);
| arch/x86/kernel/process_64.c:unsigned long KSTK_ESP(struct task_struct *task)
| arch/x86/um/asm/processor.h:#define KSTK_ESP(tsk) KSTK_REG(tsk, HOST_SP)
| arch/xtensa/include/asm/processor.h:#define KSTK_ESP(tsk)               (task_pt_regs(tsk)->areg[1])
| fs/proc/array.c:                                esp = KSTK_ESP(task);
| mm/util.c:      return (vma->vm_start <= KSTK_ESP(t) && vma->vm_end >= KSTK_ESP(t));

... or is that module being added in another tree at the moment?

Thanks,
Mark.

> we can also add
> additional header file dependencies(linux/sched/task_stack.h) in the module to
> avoid this error. Maybe perfecting header file dependencies of processor.h is a
> better option? Thanks,
> 
> 在 2022/5/10 18:40, Will Deacon 写道:
> 
>     On Mon, May 09, 2022 at 02:17:51PM +0800, Gaosheng Cui wrote:
> 
>         We get one error when building module with processor.h:
> 
>         ./arch/arm64/include/asm/processor.h:263:36: error: implicit declaration of function ‘task_stack_page’;
>           ((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
>         ./arch/arm64/include/asm/processor.h:266:42: note: in expansion of macro ‘task_pt_regs’
>          #define KSTK_ESP(tsk) user_stack_pointer(task_pt_regs(tsk))
> 
>         task_stack_page is declared in linux/sched/task_stack.h, so this patch
>         add the missing header dependencies.
> 
>         Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>         ---
>          arch/arm64/include/asm/processor.h | 1 +
>          1 file changed, 1 insertion(+)
> 
>     Do you know which commit is causing this error? I haven't seen any other
>     reports, but it's hard to know which tree should take your patch as it
>     stands.
> 
>     Thanks,
> 
>     Will
> 
> 
>         diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>         index 73e38d9a540c..1c239841c4d6 100644
>         --- a/arch/arm64/include/asm/processor.h
>         +++ b/arch/arm64/include/asm/processor.h
>         @@ -28,6 +28,7 @@
>          #include <linux/build_bug.h>
>          #include <linux/cache.h>
>          #include <linux/init.h>
>         +#include <linux/sched/task_stack.h>
>          #include <linux/stddef.h>
>          #include <linux/string.h>
>          #include <linux/thread_info.h>
>         --
>         2.25.1
> 
> 
>     .
> 
