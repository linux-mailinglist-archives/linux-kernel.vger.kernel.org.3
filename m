Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7052862F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiEPN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiEPN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:58:52 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BA3A5F0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:58:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fedd26615cso41378597b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xLKrLVs38tK2b4Kq3Ass3IEY7f7YrEWbVYpcXz55zk=;
        b=PGqWlhUUb+wFveHHLLMaV8PEbLbvss1saNPo2cO4S8IwUhVkmnD9KsIuDzA7tP+jEm
         i7ihjjgX+qTLMAr5Ald5b2mr4V6qiryyqxacouqQyRiQhaJeypf+gK9xwYUzUZOOuHUl
         QQnMd37TggpEkOGxAT8pqrsCZY70EYSBAyeBs/DgVyoOSkdmfYMb1UOXrh5jUR4JIPQy
         dyfWOkpgnYZ1IuctzAmpqniBfGAvfLI5Y0gfljsf/Ht5tJDWLqDDnwgFKF27yyLRAt80
         ZosPvWu5J8D+6TyBbyHa9QQkUS5ni2GIhJx5zGhQknX8O7F1Xg4eYPxVWvqD/qqk9gaO
         2uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xLKrLVs38tK2b4Kq3Ass3IEY7f7YrEWbVYpcXz55zk=;
        b=Jbdl7F8qgLJKxkzM1C5Jl9Xy+IttiFW0Cqmo4K/DVBKubwRFWgnGUFB0ZJw2cj6IWo
         FTJJPy4Sn7B8Z6syqGAZZooC9Pz8vl8tv97pXpe4TIQXdyAi5Kny+qRSdlVqC6MrWupS
         DxA7cojB/38uO4J94Dy+Ncjcp3SNhx+VOUKGh4RCg/H6aLwOeWiolhj2JmASS4gjLHso
         xDWzrBIJrVRyO3oirpxMXRCE9tHJZvm3OANX60MgbiqN5lXElY0CC+k8ZkElo1Kb/buJ
         vpePQclADhFSxwj3G7NfbvXQhM0N9SefsEbVSP75zp3eyhD0Xk9vioSpypqmmL19WGn/
         scrg==
X-Gm-Message-State: AOAM532tbsPqHEM7EvGL0l9726rzaskyXCsvQ/nqa5/1uBVqbbBU/9of
        7NkBUAnmDW550Jlht2x81YVpaKSLChDjMAdG8WrNiA==
X-Google-Smtp-Source: ABdhPJzO9ZWCQs6j1TdHiLEUfp3n2HHC6K4PgjyQM/2O7ztwMLfGPWVu0GanlonHwWL2hAMSUWZoMJ6gjVfIJkut3Yg=
X-Received: by 2002:a0d:c607:0:b0:2fe:c294:bfc1 with SMTP id
 i7-20020a0dc607000000b002fec294bfc1mr15597015ywd.265.1652709520065; Mon, 16
 May 2022 06:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtsp-1pi6d4J71BPYh-msjzbVt_-v3YrUu12dXPeyqTDg@mail.gmail.com>
 <87o7zylztd.wl-maz@kernel.org>
In-Reply-To: <87o7zylztd.wl-maz@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 May 2022 19:28:28 +0530
Message-ID: <CA+G9fYtLP1Kf1Ck-33XrLFQ5uc_p1z1S5Sr1x=9ZRGi=D851PQ@mail.gmail.com>
Subject: Re: Unexpected kernel BRK exception at EL1 - Internal error: BRK
 handler: f20003e8 - gic_dist_config
To:     Marc Zyngier <maz@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, pali@kernel.org,
        Ingo Molnar <mingo@kernel.org>
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

Hi Marc,

Thanks for looking into this report.

On Mon, 16 May 2022 at 12:38, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 16 May 2022 07:16:22 +0100,
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The kernel crash reported on arm64 juno-r2 device with kselftest-merge config
> > while booting Linux next-20220513 kernel  [1].

<trim>

>
> Huh. Who inserts random BRKs like this?
>
> > [    0.000000] Internal error: BRK handler: f20003e8 [#1] PREEMPT SMP
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> > 5.18.0-rc6-next-20220513 #1
> > [    0.000000] Hardware name: ARM Juno development board (r2) (DT)
> > [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    0.000000] pc : gic_dist_config+0x4c/0x68
> > [    0.000000] lr : gic_init_bases+0xd4/0x248
>
> Please provide a disassembly of this function.

objdump snipper is here.
http://ix.io/3XUW

The vmlinux file is located in this url
Please make use of it.
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/juno/lkft/linux-next/1226/

- Naresh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
