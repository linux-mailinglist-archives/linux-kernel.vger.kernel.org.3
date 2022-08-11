Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37E58F5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiHKCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHKCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:15:15 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52262CB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:15:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31f443e276fso160654417b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gaBP3YD7j31/ID4dfhFC+WnYL+xhpB2fR4p3Pda7fYc=;
        b=EK/rEN+jKFIrFQOds/KUDv8vEF55S1q8GKttSQPC2JRmNLNuEP2Ttfpj9RtUx2rRZ7
         R6cPiY1OPk9geiPwjOclOKntPh0hYm4RubUEXy4qXYLATMPjdSJwMhwwQobtz5RhCfzz
         cFkPvjI0gncbvu8I919A8dMbq9MhoSpuWeQyoVYgfqNof1pz5D8pRu7e5VdMc6yTbCp1
         NKqrGPJB8nEyKQoOHG2xBvllXCyc0H9cQ5MKbEF4YQ9TY1KGHp6D/jlsF+NS4WqSMrEH
         jgXjhzJ44mA0jz7qTOfODSagrrbk4sHVxE+9kG00Fbfbrx477vsfCr6Ixi7c1wpdZuXa
         gSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gaBP3YD7j31/ID4dfhFC+WnYL+xhpB2fR4p3Pda7fYc=;
        b=RUQj12DMcqRLTer4vUMsID94VlPUYsxwVyBOsiEjFiXaaBviQXPqgQPWtdA82x7OrA
         X00vuMrV01Ob4gTJAhsO+9InPOXiqlCekxTtPtSCcNz3rPKR8Psi6sco+hEjuJCRW0ir
         owvTqOO56KLlG4w4SWCjR0iMJuYVuij5YUscG38qbQhxsGd20z1fWkg6wgKxaRLphfn6
         0hvG7xNQJ0gySOIbX94qAAlYfs1y96e4bLNIKPOFL8Rn3DQaF3BxqMvtD020Uu9BK6l8
         VblxosTLgsgVBausYmbvm7BWm9auHhwRQ9+g0nHtE0JbFs5HidjyzTzhllWoXF23XIb9
         Db9g==
X-Gm-Message-State: ACgBeo0Xxf6qhBOM6g8d18W9kgzsPYBTz1wDIX2oNstG9M8f2Op+w0pD
        Ufm2Y9t1ElifLc9SEiRocajaCRoMFbpnkTbtUeBi
X-Google-Smtp-Source: AA6agR6qGkKEpoCB4y4z2Nfn6F8FGMTGqSB0jDsDlFNtpaLby8i+m3RMKbYTL7Gl7kEO3mn0tWGpI1CGuOQPNHXc7C4=
X-Received: by 2002:a81:b80e:0:b0:31f:35aa:9cbe with SMTP id
 v14-20020a81b80e000000b0031f35aa9cbemr31278016ywe.511.1660184113381; Wed, 10
 Aug 2022 19:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220811015758.3001641-1-jstultz@google.com> <20220811015758.3001641-2-jstultz@google.com>
 <9d2f1a82-8e0f-c0ad-e23f-e0d00905a596@infradead.org>
In-Reply-To: <9d2f1a82-8e0f-c0ad-e23f-e0d00905a596@infradead.org>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 10 Aug 2022 19:15:02 -0700
Message-ID: <CANDhNCpm6Rn2qB53pHwo9ram-G=-r9Ku2tbi+Us7wwh9J3svEg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 7:11 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/10/22 18:57, John Stultz wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c7900e8975f1..b0dde2771314 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1278,6 +1278,17 @@ config SCHED_AUTOGROUP
> >         desktop applications.  Task group autogeneration is currently based
> >         upon task session.
> >
> > +config RT_SOFTIRQ_OPTIMIZATION
> > +       bool "Improve RT scheduling during long softirq execution"
> > +       depends on ARM64
> > +       depends on SMP
> > +       default n
> > +       help
> > +         Enable an optimization which tries to avoid placing RT tasks on CPUs
>
> Above line is indented with spaces only. :(
>
> > +      occupied by nonpreemptible tasks, such as a long softirq or CPUs
> > +      which may soon block preemptions, such as a CPU running a ksoftirq
> > +      thread which handles slow softirqs.
>
> All help text lines should be indented with one tab + 2 spaces,
> per Documentation/process/coding-style.rst.
> (The 3 lines above have one tab + one space.)

My apologies! I didn't notice (and checkpatch --strict didn't seem to complain).

I'll fix it up for the next revision.

Thanks for the quick feedback!
-john
