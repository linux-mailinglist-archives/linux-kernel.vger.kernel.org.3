Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A35036C0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiDPNhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 09:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiDPNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 09:37:19 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6FBC02
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 06:34:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ebf4b91212so104793827b3.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uv6pt73Wfv4Wu/TjtLN9aQeY0zKh2XHc3uKe7btwcBY=;
        b=dH0kmiHhIxWO2EQhuk1QISZQCAGVrI0ki4AkdmQ9e0rozofH0ZqyQc0IcGIh9wgpzp
         K1od8yzLUW8f7ye0MiGWEZ0SYIJ3Cwcrb/r6sSjRhIk0L05t25P5IGzEtROW7nQ1j2q0
         tUX0kJbpSBF8AJx5JWJf7UF4t/qe3QbNkiSBLIw6IVvSR73wVrlDvcdPBBkjgjbAVqLf
         Fc5jslLOj1STQ7GvRs4zi2fPgLmyanW8uPlGXi9zwES6jR4UBS1L1YWuG4clg92u5oJi
         3B1RAj+81xXemHJmKTHbnwanLLr89kSKmrDzvobVHy6LAfBw9EDYcbuxb5SYRPm8Y6AI
         e+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uv6pt73Wfv4Wu/TjtLN9aQeY0zKh2XHc3uKe7btwcBY=;
        b=lEc+UAyMqobwuBCHgEe6aRxT/hxJFkcm/UX+vy0xscP95rekPvprY4amEffAF26wyZ
         tb2/g3T0t+uCjuUXAajkE6SBmJNHib9Zq9syRu3iTvAmWhSK5l58m2J6Ch+qu07/1Z9z
         Qj72uauzPHiROKvgXfQ6raSFjfjDihdxj5tfb0y1TpYxx+EbSCiTDsstP+Zb9msvMvkJ
         HCEJ5jdPmTYU8s/OUn9DDuQlcoIYcDAcx88ok2w16L9G1CaLpXXNSKMxhaV5L9O98oqI
         9mOVWeJrVs7f/6zHn48iRBe6moGaWFaJz0b7loPLWqap8qCjTERGuk1W7bCNNl2AG5HV
         FHkg==
X-Gm-Message-State: AOAM532FeGYap0L0wfLMnZeKsLCOFR0rS0f34f1GlFVXdRjHNYrPbOWl
        eeVDyAFEbxfVaqcnfeWs3hPxlYE8z7kgiHOwQfc=
X-Google-Smtp-Source: ABdhPJx2MkuHbp7bJ8Xq+n/e2zGt+43GmDoujvvKbtxFuS+NkKTRgfOhO44kD0XxnxbhNjlQpiCG4lHQdpRTYE2AsbU=
X-Received: by 2002:a81:4914:0:b0:2ec:85a:6714 with SMTP id
 w20-20020a814914000000b002ec085a6714mr3188741ywa.88.1650116086154; Sat, 16
 Apr 2022 06:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220416123930.5956-1-dthex5d@gmail.com>
In-Reply-To: <20220416123930.5956-1-dthex5d@gmail.com>
From:   dthex5d <dthex5d@gmail.com>
Date:   Sat, 16 Apr 2022 22:34:35 +0900
Message-ID: <CAFk61EGgQ7hjRiL+QPnZena-AzEgP+azQTo44S=WiJqxmX9OYw@mail.gmail.com>
Subject: Re: [PATCH] mm/mmzone: Introduce a new macro for_each_node_zonelist()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a compiler error that I missed.
Sorry for bothering you guys.
 I just sent a v2 for this patch.


On Sat, Apr 16, 2022 at 9:39 PM Donghyeok Kim <dthex5d@gmail.com> wrote:
>
> There are some codes using for_each_zone_zonelist() even when only
> iterating each node is needed. This commit introduces a new macro
> for_each_node_zonelist() which iterates through valid nodes in the
> zonelist.
>
> By using this new macro, code can be written in a much simpler form.
> Also, slab/slub can now skip trying to allocate from the node which was
> previously tried and failed.
>
> Co-developed-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> Signed-off-by: Donghyeok Kim <dthex5d@gmail.com>
> ---
>  include/linux/mmzone.h | 36 ++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c           | 17 +++++++----------
>  mm/mmzone.c            | 17 +++++++++++++++++
>  mm/slab.c              |  7 ++-----
>  mm/slub.c              |  8 ++++----
>  mm/vmscan.c            | 15 ++++++---------
>  6 files changed, 72 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9aaa04ac862f..cb2ddd0b4c95 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1464,6 +1464,42 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
>  #define for_each_zone_zonelist(zone, z, zlist, highidx) \
>         for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
>
> +
> +struct zoneref *next_node_zones_zonelist(struct zoneref *z,
> +                                       int prev_nid,
> +                                       enum zone_type highest_zoneidx,
> +                                       nodemask_t *nodes);
> +
> +/**
> + * for_each_node_zonelist_nodemask - helper macro to iterate over valid nodes in a zonelist which have at least one zone at or below a given zone index and within a nodemask
> + * @node: The current node in the iterator
> + * @z: First matched zoneref within current node
> + * @zlist: The zonelist being iterated
> + * @highidx: The zone index of the highest zone in the node
> + * @nodemask: Nodemask allowed by the allocator
> + *
> + * This iterator iterates through all nodes which have at least one zone at or below a given zone index and
> + * within a given nodemask
> + */
> +#define for_each_node_zonelist_nodemask(node, z, zlist, highidx, nodemask)             \
> +       for (z = first_zones_zonelist(zlist, highidx, nodemask),                        \
> +                       node = zonelist_zone(z) ? zonelist_node_idx(z) : NUMA_NO_NODE;  \
> +               zonelist_zone(z);                                                       \
> +               z = next_node_zones_zonelist(++z, node, highidx, nodemask),             \
> +                       node = zonelist_zone(z) ? zonelist_node_idx(z) : NUMA_NO_NODE)
> +
> +/**
> + * for_each_node_zonelist - helper macro to iterate over nodes in a zonelist which have at least one zone at or below a given zone index
> + * @node: The current node in the iterator
> + * @z: First matched zoneref within current node
> + * @zlist: The zonelist being iterated
> + * @highidx: The zone index of the highest zone in the node
> + *
> + * This iterator iterates through all nodes which have at least one zone at or below a given zone index.
> + */
> +#define for_each_node_zonelist(node, z, zlist, highidx) \
> +       for_each_node_zonelist_nodemask(node, z, zlist, highidx, NULL)
> +
>  /* Whether the 'nodes' are all movable nodes */
>  static inline bool movable_only_nodes(nodemask_t *nodes)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index daa4bdd6c26c..283f28f1aca8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1157,7 +1157,6 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  {
>         unsigned int cpuset_mems_cookie;
>         struct zonelist *zonelist;
> -       struct zone *zone;
>         struct zoneref *z;
>         int node = NUMA_NO_NODE;
>
> @@ -1165,18 +1164,16 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>
>  retry_cpuset:
>         cpuset_mems_cookie = read_mems_allowed_begin();
> -       for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
> +
> +       /*
> +        * no need to ask again on the same node. Pool is node rather than
> +        * zone aware
> +        */
> +       for_each_node_zonelist_nodemask(node, z, zonelist, gfp_zone(gfp_mask), nmask) {
>                 struct page *page;
>
> -               if (!cpuset_zone_allowed(zone, gfp_mask))
> -                       continue;
> -               /*
> -                * no need to ask again on the same node. Pool is node rather than
> -                * zone aware
> -                */
> -               if (zone_to_nid(zone) == node)
> +               if (!cpuset_node_allowed(node, gfp_mask))
>                         continue;
> -               node = zone_to_nid(zone);
>
>                 page = dequeue_huge_page_node_exact(h, node);
>                 if (page)
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index 68e1511be12d..8b7d6286056e 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -72,6 +72,23 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
>         return z;
>  }
>
> +/* Returns the zone in the next node and at or below highest_zoneidx in a zonelist */
> +struct zoneref *next_node_zones_zonelist(struct zoneref *z,
> +                                       int prev_nid,
> +                                       enum zone_type highest_zoneidx,
> +                                       nodemask_t *nodes)
> +{
> +       if (likely(nodes == NULL))
> +               while (z->zone && (zonelist_node_idx(z) == prev_nid || zonelist_zone_idx(z) > highest_zoneidx))
> +                       z++;
> +       else
> +               while (z->zone && (zonelist_node_idx(z) == prev_nid || zonelist_zone_idx(z) > highest_zoneidx ||
> +                               !zref_in_nodemask(z, nodes)))
> +                       z++;
> +
> +       return z;
> +}
> +
>  void lruvec_init(struct lruvec *lruvec)
>  {
>         enum lru_list lru;
> diff --git a/mm/slab.c b/mm/slab.c
> index a301f266efd1..b374fb88f80e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3077,7 +3077,6 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
>  {
>         struct zonelist *zonelist;
>         struct zoneref *z;
> -       struct zone *zone;
>         enum zone_type highest_zoneidx = gfp_zone(flags);
>         void *obj = NULL;
>         struct slab *slab;
> @@ -3096,10 +3095,8 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
>          * Look through allowed nodes for objects available
>          * from existing per node queues.
>          */
> -       for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> -               nid = zone_to_nid(zone);
> -
> -               if (cpuset_zone_allowed(zone, flags) &&
> +       for_each_node_zonelist(nid, z, zonelist, highest_zoneidx) {
> +               if (cpuset_node_allowed(nid, flags) &&
>                         get_node(cache, nid) &&
>                         get_node(cache, nid)->free_objects) {
>                                 obj = ____cache_alloc_node(cache,
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dc703488d30..3e8b4aa98b84 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2192,7 +2192,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
>  #ifdef CONFIG_NUMA
>         struct zonelist *zonelist;
>         struct zoneref *z;
> -       struct zone *zone;
> +       int nid;
>         enum zone_type highest_zoneidx = gfp_zone(flags);
>         void *object;
>         unsigned int cpuset_mems_cookie;
> @@ -2222,12 +2222,12 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
>         do {
>                 cpuset_mems_cookie = read_mems_allowed_begin();
>                 zonelist = node_zonelist(mempolicy_slab_node(), flags);
> -               for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> +               for_each_node_zonelist(nid, z, zonelist, highest_zoneidx) {
>                         struct kmem_cache_node *n;
>
> -                       n = get_node(s, zone_to_nid(zone));
> +                       n = get_node(s, nid);
>
> -                       if (n && cpuset_zone_allowed(zone, flags) &&
> +                       if (n && cpuset_node_allowed(nid, flags) &&
>                                         n->nr_partial > s->min_partial) {
>                                 object = get_partial_node(s, n, ret_slab, flags);
>                                 if (object) {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d4a7d2bd276d..f25b71bf8f61 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6176,9 +6176,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>                                           struct scan_control *sc)
>  {
>         int initial_priority = sc->priority;
> -       pg_data_t *last_pgdat;
> +       pg_data_t *pgdat;
>         struct zoneref *z;
> -       struct zone *zone;
> +       int nid;
>  retry:
>         delayacct_freepages_start();
>
> @@ -6206,19 +6206,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>         } while (--sc->priority >= 0);
>
>         last_pgdat = NULL;
> -       for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
> +       for_each_node_zonelist_nodemask(nid, z, zonelist, sc->reclaim_idx,
>                                         sc->nodemask) {
> -               if (zone->zone_pgdat == last_pgdat)
> -                       continue;
> -               last_pgdat = zone->zone_pgdat;
> +               pgdat = NODE_DATA(nid);
>
> -               snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
> +               snapshot_refaults(sc->target_mem_cgroup, pgdat);
>
>                 if (cgroup_reclaim(sc)) {
>                         struct lruvec *lruvec;
>
> -                       lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup,
> -                                                  zone->zone_pgdat);
> +                       lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
>                         clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
>                 }
>         }
> --
> 2.17.1
>
