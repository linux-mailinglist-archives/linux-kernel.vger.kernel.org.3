Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34D533139
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiEXTDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiEXTDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:03:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EE9E9FD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:01:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so27073116wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPoBKVvC2etY1rrj+YwE9RcWhQO3Aeb8jFG7VSlxgGE=;
        b=eShZOTIUQ93TOWjEzr249Q2WlZgXfVBXRXVkiPqqzxHc3weu9dWI5q3Ho56xWalhYm
         DNCo2rp9rMlgNBrK8z0XY/wW3LtOYML1vS+M+JPqvzdBIyhIp4u0EN07gBXsnOV6nri8
         362c3np7lTLklsZKcOFMwfRRupNLAPynTYIAwR6xjCdZj/A/gIhF1Qfk1QwtUz1zpdDg
         OwP1XDrZlsnRRXavqft/ReWGqQnEA11Wn1yavd6amKib47Nc170P/orJbWp9qtErNk/7
         CisGNh6vWRjQoZRymrDq8S4Qa8rADzUXLl566tiu679wuf5A6NCGy//TjeVsXiZq3cdx
         FakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPoBKVvC2etY1rrj+YwE9RcWhQO3Aeb8jFG7VSlxgGE=;
        b=YSqhioswJ8djXbJ/vkRpMpbxN6AD6f0TrnGSOW4Y1DJHZPsbroiWxaYbUkveAxptzh
         hOpcI/eYg6sI7sZ+kDoD4+AN4Mth+D1HUFj0EQTwjN2i5Toemd1UrvK8+1KflXwsaPiP
         g4HFyNffoVCOTUvhbcy/yRB7zTJV9ArDR4Ndl0KgbT1eYwNcc5w7TZxM3a0wrEwHbLkW
         Ll5ueyktjGYjRvTqsZfUOjnBbHD+CB5DGp0t+2+4z+7g+k+Kp1dKjw7bwm8dkjnKH3bD
         zrvIFMTjPfBScnq6e2bowxGA9Exq6GDuCCn+kf2kgnhnBl3AQQyvimMqYoiNKj/U+Z1n
         t/Fw==
X-Gm-Message-State: AOAM532mbaBqFa0qs2JqkAOfvJESLEIALbBpen8KuO5knwLB8pArmo0u
        rXJBHKqx6BNFYd1FY891C2DIJNBfJo27chBrDLH9Ow==
X-Google-Smtp-Source: ABdhPJzPKmJrseAx4/O0R9Tr5Y5Yi3+iPsfVW2jq7/OFy7Iu3Ypo1SokZ9tOrFY3enB09mHuuuvffQ2Sa5Fxer4lfaM=
X-Received: by 2002:a05:6000:1548:b0:20f:c4bb:defd with SMTP id
 8-20020a056000154800b0020fc4bbdefdmr15202675wry.210.1653418898448; Tue, 24
 May 2022 12:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <YoYj4sLJfGke5IGT@dhcp22.suse.cz> <87zgjcg4xs.fsf@vajain21.in.ibm.com>
 <YodDaFVeU33bu7yQ@dhcp22.suse.cz> <CAJD7tkYwv2LDZeV2F5pxuniw7LCNjBapDCm3WuRhzwTH-jN3PA@mail.gmail.com>
 <YozFZI2euSjWPgDb@cmpxchg.org>
In-Reply-To: <YozFZI2euSjWPgDb@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 24 May 2022 12:01:01 -0700
Message-ID: <CAJD7tkZxvmnrrjc4yAe5mC+SL-MZqMkn21yjetiLYyq0B=AhtA@mail.gmail.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>
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

On Tue, May 24, 2022 at 4:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, May 23, 2022 at 03:50:34PM -0700, Yosry Ahmed wrote:
> > I think it might be useful to have a dedicated entry in memory.stat
> > for proactively reclaimed memory. A case where this would be useful is
> > tuning and evaluating userspace proactive reclaimers. For instance, if
> > a userspace agent is asking the kernel to reclaim 100M, but it could
> > only reclaim 10M, then most probably the proactive reclaimer is not
> > using a good methodology to figure out how much memory do we need to
> > reclaim.
> >
> > IMO this is more useful, and a superset of just reading the last
> > reclaim request status through memory.reclaim (read stat before and
> > after).
>
> +1

It might also be useful to have a breakdown of this by memory type:
file, anon, or shrinkers.

It would also fit in nicely with a potential type=file/anon/shrinker
argument to memory.reclaim. Thoughts on this?
