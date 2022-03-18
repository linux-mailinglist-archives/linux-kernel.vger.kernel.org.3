Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5393C4DD255
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiCRBR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiCRBRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:17:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE52A046C;
        Thu, 17 Mar 2022 18:16:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h126so13428831ybc.1;
        Thu, 17 Mar 2022 18:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRsb5Zmb/JCOeENoTDRg7wIKUPQgA0/d6iKWZvPMkaw=;
        b=gxFBnfWRS6wjleZvzFQNXoTfaiX0E6pjWIupBHBHr0SfVAYDgZiI+XgDsV7PpB4U67
         4y8iSEE+2ly4nmLzGztFYRJBtHjgJQvoyuGvqtUvwyC9gh3qycNrJ4lA7A/pvnX4ZacD
         DxXxxLvuchL/+vp/rItPOgGmEEn+NuAc5WJx4lBt9E9CyTd5hlBSrEyMLFUrb6ECAy43
         mVQH5bYzRijK+Q6tdNGM6qLrKzZCDs5Cjv4QM39KllWc+dOFyZcNDKPGlSIGgynuhjZJ
         hjUAOJbtI3oOSpzwT6+makiViBL4VWYpaFa37QI2iDg6ENewo7KGQjLNjMo9fIupbIk4
         RBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRsb5Zmb/JCOeENoTDRg7wIKUPQgA0/d6iKWZvPMkaw=;
        b=a15qf1g5C/W7/vJzLh+iLxvvbsmMd0c4UbL8vAGlnEf1zaHQcs6wHU5l4SlRNFhCzo
         0gwe2NQs37WcCyVXxGQqFm4BmJ90DMsHiUJsigeIxvu3WPzgBblNJavvHPKFByZIBTGD
         DvcvujJ3XXpbDJEKeP8yxgFHB3MmCPDQJdTGRnean+QqC1LZGg1dxp+H5d3S9L4tCR1h
         zu4aVKgp5tyk+sO1PNYLYl8ktUExeKnB/hlYR73wP34h8+ARqonqw7sG34efGXNr1t+y
         mCnOuZUx/pcKywVpTLO+O7ia3j8w1utJQHifsrnQ94WATWC4j7m5fKs8zFDlJrycWD6+
         E64A==
X-Gm-Message-State: AOAM531mrlnIKybbh1lrMmNALu4/KSvb/DDWAwM1pMWhGxrwu9uRJDzD
        RShzIjwIp5edsveJYXxTPA3QcstSFDnqjU5JsCY=
X-Google-Smtp-Source: ABdhPJwg2ySuj+xOjHdgdurPQW4/xpvbPONWKSpFY/ZbtyRbsY+xD+fgXfSSRGGveSsQWmt4JiYb/ZKNVUN9rC1yMhw=
X-Received: by 2002:a25:a223:0:b0:621:1238:68b1 with SMTP id
 b32-20020a25a223000000b00621123868b1mr8097719ybi.370.1647566164753; Thu, 17
 Mar 2022 18:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-4-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-4-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 18 Mar 2022 14:15:48 +1300
Message-ID: <CAGsJ_4zr_toOjd976AA5uBctVokVn+xZdvGo1TTZAg2XH0zmKQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/14] mm/vmscan.c: refactor shrink_node()
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

On Wed, Mar 9, 2022 at 3:47 PM Yu Zhao <yuzhao@google.com> wrote:
>
> This patch refactors shrink_node() to improve readability for the
> upcoming changes to mm/vmscan.c.
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

Reviewed-by: Barry Song <baohua@kernel.org>

seems nice refactoring since we are going to skip the whole
function for lru_gen later:
static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
{
        unsigned long file;
        struct lruvec *target_lruvec;

        if (lru_gen_enabled())
                return;
       ...
}

> ---
>  mm/vmscan.c | 198 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 104 insertions(+), 94 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 59b14e0d696c..8e744cdf802f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2718,6 +2718,109 @@ enum scan_balance {
>         SCAN_FILE,
>  };
>
> +static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc=
)
> +{
> +       unsigned long file;
> +       struct lruvec *target_lruvec;
> +
> +       target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat)=
;
> +
> +       /*
> +        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> +        * lruvec stats for heuristics.
> +        */
> +       mem_cgroup_flush_stats();
> +
> +       /*
> +        * Determine the scan balance between anon and file LRUs.
> +        */
> +       spin_lock_irq(&target_lruvec->lru_lock);
> +       sc->anon_cost =3D target_lruvec->anon_cost;
> +       sc->file_cost =3D target_lruvec->file_cost;
> +       spin_unlock_irq(&target_lruvec->lru_lock);
> +
> +       /*
> +        * Target desirable inactive:active list ratios for the anon
> +        * and file LRU lists.
> +        */
> +       if (!sc->force_deactivate) {
> +               unsigned long refaults;
> +
> +               refaults =3D lruvec_page_state(target_lruvec,
> +                               WORKINGSET_ACTIVATE_ANON);
> +               if (refaults !=3D target_lruvec->refaults[0] ||
> +                       inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)=
)
> +                       sc->may_deactivate |=3D DEACTIVATE_ANON;
> +               else
> +                       sc->may_deactivate &=3D ~DEACTIVATE_ANON;
> +
> +               /*
> +                * When refaults are being observed, it means a new
> +                * workingset is being established. Deactivate to get
> +                * rid of any stale active pages quickly.
> +                */
> +               refaults =3D lruvec_page_state(target_lruvec,
> +                               WORKINGSET_ACTIVATE_FILE);
> +               if (refaults !=3D target_lruvec->refaults[1] ||
> +                   inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
> +                       sc->may_deactivate |=3D DEACTIVATE_FILE;
> +               else
> +                       sc->may_deactivate &=3D ~DEACTIVATE_FILE;
> +       } else
> +               sc->may_deactivate =3D DEACTIVATE_ANON | DEACTIVATE_FILE;
> +
> +       /*
> +        * If we have plenty of inactive file pages that aren't
> +        * thrashing, try to reclaim those first before touching
> +        * anonymous pages.
> +        */
> +       file =3D lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> +       if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FIL=
E))
> +               sc->cache_trim_mode =3D 1;
> +       else
> +               sc->cache_trim_mode =3D 0;
> +
> +       /*
> +        * Prevent the reclaimer from falling into the cache trap: as
> +        * cache pages start out inactive, every cache fault will tip
> +        * the scan balance towards the file LRU.  And as the file LRU
> +        * shrinks, so does the window for rotation from references.
> +        * This means we have a runaway feedback loop where a tiny
> +        * thrashing file LRU becomes infinitely more attractive than
> +        * anon pages.  Try to detect this based on file LRU size.
> +        */
> +       if (!cgroup_reclaim(sc)) {
> +               unsigned long total_high_wmark =3D 0;
> +               unsigned long free, anon;
> +               int z;
> +
> +               free =3D sum_zone_node_page_state(pgdat->node_id, NR_FREE=
_PAGES);
> +               file =3D node_page_state(pgdat, NR_ACTIVE_FILE) +
> +                          node_page_state(pgdat, NR_INACTIVE_FILE);
> +
> +               for (z =3D 0; z < MAX_NR_ZONES; z++) {
> +                       struct zone *zone =3D &pgdat->node_zones[z];
> +
> +                       if (!managed_zone(zone))
> +                               continue;
> +
> +                       total_high_wmark +=3D high_wmark_pages(zone);
> +               }
> +
> +               /*
> +                * Consider anon: if that's low too, this isn't a
> +                * runaway file reclaim problem, but rather just
> +                * extreme pressure. Reclaim as per usual then.
> +                */
> +               anon =3D node_page_state(pgdat, NR_INACTIVE_ANON);
> +
> +               sc->file_is_tiny =3D
> +                       file + free <=3D total_high_wmark &&
> +                       !(sc->may_deactivate & DEACTIVATE_ANON) &&
> +                       anon >> sc->priority;
> +       }
> +}
> +
>  /*
>   * Determine how aggressively the anon and file LRU lists should be
>   * scanned.  The relative value of each set of LRU lists is determined
> @@ -3188,109 +3291,16 @@ static void shrink_node(pg_data_t *pgdat, struct=
 scan_control *sc)
>         unsigned long nr_reclaimed, nr_scanned;
>         struct lruvec *target_lruvec;
>         bool reclaimable =3D false;
> -       unsigned long file;
>
>         target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat)=
;
>
>  again:
> -       /*
> -        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> -        * lruvec stats for heuristics.
> -        */
> -       mem_cgroup_flush_stats();
> -
>         memset(&sc->nr, 0, sizeof(sc->nr));
>
>         nr_reclaimed =3D sc->nr_reclaimed;
>         nr_scanned =3D sc->nr_scanned;
>
> -       /*
> -        * Determine the scan balance between anon and file LRUs.
> -        */
> -       spin_lock_irq(&target_lruvec->lru_lock);
> -       sc->anon_cost =3D target_lruvec->anon_cost;
> -       sc->file_cost =3D target_lruvec->file_cost;
> -       spin_unlock_irq(&target_lruvec->lru_lock);
> -
> -       /*
> -        * Target desirable inactive:active list ratios for the anon
> -        * and file LRU lists.
> -        */
> -       if (!sc->force_deactivate) {
> -               unsigned long refaults;
> -
> -               refaults =3D lruvec_page_state(target_lruvec,
> -                               WORKINGSET_ACTIVATE_ANON);
> -               if (refaults !=3D target_lruvec->refaults[0] ||
> -                       inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)=
)
> -                       sc->may_deactivate |=3D DEACTIVATE_ANON;
> -               else
> -                       sc->may_deactivate &=3D ~DEACTIVATE_ANON;
> -
> -               /*
> -                * When refaults are being observed, it means a new
> -                * workingset is being established. Deactivate to get
> -                * rid of any stale active pages quickly.
> -                */
> -               refaults =3D lruvec_page_state(target_lruvec,
> -                               WORKINGSET_ACTIVATE_FILE);
> -               if (refaults !=3D target_lruvec->refaults[1] ||
> -                   inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
> -                       sc->may_deactivate |=3D DEACTIVATE_FILE;
> -               else
> -                       sc->may_deactivate &=3D ~DEACTIVATE_FILE;
> -       } else
> -               sc->may_deactivate =3D DEACTIVATE_ANON | DEACTIVATE_FILE;
> -
> -       /*
> -        * If we have plenty of inactive file pages that aren't
> -        * thrashing, try to reclaim those first before touching
> -        * anonymous pages.
> -        */
> -       file =3D lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -       if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FIL=
E))
> -               sc->cache_trim_mode =3D 1;
> -       else
> -               sc->cache_trim_mode =3D 0;
> -
> -       /*
> -        * Prevent the reclaimer from falling into the cache trap: as
> -        * cache pages start out inactive, every cache fault will tip
> -        * the scan balance towards the file LRU.  And as the file LRU
> -        * shrinks, so does the window for rotation from references.
> -        * This means we have a runaway feedback loop where a tiny
> -        * thrashing file LRU becomes infinitely more attractive than
> -        * anon pages.  Try to detect this based on file LRU size.
> -        */
> -       if (!cgroup_reclaim(sc)) {
> -               unsigned long total_high_wmark =3D 0;
> -               unsigned long free, anon;
> -               int z;
> -
> -               free =3D sum_zone_node_page_state(pgdat->node_id, NR_FREE=
_PAGES);
> -               file =3D node_page_state(pgdat, NR_ACTIVE_FILE) +
> -                          node_page_state(pgdat, NR_INACTIVE_FILE);
> -
> -               for (z =3D 0; z < MAX_NR_ZONES; z++) {
> -                       struct zone *zone =3D &pgdat->node_zones[z];
> -                       if (!managed_zone(zone))
> -                               continue;
> -
> -                       total_high_wmark +=3D high_wmark_pages(zone);
> -               }
> -
> -               /*
> -                * Consider anon: if that's low too, this isn't a
> -                * runaway file reclaim problem, but rather just
> -                * extreme pressure. Reclaim as per usual then.
> -                */
> -               anon =3D node_page_state(pgdat, NR_INACTIVE_ANON);
> -
> -               sc->file_is_tiny =3D
> -                       file + free <=3D total_high_wmark &&
> -                       !(sc->may_deactivate & DEACTIVATE_ANON) &&
> -                       anon >> sc->priority;
> -       }
> +       prepare_scan_count(pgdat, sc);
>
>         shrink_node_memcgs(pgdat, sc);
>
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Thanks
Barry
