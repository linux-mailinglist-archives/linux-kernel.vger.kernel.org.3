Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156BB4A65A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiBAU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiBAU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:26:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF0C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:26:23 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a28so36223970lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltsemEE7HoLIKHkXcNlB0CpyePLR2S+8XYoTKvHdxwY=;
        b=ILkxG8/cjLZ6qIh6DnpralN/7qPYJkgLY+jsRisfd/5RIxS+tiPGowEFvFcFCmoom2
         rOFOao7QsK1hqJb/iBbG5OlCnuwCLIOXNte8Uzmfp4w1C5NiHSQj18qKISohu3dzkpgG
         zFyaeh67n/77ciUQerZgJrjWe4ZAC/VOSE8tHPji7NH4YcGU9yMg6fMbgjT2T7l8JIwH
         XNdimVFcCkjEYZcw2BWwPWhbBAeOUju8ARI30snW8sNsQOH0uHWWDwwtbTZ8TvlLOp+a
         Z9FoLYNJfFXuRGf4TR5GhbG7zriw5+Ioi3cmcZjVwQzAFsEpYEJI/8bCmnL0p4vVc6JV
         K7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltsemEE7HoLIKHkXcNlB0CpyePLR2S+8XYoTKvHdxwY=;
        b=EdlPd656+AOWeI3f8VlzyqQKeJL0mhFvEErhyHNCdkhp5fk+ELZ/9sXsSw+2BaVlmp
         nhm4STLqx5g7MlMrisdKeNmhq7rKqA28gpue/PJUuDrxJ0uadVoEYNHHp9Wz13hBdbw9
         zBpTlE4thtoyu1/YfX219NnI+VQAxuwIgsDuSTEiRYxhodaPIiG/ss3r1cRlas2or8IH
         bAM91OGR7hkJMccx98sfDY/v5lmf2SyuJUwu3oroz953FieiKJx0d9peBi2y458n+p5H
         Kf+W1WchBF1J8m643JjI8K7n9nw6w8evdFCQw/0UdY/EfNW7N2e5Q5EpaByr6aufPjVR
         MlcA==
X-Gm-Message-State: AOAM532C31YgsyCIw9ua2PE3L3JoH/HcqV70UJ9G/M5KqDJfGvy0efP0
        8qNX7cxP4K/0xXvNeZWrU1j+vO2kPNgyS7tmIRDQC5nKIS0=
X-Google-Smtp-Source: ABdhPJw22635Ta+Khv9rQ+AvtU1mFH5u0oayx/EL5nr72sUDUyiFwIzrAqFLdDvtpHDR9Iedp4BlfRx3TN537PHx6bM=
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr20760851lfl.8.1643747181742;
 Tue, 01 Feb 2022 12:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20220201200823.3283171-1-yosryahmed@google.com>
In-Reply-To: <20220201200823.3283171-1-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Feb 2022 12:26:10 -0800
Message-ID: <CALvZod5GrC9jgiLUBf9WVwmjPaRx-pKFTrnpZHswqpqKgT5BuQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: add per-memcg total kernel memory stat
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:08 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Currently memcg stats show several types of kernel memory:
> kernel stack, page tables, sock, vmalloc, and slab.
> However, there are other allocations with __GFP_ACCOUNT
> (or supersets such as GFP_KERNEL_ACCOUNT) that are not accounted
> in any of those stats, a few examples are:
> - various kvm allocations (e.g. allocated pages to create vcpus)
> - io_uring
> - tmp_page in pipes during pipe_write()
> - bpf ringbuffers
> - unix sockets
>
> Keeping track of the total kernel memory is essential for the ease of
> migration from cgroup v1 to v2 as there are large discrepancies between
> v1's kmem.usage_in_bytes and the sum of the available kernel memory stats
> in v2. Adding separate memcg stats for all __GFP_ACCOUNT kernel
> allocations is an impractical maintenance burden as there a lot of those
> all over the kernel code, with more use cases likely to show up in the
> future.
>
> Therefore, add a "kernel" memcg stat that is analogous to kmem
> page counter, with added benefits such as using rstat infrastructure
> which aggregates stats more efficiently. Additionally, this provides a
> lighter alternative in case the legacy kmem is deprecated in the future
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Thanks Yosry. Just to emphasize further, in our gradual migration to
v2 (exposing v2 interfaces in v1 and removing v1-only interfaces), the
difference between kernel memory from v1 and v2 is very prominent for
some workloads. This patch will definitely ease the v2 migration.

Acked-by: Shakeel Butt <shakeelb@google.com>
