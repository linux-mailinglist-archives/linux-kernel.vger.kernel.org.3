Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8394E3985
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiCVHYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiCVHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:24:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5A104;
        Tue, 22 Mar 2022 00:23:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e62c790cbdso54989537b3.0;
        Tue, 22 Mar 2022 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z2A4+dHsl/ogD4uXCEY/Y6/9TFLjlFsFb7JPdKbMfvY=;
        b=W6lHwCHIfKZWp0EWgiiYhQB2Ksv2qZcfvD8ez5KwL3HZmV9VxCrD082ushSrvwwBRl
         iXyPbXkq1cfl0PLv/KobJ0RwTHxoQxYx+ZMlUETpUVpXBILGlBSxTQ4jummhc5JecgHk
         uSScsl3GuA8RKuu9YJk/mrpicnEgBXpXK/rEaW6R04ddMTXbNvxXns+ZlVC2HKFq8PeR
         Hjgi3oJZk5XOPFY7rdyjk+cjSma7LtnH/NgupgkqbOlwDM3l7UH+j6qzdAXcBNShQfgk
         gUyAT0D563iZcbqYIMDL93amFeoIAgDDRj1e9tq4j7fXQl2bh4VGZId7fikeLdBO500j
         NK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z2A4+dHsl/ogD4uXCEY/Y6/9TFLjlFsFb7JPdKbMfvY=;
        b=Ym5/FGWF1r72m/8lOoPvultbeMyVu5w/eFZWrG3edOERTQF057IqUCNUNDVelzV3qK
         tH1db2+yD8052IoJzwveGI6uUM40mwnELAw1UC0j/AZwJann4kO8OLHX6IPdE3o1vKV4
         YLnm1M7XPwaGQD2CMbfLbBRrXgjBI9e4S97XGfVwMbY35J0sI2vk6cxsJp2GPUzKY0N2
         l1j0OTuonHhmNYxDwUywBLuYnsoCTkwCbU5vvBe7jtBH+RD/CkG6o7B5ywW2tM8TbHxo
         d0aywoZsr3UJHsGTAMgQ5Vykgo1r1v/uFYVvYzxH0X6yz6wsZKePDUwSw+YWiX98WKqT
         LH6Q==
X-Gm-Message-State: AOAM531fVVgM4N/4ooJGvNCcUPy/3+bsVMh1K5HbNwZ6FEuaIZVEgqw3
        yNpcykCIvucm45GhoTD4LvhC1+zJrrUVPMVeC7k=
X-Google-Smtp-Source: ABdhPJx3/eBtOtwteUg66RLu+UoP08EC0GR8O62g/Lw7/VeBHW4bejbs+b6FeSIydzWrzJvziTtJ24jF3R913wJVg4E=
X-Received: by 2002:a81:70c7:0:b0:2e5:8350:a7 with SMTP id l190-20020a8170c7000000b002e5835000a7mr28873733ywc.4.1647933781889;
 Tue, 22 Mar 2022 00:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-12-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-12-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 22 Mar 2022 20:22:51 +1300
Message-ID: <CAGsJ_4wMrUnRzdM_qssRtm=bb3oY08=DkZoiuxMt1PezxR4HWQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/14] mm: multi-gen LRU: thrashing prevention
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention, as
> requested by many desktop users [1].
>
> When set to value N, it prevents the working set of N milliseconds
> from getting evicted. The OOM killer is triggered if this working set
> cannot be kept in memory. Based on the average human detectable lag
> (~100ms), N=3D1000 usually eliminates intolerable lags due to thrashing.
> Larger values like N=3D3000 make lags less noticeable at the risk of
> premature OOM kills.
>
> Compared with the size-based approach, e.g., [2], this time-based
> approach has the following advantages:
> 1. It is easier to configure because it is agnostic to applications
>    and memory sizes.
> 2. It is more reliable because it is directly wired to the OOM killer.
>

how are userspace oom daemons like android lmkd, systemd-oomd supposed
to work with this time-based oom killer?
only one of min_ttl_ms and userspace daemon should be enabled? or both
should be enabled at the same time?

> [1] https://lore.kernel.org/lkml/Ydza%2FzXKY9ATRoh6@google.com/
> [2] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/vmscan.c            | 69 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 116c9237e401..f98f9ce50e67 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -403,6 +403,8 @@ struct lru_gen_struct {
>         unsigned long max_seq;
>         /* the eviction increments the oldest generation numbers */
>         unsigned long min_seq[ANON_AND_FILE];
> +       /* the birth time of each generation in jiffies */
> +       unsigned long timestamps[MAX_NR_GENS];
>         /* the multi-gen LRU lists */
>         struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
>         /* the sizes of the above lists */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 55cc7d6b018b..6aa083b8bb26 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4229,6 +4229,7 @@ static void inc_max_seq(struct lruvec *lruvec)
>         for (type =3D 0; type < ANON_AND_FILE; type++)
>                 reset_ctrl_pos(lruvec, type, false);
>
> +       WRITE_ONCE(lrugen->timestamps[next], jiffies);
>         /* make sure preceding modifications appear */
>         smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
>
> @@ -4340,7 +4341,8 @@ static long get_nr_evictable(struct lruvec *lruvec,=
 unsigned long max_seq,
>         return total > 0 ? total : 0;
>  }
>
> -static void age_lruvec(struct lruvec *lruvec, struct scan_control *sc)
> +static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc,
> +                      unsigned long min_ttl)
>  {
>         bool need_aging;
>         long nr_to_scan;
> @@ -4349,14 +4351,22 @@ static void age_lruvec(struct lruvec *lruvec, str=
uct scan_control *sc)
>         DEFINE_MAX_SEQ(lruvec);
>         DEFINE_MIN_SEQ(lruvec);
>
> +       if (min_ttl) {
> +               int gen =3D lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
> +               unsigned long birth =3D READ_ONCE(lruvec->lrugen.timestam=
ps[gen]);
> +
> +               if (time_is_after_jiffies(birth + min_ttl))
> +                       return false;
> +       }
> +
>         mem_cgroup_calculate_protection(NULL, memcg);
>
>         if (mem_cgroup_below_min(memcg))
> -               return;
> +               return false;
>
>         nr_to_scan =3D get_nr_evictable(lruvec, max_seq, min_seq, swappin=
ess, &need_aging);
>         if (!nr_to_scan)
> -               return;
> +               return false;
>
>         nr_to_scan >>=3D sc->priority;
>
> @@ -4365,11 +4375,18 @@ static void age_lruvec(struct lruvec *lruvec, str=
uct scan_control *sc)
>
>         if (nr_to_scan && need_aging && (!mem_cgroup_below_low(memcg) || =
sc->memcg_low_reclaim))
>                 try_to_inc_max_seq(lruvec, max_seq, sc, swappiness, false=
);
> +
> +       return true;
>  }
>
> +/* to protect the working set of the last N jiffies */
> +static unsigned long lru_gen_min_ttl __read_mostly;
> +
>  static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_cont=
rol *sc)
>  {
>         struct mem_cgroup *memcg;
> +       bool success =3D false;
> +       unsigned long min_ttl =3D READ_ONCE(lru_gen_min_ttl);
>
>         VM_BUG_ON(!current_is_kswapd());
>
> @@ -4395,12 +4412,29 @@ static void lru_gen_age_node(struct pglist_data *=
pgdat, struct scan_control *sc)
>         do {
>                 struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat)=
;
>
> -               age_lruvec(lruvec, sc);
> +               if (age_lruvec(lruvec, sc, min_ttl))
> +                       success =3D true;
>
>                 cond_resched();
>         } while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
>
>         current->reclaim_state->mm_walk =3D NULL;
> +
> +       /*
> +        * The main goal is to OOM kill if every generation from all memc=
gs is
> +        * younger than min_ttl. However, another theoretical possibility=
 is all
> +        * memcgs are either below min or empty.
> +        */
> +       if (!success && mutex_trylock(&oom_lock)) {
> +               struct oom_control oc =3D {
> +                       .gfp_mask =3D sc->gfp_mask,
> +                       .order =3D sc->order,
> +               };
> +
> +               out_of_memory(&oc);
> +
> +               mutex_unlock(&oom_lock);
> +       }
>  }
>
>  /*
> @@ -5112,6 +5146,28 @@ static void lru_gen_change_state(bool enable)
>   *                          sysfs interface
>   ***********************************************************************=
*******/
>
> +static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute =
*attr, char *buf)
> +{
> +       return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_mi=
n_ttl)));
> +}
> +
> +static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute=
 *attr,
> +                            const char *buf, size_t len)
> +{
> +       unsigned int msecs;
> +
> +       if (kstrtouint(buf, 0, &msecs))
> +               return -EINVAL;
> +
> +       WRITE_ONCE(lru_gen_min_ttl, msecs_to_jiffies(msecs));
> +
> +       return len;
> +}
> +
> +static struct kobj_attribute lru_gen_min_ttl_attr =3D __ATTR(
> +       min_ttl_ms, 0644, show_min_ttl, store_min_ttl
> +);
> +
>  static ssize_t show_enable(struct kobject *kobj, struct kobj_attribute *=
attr, char *buf)
>  {
>         unsigned int caps =3D 0;
> @@ -5160,6 +5216,7 @@ static struct kobj_attribute lru_gen_enabled_attr =
=3D __ATTR(
>  );
>
>  static struct attribute *lru_gen_attrs[] =3D {
> +       &lru_gen_min_ttl_attr.attr,
>         &lru_gen_enabled_attr.attr,
>         NULL
>  };
> @@ -5175,12 +5232,16 @@ static struct attribute_group lru_gen_attr_group =
=3D {
>
>  void lru_gen_init_lruvec(struct lruvec *lruvec)
>  {
> +       int i;
>         int gen, type, zone;
>         struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
>
>         lrugen->max_seq =3D MIN_NR_GENS + 1;
>         lrugen->enabled =3D lru_gen_enabled();
>
> +       for (i =3D 0; i <=3D MIN_NR_GENS + 1; i++)
> +               lrugen->timestamps[i] =3D jiffies;
> +
>         for_each_gen_type_zone(gen, type, zone)
>                 INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
>
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Thanks
Barry
