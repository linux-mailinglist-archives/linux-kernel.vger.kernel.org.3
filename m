Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF51346A4D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347289AbhLFSr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346257AbhLFSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:47:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE695C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:43:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l25so46705701eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0tqs06x18dIrlhQOCpAItB7M/XVYNieoVgk7uBb5Xc=;
        b=dnjgq+HiFRByUsHLmd3KYtD/FBvjnSrAZRtFpG97qYOOu9mAbMCSirbhYUuxrkIH69
         FeJJjXjy2WXL6ELT+uxGAcQm6JiK03ZIPiuhSj1LJj21TC28sJ3JdPYr1pnJzo/tNo4j
         hUISH7fqPqfDU7EpfQZxmppoZTlpJt+Gm+CaIoGub6/zx6i4qEmerbMhYawip/Lewsb2
         r7myH/rq06GgBtlM77eU9AbKseVyGuhVDcCPPKVBZ45FivvjNF2CkX6cl6pCrZE2HlrD
         A2qGWEMLLPDLk3ddQxx0PvfavJf3TJLb+qPEPh1B+KMj/6GaV6FrJhQtWjFAgbZNb6Ct
         /16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0tqs06x18dIrlhQOCpAItB7M/XVYNieoVgk7uBb5Xc=;
        b=j4xcV6K0mL2Au5AoqRwCO+jt9FER0+j06V6AMGKcTMOQp6p/IcFZdmEWsi5qgk62It
         Ex0WkXtVHHP78dq73PxKsH0CTSWfzvJd0j+3R4AKyuz584DFOdWsJTj3lURJQBm8tDwa
         ZrrehOi6pxogywfFKf08m8bsM4V9qKGR9vei+ae8NKUV4fi7hWbADSqjVdRfQTYdTN+Z
         l01xsixMoa6VbTQAmpkRbc3YCcIWYarehzYQ/C3Q4HQpgnqJN13BMrGXacw6OrT5cJYz
         LVk/eb0qCHqlpMrjgPvGDKg6kUBBxjlN9N8mCUVZnb+R7iqzPuH62dnF/9sl51A07Mai
         MZlA==
X-Gm-Message-State: AOAM533Ja/8/U9LI63BotaQizMTCsK2rv1u+JpL9WQR3Z8h36X7ttg48
        QvlPl0exDgL8nZQWYDmO6XD62uEQaL6WJLog15I=
X-Google-Smtp-Source: ABdhPJxhTrTjwLQgfslfO/XJGuM8UQohDgQ7tpbqXidsDJV6CdkTC4ve/DukHRiIjkaJup8UojgggsSHrn13N8+38/A=
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr1171548edc.93.1638816237431;
 Mon, 06 Dec 2021 10:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20211206031227.3323097-1-ying.huang@intel.com>
In-Reply-To: <20211206031227.3323097-1-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Dec 2021 10:43:46 -0800
Message-ID: <CAHbLzkocNKTPFh54u3ZDOmPAd_OOG3yhHtj5nhLshjNVHTa5iQ@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate: move node demotion code to near its user
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
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

Reviewed-by: Yang Shi <shy828301@gmail.com>

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
