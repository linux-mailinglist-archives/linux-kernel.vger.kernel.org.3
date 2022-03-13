Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B844D7210
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiCMBMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCMBME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:12:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C21B1B90;
        Sat, 12 Mar 2022 17:10:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00C20B80123;
        Sun, 13 Mar 2022 01:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA67C340F7;
        Sun, 13 Mar 2022 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647133854;
        bh=WDhHtMMzDFG5VodBhA9/54gjgFe39ayzZKWGkP/LDK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EFca1hvnGz3TxyEY897vI/6ZNFT6rs20DC1fNngBrgeE9lUgBNlvvn4OzAllO62Dy
         AnoIQfGYtdHGjdZLZOiiS/+2KjusgXbkzKRbGW2/U9IIWsQW8UneYi3oVSlj6c/mCM
         weMaLrcVrEW03gGp+ILrQpWOZZAugfeJLhfy4fGs2lXdKhbZufgRLrRTwMmv3FyTti
         nctgTdqhBMeRYPIZHW9RHlAupLYncbE9S+wQgQATScA8yjFGUm3K+nHP+ToofV2ZXL
         8l3v4vBtdcjq8QV6zjQTHPHU8s5EPGuVlnCULUKWKRNQ64nD6KlN2FP6Z3f/c0AXuu
         Akl3zOOApbbXA==
Received: by mail-ua1-f47.google.com with SMTP id j7so5258193uap.5;
        Sat, 12 Mar 2022 17:10:54 -0800 (PST)
X-Gm-Message-State: AOAM531tKKDi5d/Trao5+ijZq+PYtYWl4beU25Kbe8ESUJzqBFRIkbHm
        aFiHGx2TIsfSOfgfwtdC43rmp02F2CU+o8vrRjo=
X-Google-Smtp-Source: ABdhPJys7kYGC3JWwTiegWtxjWDYschAlzeMkP/1Qn2R1I/FiDN2MiyTMnZMxrgL9A71vc/Di9nW7mjcrZHA6J0wskU=
X-Received: by 2002:ab0:26d9:0:b0:34c:609d:c23 with SMTP id
 b25-20020ab026d9000000b0034c609d0c23mr3534202uap.84.1647133853508; Sat, 12
 Mar 2022 17:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20220312155603.1752193-1-guoren@kernel.org> <CAMo8Bf+p1-DqeqHV45GcZEsp+BEd+iMfeHP+i0P+KO7nv8W7Ow@mail.gmail.com>
In-Reply-To: <CAMo8Bf+p1-DqeqHV45GcZEsp+BEd+iMfeHP+i0P+KO7nv8W7Ow@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 13 Mar 2022 09:10:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRrDMhL0YyZ=BYJ17sRp0oU610N+Wn+WtAgBASC_TPrOg@mail.gmail.com>
Message-ID: <CAJF2gTRrDMhL0YyZ=BYJ17sRp0oU610N+Wn+WtAgBASC_TPrOg@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: patch_text: Fixup last cpu should be master
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 7:50 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Guo Ren,
>
> On Sat, Mar 12, 2022 at 7:56 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These patch_text implementations are using stop_machine_cpuslocked
> > infrastructure with atomic cpu_count. The origin idea is that when
>
> The original
>
> > the master CPU patch_text, others should wait for it. But current
> > implementation is using the first CPU as master, which couldn't
> > guarantee continue CPUs are waiting. This patch changes the last
>
> guarantee that remaining CPUs are waiting.
>
> > CPU as the master to solve the potaintial risk.
>
> potential
>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Peter Zijlstra <peterz@infradead.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/kernel/patching.c      | 4 ++--
> >  arch/csky/kernel/probes/kprobes.c | 2 +-
> >  arch/riscv/kernel/patch.c         | 2 +-
> >  arch/xtensa/kernel/jump_label.c   | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
>
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
>
> I'm curious, is there a specific issue that prompted this patch?
No, theoretical risk.

>
> --
> Thanks.
> -- Max



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
