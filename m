Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28424F054A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbiDBR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiDBR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:56:35 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA833E0C7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 10:54:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648922079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZzJyOenYgHGR7Qus+38SF8NRb7w4EHzCNnvX97aW7g=;
        b=fWKZ6gNuhfl1YgF5V33Yc3q2pJAxGzp48CNKfHcyIR9qqmetC2uU9ExOPoCBI6HyEnmUax
        FSERvPxsH4zHkehIgZVNTXQn+t6UaSMZ1kiCuqbmxCpHtRSEn5SHfs8Z9yz4+LH1OP/szU
        fo0xK26iXa+17pzPNUvHkf4SG3G0E7g=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20220402072103.5140-1-hdanton@sina.com>
Date:   Sat, 2 Apr 2022 10:54:36 -0700
Cc:     MM <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-Id: <CE7BB198-BF09-4D9F-AE99-85324B81E472@linux.dev>
References: <20220402072103.5140-1-hdanton@sina.com>
To:     Hillf Danton <hdanton@sina.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hillf!

Thank you for sharing it, really interesting! I=E2=80=99m actually working o=
n the same problem.=20

No code to share yet, but here are some of my thoughts:
1) If there is a =E2=80=9Cnatural=E2=80=9D memory pressure, no additional sl=
ab scanning is needed.
2) =46rom a power perspective it=E2=80=99s better to scan more at once, but l=
ess often.
3) Maybe we need a feedback loop with the slab allocator: e.g. if slabs are a=
lmost full there is more sense to do a proactive scanning and free up some m=
emory, otherwise we=E2=80=99ll end up allocating more slabs. But it=E2=80=99=
s tricky.
4) If the scanning is not resulting in any memory reclaim, maybe we should (=
temporarily) exclude the corresponding shrinker from the scanning.

Thanks!

> On Apr 2, 2022, at 12:21 AM, Hillf Danton <hdanton@sina.com> wrote:
>=20
> =EF=BB=BFTo mitigate the pain of having "several millions" of negative den=
tries in
> a single directory [1] for example, add the periodic slab shrinker that
> runs independent of direct and background reclaimers in bid to recycle the=

> slab objects that haven been cold for more than 30 seconds.
>=20
> Q, Why is it needed?
> A, Kswapd may take a nap as long as 30 minutes.
>=20
> Add periodic flag to shrink control to let cache owners know this is the
> periodic shrinker that equals to the regular one running at the lowest
> recalim priority, and feel free to take no action without one-off objects
> piling up.
>=20
> Only for thoughts now.
>=20
> Hillf
>=20
> [1] https://lore.kernel.org/linux-fsdevel/20220209231406.187668-1-stephen.=
s.brennan@oracle.com/
>=20
> --- x/include/linux/shrinker.h
> +++ y/include/linux/shrinker.h
> @@ -14,6 +14,7 @@ struct shrink_control {
>=20
>    /* current node being shrunk (for NUMA aware shrinkers) */
>    int nid;
> +    int periodic;
>=20
>    /*
>     * How many objects scan_objects should scan and try to reclaim.
> --- x/mm/vmscan.c
> +++ y/mm/vmscan.c
> @@ -781,6 +781,8 @@ static unsigned long do_shrink_slab(stru
>        scanned +=3D shrinkctl->nr_scanned;
>=20
>        cond_resched();
> +        if (shrinkctl->periodic)
> +            break;
>    }
>=20
>    /*
> @@ -906,7 +908,8 @@ static unsigned long shrink_slab_memcg(g
>  */
> static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>                 struct mem_cgroup *memcg,
> -                 int priority)
> +                 int priority,
> +                 int periodic)
> {
>    unsigned long ret, freed =3D 0;
>    struct shrinker *shrinker;
> @@ -929,6 +932,7 @@ static unsigned long shrink_slab(gfp_t g
>            .gfp_mask =3D gfp_mask,
>            .nid =3D nid,
>            .memcg =3D memcg,
> +            .periodic =3D periodic,
>        };
>=20
>        ret =3D do_shrink_slab(&sc, shrinker, priority);
> @@ -952,7 +956,7 @@ out:
>    return freed;
> }
>=20
> -static void drop_slab_node(int nid)
> +static void drop_slab_node(int nid, int periodic)
> {
>    unsigned long freed;
>    int shift =3D 0;
> @@ -966,19 +970,31 @@ static void drop_slab_node(int nid)
>        freed =3D 0;
>        memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
>        do {
> -            freed +=3D shrink_slab(GFP_KERNEL, nid, memcg, 0);
> +            freed +=3D shrink_slab(GFP_KERNEL, nid, memcg, 0, periodic);
>        } while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) !=3D NULL);=

>    } while ((freed >> shift++) > 1);
> }
>=20
> -void drop_slab(void)
> +static void __drop_slab(int periodic)
> {
>    int nid;
>=20
>    for_each_online_node(nid)
> -        drop_slab_node(nid);
> +        drop_slab_node(nid, periodic);
> +}
> +
> +void drop_slab(void)
> +{
> +    __drop_slab(0);
> }
>=20
> +static void periodic_slab_shrinker_workfn(struct work_struct *work)
> +{
> +    __drop_slab(1);
> +    queue_delayed_work(system_unbound_wq, to_delayed_work(work), 30*HZ);
> +}
> +static DECLARE_DELAYED_WORK(periodic_slab_shrinker, periodic_slab_shrinke=
r_workfn);
> +
> static inline int is_page_cache_freeable(struct folio *folio)
> {
>    /*
> @@ -3098,7 +3114,7 @@ static void shrink_node_memcgs(pg_data_t
>        shrink_lruvec(lruvec, sc);
>=20
>        shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> -                sc->priority);
> +                sc->priority, 0);
>=20
>        /* Record the group's reclaim efficiency */
>        vmpressure(sc->gfp_mask, memcg, false,
> @@ -4354,8 +4370,11 @@ static void kswapd_try_to_sleep(pg_data_
>         */
>        set_pgdat_percpu_threshold(pgdat, calculate_normal_threshold);
>=20
> -        if (!kthread_should_stop())
> +        if (!kthread_should_stop()) {
> +            queue_delayed_work(system_unbound_wq,
> +                        &periodic_slab_shrinker, 60*HZ);
>            schedule();
> +        }
>=20
>        set_pgdat_percpu_threshold(pgdat, calculate_pressure_threshold);
>    } else {
> --
>=20
