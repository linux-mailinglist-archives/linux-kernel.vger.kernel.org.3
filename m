Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7049D4E551C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiCWPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245101AbiCWPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:24:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E556428995
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:23:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 17so2329306lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPdkWbfJsi8zDIxFMj+CKiirvLw5O3ewudMuDoa4c84=;
        b=YtfFhWUBBF7jYtKYGEfJ1xNeZXzyCK9U6aFi6MqR4OTZQSyD9ZjXAI1M03pt4aZe0U
         tg5QpsXRNJsi9GHeDIP66JnJo9IGEWbm5viCXlhJd24MQdfyATHOzgZSLplfGLm3GOO/
         HByHycBca5E4s5yZdrOQ9h3WOu07keNfJ4xpRsd7JJih2LN5OLIfHOp2wLcwyihnNrH8
         lhzz6Q4FhcB1vIGNCBci36+NqJYuCQKc2ET7G04bJdLM+9ZUB/6OHYtjAKDG7soRObrk
         04GTPkDQnm+OpBohd4PQlWJzGe5Gz/mSKCSWjwqJtkkIbP+lyK5dbo6XNJ/BLgWulSUv
         tzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPdkWbfJsi8zDIxFMj+CKiirvLw5O3ewudMuDoa4c84=;
        b=hBM0XUfQvvxnSCuL63puC6auFUpsojCjqzCTm6o7X+zznIFTB1bgv9GMMVr4N87Roc
         852HjnikG4WItkVQw7+exbyR8HuAOSUrlH6gtsHFauHAmxm777UTeyM5PBKeLYRr/WeJ
         xz1K2ZvPWn1BICwX3feWX9FhVsoAjNBZvnSOW223KNt2KVIkwwpE7wF3sj++aBJbeJ5H
         fBgOf4g2PDGd6bkwVW5L8vPF2n6BDz2SBt05YXBKzb1lIX+65J5PV+MtGmOL5kCCXcfs
         tR8xrixQOdYRUUA2/6qcY40QbKsGTodm2RX35jHAcqlKkAs6/ypU4KWZlpSFFFWV0GBV
         tGhg==
X-Gm-Message-State: AOAM531qQoadsZbbQhskX/IxR3+ipwqcRzw7S6wQtZNF4wV5FccVlZUy
        g9gPlafpZRynRjfYPxTgQG2lHy29j5frOR0ReSsQzA==
X-Google-Smtp-Source: ABdhPJyoRqphnjB2UcTefoGBg0qrolh/MnL/8ndrJ6ufncCeviK4MmIVioHwYbRvgKaI41MznynORtMpZK24Q6Le7K4=
X-Received: by 2002:a2e:b6c3:0:b0:249:9b61:656f with SMTP id
 m3-20020a2eb6c3000000b002499b61656fmr404573ljo.266.1648048997144; Wed, 23 Mar
 2022 08:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org> <Yji0twS4N+0b/Rs9@slm.duckdns.org>
 <3c3a86fb2ead653318ecbaf2c999f6088c6eca4f.camel@linux.intel.com>
In-Reply-To: <3c3a86fb2ead653318ecbaf2c999f6088c6eca4f.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Mar 2022 16:23:05 +0100
Message-ID: <CAKfTPtDjHGT313+j9Mtmx-taaKZWTaNmN0KzsEdDY4k-yL0ypA@mail.gmail.com>
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@google.com
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

On Tue, 22 Mar 2022 at 17:41, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Mon, 2022-03-21 at 07:24 -1000, Tejun Heo wrote:
> > Hello,
> >
> > On Fri, Mar 11, 2022 at 05:14:06PM +0100, Vincent Guittot wrote:
> > > Tasks can set its latency priority which is then used to decide to preempt
> > > the current running entity of the cfs but sched group entities still have
> > > the default latency priority.
> > >
> > > Add a latency field in task group to set the latency priority of the group
> > > which will be used against other entity in the parent cfs.
> >
> > One thing that bothers me about this interface is that the configuration
> > values aren't well defined. We have the same problems with the nice levels
> > but at least have them map to well defined weight values, which likely won't
> > change in any foreseeable future. The fact that we have the
> > not-too-well-defined nice levels as an interface shouldn't be a reason we
> > add another one. Provided that this is something scheduler folks want, it'd
> > be really great if the interface can be better thought through. What are the
> > numbers actually encoding?
> >
> >
>
> The way I was interpreting the latency_nice number is as follow:
> Given runnable tasks that have not exceeded their time slice,
> the task with the lowest latency nice number run first.

The current version is not such binary in the decision as I wanted to
have a smoother level of preemption between close latency nice
priority.

>
> The current patchset takes care of the
> case of tasks within a run queue. I think we also need to
> consider which cpu should be selected for a waking
> task, if we cannot find an idle CPU.
>
> It seems reasonable that we wake a task on a CPU that is running a task with
> a higher latency nice value and lower load than previous CPU the waking task
> has run on. That way we can wake latency sensitive tasks faster in a busy system.
>
> Tim
>
