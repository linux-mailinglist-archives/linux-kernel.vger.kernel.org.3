Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD15B128D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIHCfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIHCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:35:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4469195E5E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:35:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z187so16475104pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ky2nnvwk5aMRpug1OiXdRVfX6OZ/Blwf8y/RgQf3zCU=;
        b=IfqRKpQJZLtUUw3FK0nalBJ+FjJYspG6C1fY/6m//4cf4HJJhIsIsPGoRoTTNsCnQS
         7nDJRuNF1imN5jNzf1YM9DNRaGaBVS8u6DC8VjpdD21adZbQ2kRVjn0a8VcZc1183KRg
         2rXc26R4gdOX0PTflk+HqGryZp4BUoLR5cBn30bUaqne7zTicctxBSgJs9JtzcnYXyZL
         eRBGv7Lp6b5LRD1WAHxDRG+vdsi5AHQ5lB6HeYq6qn4StAAY1Di5cQn9AePJ9KKqSKPs
         z6NWDM0fVXaufe1qxDay/6XZqvQJgXE6wAeA8OLyScix0+vjawVxHPhgPncsveXFTinG
         czFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ky2nnvwk5aMRpug1OiXdRVfX6OZ/Blwf8y/RgQf3zCU=;
        b=sco+nQVRdEy+Fm68fsStbRpANVvRmfyVp8nIof9/1uBWE8YpPb1484GsEu8G5gJEAs
         /oDivsYM15AKIZOeDwtNBDidJc9twdnRa8kOkisRNQO1OOUIHrWsRucnlKW5RZeKb12E
         BpH8y5tTcsgr095gJ9z/PM4Vr9Ka6WcJ8ToqZE6edfTb4wlT9NZudt++GT6OFks/Z04B
         hIEQgImXfAtAaVR0f11O9cEbffvYb/NJixO1GSSVhNP4XJYbySLWbFHNyOwnxkB8beCA
         a0XEgFE5gdHxndoWk7hQ/3rflqK9tZdGK9eik80qfya2Roqh7Nx4d25YKtFU4tEAWlVY
         6+9Q==
X-Gm-Message-State: ACgBeo2rer9Xq8/h1wMdywpQPfWGskYrlR47X5hYLBVG8FPXpDK62O2U
        nuRez6tJabBbDbf3+5MFDotuBvq1vTVP8kDshny9SA==
X-Google-Smtp-Source: AA6agR5EJ0ZEbrVZkpUuRie3AJaKAJdYbfgDtopgpj+sqF8J4AGNCc7ajxsAMVxIBf+qfSs0s80TkD+CAq7HDXDati8=
X-Received: by 2002:a05:6a00:2385:b0:53a:cad4:79de with SMTP id
 f5-20020a056a00238500b0053acad479demr6913798pfc.8.1662604521620; Wed, 07 Sep
 2022 19:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com> <20220907043537.3457014-4-shakeelb@google.com>
In-Reply-To: <20220907043537.3457014-4-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Sep 2022 19:35:10 -0700
Message-ID: <CALvZod70Mvxr+Nzb6k0yiU2RFYjTD=0NFhKK-Eyp+5ejd1PSFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Sep 6, 2022 at 9:36 PM Shakeel Butt <shakeelb@google.com> wrote:
>
[...]
>
>  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  {
>         long x = 0;
>         int cpu;
> +       int index = memcg_events_index(event);
> +
> +       if (index < 0)
> +               return 0;
>
>         for_each_possible_cpu(cpu)
>                 x += per_cpu(memcg->vmstats_percpu->events[event], cpu);

Andrew, can you please replace 'event' in the above line with 'index'?
I had this correct in the original single patch but messed up while
breaking up that patch into three patches for easier review.
