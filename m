Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00A50BEDF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiDVRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiDVRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:41:10 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE4E07E1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:38:03 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id n18so12347783plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiXv4gRA4sTObvIQ+FoZbquWQgdoIl4ETDd06lrJqYI=;
        b=j1kJ+/P6c1H11XFyMz2fXLe7XysDwsCdF9a79eOUYcvtLdxf9Tx3Eny+Pb3enhMss6
         04ovK/+SnfhDeRevELEOpWSR1VcwaJTfHWKYkiWg4FRlhxiRSBEDrmYgzdfB8eFbAEtb
         76X8pK+PaE7/0ubmPPOmWhWqa7QT+SdZlAi5HewV0Gj+lB2YMQLhfQZ/QkPTfKgA3D9F
         aPBfaMe2M3q4C9A2dw8u1uuX7nhKaoxy4lymOUm3zPAYbZVxEVEOXlwE3rsJUHVZkBJs
         xSV0Z0mQ/rMafG39d34kIxoKIoBsEBA0qm8Nke2p60oFKdYkQptdQ1rwyx/i6zHsir2N
         F+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiXv4gRA4sTObvIQ+FoZbquWQgdoIl4ETDd06lrJqYI=;
        b=8SEPABFidJXWttxD+AMRs/Q7bp2aQ/HQ24zzt/fgLmHGarAI3FZ6AfDyNTpJuTuQmL
         Zbbmp6d8L1DowaqnPCyn3+AqaZSHDsvxCjZmt7JJlk2ABGHGAC6V9nPcRHEipksV3mAO
         SGx2bI5Mn0ZFXZCTTkqtuNvKoxO1zlLtbNpOGsFf9jey1SL6/YnOK2PfWH84Gv1hcO6R
         jX0DoTvG7Ud+SGHonGmo+zxotGA+Yp7IIR4roZ+G6NjCc1/gOtxKjkG0lp6Dl68qQDZp
         hZA/37mjQ8f94mOlIUJm6vRKaxIrbLjh+gtCTE68hL/RPbOT0bw6VklBDjxDgrmQ21rs
         eYrw==
X-Gm-Message-State: AOAM531yRhpEbyWyrxrBPzGqYym/JIw4XDlURknaTIsxFrh+Ts0LTbFj
        M+zzn3E9H8zwqxupYbu2U6fLC/HoruGUtded2qo=
X-Google-Smtp-Source: ABdhPJwDtXXK2rudfcxu6wHXZuUanIAPzm53VgsV1cCq2vwpLT/lRskHReTO45q5f74JiCAzll30576kEc3oqOCCZ34=
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id
 g3-20020a170902d5c300b00154c472de80mr5593008plh.87.1650648845908; Fri, 22 Apr
 2022 10:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220416053902.68517-1-dave@stgolabs.net> <20220416053902.68517-6-dave@stgolabs.net>
 <CAHbLzkruFaKF_92w2qsZz4sH24C-TARXaL-byT6doVVe6VQ4Zg@mail.gmail.com>
In-Reply-To: <CAHbLzkruFaKF_92w2qsZz4sH24C-TARXaL-byT6doVVe6VQ4Zg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Apr 2022 10:33:53 -0700
Message-ID: <CAHbLzkr4w-20H11uNrf-9ZJd=oHGTXTatd5OJ0JAO1KwojySdA@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm/migration: export demotion_path of a node via sysfs
To:     Davidlohr Bueso <dave@stgolabs.net>, jvgediya@linux.ibm.com,
        ying.huang@intel.com, weixugc@google.com
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:31 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 10:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> > Add a /sys/devices/system/node/nodeX/demotion_path file
> > to export the possible target(s) in node_demotion[node].
>
> I'm not sure if you noticed that Jagdish Gediya is working on the
> similar patch, please see
> https://lore.kernel.org/linux-mm/20220413092206.73974-1-jvgediya@linux.ibm.com/

Loop in Jagdish Gediya, Ying Huang and Wei Xu.

>
> It would be better to combine the two to avoid duplicate effort.
>
> >
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  Documentation/ABI/stable/sysfs-devices-node |  6 ++++
> >  drivers/base/node.c                         | 39 +++++++++++++++++++++
> >  include/linux/migrate.h                     | 15 ++++++++
> >  mm/migrate.c                                | 15 +-------
> >  4 files changed, 61 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > index 3c935e1334f7..f620c6ae013c 100644
> > --- a/Documentation/ABI/stable/sysfs-devices-node
> > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > @@ -192,3 +192,9 @@ Description:
> >                 When it completes successfully, the specified amount or more memory
> >                 will have been reclaimed, and -EAGAIN if less bytes are reclaimed
> >                 than the specified amount.
> > +
> > +What:          /sys/devices/system/node/nodeX/demotion_path
> > +Date:          April 2022
> > +Contact:       Davidlohr Bueso <dave@stgolabs.net>
> > +Description:
> > +               Shows nodes within the next tier of slower memory below this node.
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index d80c478e2a6e..ab4bae777535 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/nodemask.h>
> >  #include <linux/cpu.h>
> >  #include <linux/device.h>
> > +#include <linux/migrate.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/swap.h>
> >  #include <linux/slab.h>
> > @@ -560,11 +561,49 @@ static ssize_t node_read_distance(struct device *dev,
> >  }
> >  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
> >
> > +static ssize_t node_read_demotion_path(struct device *dev,
> > +                                      struct device_attribute *attr, char *buf)
> > +{
> > +       int nid = dev->id;
> > +       int len = 0;
> > +       int i;
> > +       struct demotion_nodes *nd;
> > +
> > +       /*
> > +        * buf is currently PAGE_SIZE in length and each node needs 4 chars
> > +        * at the most (target + space or newline).
> > +        */
> > +       BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
> > +
> > +       if (!node_demotion) {
> > +               len += sysfs_emit_at(buf, len, "%d", NUMA_NO_NODE);
> > +               goto done;
> > +       }
> > +
> > +       nd = &node_demotion[nid];
> > +
> > +       rcu_read_lock();
> > +       if (nd->nr == 0)
> > +               len += sysfs_emit_at(buf, len, "%d", NUMA_NO_NODE);
> > +       else {
> > +               for (i = 0; i < nd->nr; i++) {
> > +                       len += sysfs_emit_at(buf, len, "%s%d",
> > +                                            i ? " " : "", nd->nodes[i]);
> > +               }
> > +       }
> > +       rcu_read_unlock();
> > +done:
> > +       len += sysfs_emit_at(buf, len, "\n");
> > +       return len;
> > +}
> > +static DEVICE_ATTR(demotion_path, 0444, node_read_demotion_path, NULL);
> > +
> >  static struct attribute *node_dev_attrs[] = {
> >         &dev_attr_meminfo.attr,
> >         &dev_attr_numastat.attr,
> >         &dev_attr_distance.attr,
> >         &dev_attr_vmstat.attr,
> > +       &dev_attr_demotion_path.attr,
> >         NULL
> >  };
> >
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index 90e75d5a54d6..b0ac6a717e44 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -111,6 +111,21 @@ static inline int migrate_misplaced_page(struct page *page,
> >  }
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> > +#define DEFAULT_DEMOTION_TARGET_NODES 15
> > +
> > +#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> > +#define DEMOTION_TARGET_NODES  (MAX_NUMNODES - 1)
> > +#else
> > +#define DEMOTION_TARGET_NODES  DEFAULT_DEMOTION_TARGET_NODES
> > +#endif
> > +
> > +struct demotion_nodes {
> > +       unsigned short nr;
> > +       short nodes[DEMOTION_TARGET_NODES];
> > +};
> > +
> > +extern struct demotion_nodes *node_demotion __read_mostly;
> > +
> >  #ifdef CONFIG_MIGRATION
> >
> >  /*
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 6c31ee1e1c9b..e47ea25fcfe8 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2172,20 +2172,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
> >   * must be held over all reads to ensure that no cycles are
> >   * observed.
> >   */
> > -#define DEFAULT_DEMOTION_TARGET_NODES 15
> > -
> > -#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> > -#define DEMOTION_TARGET_NODES  (MAX_NUMNODES - 1)
> > -#else
> > -#define DEMOTION_TARGET_NODES  DEFAULT_DEMOTION_TARGET_NODES
> > -#endif
> > -
> > -struct demotion_nodes {
> > -       unsigned short nr;
> > -       short nodes[DEMOTION_TARGET_NODES];
> > -};
> > -
> > -static struct demotion_nodes *node_demotion __read_mostly;
> > +struct demotion_nodes *node_demotion __read_mostly;
> >
> >  /**
> >   * next_demotion_node() - Get the next node in the demotion path
> > --
> > 2.26.2
> >
> >
