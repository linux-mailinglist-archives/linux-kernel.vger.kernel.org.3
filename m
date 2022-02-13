Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478A94B3CB3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiBMSCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:02:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiBMSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:02:47 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D5B180
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:02:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id i34so26388624lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQb5jjxot49LgjHmzyBNQHYR8MDQIKcC739RRM0sxGo=;
        b=KcO5BamHYhDQz3M13BlgPvwIoCJe5swOLMwBli5+LeHH3/CwzONlqZGEUhJdQq/7bC
         2s+zyJzA5gSp4H7n/wB2ixfooqW/3fbW53CfVMOO1A0/H2BIKLGTTyiaEHZXY0NE17ZF
         zr69ZACjRis5ga0XY6pe7YzI+jBPXwFyliKOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQb5jjxot49LgjHmzyBNQHYR8MDQIKcC739RRM0sxGo=;
        b=bAlaPe50Evk1dxQDmf0mIhmc7gE6CLpNlGjQpk096LtJKap1f2xPK2DloyPfr0deQe
         DgGNZwiS7LV7Fst9x3dDbVCjaXCzrHYXrfVI8ZtYuzkVk61H65bxeXCKT9GueK8tL6fy
         M0PokWSoFgBlMyVOfa7LGcrty6mOF3Xq1a8UspaHuATRDMXrwy7XMJoQ1g66hFdXy3FN
         RIgPa6DuJFBUwq7uXr4V/zntGKKnPKFgUMBAqsuZSXTcljZd89fdd0/srhuQ/zpMv7hY
         VubmYjLUlqPHVu6IGklQMTTqoqm/elI1izotoaGWFAGr/j8LA5KMFtczHKRsqirPBQor
         lUig==
X-Gm-Message-State: AOAM531bd+ZgVGjj3kr/0yrW9+i11LPVrSJwTA5N4NMoRmzY7rxlNjcM
        fJ6/JIoBL9Uf12jDGFgfyYV9cHqBJ/FDN/qP
X-Google-Smtp-Source: ABdhPJye+e6LNwym+97li1TtZ4tOuaSd33zvW2Q7box3709Z9KFmbPaYNHBXmT2Ikx68eQ4eXaDEXA==
X-Received: by 2002:a05:6512:3b91:: with SMTP id g17mr8482504lfv.79.1644775359926;
        Sun, 13 Feb 2022 10:02:39 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b9sm3818385lfb.222.2022.02.13.10.02.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 10:02:39 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id be32so839438ljb.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:02:39 -0800 (PST)
X-Received: by 2002:a2e:8081:: with SMTP id i1mr6885582ljg.506.1644775358861;
 Sun, 13 Feb 2022 10:02:38 -0800 (PST)
MIME-Version: 1.0
References: <Ygj7feK+vdtPw6zj@zn.tnic>
In-Reply-To: <Ygj7feK+vdtPw6zj@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Feb 2022 10:02:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
Message-ID: <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
Subject: Re: [GIT PULL] sched/urgent for 5.17-rc4
To:     Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 4:37 AM Borislav Petkov <bp@suse.de> wrote:
>
> Tadeusz Struk (1):
>       sched/fair: Fix fault in reweight_entity

I've pulled this, but this really smells bad to me.

If set_load_weight() can see a process that hasn't even had the
runqueue pointer set yet, then what keeps *others* from the same
thing?

Adding a test like this in set_load_weight() just makes me go "what
makes this function so special"? IOW, why could only that function see
this situation with a missing cfs_rq pointer?

I really get the feeling that this is papering over a serious mistake
in how commit 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an
invalid sched_task_group") now causes fundamental process state to be
initialized too late - when the process is already visible to others.

The setpriority() -> dequeue_load_avg() chain just seems to be one
possible case.

*ANYBODY* that does find_task_by_vpid(who) would seem to be able to
find a task that hasn't actually been fully set up yet, and

Somebody tell me why I'm wrong, and what makes that setpriority thing
so magically special. Please.

                    Linus
