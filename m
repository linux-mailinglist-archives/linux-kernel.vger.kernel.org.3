Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE574F1C08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379954AbiDDVVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379517AbiDDRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:21:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B6E098
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:19:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so8713492plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhZvWBIYSPxrHtL/UXP4sOCKqMqAgTQ5cHbzprIzUlI=;
        b=rzW4aaUe8wJHBTW/ExLvJddgYRg1t4YhtSpQVQScLfUwXMUjqtSxLLNi52Rpn5/B9e
         4fm33kwEjNNC8PObxWVWNVFke/MshRfAUZolEP0oeRGIcWs1cMZ8dqnCMHUOTSSXF2R+
         Nxc7bj+ITBZAcBUCg6yEKcw6zz2obIN/RDEpBS+4YLPJ4AjvRWmQYm9ga69a1RiY4EDX
         oGzty137ABa8Ztyvwr1RlrkdXRpVcepr1eO0rJxfGr76K3XVs6VQ3L6PIza3Wro/7erv
         oZSbbPlhDhdZagCPj0TuB4euNN0h0a1bfMWvh80WoOYfDkjShCEByhv1m6HFJ/OrDhaM
         E/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhZvWBIYSPxrHtL/UXP4sOCKqMqAgTQ5cHbzprIzUlI=;
        b=pM66YnWM8SHnkgDiqATaY1RBFeNN2dFvjerTM2zOmrj2Rq5MkMu7IhigSXLm4ntf2A
         GBvmUJCG0kTTMevSZ9mcRhY5VhnN9dKMYU/le2QisR0ZsrdYCXVrp/WA8PEX5lfttq9S
         wQrPQK0SJJS3VTcN/Y8TJ/SnWL8p8j39qYjKMfYph/qZXtW13nQc5HztlAh6vRhiR0ZC
         KNpG9KAdTDUBAMZBTOJ7rP/B9V/bzycf42IjucncNu0MK8ZVENoeLG4QSR/p0+Y4KWVp
         K3MADm967jX8ozeJdk4UHJnrX0b/9N3LRnBAj0/iJSbtGXZ0nT/yF2u5fTZRtJJ8tMMO
         4hWA==
X-Gm-Message-State: AOAM532+9NfYQnfN3HStcPM7gM5/JCjhdxN/3YFJpD53WhHwFrinBkUn
        i4cZYDYyWXPyXtQLKUI3hwc0XV9sA0w4WcRG8doBcA==
X-Google-Smtp-Source: ABdhPJz50EolXnmloOFRdflV7luhmQEbXQ6TLx1sRiAzjczB5dC9hpz0y8SCGJwdMY8U2thvWleWIxvnBRXFYbPjKbA=
X-Received: by 2002:a17:903:2351:b0:156:a562:b3f8 with SMTP id
 c17-20020a170903235100b00156a562b3f8mr670651plh.81.1649092759112; Mon, 04 Apr
 2022 10:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <874k3d6vuq.fsf@vajain21.in.ibm.com> <CAJD7tka1UstKYBVrie-_1CgvtaLtVD1uwgzfk5SifxW4FQbOVw@mail.gmail.com>
 <871qyd7bif.fsf@vajain21.in.ibm.com>
In-Reply-To: <871qyd7bif.fsf@vajain21.in.ibm.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 4 Apr 2022 10:18:42 -0700
Message-ID: <CAJD7tka01bKnxQuizxTN7MtHj_hYu+dSztC2fY0jUPCcvk-9JA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
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

On Sun, Apr 3, 2022 at 8:50 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>
> Apologies for the delayed response,
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Fri, Apr 1, 2022 at 1:39 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
> >>
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >> > From: Shakeel Butt <shakeelb@google.com>
> >> >
> >> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> >> <snip>
> >>
> >> > +
> >> > +     while (nr_reclaimed < nr_to_reclaim) {
> >> > +             unsigned long reclaimed;
> >> > +
> >> > +             if (signal_pending(current))
> >> > +                     break;
> >> > +
> >> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> >> > +                                             nr_to_reclaim - nr_reclaimed,
> >> > +                                             GFP_KERNEL, true);
> >> > +
> >> > +             if (!reclaimed && !nr_retries--)
> >> > +                     break;
> >> > +
> >> > +             nr_reclaimed += reclaimed;
> >>
> >> I think there should be a cond_resched() in this loop before
> >> try_to_free_mem_cgroup_pages() to have better chances of reclaim
> >> succeding early.
> >>
> > Thanks for taking the time to look at this!
> >
> > I believe this loop is modeled after the loop in memory_high_write()
> > for the memory.high interface. Is there a reason why it should be
> > needed here but not there?
> >
>
> memory_high_write() calls drain_all_stock() atleast once before calling
> try_to_free_mem_cgroup_pages(). This would drain all percpu stocks
> for the given memcg and its descendents, giving a high chance
> try_to_free_mem_cgroup_pages() to succeed quickly. Such a functionality
> is missing from this patch.
>
> Adding a cond_resched() would atleast give chance to other processess
> within the memcg to run and make forward progress thereby making more
> pages available for reclaim.
>
> Suggestion is partly based on __perform_reclaim() issues a cond_resche()
> as it may get called repeatedly during direct reclaim path.
>
As Michal pointed out, there is already a call to cond_resched() in
shrink_node_memcgs().
>
> >> <snip>
> >>
> >> --
> >> Cheers
> >> ~ Vaibhav
> >
>
> --
> Cheers
> ~ Vaibhav
