Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D9563C39
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiGAWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAWOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:14:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1A2E688
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:14:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e40so4545620eda.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4URNM02Tr+qhwarOcnzMYwfkN9WcQYPEfgtjcHdqZjg=;
        b=iJj1lPcih9ZBd3UEScNOLAAvr5dkXJvFFamp0mUOpA57sV84kvH3iJMtIVwpoO7on5
         ZaiZTIcrd9xof4f9S8afK2YoZiU5d9RUtwJ+REJS9CMCu1cIneKucD122Vhj1kWUruqn
         D63BJ76OQVM/6pHNsfYLaHpH5x9l6XnftfjLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4URNM02Tr+qhwarOcnzMYwfkN9WcQYPEfgtjcHdqZjg=;
        b=p9DWV/cFaidAPL8UAtg65XTGMRwhhMVfxSDbI945oUZgk/1MF3+LgooXHCUjcYjlyL
         2L6yvowlgNnLm/3d0GOnkK9eBn/1Y87iMV5jvIoszsMdQudT5wutjZn+9/PWZKLlzPN+
         qwpcUORtKjw6LnxWvOvGAmruRMQqcx1Xzm4N2+sH02UsYRQ0y+MkjDVTw7yQg4PZOwIE
         EuJp2U41MnTkExTszDY1JZ0aQdzzzAZApwOmU6McUNqQISSGjvlGPlo8ztuUldptextZ
         i7LfxrU1GMnfmcajE941WaF3PIA2Trty78abVjBUHd/pyULvtSoylRLlfFf25lh8AewW
         3K2w==
X-Gm-Message-State: AJIora/T5cjOb58fBjuZksywknS1PYUQFb1qKIrUpkHxNto3fNCIjexU
        sKYSqW1TSwv3oO/ZQWqO4uFxS+yYh14Vfw9r
X-Google-Smtp-Source: AGRyM1v+xe3YUo55+7eNoyp7x1S4AyN4+1i8iQBcsWRDps0ladf4Z0nw2O9YrOIN2Ih35YPsSsgNDg==
X-Received: by 2002:aa7:c2cf:0:b0:435:6576:b7c0 with SMTP id m15-20020aa7c2cf000000b004356576b7c0mr22245002edp.18.1656713670705;
        Fri, 01 Jul 2022 15:14:30 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm10915400ejd.196.2022.07.01.15.14.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 15:14:29 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id q9so5004124wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 15:14:29 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr15172082wrd.659.1656713668620; Fri, 01
 Jul 2022 15:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org>
In-Reply-To: <20220511060521.465744-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Jul 2022 15:14:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
Message-ID: <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 10, 2022 at 11:05 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> This patch-set reworks pending fixes from Wei's series [1] to make
> single-step debugging via kgdb/kdb on arm64 work as expected. There was
> a prior discussion on ML [2] regarding if we should keep the interrupts
> enabled during single-stepping. So patch #1 follows suggestion from Will
> [3] to not disable interrupts during single stepping but rather skip
> single stepping within interrupt handler.
>
> [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
>
> Changes in v3:
> - Reword commit descriptions as per Daniel's suggestions.
>
> Changes in v2:
> - Replace patch #1 to rather follow Will's suggestion.
>
> Sumit Garg (2):
>   arm64: entry: Skip single stepping into interrupt handlers
>   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
>
>  arch/arm64/include/asm/debug-monitors.h |  1 +
>  arch/arm64/kernel/debug-monitors.c      |  5 +++++
>  arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
>  arch/arm64/kernel/kgdb.c                |  2 ++
>  4 files changed, 25 insertions(+), 1 deletion(-)

Sorry it took so long for me to respond. I kept dreaming that I'd find
the time to really dig deep into this to understand it fully and I'm
finally giving up on it. I'm going to hope that Will and/or Catalin
knows this area of the code well and can give it a good review. If not
then I'll strive harder to make the time...

In any case, I poked around with this a bunch and it definitely
improved the stepping behavior a whole lot. I still got one case where
gdb hit an assertion while I was stepping, but I could believe that
was a problem with gdb? I couldn't reproduce it. Thus I can at least
give:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'll also note that I _think_ I remember that with Wei's series that
the gdb function "call" started working. I tried that here and it
didn't seem so happy. To keep things simple, I created a dummy
function in my kernel that looked like:

void doug_test(void)
{
  pr_info("testing, 1 2 3\n");
}

I broke into the debugger by echoing "g" to /proc/sysrq-trigger and
then tried "call doug_test()". I guess my printout actually printed
but it wasn't so happy after that. Seems like it somehow ended up
returning to a bogus address after the call which then caused a crash.

  testing, 1 2 3
  BUG: sleeping function called from invalid context at
arch/arm64/mm/fault.c:593
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3393, name: bash
  preempt_count: 0, expected: 0
  RCU nest depth: 1, expected: 0
  CPU: 6 PID: 3393 Comm: bash Not tainted 5.19.0-rc4+ #3
dbec0bdb8582e447bccdcf2e70d7fe04477b1aac
  Hardware name: Google Herobrine (rev1+) (DT)
  Call trace:
   dump_backtrace+0xf0/0x110
   show_stack+0x24/0x70
   dump_stack_lvl+0x64/0x7c
   dump_stack+0x18/0x38
   __might_resched+0x144/0x154
   __might_sleep+0x54/0x84
   do_page_fault+0x1d4/0x42c
   do_mem_abort+0x4c/0xb0
   el1_abort+0x3c/0x5c
   el1h_64_sync_handler+0x4c/0xc4
   el1h_64_sync+0x64/0x68
   0xffffffc008000000
   __handle_sysrq+0x15c/0x184
   write_sysrq_trigger+0x94/0x128
   proc_reg_write+0xbc/0xec
   vfs_write+0xf0/0x2c8
   ksys_write+0x84/0xf0
   __arm64_sys_write+0x28/0x34
   invoke_syscall+0x4c/0x120
   el0_svc_common+0x94/0xfc
   do_el0_svc+0x38/0xc0
   el0_svc+0x2c/0x7c
   el0t_64_sync_handler+0x48/0x114
   el0t_64_sync+0x18c/0x190
  Unable to handle kernel execute from non-executable memory at
virtual address ffffffc008000000
  Mem abort info:
    ESR = 0x000000008600000f
    EC = 0x21: IABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x0f: level 3 permission fault
  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000082863000
  [ffffffc008000000] pgd=100000027ffff003, p4d=100000027ffff003,
pud=100000027ffff003, pmd=100000027fffe003, pte=00680001001c3703
  Internal error: Oops: 8600000f [#1] PREEMPT SMP

I'm not sure if that's a sign that something is missing with your patch or not.

-Doug
