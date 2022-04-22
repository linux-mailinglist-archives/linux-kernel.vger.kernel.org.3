Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2BA50BECB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiDVRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiDVRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:38:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D525E016
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:35:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y14so7855354pfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTx9j6um++bDvPzngdWfztBTWMSm5Y4kGTKyaYCvWJA=;
        b=GawO1yJAJrxBdODI2xKPb6ONjN181mj1BvSw15s51XVSw+bHIkn6QEWm4FY7vQ8BSf
         KUGpARxzDIm6O0PIGm9sk0jFAEFcC9gCkD0w3XoD3bEvtljZ0NHT9DHP1a6Z9nCKwK2s
         eNSpY7SBmV3WGCAyKJmYxT02DDLgNtWDUB8CHeBMbQqnCpc8HUWwYDSQBsRs4eXIiPE3
         V/J7IR3NDraoYA2LVarFTf2Tf0EwFnTDxSGJ357fl8YZsyuEOOo1p3XNqvHQCK6tcTO0
         BEPCriGAGadBvtg0+uRoRckN8aAk85fCdz0Yvcahz0qaZGgRXYBXbni3tt7TwLeie+yZ
         pVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTx9j6um++bDvPzngdWfztBTWMSm5Y4kGTKyaYCvWJA=;
        b=AOgJ+L6NU2Sk7KLy1KU+gLWKy/uIBQ4fGgvswsKRziRFo17gBtHy8wfgsi5Rgxu8H3
         XvlQSFOP0+EE2w2/HwYbXu+sdPAGTaXVyOXIUHAJGBAJ0l4+Hry3EYC3GIaXEPB0WEub
         xwa7JDetkaunoiGa0RqjD5MeR4JiROcHNCA51jFkpmA8fzW1b/eCLiO5EnzpF0uXE06X
         au6ff93Flj3w1LcepVqRNQUc+xODENf9ueuIPsi4px0cTxjrky8OAxMrI9L3Lk/OqJF3
         WEFWAMx9SK4bh7paBuvhF5tjk0X82j4+0WHYcHsuHGwhcqGwaBbXajP3GIff+tBWahX8
         8vPA==
X-Gm-Message-State: AOAM531wae0JeUX+mIHQ7RobDRvOd6jost733MeDjVfnCog2qWcM6gd9
        tfkpWLqd793jpD+cLNBjAWPqWi26PwM5FvbtUN0=
X-Google-Smtp-Source: ABdhPJwt2+2ZOpnouIOeQ4yI8QwOAwZ0wMwJHawmc2MnYo2JfXzrJf207yutiEaSFTqpBg4LFWhL2K55GE2rsvJxEXw=
X-Received: by 2002:a05:6a00:bd1:b0:505:79c7:75f6 with SMTP id
 x17-20020a056a000bd100b0050579c775f6mr5889282pfu.23.1650648728728; Fri, 22
 Apr 2022 10:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220416053902.68517-1-dave@stgolabs.net> <20220416053902.68517-6-dave@stgolabs.net>
In-Reply-To: <20220416053902.68517-6-dave@stgolabs.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Apr 2022 10:31:56 -0700
Message-ID: <CAHbLzkruFaKF_92w2qsZz4sH24C-TARXaL-byT6doVVe6VQ4Zg@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm/migration: export demotion_path of a node via sysfs
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Add a /sys/devices/system/node/nodeX/demotion_path file
> to export the possible target(s) in node_demotion[node].

I'm not sure if you noticed that Jagdish Gediya is working on the
similar patch, please see
https://lore.kernel.org/linux-mm/20220413092206.73974-1-jvgediya@linux.ibm.com/

It would be better to combine the two to avoid duplicate effort.

>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/stable/sysfs-devices-node |  6 ++++
>  drivers/base/node.c                         | 39 +++++++++++++++++++++
>  include/linux/migrate.h                     | 15 ++++++++
>  mm/migrate.c                                | 15 +-------
>  4 files changed, 61 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 3c935e1334f7..f620c6ae013c 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -192,3 +192,9 @@ Description:
>                 When it completes successfully, the specified amount or more memory
>                 will have been reclaimed, and -EAGAIN if less bytes are reclaimed
>                 than the specified amount.
> +
> +What:          /sys/devices/system/node/nodeX/demotion_path
> +Date:          April 2022
> +Contact:       Davidlohr Bueso <dave@stgolabs.net>
> +Description:
> +               Shows nodes within the next tier of slower memory below this node.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index d80c478e2a6e..ab4bae777535 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -17,6 +17,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/cpu.h>
>  #include <linux/device.h>
> +#include <linux/migrate.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> @@ -560,11 +561,49 @@ static ssize_t node_read_distance(struct device *dev,
>  }
>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>
> +static ssize_t node_read_demotion_path(struct device *dev,
> +                                      struct device_attribute *attr, char *buf)
> +{
> +       int nid = dev->id;
> +       int len = 0;
> +       int i;
> +       struct demotion_nodes *nd;
> +
> +       /*
> +        * buf is currently PAGE_SIZE in length and each node needs 4 chars
> +        * at the most (target + space or newline).
> +        */
> +       BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
> +
> +       if (!node_demotion) {
> +               len += sysfs_emit_at(buf, len, "%d", NUMA_NO_NODE);
> +               goto done;
> +       }
> +
> +       nd = &node_demotion[nid];
> +
> +       rcu_read_lock();
> +       if (nd->nr == 0)
> +               len += sysfs_emit_at(buf, len, "%d", NUMA_NO_NODE);
> +       else {
> +               for (i = 0; i < nd->nr; i++) {
> +                       len += sysfs_emit_at(buf, len, "%s%d",
> +                                            i ? " " : "", nd->nodes[i]);
> +               }
> +       }
> +       rcu_read_unlock();
> +done:
> +       len += sysfs_emit_at(buf, len, "\n");
> +       return len;
> +}
> +static DEVICE_ATTR(demotion_path, 0444, node_read_demotion_path, NULL);
> +
>  static struct attribute *node_dev_attrs[] = {
>         &dev_attr_meminfo.attr,
>         &dev_attr_numastat.attr,
>         &dev_attr_distance.attr,
>         &dev_attr_vmstat.attr,
> +       &dev_attr_demotion_path.attr,
>         NULL
>  };
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 90e75d5a54d6..b0ac6a717e44 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -111,6 +111,21 @@ static inline int migrate_misplaced_page(struct page *page,
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>
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
> +extern struct demotion_nodes *node_demotion __read_mostly;
> +
>  #ifdef CONFIG_MIGRATION
>
>  /*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6c31ee1e1c9b..e47ea25fcfe8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2172,20 +2172,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>   * must be held over all reads to ensure that no cycles are
>   * observed.
>   */
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
> +struct demotion_nodes *node_demotion __read_mostly;
>
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
> --
> 2.26.2
>
>
