Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85C4C9161
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiCARWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiCARWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:22:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB182AC66
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:21:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so2286218pjq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDu+y+f8JQYU3RGpZYFrasVkU7NMBDyxJALCa/zmka4=;
        b=fZDK1hgTtMcHNo/1P6qNEVs6yPXFW/deYvEker6YOPN/13zmSjk1YYcJXGviYMEHVE
         8E5wYMvxqyk9r+yvmbYSX6r1jorlcBKFdppXneLtzmArqDVTPbn4BjCzfdnEoQYkvwpC
         +1KPBbrEQXutzxvFKYDHODHzf6BNyzYGQyini1yAIT1q5rKocES28Miw5n8nRC4DsrUW
         95jHg8JdltfmO7jbciMVzAMSOll3yN75VkTePIEZC/jJNJdH+LM5DcXvo1Lu0SyJaJgb
         LvnaHbrHPb/kASBRMt331ZL1U+jq0zO09UlbhoWsibz9JmgWc/nM7dCtnLg2Pfsa+8HM
         kCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDu+y+f8JQYU3RGpZYFrasVkU7NMBDyxJALCa/zmka4=;
        b=sH8Z+PxJ+lqEylbrzZVaSWDntDirPAbef9SU40uk4i3Iq5J0RUdFiIiVBkMcaPUlCX
         9rIe4a2YTPdlPwuw3X/15wK/tdoTItPi3VJHFPG+nBVqospEMPEL3Vu5321VtB00HcAj
         Vj0q6zk1UV1PsoifIuVvqTzVAHFjEArm32agb2ZKbNJA7A7xTmF4jxtJeHw1jALljTkv
         WnA4W6dsAvmewX02vaWoZs5DjFtyXiElfUlIrf+9jGhyiFL3KMEskhPYJ2wlmOzHnTDu
         GNO20SENuakSfHJD32/KRefqsZNB5WTl3CBEvRs+fJnTkVWHJbPRGbLTwTBXDxkoxybU
         8wKA==
X-Gm-Message-State: AOAM532fmSmUPt6W+DPFCcg3h9ZdF7XBQwfvxoeR37rquvUHwmNU+JFb
        KAXfhoaN//PPPoTJVyB0raWNiexH8HnlaKOnfmD5EA==
X-Google-Smtp-Source: ABdhPJyt2R86MfvJOKl18sRXeH5vqN/UgE3OOP6++3snjuxTLntHdzYRzxuBoBm6IARu9orWbMDqL72UVWnlthx7f2w=
X-Received: by 2002:a17:90a:eb0b:b0:1be:ddea:29ef with SMTP id
 j11-20020a17090aeb0b00b001beddea29efmr3604540pjz.126.1646155284124; Tue, 01
 Mar 2022 09:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20220226002412.113819-1-shakeelb@google.com> <Yh3h33W45+YaMo92@dhcp22.suse.cz>
In-Reply-To: <Yh3h33W45+YaMo92@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Mar 2022 09:21:12 -0800
Message-ID: <CALvZod7aF9xRc+XvY7GPN7OnDyPitt1H6Q4yrwzAXTFzv1LzWQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
To:     Michal Hocko <mhocko@suse.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 1:05 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 25-02-22 16:24:12, Shakeel Butt wrote:
> > Daniel Dao has reported [1] a regression on workloads that may trigger
> > a lot of refaults (anon and file). The underlying issue is that flushing
> > rstat is expensive. Although rstat flush are batched with (nr_cpus *
> > MEMCG_BATCH) stat updates, it seems like there are workloads which
> > genuinely do stat updates larger than batch value within short amount of
> > time. Since the rstat flush can happen in the performance critical
> > codepaths like page faults, such workload can suffer greatly.
> >
> > The easiest fix for now is for performance critical codepaths trigger
> > the rstat flush asynchronously. This patch converts the refault codepath
> > to use async rstat flush. In addition, this patch has premptively
> > converted mem_cgroup_wb_stats and shrink_node to also use the async
> > rstat flush as they may also similar performance regressions.
>
> Why do we need to trigger flushing in the first place from those paths.
> Later in the thread you are saying there is a regular flushing done
> every 2 seconds. What would happen if these paths didn't flush at all?
> Also please note that WQ context can be overwhelmed by other work so
> these flushes can happen much much later.
>
> So in other words why does async work (that can happen at any time
> without any control) make more sense than no flushing?
> --

Without flushing the worst that can happen in the refault path is
false (or missed) activations of the refaulted page. For reclaim code,
some heuristics (like deactivating active LRU or cache-trim) may act
on old information.

However I don't think these are too much concerning as the kernel can
already missed or do false activations on refault. For the reclaim
code, the kernel does force deactivation if it has skipped it in the
initial iterations, so, not much to worry.

Now, coming to your question, yes, we can remove the flushing from
these performance critical codepaths as the stats at most will be 2
second old due to periodic flush. Now for the worst case scenario
where that periodic flush (WQ) is not getting CPU, I think it is
reasonable to put a sync flush if periodic flush has not happened for,
let's say, 10 seconds.
