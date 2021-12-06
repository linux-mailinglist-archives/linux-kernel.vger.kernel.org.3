Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4346AB40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347156AbhLFWQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbhLFWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:16:26 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059A3C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:12:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so14621087iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU0RUYEua2dZFR/ZcB6wsb6hIVHEQ0Wkelc6tuwAtXY=;
        b=TXTB0jbWQdGAS+aqrUvPmhm363h4+QOR0qZ/3LMHNiSf5/eBT0/zj8buGPyk5ATlYH
         6P1/Rgko+Et1sfVakEs7czuCF4v68UKX+NCL5kK4dIv6owKGdHlwqFIKdNqOgL+5COoO
         D/eEYKS8dICAxR05vxSD2ps7AAdiiJrnubsVfPdvR/AS5OgmdthqjSzxRQYRZusNi+u5
         gP3zJYEZ9GuMBNIifPGMzODsAyUkKV36Wkpme5WiD9C/FwA4uDRLCl8l6EHa9QX9lkCr
         1mXUp+VY+sHWAPqsD2Q2KaGcT/s71FQKdOEmaFhoD33TaiEcLpDs8xCWLXZMdIATkNjP
         j+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU0RUYEua2dZFR/ZcB6wsb6hIVHEQ0Wkelc6tuwAtXY=;
        b=yZj4oP45o7h9jL+AZDWs8ZZxSW0Q4VAUoARXlNet3bgYKwJbdYSWQ+zzkPdH/kZ7rU
         wnf5rPqCVIS08ruN0yp11rUHfnOAMjHSM2MJa6Vpt49zpJ4Xbe3W8G4+4RPa5nyjiZn8
         ZUPXwWkNzi+jh/J9L6SkybT4eiz2jcQC44wullefFacn3P3R9uGoXPpeQ15xZzBol1R8
         BjccMDqVnZsbV9wSrib5zrrfH+tTewLUF8lglfOErx6qp0EyiP4DOee8Qxs7I373M1F7
         VRI4sWNF2ijU+ZbZrV9JM8lLSINTnb7VUyw1s5+WpVk79AK3/z5SiilvacfcBtYhKn1O
         eLoA==
X-Gm-Message-State: AOAM530QD8WpacKCAzy1ZL+/r93nqDNG6E8MpsJyG2ujypeFf40jCvww
        EuxF/1sgoSAOziXzPVWhYbwSwyfRywKSLQzYVmOX+w==
X-Google-Smtp-Source: ABdhPJwos3UD/sOaAzQ+13tMuSQa9YpMahuqqh92ruy8sd/C75mPv+dspNdb8LCzEkOxEMzhlf+w9rGOma8yJNQqDnY=
X-Received: by 2002:a02:b616:: with SMTP id h22mr45568675jam.127.1638828775740;
 Mon, 06 Dec 2021 14:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20211206031227.3323097-1-ying.huang@intel.com>
In-Reply-To: <20211206031227.3323097-1-ying.huang@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 6 Dec 2021 14:12:44 -0800
Message-ID: <CAAPL-u8QL-1Dk+gKvC=Qv2qqJrNg+o-skiASNKyEdC5wHfcmgA@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate: move node demotion code to near its user
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 7:12 PM Huang Ying <ying.huang@intel.com> wrote:
>
> Now, node_demotion and next_demtion_node() is placed between
> __unmap_and_move() and unmap_and_move().  This hurts the code
> readability.  So, move it to near its user in the file.  There's no
> any functionality change in this patch.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Wei Xu <weixugc@google.com>

> ---
>  mm/migrate.c | 265 +++++++++++++++++++++++++--------------------------
>  1 file changed, 132 insertions(+), 133 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c503ef1f4360..d487a399253b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1083,139 +1083,6 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>         return rc;
>  }
>
> -
> -/*
> - * node_demotion[] example:
> - *
> - * Consider a system with two sockets.  Each socket has
> - * three classes of memory attached: fast, medium and slow.
> - * Each memory class is placed in its own NUMA node.  The
> - * CPUs are placed in the node with the "fast" memory.  The
> - * 6 NUMA nodes (0-5) might be split among the sockets like
> - * this:
> - *
> - *     Socket A: 0, 1, 2
> - *     Socket B: 3, 4, 5
> - *
> - * When Node 0 fills up, its memory should be migrated to
> - * Node 1.  When Node 1 fills up, it should be migrated to
> - * Node 2.  The migration path start on the nodes with the
> - * processors (since allocations default to this node) and
> - * fast memory, progress through medium and end with the
> - * slow memory:
> - *
> - *     0 -> 1 -> 2 -> stop
> - *     3 -> 4 -> 5 -> stop
> - *
> - * This is represented in the node_demotion[] like this:
> - *
> - *     {  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> - *     {  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> - *     {  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> - *     {  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> - *     {  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> - *     {  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> - *
> - * Moreover some systems may have multiple slow memory nodes.
> - * Suppose a system has one socket with 3 memory nodes, node 0
> - * is fast memory type, and node 1/2 both are slow memory
> - * type, and the distance between fast memory node and slow
> - * memory node is same. So the migration path should be:
> - *
> - *     0 -> 1/2 -> stop
> - *
> - * This is represented in the node_demotion[] like this:
> - *     { nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> - *     { nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> - *     { nr=0, nodes[0]=-1, }, // Node 2 does not migrate
> - */
> -
> -/*
> - * Writes to this array occur without locking.  Cycles are
> - * not allowed: Node X demotes to Y which demotes to X...
> - *
> - * If multiple reads are performed, a single rcu_read_lock()
> - * must be held over all reads to ensure that no cycles are
> - * observed.
> - */
> -#define DEFAULT_DEMOTION_TARGET_NODES 15
> -
> -#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> -#define DEMOTION_TARGET_NODES  (MAX_NUMNODES - 1)
> -#else
> -#define DEMOTION_TARGET_NODES  DEFAULT_DEMOTION_TARGET_NODES
> -#endif
> -
> -struct demotion_nodes {
> -       unsigned short nr;
> -       short nodes[DEMOTION_TARGET_NODES];
> -};
> -
> -static struct demotion_nodes *node_demotion __read_mostly;
> -
> -/**
> - * next_demotion_node() - Get the next node in the demotion path
> - * @node: The starting node to lookup the next node
> - *
> - * Return: node id for next memory node in the demotion path hierarchy
> - * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> - * @node online or guarantee that it *continues* to be the next demotion
> - * target.
> - */
> -int next_demotion_node(int node)
> -{
> -       struct demotion_nodes *nd;
> -       unsigned short target_nr, index;
> -       int target;
> -
> -       if (!node_demotion)
> -               return NUMA_NO_NODE;
> -
> -       nd = &node_demotion[node];
> -
> -       /*
> -        * node_demotion[] is updated without excluding this
> -        * function from running.  RCU doesn't provide any
> -        * compiler barriers, so the READ_ONCE() is required
> -        * to avoid compiler reordering or read merging.
> -        *
> -        * Make sure to use RCU over entire code blocks if
> -        * node_demotion[] reads need to be consistent.
> -        */
> -       rcu_read_lock();
> -       target_nr = READ_ONCE(nd->nr);
> -
> -       switch (target_nr) {
> -       case 0:
> -               target = NUMA_NO_NODE;
> -               goto out;
> -       case 1:
> -               index = 0;
> -               break;
> -       default:
> -               /*
> -                * If there are multiple target nodes, just select one
> -                * target node randomly.
> -                *
> -                * In addition, we can also use round-robin to select
> -                * target node, but we should introduce another variable
> -                * for node_demotion[] to record last selected target node,
> -                * that may cause cache ping-pong due to the changing of
> -                * last target node. Or introducing per-cpu data to avoid
> -                * caching issue, which seems more complicated. So selecting
> -                * target node randomly seems better until now.
> -                */
> -               index = get_random_int() % target_nr;
> -               break;
> -       }
> -
> -       target = READ_ONCE(nd->nodes[index]);
> -
> -out:
> -       rcu_read_unlock();
> -       return target;
> -}
> -
>  /*
>   * Obtain the lock on page, remove all ptes and migrate the page
>   * to the newly allocated page in newpage.
> @@ -3035,6 +2902,138 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
>
> +/*
> + * node_demotion[] example:
> + *
> + * Consider a system with two sockets.  Each socket has
> + * three classes of memory attached: fast, medium and slow.
> + * Each memory class is placed in its own NUMA node.  The
> + * CPUs are placed in the node with the "fast" memory.  The
> + * 6 NUMA nodes (0-5) might be split among the sockets like
> + * this:
> + *
> + *     Socket A: 0, 1, 2
> + *     Socket B: 3, 4, 5
> + *
> + * When Node 0 fills up, its memory should be migrated to
> + * Node 1.  When Node 1 fills up, it should be migrated to
> + * Node 2.  The migration path start on the nodes with the
> + * processors (since allocations default to this node) and
> + * fast memory, progress through medium and end with the
> + * slow memory:
> + *
> + *     0 -> 1 -> 2 -> stop
> + *     3 -> 4 -> 5 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *
> + *     {  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> + *     {  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> + *     {  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> + *     {  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> + *     {  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> + *     {  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> + *
> + * Moreover some systems may have multiple slow memory nodes.
> + * Suppose a system has one socket with 3 memory nodes, node 0
> + * is fast memory type, and node 1/2 both are slow memory
> + * type, and the distance between fast memory node and slow
> + * memory node is same. So the migration path should be:
> + *
> + *     0 -> 1/2 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *     { nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> + *     { nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> + *     { nr=0, nodes[0]=-1, }, // Node 2 does not migrate
> + */
> +
> +/*
> + * Writes to this array occur without locking.  Cycles are
> + * not allowed: Node X demotes to Y which demotes to X...
> + *
> + * If multiple reads are performed, a single rcu_read_lock()
> + * must be held over all reads to ensure that no cycles are
> + * observed.
> + */
> +#define DEFAULT_DEMOTION_TARGET_NODES 15
> +
> +#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> +#define DEMOTION_TARGET_NODES  (MAX_NUMNODES - 1)
> +#else
> +#define DEMOTION_TARGET_NODES  DEFAULT_DEMOTION_TARGET_NODES
> +#endif
> +
> +struct demotion_nodes {
> +       unsigned short nr;
> +       short nodes[DEMOTION_TARGET_NODES];
> +};
> +
> +static struct demotion_nodes *node_demotion __read_mostly;
> +
> +/**
> + * next_demotion_node() - Get the next node in the demotion path
> + * @node: The starting node to lookup the next node
> + *
> + * Return: node id for next memory node in the demotion path hierarchy
> + * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> + * @node online or guarantee that it *continues* to be the next demotion
> + * target.
> + */
> +int next_demotion_node(int node)
> +{
> +       struct demotion_nodes *nd;
> +       unsigned short target_nr, index;
> +       int target;
> +
> +       if (!node_demotion)
> +               return NUMA_NO_NODE;
> +
> +       nd = &node_demotion[node];
> +
> +       /*
> +        * node_demotion[] is updated without excluding this
> +        * function from running.  RCU doesn't provide any
> +        * compiler barriers, so the READ_ONCE() is required
> +        * to avoid compiler reordering or read merging.
> +        *
> +        * Make sure to use RCU over entire code blocks if
> +        * node_demotion[] reads need to be consistent.
> +        */
> +       rcu_read_lock();
> +       target_nr = READ_ONCE(nd->nr);
> +
> +       switch (target_nr) {
> +       case 0:
> +               target = NUMA_NO_NODE;
> +               goto out;
> +       case 1:
> +               index = 0;
> +               break;
> +       default:
> +               /*
> +                * If there are multiple target nodes, just select one
> +                * target node randomly.
> +                *
> +                * In addition, we can also use round-robin to select
> +                * target node, but we should introduce another variable
> +                * for node_demotion[] to record last selected target node,
> +                * that may cause cache ping-pong due to the changing of
> +                * last target node. Or introducing per-cpu data to avoid
> +                * caching issue, which seems more complicated. So selecting
> +                * target node randomly seems better until now.
> +                */
> +               index = get_random_int() % target_nr;
> +               break;
> +       }
> +
> +       target = READ_ONCE(nd->nodes[index]);
> +
> +out:
> +       rcu_read_unlock();
> +       return target;
> +}
> +
>  #if defined(CONFIG_HOTPLUG_CPU)
>  /* Disable reclaim-based migration. */
>  static void __disable_all_migrate_targets(void)
> --
> 2.30.2
>
