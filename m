Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1834F510CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356161AbiDZXgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356149AbiDZXgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:36:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBC4C438;
        Tue, 26 Apr 2022 16:33:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so108884ejb.6;
        Tue, 26 Apr 2022 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6g4o+wEfKL9+T8sQSTcxefCBo4KDuhC1uhCrtK54UWo=;
        b=RZublxYNfQ7ngoScyoD6qTgaa97/w7pVGTUyLZhdE0TbXzm6oFZt1wzzdGxgoB+FOp
         ZURXwDkCEXvHnAFv8Qg7/HFrHMVTKXQoL74HkkAplLob98VWlB+9Q+cEJ1hNOOSOSXII
         t1AIQmJg8BTbun+5r7wh8s9RJ6EhtfHg5P6gBvE7vklc6IgSkphXHRc6NrmHWSBVM3RF
         22/DppMe/W6wtg/i8IPus0fmKZoF4YFiaHF6CT8c10rBNMuJrP0EG1DFiEvM3XxRLDVU
         tf5d59s4jmV7/sJdbMAgJSGbuLa/PaetUFZ3cWHDmN3qlp1YiNjbvZ0rRppM7T1oIzek
         7v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6g4o+wEfKL9+T8sQSTcxefCBo4KDuhC1uhCrtK54UWo=;
        b=L3pVqOVtksF6RYyDxH0yeKYak1OlmdSZRrHTkKoPCznJjgRQ44ntSmNug5OFIP5xv+
         y2+AK0VZP5Gc+R0eQlCdBh1Y9K57yRLNL6fYfyCz8dMBDsbROcv2idaRy62xJZ2uoIw7
         86YIL0RQy37G+kxbkhjLrfq4wApTvp6bYwKxU2EvAWowqCROpOSDoTmgF1RUwhPxTmw9
         hq7ogP3OYStWhu84vW29pWM8H4zxwe+91kk2IkSll7utzp/NY8f2/vZuvn3rDHIm3KBD
         Yn+eEWfmWs954xBeLotR2XT59nBIAezMUNWLNUAjrg3FC65W0cGKzRcIJ2Is6L6/NKaw
         VLqg==
X-Gm-Message-State: AOAM532+Bv6jr9wn00m9Kicq8qw07dUwk2sMYtnDudO25zLuXlVuCl1b
        j34TGgsApJwIK/GjUo2ql1iXD93GKdc7PxAvU+c=
X-Google-Smtp-Source: ABdhPJzoP1IGO9WxJhw+OnKRq3I9DjJUIfZg1Ycf6YGL83bTUk5OATfKVWfg65XwnlWyuqHbdlWsXk2Om0KInnUzcTo=
X-Received: by 2002:a17:906:7c96:b0:6f3:b6c4:7b2 with SMTP id
 w22-20020a1709067c9600b006f3b6c407b2mr4426898ejo.676.1651016015646; Tue, 26
 Apr 2022 16:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org> <20220426225211.308418-4-ebiederm@xmission.com>
In-Reply-To: <20220426225211.308418-4-ebiederm@xmission.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 26 Apr 2022 16:33:24 -0700
Message-ID: <CAMo8BfJdDJ2tWPp0vNZ0SF2HkRGsytoVhnsnRMDcbSmGByH8zA@mail.gmail.com>
Subject: Re: [PATCH 4/9] ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        mgorman@suse.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:52 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> xtensa is the last user of the PT_SINGLESTEP flag.  Changing tsk->ptrace in
> user_enable_single_step and user_disable_single_step without locking could
> potentiallly cause problems.
>
> So use a thread info flag instead of a flag in tsk->ptrace.  Use TIF_SINGLESTEP
> that xtensa already had defined but unused.
>
> Remove the definitions of PT_SINGLESTEP and PT_BLOCKSTEP as they have no more users.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/xtensa/kernel/ptrace.c | 4 ++--
>  arch/xtensa/kernel/signal.c | 4 ++--
>  include/linux/ptrace.h      | 6 ------
>  3 files changed, 4 insertions(+), 10 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
