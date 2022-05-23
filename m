Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5D530FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiEWMwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiEWMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:52:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992852E77
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:52:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z7so3936129ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GenjPe3LrNC6qWAdvbWNOjWJ7IfOHse++vxp3OTgmUQ=;
        b=secIkysmb5CdxMzyOZgxQo6f+FanOyB5E3cxo6Rxju9Rm/74cgf9sa9rxCZgt49kkJ
         /eCSmsMF2Ckkp9CaGse5K+Ks+9cDHUInXyd7K6keRi6EzlrWmmoHX4ciHDRvhA9WdfUM
         JJLtstnYg4I3MNHr9WjaPLhYW3v6AmHSiB2MsW8Z5nl45qTEisxlQ5I+L9+R+anWrPn1
         VUeClI5k3CT8F2j2BKqF9ueMTo4FkQ8CY8UGrPoToEHCClTVYWRkNv9zzZCDMkULrpXB
         crtYKI/t+SXysAKpp3CulMjz9xkzo/EUICSzOx2YxpdRVUrM0PAkKnHGzq7SFRXeTDs1
         vs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GenjPe3LrNC6qWAdvbWNOjWJ7IfOHse++vxp3OTgmUQ=;
        b=gARRmGeWHsIxL7Qv4mJV2eMaCUr8iWR3bAmALedc8qQy5AUjUp8GxEChesi+Xpwr/q
         grVMPZZd9Auzb9td5TIduITWxA3ie9krbAzJotgCNEm/RZ63h+cQPtk4ltgOQuid7iNr
         w+8VkA7UU/MwnIIuA9Fff4TpGa6J9PpJK2TBCCOQfdZOiBc0rh8BnpS+06Tiwds79hQs
         A97tLcbc9DtM6+tuxLOs1rnQKt/LxHWFaazdlImPzdg0DFrFKYe6iRV+14WHkCFmR6HA
         jzm9qeBmI8WWXj+K+bbpKJW14S8cqIHtlxVQE6Eq223E9s5ZfJUFkp3ZLs4hGBsyljjp
         AKeg==
X-Gm-Message-State: AOAM530Xra+v9wfPzx7AooM3xLFhgIM9FzN6ShJXIsQmioIxNsTXFu/k
        N0o9C38TyklGPtcqJG8J7WLeJ6OM3axWb44x2jsnqg==
X-Google-Smtp-Source: ABdhPJxQsxRY8MZEwvMmwMzw4W5ZnpO9KwDz9+Bps++wbCzQG9LfnVLNbfO2M/6yNd8qAjAnQDwIdvEl7E09uMJLu6U=
X-Received: by 2002:a25:23d2:0:b0:64e:a1e4:683c with SMTP id
 j201-20020a2523d2000000b0064ea1e4683cmr22036776ybj.211.1653310351099; Mon, 23
 May 2022 05:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
 <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
 <CAKfTPtBEHyP202duKwJi+GVNTMza+L_PuK3hmUxcjKnODOuRjw@mail.gmail.com>
 <9c0f9158-2d0c-dba9-1505-79ba4e642684@oracle.com> <aa8746fbb27849ee34ddb0ff028d0a1ee064c506.camel@linux.intel.com>
In-Reply-To: <aa8746fbb27849ee34ddb0ff028d0a1ee064c506.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 May 2022 14:52:19 +0200
Message-ID: <CAKfTPtAotgr+C1zXyWDSZt59NFX7Twb7gQLMcSv5hm6ywM85+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add latency_nice priority
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Chris Hyser <chris.hyser@oracle.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        joshdon@google.com, len.brown@intel.com
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

On Fri, 20 May 2022 at 20:46, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Thu, 2022-05-19 at 14:14 -0400, Chris Hyser wrote:
> > On 5/19/22 10:16 AM, Vincent Guittot wrote:
> > > On Fri, 13 May 2022 at 23:44, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > > > On Thu, 2022-05-12 at 18:35 +0200, Vincent Guittot wrote:
> > > > > This patchset restarts the work about adding a latency nice priority to
> > > > > describe the latency tolerance of cfs tasks.
> > > > >
> > > > > The patches [1-4] have been done by Parth:
> > > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > > >
> > > > > I have just rebased and moved the set of latency priority outside the
> > > > > priority update. I have removed the reviewed tag because the patches
> > > > > are 2 years old.
> > > > >
> > > >
> > > > Vincent,
> > > >
> > > > Thanks for introducing the feature again, which is much needed.  I am trying
> > > > to look at the problem again from usage point of view. And wonder if
> > > > there are ways to make the latency_nice knob easier to use.
> > > >
> > > > The latency nice value here is relative.  A latency sensitive task
> > > > may not tell if setting the latency_nice to -5, or to -10 is good enough.
> > > > It depends on what other tasks are setting their latency_nice value to.
> > > > What a task does know is what it it doing and its characteristics.
> > > > For instance for client tasks, we may have categories such as
> > > >
> > > > Task Category                                   latency_nice_range
> > > > -------------                                   ------------------
> > > > urgent                                          -19 to -16
> > > > media playback                                  -15 to -11
> > > > interactive (e.g.pressing key)                  -10 to -6
> > > > normal                                          -5  to  9
> > > > background                                       10  to 15
> > > > opportunistic soaker task (sched_idle class)     16 to  20
> > > >
> > > > And we could allow a task to set attribute of which task category applies
> > > > to it and the OS can set a default latency nice value in its task category.
> > > > So a task can just declare itself what kind of task it is, and not worry about
> > > > actually setting a latency nice value which it may not know
> > > > what is appopriate.
> > > > If needed, a task could still adjust its latency nice value within the range to
> > > > differentiate itself in a task category. And we will prevent
> > > > a task from seeting inappropriate latency nice value out of the right range.
> > >
> > > The description above make sense but I'm not sure this should be put
> > > as part of the interface but more in the documentation to describe how
> > > system can make use of nice_latency
> > > > Knowing a task characteristics will also be helpful with other
> > > > scheduling decisions, like placing a task on a more high performing
> > > > core in hetero systems.
> > >
> > > Ok so you would like a more general interface than an latency
> > > interface but a way to set some attributes to a task so we can make
> > > smarter decision
> >
> > The original definition of latency nice was as a task attribute describing the latency sensitivity of the task. The fact
> > that it was mapped to 'nice' values created too much granularity and made it look more like a tuning knob than a
> > statement about the characteristics of the task as intended.
> >
> > > > I think the missing piece here is a way for a task to declare
> > > > what kind of task it is.  I think that will make things easier.
> >
> > A classification of tasks into categories would be useful, but perhaps one level up in a user space tool or a user's
> > head (ie docs). For any of the categories you describe, there may be a number of per-task attributes beyond latency
> > sensitivity needed to capture the task characteristics you mention and ideally would be set in specific ways. Say 'nice'
> > values, oom kill, etc. And others may make sense in the future, like say NUMA sensitivity, etc.
> >
> > Basically, a category can map to a bunch of desired default values for various scheduler visible task attributes.
>
> Yes.  I think having a default value for each category will make the setting of the attributes
> consistent and life of a task simpler.
>
> Without guidance, one media playback task can set its latency_nice to be -5,
> and another interactive task doing computation and displaying results to user
> set its latency_nice to be -6. We would have the interactive task running ahead of the media playback,
> which is undesired.  Just letting each task set its own latency_nice value will not achieve the
> desired effect.  We need guidance on what attribute value a certain task category
> should use (as in documentation that Vincent mentioned).
>
> Or let OS set the attribute to some sensible value if it knows the task category.

I'm in favor of documentation that provides guidance rather than the
OS setting attribute because the values are relative to each others so
we will always find some exceptions to a default configuration for let
say media vs user interaction. With a documentation, someone can
always not follow it if he thinks it doesn't apply to his system
because of whatever the reason. With the OS setting attributes, this
exception will have to abuse its category to get the right priority vs
others

>
> >
> > Now you could also take the idea in the other direction where you set a "category value" for a task and have the kernel
> > pick the other attribute defaults like 'nice' that would typically apply to tasks in the category, but I think letting
> > user space figure stuff out and then set low level kernel task attributes primitives is cleaner.
>
> It is cleaner for the OS to give the knob to the user and say, "set it".
> But users need guidance on what knob value they should use,
> or even better, they don't need to worry about setting the knob.
> I think it is easy for the user to set task category correctly, but
> harder to set the low level knobs.
>
> I can see that it is easy to set the latency_nice knob incorrectly.
> The absolute value of the knob doesn't matter. Only the relative values
> between tasks do. So we need all the tasks to agree on what latency-nice
> to use for a task category.
>
> Tim
>
>
> >
> > -chrish
>
