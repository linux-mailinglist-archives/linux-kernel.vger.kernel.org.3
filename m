Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67F585801
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbiG3C3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 22:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiG3C3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 22:29:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D34DFDF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 19:29:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 206so1800379pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D8nh9rddTt6L51ZbXbpeHlTuyQZ7jqEF8HhjNBeFMSo=;
        b=J43v+iWR0ZHURNM5y3qQ9FP2G7QJNDpPf+aTs6ZD5S9y8mHMgOypQMzYFc0Q60UcBv
         ZMC8qtqJU5OzrBazvtEopY1MQn7M8ObvQ7OmnhUn0CIuxKqWG0gn3VOXjuf/lDi6xY2q
         VA1iZ9+pH7x4TgO3Seb5dJOnScqq3q4TPvz5q/auQuaPgUn/IlUImL9SalBfeVeF8O1C
         J2V7W1eWFdtMuLCEq5K7Th3qvr1Blq3uEMolkTtRzAHA51xgkm6GEBJGSAcg6qOwzP1A
         Cis90QOF/yXt918e3Vjgv+EEZ9UVn9jZzx3aQnmpOcYhPoS0OYFQYldqefXf6JGqQsCR
         MxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D8nh9rddTt6L51ZbXbpeHlTuyQZ7jqEF8HhjNBeFMSo=;
        b=VCqiq7B4uVUzLrIBPjXMZsMvCDWT7qZA93GGRdmulxt2aMkhRAcUDIABkm5rgb2+M4
         Be6wtbXXQ31W3ptO6ZopmhXGw3RMA0diUtUfSCdGQ7ojdBMK4JE1wxWEd+mp/g3y3El6
         YnS7E+qSCMEPWzTBCFfjMxuyZsVAmXsWBXEJHR2d22q7lTM6H7eqON6zug5SaWdM0NEi
         lQe7Mi49n7NbKRYQccLbtth5+uiJPjhCfcr8bU7VcTAoRqi6sMfU98lhy1izP2U8lHa0
         G4Ve0FTnDt/LGWqDpGlOvpPKQFrAlR7genOT5Wco8Fv3XeHjo+IVWFwJqW+UsSaEORvy
         TMGQ==
X-Gm-Message-State: AJIora+9m7t9GgUQ8XI0Sad/5PdCYOGz7ruXDdGwqBeNtkQ2y/4voGl8
        Nubjjl3UOwNXdm7e095k1LGhtOpnN+QHQUdub/E=
X-Google-Smtp-Source: AGRyM1tzLXxBW/OHVmYkOjGUsDptBkCU4EJjbbLqSOXbjCorpcuSYRiTQJ0HQMksd5CP+xzgTdzj4nQVog9zCTCTaqE=
X-Received: by 2002:a65:49c8:0:b0:41a:eb36:d1a7 with SMTP id
 t8-20020a6549c8000000b0041aeb36d1a7mr5103118pgs.66.1659148142504; Fri, 29 Jul
 2022 19:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220729004920.8544-1-quic_yingangl@quicinc.com>
In-Reply-To: <20220729004920.8544-1-quic_yingangl@quicinc.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 30 Jul 2022 07:58:49 +0530
Message-ID: <CAFqt6zaAFONhDtWcwBbTVM5LkT4v0uM0wLiAnVGpzNydHp_S0Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_owner.c: add llseek for page_owner
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 6:19 AM Kassey Li <quic_yingangl@quicinc.com> wrote:
>
> There is usage to dump a given cma region page_owner
> instead of all page's.
>
> This change allows to specify a ppos as start_pfn
> by fseek.
>
> Any invalid ppos will be skipped, so it did not
> broken the origin dump feature.
>

I think a Suggested-by tag needs to be added.


> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  mm/page_owner.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..231b1877af99 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -497,8 +497,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>                 return -EINVAL;
>
>         page = NULL;
> -       pfn = min_low_pfn + *ppos;
>
> +       pfn = *ppos;
>         /* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>         while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>                 pfn++;
> @@ -561,7 +561,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>                         continue;
>
>                 /* Record the next PFN to read in the file offset */
> -               *ppos = (pfn - min_low_pfn) + 1;
> +               *ppos = pfn + 1;
>
>                 return print_page_owner(buf, count, pfn, page,
>                                 page_owner, handle);
> @@ -570,6 +570,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>         return 0;
>  }
>
> +static loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
> +{
> +       loff_t retval = 0;
> +       switch (whence) {
> +               case SEEK_CUR:
> +               case SEEK_SET:
> +                       file->f_pos = offset;
> +                       break;
> +               default:
> +                       retval = -ENXIO;
> +       }
> +
> +       return retval;
> +}
> +
>  static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  {
>         unsigned long pfn = zone->zone_start_pfn;
> @@ -660,6 +675,7 @@ static void init_early_allocated_pages(void)
>
>  static const struct file_operations proc_page_owner_operations = {
>         .read           = read_page_owner,
> +       .llseek         = llseek_page_owner,
>  };
>
>  static int __init pageowner_init(void)
> --
> 2.17.1
>
>
