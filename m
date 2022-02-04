Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEB4AA2A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiBDV4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBDV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:56:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1F3C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:56:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s16so6072289pgs.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sVAEL1/KJCwmGYaCcxXp2lw6FUwS8oapDcHjiQKyg4c=;
        b=J9NvrugY0fz1DaakFJ4iHmhLh/ojYJfV5zisnlvURW1KHFAxEL1BhO2+aowxIQnCWu
         VgPOiSIbHTRKGPbsLTYMCwu8uh27U8nLaeDLVgKzGCNfGPAsXmzCYa/FR+nlDt07WSPI
         EMrt3zqDok7jlkMuOLXLRworjDROFPdH871/t0xLczY4aseEj5MXZGpPGa0T7veMqZE1
         Yx8EIWGr3K/1fejW5ECj9sV4KeMNngbFVR2Ck5aTXCkPfiZYblw+FEHoSKlrjGBxL/Y4
         T4JYjOA5tLnsAcs1yW8vEh8N/08TW5S1RUEsMTGlPsyms2W+qjjG0lP6ieUK7z8RxU4I
         wBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sVAEL1/KJCwmGYaCcxXp2lw6FUwS8oapDcHjiQKyg4c=;
        b=qSV5V4v7/t5fE5fX9j9IZ7QjF+FoRaAKEV97370gMjQhJBn3jeFEC+g9mBRf3UKxs1
         ntWwu9HBrWz/8prr7woL/tB7mV0MT8YvwS4EAL4EAXeF4dr1KuPWgy0K+1U7WmmWT6Rd
         0z/3za3F5Dzm4FY+hKgvs1saUez9RIc/XqvziHTIzJQweIwKudd4W79z693/qbnZO1wj
         t7kfTZVNmHGsmghBHb3Szfx33utVzG/I6OJx8Mq84UfksXQBPlcRFPxm3oJGUMzrQa1G
         145KZ29kWE2clFKxkZeRNREJSVfhOKDCVo6Nns9O5nFd+bPxNJg31LcKomxxTitFKnlv
         ebAw==
X-Gm-Message-State: AOAM531SDGDAtQOrc8HOUN4svx5vyT/8ujTMP5cfFf88yl11k5CYmzsa
        Wk2VvTarIHE9zz+f2vn06BAdHw==
X-Google-Smtp-Source: ABdhPJwe8Cvsry9jnU9HSb0f+++KvGO+SPPNWTtcj4zbO/vScOO1egXVBXfqsW5oYRCTK+y5lX+PCA==
X-Received: by 2002:a63:6cc9:: with SMTP id h192mr821263pgc.486.1644011791772;
        Fri, 04 Feb 2022 13:56:31 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id mn2sm3071827pjb.38.2022.02.04.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:56:31 -0800 (PST)
Date:   Fri, 04 Feb 2022 13:56:31 -0800 (PST)
X-Google-Original-Date: Fri, 04 Feb 2022 13:56:04 PST (-0800)
Subject:     Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
In-Reply-To: <20220117154433.3124-1-changbin.du@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        changbin.du@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     changbin.du@gmail.com
Message-ID: <mhng-43e63f81-4c9c-4ffa-b514-b418d21b69d4@palmer-ri-x1c9>
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

On Mon, 17 Jan 2022 07:44:33 PST (-0800), changbin.du@gmail.com wrote:
> I tried different pieces of code which uses __builtin_frame_address(1)
> (with both gcc version 7.5.0 and 10.3.0) to verify whether it works as
> expected on riscv64. The result is negative.
>
> What the compiler had generated is as below:
> 31                      fp = (unsigned long)__builtin_frame_address(1);
>    0xffffffff80006024 <+200>:   ld      s1,0(s0)
>
> It takes '0(s0)' as the address of frame 1 (caller), but the actual address
> should be '-16(s0)'.
>
>           |       ...       | <-+
>           +-----------------+   |
>           | return address  |   |
>           | previous fp     |   |
>           | saved registers |   |
>           | local variables |   |
>   $fp --> |       ...       |   |
>           +-----------------+   |
>           | return address  |   |
>           | previous fp --------+
>           | saved registers |
>   $sp --> | local variables |
>           +-----------------+
>
> This leads the kernel can not dump the full stack trace on riscv.
>
> [    7.222126][    T1] Call Trace:
> [    7.222804][    T1] [<ffffffff80006058>] dump_backtrace+0x2c/0x3a
>
> This problem is not exposed on most riscv builds just because the '0(s0)'
> occasionally is the address frame 2 (caller's caller), if only ra and fp
> are stored in frame 1 (caller).
>
>           |       ...       | <-+
>           +-----------------+   |
>           | return address  |   |
>   $fp --> | previous fp     |   |
>           +-----------------+   |
>           | return address  |   |
>           | previous fp --------+
>           | saved registers |
>   $sp --> | local variables |
>           +-----------------+
>
> This could be a *bug* of gcc that should be fixed. But as noted in gcc
> manual "Calling this function with a nonzero argument can have
> unpredictable effects, including crashing the calling program.", let's
> remove the '__builtin_frame_address(1)' in backtrace code.
>
> With this fix now it can show full stack trace:
> [   10.444838][    T1] Call Trace:
> [   10.446199][    T1] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
> [   10.447711][    T1] [<ffffffff800060ac>] show_stack+0x32/0x3e
> [   10.448710][    T1] [<ffffffff80a005c0>] dump_stack_lvl+0x58/0x7a
> [   10.449941][    T1] [<ffffffff80a005f6>] dump_stack+0x14/0x1c
> [   10.450929][    T1] [<ffffffff804c04ee>] ubsan_epilogue+0x10/0x5a
> [   10.451869][    T1] [<ffffffff804c092e>] __ubsan_handle_load_invalid_value+0x6c/0x78
> [   10.453049][    T1] [<ffffffff8018f834>] __pagevec_release+0x62/0x64
> [   10.455476][    T1] [<ffffffff80190830>] truncate_inode_pages_range+0x132/0x5be
> [   10.456798][    T1] [<ffffffff80190ce0>] truncate_inode_pages+0x24/0x30
> [   10.457853][    T1] [<ffffffff8045bb04>] kill_bdev+0x32/0x3c
> ...
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 201ee206fb57..14d2b53ec322 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -22,15 +22,16 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			     bool (*fn)(void *, unsigned long), void *arg)
>  {
>  	unsigned long fp, sp, pc;
> +	int level = 0;
>
>  	if (regs) {
>  		fp = frame_pointer(regs);
>  		sp = user_stack_pointer(regs);
>  		pc = instruction_pointer(regs);
>  	} else if (task == NULL || task == current) {
> -		fp = (unsigned long)__builtin_frame_address(1);
> -		sp = (unsigned long)__builtin_frame_address(0);
> -		pc = (unsigned long)__builtin_return_address(0);
> +		fp = (unsigned long)__builtin_frame_address(0);
> +		sp = sp_in_global;
> +		pc = (unsigned long)walk_stackframe;
>  	} else {
>  		/* task blocked in __switch_to */
>  		fp = task->thread.s[0];
> @@ -42,7 +43,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  		unsigned long low, high;
>  		struct stackframe *frame;
>
> -		if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> +		if (unlikely(!__kernel_text_address(pc) || (level++ >= 1 && !fn(arg, pc))))
>  			break;
>
>  		/* Validate frame pointer */

Thanks, this is on fixes.
