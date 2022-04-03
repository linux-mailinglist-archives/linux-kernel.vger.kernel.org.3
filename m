Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8D4F0834
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354715AbiDCG63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiDCG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:58:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13F5381B5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 23:56:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 9so7799224iou.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZlimpDrEHgO1rzyCYuAbLljxvciHy4QdNJs4xVtrnk=;
        b=T2EKk7dyMep8/29cdvnmpJvSBhC3tVejpCx/rLNsKf9qKNg480LjqMQQCRXV1WS/ql
         IiF4bR7DYMvv35us0w7WT1RPk7OpoLdrERvZ8VyxZJqHoBllBNyHAYErlPDEkLB+DHQN
         pqmkgvAu33MWBs0sIXCOx4fkIX797PCMn7wSpeVMYSEIROsVlttHatLTe/nIo46c5Yu9
         +PI1uA1Pynxd42/t/8MA5rtp2aNcmszrbKSoR5yHjyZfvqumvyp6bSGaB3AGan996wek
         XoIdhE2QCNIGkDF/ozpMGNF1ex5zm1Zqts+fajdYUF28OEIrsXf5yYKjIK5jzzYybDaa
         3idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZlimpDrEHgO1rzyCYuAbLljxvciHy4QdNJs4xVtrnk=;
        b=dpIeHIrMdu038HA2cwRZOyuo7/ONR2w+eqyvYkaECkBxGPeqGg9+7vuZRplSatkN0u
         MqQbo0VKamqleJL3FieifZMifeLn+I3+P1aQWbeN2whn/AM8FFK7wIjoZRDw0MnxRzLQ
         DEqBvmd4RH9i/Ig3FfZ+mPtdUe3iMJq9qsPYf6LuCbOzAFvclqZJrZM70m0gb0wCqA7y
         c9Om80Kb5biwOourOpIzju0k/6FfRnCKnZLY/kfIYMwNqrrpPCcUuJZ1cXDoVRCfpGkV
         PqAgSNbU0KqIWyAqaMRCaxpR9KoNy6X64FQ9ZNi6NH5YLmkfywYgUGzSNRBiC8lKzmew
         dNVA==
X-Gm-Message-State: AOAM531YoocWz1jIVhnxUcmakJAi9pXVum24bAbcdP89i8B5YAO7tHcG
        Egi/Xf9o5u7gUGm1zJYmEY8LXVr+CsoJBFibsOJaaQ==
X-Google-Smtp-Source: ABdhPJzb5mBXYffh2qbyaAwkzrHxSsPGl5iPs/oVvkZeOgVaq4/cqjWLGtERImQrJF6BNnSrg/zcLtNNEsH2s3lfa5Y=
X-Received: by 2002:a05:6602:2c52:b0:646:2488:a9a0 with SMTP id
 x18-20020a0566022c5200b006462488a9a0mr3051360iov.130.1648968990332; Sat, 02
 Apr 2022 23:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz> <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Sat, 2 Apr 2022 23:56:19 -0700
Message-ID: <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
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

On Sat, Apr 2, 2022 at 1:13 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> > On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
> >> > From: Shakeel Butt <shakeelb@google.com>
> >> >
>
> [snip]
>
> >> > Possible Extensions:
> >> > --------------------
> >> >
> >> > - This interface can be extended with an additional parameter or flags
> >> >   to allow specifying one or more types of memory to reclaim from (e.g.
> >> >   file, anon, ..).
> >> >
> >> > - The interface can also be extended with a node mask to reclaim from
> >> >   specific nodes. This has use cases for reclaim-based demotion in memory
> >> >   tiering systens.
> >> >
> >> > - A similar per-node interface can also be added to support proactive
> >> >   reclaim and reclaim-based demotion in systems without memcg.
> >> >
> >> > For now, let's keep things simple by adding the basic functionality.
> >>
> >> Yes, I am for the simplicity and this really looks like a bare minumum
> >> interface. But it is not really clear who do you want to add flags on
> >> top of it?
> >>
> >> I am not really sure we really need a node aware interface for memcg.
> >> The global reclaim interface will likely need a different node because
> >> we do not want to make this CONFIG_MEMCG constrained.
> >
> > A nodemask argument for memory.reclaim can be useful for memory
> > tiering between NUMA nodes with different performance.  Similar to
> > proactive reclaim, it can allow a userspace daemon to drive
> > memcg-based proactive demotion via the reclaim-based demotion
> > mechanism in the kernel.
>
> I am not sure whether nodemask is a good way for demoting pages between
> different types of memory.  For example, for a system with DRAM and
> PMEM, if specifying DRAM node in nodemask means demoting to PMEM, what
> is the meaning of specifying PMEM node? reclaiming to disk?
>
> In general, I have no objection to the idea in general.  But we should
> have a clear and consistent interface.  Per my understanding the default
> memcg interface is for memory, regardless of memory types.  The memory
> reclaiming means reduce the memory usage, regardless of memory types.
> We need to either extending the semantics of memory reclaiming (to
> include memory demoting too), or add another interface for memory
> demoting.

Good point.  With the "demote pages during reclaim" patch series,
reclaim is already extended to demote pages as well.  For example,
can_reclaim_anon_pages() returns true if demotion is allowed and
shrink_page_list() can demote pages instead of reclaiming pages.

Currently, demotion is disabled for memcg reclaim, which I think can
be relaxed and also necessary for memcg-based proactive demotion.  I'd
like to suggest that we extend the semantics of memory.reclaim to
cover memory demotion as well.  A flag can be used to enable/disable
the demotion behavior.
