Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52702595726
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiHPJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiHPJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:53:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39652883F3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:49:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so8686471pgm.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ew0JbuH+cKc1GM98uFK2TY2D+9upbKP43VxsyM3NabU=;
        b=CocRxk7jQ2Biv6MJ+Opj5wyIE68fFgnwYhZW3jCxCacPKs0IKO1vgpJYm0/gVQfM0w
         CXNext33qwE8N7nZ0+dxm2kPy12oSb7Ij0pPuCvRDPBdpD8kT3hUMScN2zAD7xmhiPhc
         76yIEVbZXnknWnlInNHPYnyhEeyW3YMZjuk1zOTLxoKugN4FMqxL2bl2KdpDP5rFCbpQ
         uMu/vigsLWcV7DyQtRLqXVEKKlZdrJlqOWdTOAdszZ7dllTrEK7Gi36v7ALhZsA85c7F
         PfQlnfI3dKGTI+uAyZt263VxEOkJNhXzsWfDdWW2v1oiFYra60gOuRO0sdgH4hPKUT8i
         7mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ew0JbuH+cKc1GM98uFK2TY2D+9upbKP43VxsyM3NabU=;
        b=MBa73ZIUqWK6xFLVTxsrLQCuJrRp2tplztU3+GsT4ODU+O2HmuV6/KNCgGPYGNvWTq
         eapATPzhXZV4z9nOAT+ti4bgEzfR0sIt+9AfSY/HcWQkLARHTh0z/Sh5iPtPTdGl+RhA
         XyUHRJHBJ7dy0i4iPN4nDMi9sqeKn5hHaoo/pycuLdaRvuADKmW2sJkbNUkSUfkeF9J/
         onFr7A6g5rHrBH8r+qG9Pcy9x4rzScBcUPsHhG6kBvZsyCe0HbZSVr2c00S5nJplXGy4
         52FYiXO5+K7pHGHaRqCADBoTs+S4JApM6TPzIQhHbvGWkjfp7FfymMRtiight8FtRGoy
         j8gQ==
X-Gm-Message-State: ACgBeo1yNMd+s2deQqzka71MG0ZGzdYLAWY0bjVmaioGKxNmgCTrmbn+
        Q2TuyVaBrdO9t1LZb4Sk2rRgoAn2a715c+NAry8=
X-Google-Smtp-Source: AA6agR5jLUKIksUtcXneGgeIb15FslvkMh42IlSp55a5aOcBny1Rmc/S5HpHr0Res5cKXwsHlBjR0nnuwCAF1Yu/RPU=
X-Received: by 2002:a63:6345:0:b0:41d:649a:af3d with SMTP id
 x66-20020a636345000000b0041d649aaf3dmr17235518pgb.354.1660639759746; Tue, 16
 Aug 2022 01:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 16 Aug 2022 16:48:41 +0800
Message-ID: <CAC=cRTN=vbrgOsH7PNNMV+Coyabp=H_XF99MUL00kfET=K-32w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liu Shixin <liushixin2@huawei.com>,
        Huang Ying <ying.huang@intel.com>
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

On Tue, Aug 16, 2022 at 4:38 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> From: Liu Shixin <liushixin2@huawei.com>
>
> The page on pcplist could be used, but not counted into memory free or
> avaliable, and pcp_free is only showed by show_mem(). Since commit
> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> significant decrease in the display of free memory, with a large number
> of cpus and nodes, the number of pages in the percpu list can be very
> large, so it is better to let user to know the pcp count.

Can you show some data?

Another choice is to count PCP free pages in MemFree.  Is that OK for
your use case too?

Best Regards,
Huang, Ying

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/base/node.c | 14 +++++++++++++-
>  fs/proc/meminfo.c   |  9 +++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eb0f43784c2b..846864e45db6 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>         struct sysinfo i;
>         unsigned long sreclaimable, sunreclaimable;
>         unsigned long swapcached = 0;
> +       unsigned long free_pcp = 0;
> +       struct zone *zone;
> +       int cpu;
>
>         si_meminfo_node(&i, nid);
>         sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>  #ifdef CONFIG_SWAP
>         swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>  #endif
> +       for_each_populated_zone(zone) {
> +               if (zone_to_nid(zone) != nid)
> +                       continue;
> +               for_each_online_cpu(cpu)
> +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> +       }
> +
>         len = sysfs_emit_at(buf, len,
>                             "Node %d MemTotal:       %8lu kB\n"
>                             "Node %d MemFree:        %8lu kB\n"
> +                           "Node %d PcpFree:        %8lu kB\n"
>                             "Node %d MemUsed:        %8lu kB\n"
>                             "Node %d SwapCached:     %8lu kB\n"
>                             "Node %d Active:         %8lu kB\n"
> @@ -397,7 +408,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>                             "Node %d Mlocked:        %8lu kB\n",
>                             nid, K(i.totalram),
>                             nid, K(i.freeram),
> -                           nid, K(i.totalram - i.freeram),
> +                           nid, K(free_pcp),
> +                           nid, K(i.totalram - i.freeram - free_pcp),
>                             nid, K(swapcached),
>                             nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
>                                    node_page_state(pgdat, NR_ACTIVE_FILE)),
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6e89f0e2fd20..672c784dfc8a 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>         unsigned long pages[NR_LRU_LISTS];
>         unsigned long sreclaimable, sunreclaim;
>         int lru;
> +       unsigned long free_pcp = 0;
> +       struct zone *zone;
> +       int cpu;
>
>         si_meminfo(&i);
>         si_swapinfo(&i);
> @@ -55,8 +58,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>         sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
>         sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
>
> +       for_each_populated_zone(zone) {
> +               for_each_online_cpu(cpu)
> +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> +       }
> +
>         show_val_kb(m, "MemTotal:       ", i.totalram);
>         show_val_kb(m, "MemFree:        ", i.freeram);
> +       show_val_kb(m, "PcpFree:        ", free_pcp);
>         show_val_kb(m, "MemAvailable:   ", available);
>         show_val_kb(m, "Buffers:        ", i.bufferram);
>         show_val_kb(m, "Cached:         ", cached);
> --
> 2.35.3
>
>
