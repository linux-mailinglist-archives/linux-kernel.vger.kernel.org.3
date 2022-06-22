Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E37555415
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377458AbiFVTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355581AbiFVTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:14:17 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A13703E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:14:16 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id w187so3769874vsb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoREZ7M189g66OG8lXhmFj3468Kg13OaxkXYT1yDuy0=;
        b=SM1g3aqxVrUaMGMy35p/7jhCtE+8kqqQRHT0rNEpJZWkxmz4NQfVQ1vS4wsE5PXkOm
         BEZzyiYQ9qTsNlIKMkPD0oHcL2GUWxwBBHLoynI5Ds2O+cAiVGROk0Fp7TiczG9v5gtA
         1SL3+zTzEYdIBq9lYISUPU6KPgjBhrWz7rTOjN5jkLLGjYUECl0BLXZnl1kQlj2bs6wh
         ZQUkcj9kA6Vn7kEhQ5dlzhgBd4Punbj32qMSkl9RtN2V+81sL0ilnVR/INN094vIJfMW
         aA5cI2rG+Ilvpy47D1tla5NCzP8r2O5D4gzSXUj6MGR/wp85LYyBAWPUZhug62RQQbv3
         A8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoREZ7M189g66OG8lXhmFj3468Kg13OaxkXYT1yDuy0=;
        b=g1OnkUIvpxIow4zR7Og4b/6Dpbnep19MsbT5+cnF+WXt7SjgYS2c+8tfUi3aPTJAQQ
         zAb0Dt/vReg4iPomHiLxTPuB5b3tgbry2dnA0KP8w+N6byM+xF3AvtNEHBePo/JndTli
         75e9FL3eR27s1FtDYh61d740d+WYe9X9L8P3Ert6J/R4sTnlU+JxKFU71Dv5CJpgjOCt
         RqUAKLa7eGEX8GSKh385drcPohucpye8jTrsJn2yjlC60yra/anayC5erhrivjLkrHtO
         ZgU0vFtBWf7iPSIMhAo9XvwEC/CBJJV5SYe5jsOfLcRweI8gDBal8KgxRodmuTqe4v4P
         woBg==
X-Gm-Message-State: AJIora+YNpO5jJzstpy4s+XPO+h3RUJCYSjGRNi5aoEwRT8PIiAZWqN1
        zEyRsJ6yfuVjvxvHRTNPSxby5GxLHfYmT1Qmku5k/Q==
X-Google-Smtp-Source: AGRyM1tqzfn/eGooe7rVyqLakJqYPnRIyJ7e5Hcfdor2BRQlRrkwrn6OyhG0ItwgwFDnmhbwVkV/LdlAgMONSUwHn8Q=
X-Received: by 2002:a67:fa01:0:b0:354:3ce9:4537 with SMTP id
 i1-20020a67fa01000000b003543ce94537mr6735666vsq.50.1655925255299; Wed, 22 Jun
 2022 12:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220614071650.206064-1-yuzhao@google.com> <20220614071650.206064-13-yuzhao@google.com>
 <214db251-827c-715c-54cf-9c0e9bb5fe30@bytedance.com>
In-Reply-To: <214db251-827c-715c-54cf-9c0e9bb5fe30@bytedance.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 22 Jun 2022 13:13:39 -0600
Message-ID: <CAOUHufZ8xaVKZD7LNeo8AZv_xywvwef4P8CjdO+npijLHEUfWg@mail.gmail.com>
Subject: Re: [PATCH v12 12/14] mm: multi-gen LRU: debugfs interface
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 3:16 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> > +static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
> > +                              size_t len, loff_t *pos)
> > +{
> > +     void *buf;
> > +     char *cur, *next;
> > +     unsigned int flags;
> > +     struct blk_plug plug;
> > +     int err = -EINVAL;
> > +     struct scan_control sc = {
> > +             .may_writepage = true,
> > +             .may_unmap = true,
> > +             .may_swap = true,
> > +             .reclaim_idx = MAX_NR_ZONES - 1,
> > +             .gfp_mask = GFP_KERNEL,
> > +     };
> > +
> > +     buf = kvmalloc(len + 1, GFP_KERNEL);
> > +     if (!buf)
> > +             return -ENOMEM;
> > +
> > +     if (copy_from_user(buf, src, len)) {
> > +             kvfree(buf);
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (!set_mm_walk(NULL)) {
>
> The current->reclaim_state will be dereferenced in set_mm_walk(), so
> calling set_mm_walk() before set_task_reclaim_state(current,
> &sc.reclaim_state) will cause panic:
>
> [ 1861.154916] BUG: kernel NULL pointer dereference, address:
> 0000000000000008

Thanks.

Apparently I shot myself in the foot by one of the nits between v11 and v12.

> > +             kvfree(buf);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     set_task_reclaim_state(current, &sc.reclaim_state);
> > +     flags = memalloc_noreclaim_save();
> > +     blk_start_plug(&plug);
> > +
> > +     next = buf;
> > +     next[len] = '\0';
> > +
> > +     while ((cur = strsep(&next, ",;\n"))) {
> > +             int n;
> > +             int end;
> > +             char cmd;
> > +             unsigned int memcg_id;
> > +             unsigned int nid;
> > +             unsigned long seq;
> > +             unsigned int swappiness = -1;
> > +             unsigned long opt = -1;
> > +
> > +             cur = skip_spaces(cur);
> > +             if (!*cur)
> > +                     continue;
> > +
> > +             n = sscanf(cur, "%c %u %u %lu %n %u %n %lu %n", &cmd, &memcg_id, &nid,
> > +                        &seq, &end, &swappiness, &end, &opt, &end);
> > +             if (n < 4 || cur[end]) {
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             err = run_cmd(cmd, memcg_id, nid, seq, &sc, swappiness, opt);
> > +             if (err)
> > +                     break;
> > +     }
> > +
> > +     blk_finish_plug(&plug);
> > +     memalloc_noreclaim_restore(flags);
> > +     set_task_reclaim_state(current, NULL);
> > +
> > +     clear_mm_walk();
>
> Ditto, we can't call clear_mm_walk() after
> set_task_reclaim_state(current, NULL).
>
> Maybe it can be modified as follows:
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2422edc786eb..552e6ae5243e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5569,12 +5569,12 @@ static ssize_t lru_gen_seq_write(struct file
> *file, const char __user *src,
>                  return -EFAULT;
>          }
>
> +       set_task_reclaim_state(current, &sc.reclaim_state);
>          if (!set_mm_walk(NULL)) {
>                  kvfree(buf);
>                  return -ENOMEM;
>          }
>
> -       set_task_reclaim_state(current, &sc.reclaim_state);

We need a `goto` because otherwise we leave a dangling
`current->reclaim_state`. (I swear I had one.)
