Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5B52C68A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiERWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiERWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:47:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF2131291
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:47:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so3108977wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+OwTFSdR2gyZK543TiqztKo53GHODJ6up3IJF4FH3Q=;
        b=CY2hT2cxVOa7I78OfBysSpF9QWMDtFJDTVA6Kviy4R8WS6Q+xuv7RL32PUKyj08vHJ
         W9YxtXiwKZFnDQs2tR6hUO4o3ocvYURJJyKo9nVHOMS51dxTMtOawzWdYQUZc+xBm6Xn
         LjDh1ZVIU4bzckrIbwCaO2p6u36PePUrb9MC6CInbOZrHQzPNs0oGYvcLJVgkMjakB0O
         OyUW3U5sDbP6PPxnF1K1q50LHcNxbExmQcgU9RT3jr8z9akdx8x3L3Rm5vAZqD/2PuDR
         E4ZJU/fHyBOTenVywrCMzIWtJbM98O67Au4c5ciSUf15NW1AAOCRuPMnv5L6YAtQgMQE
         SCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+OwTFSdR2gyZK543TiqztKo53GHODJ6up3IJF4FH3Q=;
        b=XF6fIU0fDXkZ1uOv6rNwCNg+FFXcehTWAnJx/ZCfoUQzVzQKLFOb8YfR5NWkhFckKF
         O1HaXiQ5dhH7ZQy2c2L4fc0l7njDPUotVDMysXfOeGyU/mhhhzg+MEG9zwMre0Hys46T
         sxDh3St4vP1rY412lx5f2VGJjQX12PGW07YLqw1zzG6G7dtbhbVsn5KKNEDl+FA4DhYl
         qBfjt3eP1pGnZUtzk3ySxDrvePhyrFGq7h09v/Z8cySxB20HTkXQOQIW8BWoqJusIysN
         Jl1xCOWmhF1VshEtIdkr2JiriFVhGb+MZduy0UzI5gAmGui/f+ml4xiPZ7qba4+4PDnr
         ZrDQ==
X-Gm-Message-State: AOAM533o13j75lcgxuSrOuZfoyGtO+3VXKf32TtrHVpfmOIDVVAGB1Gz
        kpai3bAO7ae4kK5a2SSEbYubzQ1NnzQVTRHhtw0PHQ==
X-Google-Smtp-Source: ABdhPJxKqoB9/iLAS1FfPSmYtqbu9F561aCoMfcSeQltohNa5RLDczPdtqjlZNYM0PtMB+QNjrD1JMn7fmP6e3RI6PY=
X-Received: by 2002:a05:600c:1c84:b0:394:5de0:2475 with SMTP id
 k4-20020a05600c1c8400b003945de02475mr1268968wms.27.1652914020870; Wed, 18 May
 2022 15:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
In-Reply-To: <20220518223815.809858-1-vaibhav@linux.ibm.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 18 May 2022 15:46:24 -0700
Message-ID: <CAJD7tkZSgRs6T60Gv4dZR5xBemxgCB_2s8hz8zB0F_nakN5aTQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
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

On Wed, May 18, 2022 at 3:38 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> [1] Provides a way for user-space to trigger proactive reclaim by introducing
> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
> of pages scanned and reclaimed is still not directly available to the
> user-space.
>
> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
> readable which returns the number of pages scanned / reclaimed during the
> reclaim process from 'struct vmpressure' associated with each memcg. This should
> let user-space asses how successful proactive reclaim triggered from memcg
> 'memory.reclaim' was ?

Isn't this a racy read? struct vmpressure can be changed between the
write and read by other reclaim operations, right?

I was actually planning to send a patch that does not updated
vmpressure for user-controller reclaim, similar to how PSI is handled.

The interface currently returns -EBUSY if the entire amount was not
reclaimed, so isn't this enough to figure out if it was successful or
not? If not, we can store the scanned / reclaim counts of the last
memory.reclaim invocation for the sole purpose of memory.reclaim
reads. Maybe it is actually more intuitive to users to just read the
amount of memory read? In a format that is similar to the one written?

i.e
echo "10M" > memory.reclaim
cat memory.reclaim
9M

>
> With the patch following command flow is expected:
>
>  # echo "1M" > memory.reclaim
>
>  # cat memory.reclaim
>    scanned 76
>    reclaimed 32
>
> [1]:  https://lore.kernel.org/r/20220425190040.2475377-1-yosryahmed@google.com
>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++++---
>  mm/memcontrol.c                         | 14 ++++++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 27ebef2485a3..44610165261d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1209,18 +1209,27 @@ PAGE_SIZE multiple when read back.
>         utility is limited to providing the final safety net.
>
>    memory.reclaim
> -       A write-only nested-keyed file which exists for all cgroups.
> +       A nested-keyed file which exists for all cgroups.
>
> -       This is a simple interface to trigger memory reclaim in the
> -       target cgroup.
> +       This is a simple interface to trigger memory reclaim and retrieve
> +       reclaim stats in the target cgroup.
>
>         This file accepts a single key, the number of bytes to reclaim.
>         No nested keys are currently supported.
>
> +       Reading the file returns number of pages scanned and number of
> +       pages reclaimed from the memcg. This information fetched from
> +       vmpressure info associated with each cgroup.
> +
>         Example::
>
>           echo "1G" > memory.reclaim
>
> +         cat memory.reclaim
> +
> +         scanned 78
> +         reclaimed 30
> +
>         The interface can be later extended with nested keys to
>         configure the reclaim behavior. For example, specify the
>         type of memory to reclaim from (anon, file, ..).
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2e2bfbed4717..9e43580a8726 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6423,6 +6423,19 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>         return nbytes;
>  }
>
> +static int memory_reclaim_show(struct seq_file *m, void *v)
> +{
> +       struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +       struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
> +
> +       spin_lock(&vmpr->sr_lock);
> +       seq_printf(m, "scanned %lu\nreclaimed %lu\n",
> +                  vmpr->scanned, vmpr->reclaimed);
> +       spin_unlock(&vmpr->sr_lock);
> +
> +       return 0;
> +}
> +
>  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>                               size_t nbytes, loff_t off)
>  {
> @@ -6525,6 +6538,7 @@ static struct cftype memory_files[] = {
>                 .name = "reclaim",
>                 .flags = CFTYPE_NS_DELEGATABLE,
>                 .write = memory_reclaim,
> +               .seq_show  = memory_reclaim_show,
>         },
>         { }     /* terminate */
>  };
> --
> 2.35.1
>
