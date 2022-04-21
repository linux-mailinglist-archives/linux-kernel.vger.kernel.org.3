Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB550A408
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390060AbiDUP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390018AbiDUP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:28:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67F1A3BD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:25:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t12so5182532pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X/olzZyiEOTaDnSyvUQfJTotSJF//8MOqgCU8Vd1Hk=;
        b=EY3vQ8aQYxoLMh83TYT+sWZvvXQ5Q00X8s+8TVct4w2bwn28LSqEbXyWHMkfT764BX
         X7kAMRbROJdVuSuhy0oW4ukxJYDi9452CKht+efnYSRj+5mnACYOmLbXO3H4g7DqdGwQ
         TItWlo987dF8taxXxRwH1XTOjLsHO1rrWiCpLZB33gx7+iMoCqZsfhw1DCiayNGZUQFz
         LRJCnjLv63jX+dsQrIA/F+cVj3MRpm+zKCrObpwM2GZksgRphVhFiwVQMSULFFFFAxiG
         77MBLO77H7Ck9de/bqGmfgdY4aHJs3CZYx78B5HWsmwJv0Ejy0OkGYbfeyEOOcEidDjt
         El9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X/olzZyiEOTaDnSyvUQfJTotSJF//8MOqgCU8Vd1Hk=;
        b=V8YbBOUcvAcvQ1iGn4J2GuSJujCMHZeV434Lwdhv/RwAPSaPAbCf+rfLBai2sfX8SY
         FoZ++ORMJn06yVxHOV7bpApwcvym9uPEK6HbhQeUkcrK/VsKTZCsh3dNirMHWY+VHwWF
         Fi6kW/KAY3MaJz11oUSz2fAS0MtFnOriOfWlWnsjLzY2hMH86llXFf31Md77+EqSIK3A
         plH84xtLd5HR/YGNoVZnTgGo0EBAXP2gtD2YeEijBrwK4jv9reLDkuO1tSKi3E7LhrA3
         JURLGgUCG33+ZKA8a+GK/qQHzB83Bb/McowSC7cyghHm2CJCi3Y+kMKo9lGCyuC9dGGV
         aHVA==
X-Gm-Message-State: AOAM5322IGvYufkJGea44jFqQbVW9j3dIu1/TQZ0dzwLwQjdQHIMBB5y
        6L+IjfGKOIdOrgDsuIJTr6yUHhWMXOjQOGZjemjH7A==
X-Google-Smtp-Source: ABdhPJxhUlkzsVifLeex0uye6BzHOsePBN4vsPwvKF0JB6gGtGu9+0yzrhAcyhs2TPLbVDSSbAfyFtWMs88v92ospfc=
X-Received: by 2002:a17:90b:3b8c:b0:1d4:cd93:ffe7 with SMTP id
 pc12-20020a17090b3b8c00b001d4cd93ffe7mr157473pjb.237.1650554736855; Thu, 21
 Apr 2022 08:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220421124736.62180-1-lujialin4@huawei.com>
In-Reply-To: <20220421124736.62180-1-lujialin4@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 21 Apr 2022 08:25:25 -0700
Message-ID: <CALvZod6zbOG_fBCYGufm=fJrA-yZH4AWrThapFb3Gm_4ACQoeA@mail.gmail.com>
Subject: Re: [PATCH -next] mm/memcontrol.c: make cgroup_memory_noswap static
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:48 AM Lu Jialin <lujialin4@huawei.com> wrote:
>
> cgroup_memory_noswap is only used in mm/memcontrol.c, therefore just make
> it static, and remove export in include/linux/memcontrol.h
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
