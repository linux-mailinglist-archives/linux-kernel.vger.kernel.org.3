Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B065236A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiEKPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245619AbiEKPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:03:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6339B21A951
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:02:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so4630633ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KE8F0pAboHlmVpDvIJzJeE3Yh6I2powqB0a7EA++YRI=;
        b=LR9gjop7+QkUAbsLbkhth1quvU+Y2S26jy9bP0TJc+WR2RfvWtvGRZvLRWY9hDAmPF
         FQ9i3/sWNaR1Go43p1OV24bGISMi51za4K/IPCh3I5ziNJBSpN2XGn4yhLL1K27WgXkR
         WfTHj84m779s6NqZ9xE3IKV2WUv5nkHnS9cdlgUiHEaw1zsv8ckS81GzkGsAdF7Huebe
         H/XuvxEBDFYKfCTzkHaBr3+YHf5elnNigLJReC9TQlKcwQwr197XQTaLmLjm3eBABedz
         EzF78hiImxo3fe9im1TKS85Y44ntcvp+ngpXj1fix9+/ThCExVzTph9PA22O+TSwdXNV
         FmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KE8F0pAboHlmVpDvIJzJeE3Yh6I2powqB0a7EA++YRI=;
        b=jEjCSuinV2biL3IATiiMhtUthxyxakQTfLM7sgkNichrZcOxATRkhZ4fldS8TN8gJ7
         cxGns4Ct6GlVJ3YfVd/ca8NX+hsr6Px6f3pfMaSLRpT3oHg72IUQW0V6yrDvgMJwbr2y
         wd3FT8gv2lG/PeLZiBudBfpCMBzBcjABh7VSB4MB+hPTiIPQ1pVbgu8r7IOc/Zg7rfE6
         NW+CgS5267n6XEqCvNXESYdq6T6U41Qg8TjWeuKnm/InN/X68xmnXdhkPB8HTrXvRLGY
         ciMA1WNAt408J09nfBSjvSiiEByHnDigPIrKZ8HhN9QFx67GfrtT5RTWDkHDr0j1XhwS
         CczQ==
X-Gm-Message-State: AOAM5313U9wyPtK5+Hr9GTwzRRzNyTFIAQrSOuuLAL5J42K5O5HMW2Bd
        7Hmm+JkQOjmvwxmqTsFoxROCxPWvkSOJbE0z4QQhoJSEjTk=
X-Google-Smtp-Source: ABdhPJy64G0q+ERl9Hvtunxneij8b0z+R7rktknovQpURcpN78u8b6tRsGXULKT3LZ6wyg8U6Q/OCcPYELZI9gidFh4=
X-Received: by 2002:a17:907:980e:b0:6f5:222a:334e with SMTP id
 ji14-20020a170907980e00b006f5222a334emr23452161ejc.643.1652281361550; Wed, 11
 May 2022 08:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220511081207.132034-1-vvghjk1234@gmail.com> <20220511142303.GN20579@suse.de>
In-Reply-To: <20220511142303.GN20579@suse.de>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Thu, 12 May 2022 00:02:30 +0900
Message-ID: <CAEcHRTrq6gGac5zYS24qf59rEjDBYvGHkjdZGyGNnuKzXTKVcQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Fix tracepoint mm_page_alloc_zone_locked()
To:     Mel Gorman <mgorman@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:23 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Wed, May 11, 2022 at 05:12:07PM +0900, Wonhyuk Yang wrote:
> > Currently, trace point mm_page_alloc_zone_locked() doesn't show
> > correct information.
> >
> > First, when alloc_flag has ALLOC_HARDER/ALLOC_CMA, page can
> > be allocated from MIGRATE_HIGHATOMIC/MIGRATE_CMA. Nevertheless,
> > tracepoint use requested migration type not MIGRATE_HIGHATOMIC and
> > MIGRATE_CMA.
> >
> > Second, after Commit 44042b4498728 ("mm/page_alloc: allow high-order
> > pages to be stored on the per-cpu lists") percpu-list can store
> > high order pages. But trace point determine whether it is a refiil
> > of percpu-list by comparing requested order and 0.
> >
> > To handle these problems, use cached migration type by
> > get_pcppage_migratetype() instead of requested migration type.
> > Then, make mm_page_alloc_zone_locked() be called only two contexts
> > (rmqueue_bulk, rmqueue). With a new argument called percpu_refill,
> > it can show whether it is a refill of percpu-list correctly.
> >
>
> You're definitely right that the current tracepoint is broken.
>
> I got momentarily confused because HIGHATOMIC and CMA are not stored on
> PCP lists even though they are a pageblock migrate type. Superficially
> calling get_pcppage_migratetype on a page that cannot be a PCP page
> seems silly but in the context of this patch, it happens to work because
> it was isolated with __rmqueue_smallest which sets the PCP type even if
> the page is not going to a PCP list.

Yes, I agree that calling get_pcppage_migratetype look quite confusing.

> The original intent of that tracepoint was to trace when pages were
> removed from the buddy list. That would suggest this untested patch on
> top of yours as a simplication;
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0351808322ba..66a70b898130 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2476,6 +2476,8 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>                 del_page_from_free_list(page, zone, current_order);
>                 expand(zone, page, order, current_order, migratetype);
>                 set_pcppage_migratetype(page, migratetype);
> +               trace_mm_page_alloc_zone_locked(page, order, migratetype,
> +                       pcp_allowed_order(order) && migratetype < MIGRATE_PCPTYPES);
>                 return page;
>         }

Interestingly, my first approach was quite similar your suggestion. But I
noticed that there can be a request whose migration type is MOVABLE
and alloc_flags doen't have ALLOC_CMA. In that case, page are marked
as percpu-refill even though it was allocated from buddy-list directly.
Is there no problem if we just ignore this case?


> @@ -3025,7 +3027,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>                         int migratetype, unsigned int alloc_flags)
>  {
>         int i, allocated = 0;
> -       int mt;
>
>         /*
>          * local_lock_irq held so equivalent to spin_lock_irqsave for
> @@ -3053,9 +3054,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>                  */
>                 list_add_tail(&page->lru, list);
>                 allocated++;
> -               mt = get_pcppage_migratetype(page);
> -               trace_mm_page_alloc_zone_locked(page, order, mt, true);
> -               if (is_migrate_cma(mt))
> +               if (is_migrate_cma(get_pcppage_migratetype(page)))
>                         __mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
>                                               -(1 << order));
>         }
> @@ -3704,7 +3703,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>  {
>         unsigned long flags;
>         struct page *page;
> -       int mt;
>
>         if (likely(pcp_allowed_order(order))) {
>                 /*
> @@ -3734,17 +3732,15 @@ struct page *rmqueue(struct zone *preferred_zone,
>                  * reserved for high-order atomic allocation, so order-0
>                  * request should skip it.
>                  */
> -               if (order > 0 && alloc_flags & ALLOC_HARDER) {
> +               if (order > 0 && alloc_flags & ALLOC_HARDER)
>                         page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> -               }
>                 if (!page) {
>                         page = __rmqueue(zone, order, migratetype, alloc_flags);
>                         if (!page)
>                                 goto failed;
>                 }
> -               mt = get_pcppage_migratetype(page);
> -               trace_mm_page_alloc_zone_locked(page, order, mt, false);
> -               __mod_zone_freepage_state(zone, -(1 << order), mt);
> +               __mod_zone_freepage_state(zone, -(1 << order),
> +                                         get_pcppage_migratetype(page));
>                 spin_unlock_irqrestore(&zone->lock, flags);
>         } while (check_new_pages(page, order));
>
