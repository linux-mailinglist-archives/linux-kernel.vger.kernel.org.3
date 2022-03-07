Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0D4CEFF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiCGDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiCGDHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:07:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9715E156
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:06:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so12765421pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ey8cLWo1tz1DNUd2Nc6hiH1KedMMgMlODqQQD3VlCY=;
        b=Qgt1K3fEyPBstauNxxmncR1jrHD3gM7mvcJt6hygrWjZtJ2/1ZSN/u3TE8NNG5RBx8
         517BVk5U/KnYi/qULMblsVXoXv6URbi6qN/2VfdqHbiZf/fudYvnGqmJ/gdAe3U6M707
         VXEdd5QoT7oF4cMDfmF+E/yaiGsOXtMzfD3+AdHFS61S3OGqaWg6creqk8G3EmqnZasD
         v9u6tFSwNiJSn6S3aIew0NTPkbvCZpOlGx+QmVJmflNmyknitM57bkNSkqkKHLWNr9ba
         elJx5NozxzqnDMTy/Us3/cwJ2ZAEYjgcRUuPogVF6SKXZt3PAge1AGeaxdcYor6Y+GuF
         Hjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ey8cLWo1tz1DNUd2Nc6hiH1KedMMgMlODqQQD3VlCY=;
        b=FL6GtcEttY6s+4wRfKcULSnH/T0doOU87VRElNckQmLoyB6ViyHQjTMSzXw+5jhvXj
         0J0XUJuLF+3+m3m7xZuluIHsHlhbHlC07qcf8SiLf8M/FJDdgjMB0bVpyxwUtG4xP/4U
         ximqHrBxdtB+paA4Okx8/T6wZuTdDMZZRxs48KHeZ0QGz3d5pZROD/NDaCTRdZw8NfHc
         ZhNaqIqnAy9Jw09VCDxiqQOrtb+rBg115Ll1x4Qbvl0J7jMrg7rOpuXqwxDnUlyVi7ip
         v7GXmykp3Xm9qVKxZl1X4VKkqJmvKYfjgtP8ea2POj+4EZ1bSkHaG4RL53GjfrdrPN2D
         TmXw==
X-Gm-Message-State: AOAM531pDgFOz3aKGuiXliET0+CneF+QnPq+JgRB4IzY3jV0HM3JuBwW
        fxJYwifKve7nnA8H5TpoRpx+s8HhAieLp87gWJJH4dVTwqYvOw==
X-Google-Smtp-Source: ABdhPJxRokqzFjtZhzZrl2YEdzw7kIjEpxRXVztns9i9QlzriHGNyrKZnBcLga6GFIe22xMSyT7ICvA5lpmsSH5UwtY=
X-Received: by 2002:a17:902:e745:b0:151:5474:d3ed with SMTP id
 p5-20020a170902e74500b001515474d3edmr9762847plf.106.1646622408818; Sun, 06
 Mar 2022 19:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20220304184040.1304781-1-shakeelb@google.com> <20220306184404.049447f8447d288fde34cabe@linux-foundation.org>
In-Reply-To: <20220306184404.049447f8447d288fde34cabe@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 6 Mar 2022 19:06:37 -0800
Message-ID: <CALvZod4ea983DMvyyc=MDqQfd6H+9wUhwiT49Bzcz+1ye=MDzA@mail.gmail.com>
Subject: Re: [PATCH] memcg: sync flush only if periodic flush is delayed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Frank Hofmann <fhofmann@cloudflare.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 6:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  4 Mar 2022 18:40:40 +0000 Shakeel Butt <shakeelb@google.com> wrote:
>
> > Daniel Dao has reported [1] a regression on workloads that may trigger
> > a lot of refaults (anon and file). The underlying issue is that flushing
> > rstat is expensive. Although rstat flush are batched with (nr_cpus *
> > MEMCG_BATCH) stat updates, it seems like there are workloads which
> > genuinely do stat updates larger than batch value within short amount of
> > time. Since the rstat flush can happen in the performance critical
> > codepaths like page faults, such workload can suffer greatly.
> >
> > This patch fixes this regression by making the rstat flushing
> > conditional in the performance critical codepaths. More specifically,
> > the kernel relies on the async periodic rstat flusher to flush the stats
> > and only if the periodic flusher is delayed by more than twice the
> > amount of its normal time window then the kernel allows rstat flushing
> > from the performance critical codepaths.
> >
> > Now the question: what are the side-effects of this change? The worst
> > that can happen is the refault codepath will see 4sec old lruvec stats
> > and may cause false (or missed) activations of the refaulted page which
> > may under-or-overestimate the workingset size. Though that is not very
> > concerning as the kernel can already miss or do false activations.
> >
> > There are two more codepaths whose flushing behavior is not changed by
> > this patch and we may need to come to them in future. One is the
> > writeback stats used by dirty throttling and second is the deactivation
> > heuristic in the reclaim. For now keeping an eye on them and if there is
> > report of regression due to these codepaths, we will reevaluate then.
> >
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> >
> > ...
> >
> > @@ -648,10 +652,16 @@ void mem_cgroup_flush_stats(void)
> >               __mem_cgroup_flush_stats();
> >  }
> >
> > +void mem_cgroup_flush_stats_delayed(void)
> > +{
> > +     if (rstat_flush_time && time_after64(jiffies_64, flush_next_time))
>
> rstat_flush_time isn't defined for me and my googling indicates this is
> the first time the symbol has been used in the history of the world.
> I'm stumped.
>

Oh sorry about that. I thought I renamed all instances of
"rstat_flush_time" to "flush_next_time" before sending out the email.
Please just remove "rstat_flush_time &&" from the if-condition.

thanks,
Shakeel
