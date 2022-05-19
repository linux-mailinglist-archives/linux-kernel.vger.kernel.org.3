Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA452CB67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiESFLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiESFLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:11:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C993451
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:11:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p5-20020a254205000000b0064da2110759so3461752yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cmzHfr/tzIaOpFcknLr2dzNk6szSsRhRNS5zlznLZ9M=;
        b=Hsh2y+tLr1ztijKLv8pNbAuZtGgMNZKaeS/+tihdOAw9OZRZgK8Y09uonswsQfsVBc
         yihsoK8f+1QtnhGaH/zfGD621ZmVzl0rldmYwpKvrtSyDErXQUoFnZdVNLmUv3U/vBZo
         7NUnGfPAv0dqhDf7nkQW6ouOvGiZ3UyikHqUECpX5++9qZs+RJ8sGNuYjr5YbBp3zrEj
         6BIhoQT9a9Pxw920WN5jc6SQwddir956v/0RqSuIjghjDtmcEutBla82S7NkGgT45xFz
         JYrcB6j12U5LibCvgo2kWcfQuUI9LsgtOjoqffpsbLJas5Y3oYD/DN+Mkn/YDxAuuyot
         zQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cmzHfr/tzIaOpFcknLr2dzNk6szSsRhRNS5zlznLZ9M=;
        b=l7KUTsxzkYp9xj9n7MDLBisD6YbemVNkYiP7RF6mpVE911PfXhU5zUCSLFs80EHwlj
         bd2C0mDaRXYONQ7KaWTuQvXAIgoF4/son/6qL2AlVbZEoJ1MYF150Bz2upTqSb/II3mP
         Z+QyyvVBdk/E6kJJgoloecW0ZpQU8O521yTrnGLJGQu7XLXo13crvbBNRNQECDkZZz0A
         KCkDCt2usGuDTJU1Fj3nixEeXsCxRZwhIiZwiQURNmQwct6p2WxNHhzD+PtdQks9ev57
         LvM3b2qDCizQS7EQtSYjM/hhekMEK3j8EF4IkWcjQBKyupp+InPnLwAkqMahbc7C7OL/
         RXfA==
X-Gm-Message-State: AOAM532cHeXiqBrKEtqhVWNKDuxrO51M+O1oi4wfvYUKVCNvIekMt96s
        hnzux0k9psPdP1cNgyTkbKcv+yIdVQIXog==
X-Google-Smtp-Source: ABdhPJwU010Tq9p4lmf0G/jI2g6ryHWv35ZyP+KyxlRYUzzjrgMNUmWGRd+Ibcs6qVy1ZfqpU7CJYdnPwukEOw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:3b86:0:b0:64d:7480:5ca7 with SMTP id
 i128-20020a253b86000000b0064d74805ca7mr2628497yba.553.1652937103804; Wed, 18
 May 2022 22:11:43 -0700 (PDT)
Date:   Thu, 19 May 2022 05:11:41 +0000
In-Reply-To: <20220518190911.82400-1-hannes@cmpxchg.org>
Message-Id: <20220519050946.vzhgsxqgsmscgp2d@google.com>
Mime-Version: 1.0
References: <20220518190911.82400-1-hannes@cmpxchg.org>
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:09:11PM -0400, Johannes Weiner wrote:
> This reverts commit 3a235693d3930e1276c8d9cc0ca5807ef292cf0a.
> 
> Its premise was that cgroup reclaim cares about freeing memory inside
> the cgroup, and demotion just moves them around within the cgroup
> limit. Hence, pages from toptier nodes should be reclaimed directly.
> 
> However, with NUMA balancing now doing tier promotions, demotion is
> part of the page aging process. Global reclaim demotes the coldest
> toptier pages to secondary memory, where their life continues and from
> which they have a chance to get promoted back. Essentially, tiered
> memory systems have an LRU order that spans multiple nodes.
> 
> When cgroup reclaims pages coming off the toptier directly, there can
> be colder pages on lower tier nodes that were demoted by global
> reclaim. This is an aging inversion, not unlike if cgroups were to
> reclaim directly from the active lists while there are inactive pages.
> 
> Proactive reclaim is another factor. The goal of that it is to offload
> colder pages from expensive RAM to cheaper storage. When lower tier
> memory is available as an intermediate layer, we want offloading to
> take advantage of it instead of bypassing to storage.
> 
> Revert the patch so that cgroups respect the LRU order spanning the
> memory hierarchy.
> 
> Of note is a specific undercommit scenario, where all cgroup limits in
> the system add up to <= available toptier memory. In that case,
> shuffling pages out to lower tiers first to reclaim them from there is
> inefficient. This is something could be optimized/short-circuited
> later on (although care must be taken not to accidentally recreate the
> aging inversion). Let's ensure correctness first.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
