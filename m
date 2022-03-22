Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC64E4269
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiCVO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiCVO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:58:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55408AE59
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:57:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w27so30263397lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OJI0RmOHgLzwXqCzU2LAM4gTSaQuoMgdbBB+V0QYV0=;
        b=nDokgy2xQaPO4m12Ar1r8ltnpEIVvSpjlVOeM/Mq0XKMcDULK4aKpZM/En9btUbKSy
         3SjLEU10gB6ydeglw5nwd6Er3AvBY4o3HzHE5UGPJjtbWxw0NPbC/C3Idl2qOQaPo/DH
         +N1Kt82UNG2oeGxu6u8SqPwoFkIJoRsx8l4Y8mjKYuD+E3Y3yGS8zRl75oloyvkvAvJM
         qcJyIrWX9u/aji3bWxCBnfxpGfCDzpa6VaQHx8l4405Jvxl/qXgpfp4wcockdZPulHux
         L37DqCeIMqD7d/QhmEDpmkUlAvOD12gloovOABW8Jy6vNWvTy+l1Z9fcfq3KKQLgTqCJ
         bDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OJI0RmOHgLzwXqCzU2LAM4gTSaQuoMgdbBB+V0QYV0=;
        b=oNn9IuHZ/4mUE2A01kDNgXqXnvVFp4P3clLW5ncVXsXSCpaYt7R9e62jRBERRZEO4K
         3RArYwABc4VOylFtZXXInSxeBggxkPU8VCY4N/QpghESmrm9eFGFeNcatZ2Z1OzcufL+
         ixCaqmAB8Fd9VjN7Ur4yYNPulomzynQnYowfaSM2io+DeCgJt0SYRikSjUI/4qH5ANqs
         1/RADVzEUPJM5yOcttKVVdqzu8xVc/Hl4pwPey6q8NlPnRA6aBA0WhzmDGz6on8lokdi
         e9ENkJoh77tCaVo/tT0JhHqIdo6Fh4UIlS+H2g4V41QiYzTDAeJE30Yia0pFsuv312cp
         E/zQ==
X-Gm-Message-State: AOAM5324AZRReRMGpbfkZPYvHQhbUmhJ1pFuWpVXzWHiIQ96MupRrZ+Y
        OSLk4YXAW1H7OcadyNzSq3JtOVnc6fQHNhNAjEkz8w==
X-Google-Smtp-Source: ABdhPJx5PB2Oe89BVlzP2JupeOp8bhlOxFSOT3Cnm2ubk+Q32XCjb+DDqn7XnKiwZqIVDJ8iDEy9/RjEsZvryYhIZAU=
X-Received: by 2002:a05:6512:690:b0:44a:30d6:fb1c with SMTP id
 t16-20020a056512069000b0044a30d6fb1cmr5916119lfe.430.1647961041120; Tue, 22
 Mar 2022 07:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-3-vincent.guittot@linaro.org> <a19be99d1e1a282bd5c6b9af60ea6c0417223000.camel@linux.intel.com>
In-Reply-To: <a19be99d1e1a282bd5c6b9af60ea6c0417223000.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 22 Mar 2022 15:57:09 +0100
Message-ID: <CAKfTPtBCKyqa-472Z7LtiWTq+Yirq6=jSrkzJtNbkdKXnwP-mA@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched/core: Propagate parent task's latency
 requirements to the child task
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com
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

On Tue, 22 Mar 2022 at 01:22, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2022-03-11 at 17:14 +0100, Vincent Guittot wrote:
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  init/init_task.c    | 1 +
> >  kernel/sched/core.c | 4 ++++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 73cc8f03511a..2afa249c253b 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -78,6 +78,7 @@ struct task_struct init_task
> >       .prio           = MAX_PRIO - 20,
> >       .static_prio    = MAX_PRIO - 20,
> >       .normal_prio    = MAX_PRIO - 20,
> > +     .latency_nice   = 0,
>
> Probably better to use non hardcoded number here
>         .latency_nice   = DEFAULT_LATENCY_NICE;

yes
>
> >       .policy         = SCHED_NORMAL,
> >       .cpus_ptr       = &init_task.cpus_mask,
> >       .user_cpus_ptr  = NULL,
> >
>
> Tim
>
