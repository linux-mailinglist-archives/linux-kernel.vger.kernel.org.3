Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD84E4FF04B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiDMHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiDMHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:06:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D682DAA7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:03:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso1196020pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKD/CmDUW2VaTfsG+wCzkkyEvaGkyMuQ2kCUvWIZW/k=;
        b=d+CTkeCCj/EGQlrZ863KMzMojnZqHi9nnvmjCveYb19+erTyDuA4CvR0/g9JH2Ldu4
         WYlfMCtOJ+o7EQxL+p/hxj127RG7tp4MDuNxMbSwwgT+d2JtuA1iiVlmjrqEy0ox2U1/
         QnJXS1pJKbxB+Q6wWZY7Xb7CSLGHirxW62O7cLIgqdVqTCAVS4jv5U/gd/zq772nPAOk
         u89ZtMWTfY/RxOSJB0CFLbTvuzEQk71avruwDMNghj8K8APbR3XnneQYVSF9P+XpoaX/
         bSOgahP7uM/1gulXCQWucrdcgc8NasMPx94Nqz0lf+lIbg8Xz9FDdXpZT1rsv+b9hYHi
         6B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKD/CmDUW2VaTfsG+wCzkkyEvaGkyMuQ2kCUvWIZW/k=;
        b=ibdAEsyHu8RAgcAcK9GTH9kJNlqcREy5rlWGoCkKLSK9xiBz1K3kpqoIZVjx4w6csa
         m8gz9hNOwcyKbxzbriTQIVKD5vhSAO1d7tTTZkCEp3NBq4vglJXJzSN0qTSQdJgOSqPf
         cawttfXxNHqSff4kGzet/TULXPgybP3fcqsqf/DP6rySQeG9bAWwSnLF6cudqFqXDu3i
         Fz2nS3xOR1fv86CymTwlh+f39kL/SqR01zqs1BfsFa62/QIdwliIExyty5NAat8eZPZC
         8ZwfUhvKH+94LCMmS6+gvlm+yrIu7oUOCdhBVmVD1n7zruEcjCB0XTYbj9kynncyqmLj
         bL9Q==
X-Gm-Message-State: AOAM532BW5a1nGHsdf4J/W3E4uAxKWm1IjClUbgc3qBW6lyJqjcqnubu
        YEd+Yyf+io2MFE2THsOlMNtgdFIhAzSIz5c+wFZSkg==
X-Google-Smtp-Source: ABdhPJxzoM6ULFIVwie4OnYck0mDsYakGSneZKdDkuQBQSI1lh8i7l2fDZJDzxsH+L+TX+YuVyL4Y0VKM1TcU0ycWgg=
X-Received: by 2002:a17:902:ecc7:b0:158:603c:4f5b with SMTP id
 a7-20020a170902ecc700b00158603c4f5bmr14184640plh.131.1649833418354; Wed, 13
 Apr 2022 00:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220411093819.1012583-1-sumit.garg@linaro.org> <CAD=FV=WZXBG98nKp4qq_=B+VmJ=MUAJJdOhaV4OkAT=AvDcTfg@mail.gmail.com>
In-Reply-To: <CAD=FV=WZXBG98nKp4qq_=B+VmJ=MUAJJdOhaV4OkAT=AvDcTfg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 Apr 2022 12:33:27 +0530
Message-ID: <CAFA6WYO3vqG+c4auC0f5ewPABF6mf9axqRnT=V1NduXbtQ7+aw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: kgdb/kdb: Fix pending single-step debugging issues
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for looking into this patch-set.

On Tue, 12 Apr 2022 at 05:39, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Apr 11, 2022 at 2:38 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > This patch-set reworks pending fixes from Wei's series [1] to make
> > single-step debugging via kgdb/kdb on arm64 work as expected. There was
> > a prior discussion on ML [2] regarding if we should keep the interrupts
> > enabled during single-stepping but it turns out that in case of kgdb, it
> > is risky to enable interrupts as sometimes a resume after single
> > stepping an interrupt handler leads to following unbalanced locking
> > issue:
> >
> > [  300.328300] WARNING: bad unlock balance detected!
> > [  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
> > [  300.329058] -------------------------------------
> > [  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
> > [  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
> > [  300.330029] but there are no more locks to release!
> > [  300.330265]
> > [  300.330265] other info that might help us debug this:
> > [  300.330668] 4 locks held by sh/173:
> > [  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x98/0x204
> > [  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2}, at: kgdb_cpu_enter+0x5b4/0x820
> > [  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2}, at: kgdb_cpu_enter+0xe0/0x820
> > [  300.332717]  #3: ffffd57c973bc2a8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x1ec/0x820
> >
> > So, I choose to keep interrupts disabled specifically for kgdb. This
> > series has been rebased to Linux 5.18-rc1 and I have dropped Doug's
> > review and test tags as there is significant rework involved.
>
> Hmmmm. I guess it's really up to Will here, but re-reading his
> previous email made it pretty clear that he wasn't willing to land a
> solution that he wasn't willing to land a solution that left
> interrupts disabled during step. He also pointed out some things that
> would actually be broken, like single-stepping over a call to
> irqs_disabled() or single stepping over something that caused an
> exception where the exception handler needed interrupts enabled.
>
> I thought he had a proposal at:
>
> https://lore.kernel.org/r/20200626095551.GA9312@willie-the-truck
>
> ...that was supposed to make all the problems go away and it was just
> that nobody had time to implement his proposal?
>

So I took a shot at Will's proposal as a replacement of patch #1 in v2
[1]. I hope that it is aligned with Will's thinking.

[1] https://lkml.org/lkml/2022/4/13/136

-Sumit

>
> > [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> > [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> >
> > Sumit Garg (2):
> >   arm64: kgdb: Fix incorrect single stepping into the irq handler
> >   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
> >
> >  arch/arm64/include/asm/debug-monitors.h |  1 +
> >  arch/arm64/kernel/debug-monitors.c      |  5 ++++
> >  arch/arm64/kernel/kgdb.c                | 35 +++++++++++++++++++++++--
> >  3 files changed, 39 insertions(+), 2 deletions(-)
> >
> > --
> > 2.25.1
> >
