Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9744EEA57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiDAJ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiDAJ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:26:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D35F5BD2A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:24:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c23so2043148plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqHcENevlipVpLwJzXjFe9d3oZf1LHDk3dciHpBysEs=;
        b=SE0wj13yNQUKOLM7y5D13X3QyLAcWrPwhqQndeixZUJj6q9pgA456c8KR80+WD0J4T
         0B29QRq5HhGLr5tyU1zOJD/4zhyujrn1COBvQHyQG0IkF+B7lhHruTepHwDZ6y0Dyqdf
         udoZQegWVZWcu+U+gY66/nsmhnOOOqWbZ3bsB0CLnxC+FTaiugBCHOBpEr/IvU87nfid
         ng87Quwf+lM88JUvep0VBVmphTmD6/NdezPovc4WuobQb42jRkZ7P9qMVe+O9TuFF3RL
         geu+SYCVcB0i0i/mVYgCqw80holeY6GYkG2zo8XI2CVyJ8+ZRn2wD0Aa1RbFQmuCT/gO
         npFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqHcENevlipVpLwJzXjFe9d3oZf1LHDk3dciHpBysEs=;
        b=h5FRbDZ71K3zYpzYYH1JRDYuizFRgr0h/w5zM5oXgQmuAfOinqN7gAd/ZSbiKDeIV5
         sUXAgbKEwLoTes1Iis3G6NjNdLDg2/Cl18J8iKMaZiDYow8H0nueuMeFGfVkJTMjPU7r
         rJBRRU90pTwUUM2HdEqCAiR5ZWROo1NnaYDhEYX+ZRyQB1yl9+aAhT2KYMZ8gmVdO/Yd
         Kv5t1YAsnX9xGhwff4HCHoWcWp+PBBjVPsdcN6QygXEEhJlwMWnunZ0R/8ZCoSb9+54g
         /UEvZSeUHGWpOgNOxYUA8T8hPECqkb7SyuRH1Zzqd2i1Xej8NAmE7b+A1jAvgAMRA5H6
         va+A==
X-Gm-Message-State: AOAM533uVEkNXRz+iIE3ERh8MLi6xOljYQkTpqEhAD4NL2l5UBTwqj86
        iUlJbRw1wM/5CUycbJ+CLEJJ3kvjesHIw0KoyLQAXQ==
X-Google-Smtp-Source: ABdhPJyH95f+uF5qt0Sg+nXhMwNGNDRbUvVYUqz2vCJG9jFsEU4WrvTARHYgoWhnQP5k0RrMO50potZ/qEls6eMvXl8=
X-Received: by 2002:a17:902:f24b:b0:154:de5:a24c with SMTP id
 j11-20020a170902f24b00b001540de5a24cmr9550361plc.162.1648805049999; Fri, 01
 Apr 2022 02:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <874k3d6vuq.fsf@vajain21.in.ibm.com>
In-Reply-To: <874k3d6vuq.fsf@vajain21.in.ibm.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 1 Apr 2022 02:23:33 -0700
Message-ID: <CAJD7tka1UstKYBVrie-_1CgvtaLtVD1uwgzfk5SifxW4FQbOVw@mail.gmail.com>
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
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
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

On Fri, Apr 1, 2022 at 1:39 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>
> Yosry Ahmed <yosryahmed@google.com> writes:
> > From: Shakeel Butt <shakeelb@google.com>
> >
> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> <snip>
>
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     break;
> > +
> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                             nr_to_reclaim - nr_reclaimed,
> > +                                             GFP_KERNEL, true);
> > +
> > +             if (!reclaimed && !nr_retries--)
> > +                     break;
> > +
> > +             nr_reclaimed += reclaimed;
>
> I think there should be a cond_resched() in this loop before
> try_to_free_mem_cgroup_pages() to have better chances of reclaim
> succeding early.
>
Thanks for taking the time to look at this!

I believe this loop is modeled after the loop in memory_high_write()
for the memory.high interface. Is there a reason why it should be
needed here but not there?

> <snip>
>
> --
> Cheers
> ~ Vaibhav
