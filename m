Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494C577E19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiGRI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiGRI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:57:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9711A14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:57:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i14so19680039yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4hcKXeKDY4mZgkkWrO2UJFIB2+YkvdMpf7oiIiz6Vw=;
        b=UCIHI1H6TeNg0v3uYSbIuL/VieFk1ImiXQDuN/19M2oYbk+kcyRKEEqHGhqSw3eUut
         BdnC2zIydmA4KpoHM2EtnVw+ahe4W6zoILmUWR59hch4t38x8wPS53oZhJLwySWmW7Z9
         vHjEDczIaHH3Qftdg7tdTxUstk77/GJABs7mPAZGyswj7G7P3ikkEgn2C4trLQ+r2mz4
         RqM4ConzLpmjisWpgCVxPDvqWjg+e+j8PNmJSPgP7WrNbTU46G4nBXIMkB76x6q+uaFm
         vhOTUvCGzEGEPAprRntYjRsx1Vk6cQXsB+oJPey+mkXfUzy6e25fNM6/jcy+JAkMGsV+
         vVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4hcKXeKDY4mZgkkWrO2UJFIB2+YkvdMpf7oiIiz6Vw=;
        b=14mU/z+U7L68jNA3n31Y4JeqphvQzEZaJxca7fQIpBsp24EZaC9ki4rKXUZyQ5KXE2
         89bjxchaJtQ3qcsLl9D7k52SgICN+8D0+4ZNZvODH1hacWZAWTL4YQ8RYrOoMK96LumP
         nOZ+L6WwLnjlgdJG9rUAguFcaki15n9qkEHGmcuMSL0IHCP3JU/yIV1NX+Y46Uf0/sq1
         uGKR6glL94RnDAtRlNHYCAKjla9fRS90EGx+U1fLnBE449mUmTs/vvfxcdOlOB4g8+eI
         ob3VxR1yq5Lwaheup+kTSSr9RJYqSKBEOI9oRdVSfa7neqt+4ODDCB6tJRR02m5deAtO
         T1bQ==
X-Gm-Message-State: AJIora9ObXF+brUK5+ZUZxNHj0sHa+H1Cl2YSv03TZlQz50L4Ca1x53D
        I3IUX/xuvgwkWqUhmusOu1407aKZz4fLqL1Y21iM8g==
X-Google-Smtp-Source: AGRyM1uvQuAYd5Xd3CpqPVNwGhgZoalb7/c9+nWogQm4nDzGun/0TtAYRBVk6lqyyRP8T4PC+GMB4hceI7OvjD3faTY=
X-Received: by 2002:a5b:9c5:0:b0:66e:cbbf:2904 with SMTP id
 y5-20020a5b09c5000000b0066ecbbf2904mr24557371ybq.220.1658134663023; Mon, 18
 Jul 2022 01:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-2-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-2-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 10:57:31 +0200
Message-ID: <CACRpkdaXDGHLwqXQsEedRt=CLRUe1hei1vJDGAQ+D4U0OPcv8Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: stacktrace: Skip frame pointer boundary check
 for call_with_stack()
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:

> When using the frame pointer unwinder, it was found that the stack trace
> output of stack_trace_save() is incomplete if the stack contains
> call_with_stack():
>
>  [0x7f00002c] dump_stack_task+0x2c/0x90 [hrtimer]
>  [0x7f0000a0] hrtimer_hander+0x10/0x18 [hrtimer]
>  [0x801a67f0] __hrtimer_run_queues+0x1b0/0x3b4
>  [0x801a7350] hrtimer_run_queues+0xc4/0xd8
>  [0x801a597c] update_process_times+0x3c/0x88
>  [0x801b5a98] tick_periodic+0x50/0xd8
>  [0x801b5bf4] tick_handle_periodic+0x24/0x84
>  [0x8010ffc4] twd_handler+0x38/0x48
>  [0x8017d220] handle_percpu_devid_irq+0xa8/0x244
>  [0x80176e9c] generic_handle_domain_irq+0x2c/0x3c
>  [0x8052e3a8] gic_handle_irq+0x7c/0x90
>  [0x808ab15c] generic_handle_arch_irq+0x60/0x80
>  [0x8051191c] call_with_stack+0x1c/0x20
>
> For the frame pointer unwinder, unwind_frame() checks stackframe::fp by
> stackframe::sp. Since call_with_stack() switches the SP from one stack
> to another, stackframe::fp and stackframe: :sp will point to different
> stacks, so we can no longer check stackframe::fp by stackframe::sp. Skip
> checking stackframe::fp at this point to avoid this problem.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Very nice catch! Took me some time to realize what was
going on here.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Nitpick below:

> +       /*
> +        * call_with_stack() is the only place we allow SP to jump from one
> +        * stack to another, with FP and SP pointing to different stacks,
> +        * skipping the FP boundary check at this point.
> +        */
> +       if (pc >= (unsigned long)&call_with_stack &&
> +                       pc < (unsigned long)&call_with_stack_end)
> +               return 0;

Can we create a local helper macro to do this, if it needs to happen
some other time?

#define ARM_PC_IN_FUNCTION(pc, func) (pc >=. ...)

Yours,
Linus Walleij
