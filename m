Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E84DA0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbiCORJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiCORJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:09:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A4639C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:07:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w7so34153246lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OwTI3UtdnqUESoKlohwZIL3xHHO7DnZYdKpKk+9gN8=;
        b=T+8KXwJOwXVyiorrQqYAEcy7XHZKpO6ojbZEyPTVsXpl1EMi8Uklm6Fupyz0/zXQ3t
         s70j/5coRJYMChxYcdoJSi+mobg6Zrk0EBVr+odk8Rhko8jE54yeCVH50apvJx5fuCGB
         UXVSqgIT0M14ZwNPtk8DGNiXL2zvr8UU9JkRdUdrP+W1VQB7fwT50tMM9xi8hOVzrRNc
         15dGLzoO0y/G+rc/+CTXwpQ+ONpVfKJdegMC3A1VjEUb1Ym5rc9t9Ul/HO09WU//bNbs
         cbWymF7b899NetmXvns0IyzfU3tn8PJuop1pZnP713Xa6vWWvCyrLlE16b2g97HAU6xI
         50iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OwTI3UtdnqUESoKlohwZIL3xHHO7DnZYdKpKk+9gN8=;
        b=8Pi+3KRSahG69sT/H5aqNYupIhSL4WHvKQaL1FFxwXwWZjgW7yTLwCbxzoyRbC3Y4f
         IL3qkK/37hmslrcZJnzfBCDzmJUT+83b5nH4G/57/q09gyjEKieUJ76CgctHfqr/DxF+
         RqATWMOkrwyp0c+pMq3tCLvXxtBNKyHRlCuFXXzb7Ib9MB+/DTrdPyhI+wabKmF8pXOO
         uQW1aJCez/USNwMqNizf2TwUaL6puLAa5QJDuXbkDVuoZur78OlsJy0oFNBAIHHOQ8lf
         vV686wU7fVde47fu3QJUtXPXvjbo4gLtTDNa4Tgo5Z+tQ5ZLDlx10CSsnCOniJJquEqu
         zIVA==
X-Gm-Message-State: AOAM531Xam0z9qNDmB9DbQDQg57TLIBuNEi7y5x3fhHUuDk85JU3Z5xh
        JiqhfaMgaC5173Yy8Utkh4QWo6ULcnEXTR9sltoAgw==
X-Google-Smtp-Source: ABdhPJw9hAhG0DNB8EFqKWQtVHVToNYXk82biM84hBl1YWN/4P4/jEnTwAL/yHV5wIyR52SApMeCUusq51PrfjEraBI=
X-Received: by 2002:a05:6512:3f99:b0:447:1ef5:408a with SMTP id
 x25-20020a0565123f9900b004471ef5408amr17117476lfa.490.1647364068619; Tue, 15
 Mar 2022 10:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org> <CABk29Ns1=2kc3JAESx_Ce7PP86KqiDA4O9K+vaOLZbKfq_XVaQ@mail.gmail.com>
In-Reply-To: <CABk29Ns1=2kc3JAESx_Ce7PP86KqiDA4O9K+vaOLZbKfq_XVaQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Mar 2022 18:07:37 +0100
Message-ID: <CAKfTPtAZVred+GqR5Uj0eGeawhhbSQR5+N4GFvtkM-KsYrcSpw@mail.gmail.com>
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>, qperret@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>
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

On Tue, 15 Mar 2022 at 01:59, Josh Don <joshdon@google.com> wrote:
>
> On Fri, Mar 11, 2022 at 8:15 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> [snip]
> >
> >  static struct cftype cpu_legacy_files[] = {
> > @@ -10649,6 +10673,11 @@ static struct cftype cpu_legacy_files[] = {
> >                 .read_s64 = cpu_idle_read_s64,
> >                 .write_s64 = cpu_idle_write_s64,
> >         },
> > +       {
> > +               .name = "latency",
> > +               .read_s64 = cpu_latency_read_s64,
> > +               .write_s64 = cpu_latency_write_s64,
> > +       },
> >  #endif
> >  #ifdef CONFIG_CFS_BANDWIDTH
> >         {
> > @@ -10866,6 +10895,18 @@ static struct cftype cpu_files[] = {
> >                 .read_s64 = cpu_idle_read_s64,
> >                 .write_s64 = cpu_idle_write_s64,
> >         },
> > +       {
> > +               .name = "latency",
> > +               .flags = CFTYPE_NOT_ON_ROOT,
> > +               .read_s64 = cpu_latency_read_s64,
> > +               .write_s64 = cpu_latency_write_s64,
> > +       },
> > +       {
> > +               .name = "latency.nice",
> > +               .flags = CFTYPE_NOT_ON_ROOT,
> > +               .read_s64 = cpu_latency_nice_read_s64,
> > +               .write_s64 = cpu_latency_nice_write_s64,
> > +       },
>
> Something I considered when adding cpu.idle was that negative values
> could be used to indicate increasing latency sensitivity. Folding the
> above latency property into cpu.idle could help consolidate the
> "latency" behavior, especially given that it shouldn't really be
> possible to configure an entity as both latency sensitive and idle.

The range of latency nice is [-19:20] and it doesn't touch on the
weight whereas sched_idle behavior impacts both the shares and the
preemption so I was afraid of possible confusion with what latency
nice is doing
