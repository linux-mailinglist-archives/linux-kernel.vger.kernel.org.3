Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8445A5CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiH3HRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiH3HRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:17:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262FC4832
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:17:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso7807641pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=8X5YjQNJp39iICiFELV0b1qxV/uVuwr9QMF6V7zHUxY=;
        b=kg9bndIVQ/M5xRxEIrIaEHNHjU3YulsSXaj5klBeIRYw46oslukLYPz6JMCHUphkei
         EEXV2u0r1il7YfdDQl8QgubYsaGg5v+bBw1ajGcBHpzS0KOeKz9Wm84g4Yo4zB8GJVHF
         rNWMgfAY4BmsY6Dhw5JW6173PxRNf/lD4gV+6fqLzAcVnyCxUWssvZPEuWMD12F5v5Wm
         8f2a7ohO3TYZDPvvV1csMOmMdPTwuwIiNP03xBzZJY2RvSOcqajtMbeILwXORYXw6DVi
         A9i5ub5uUMxsjn4vjGRqfXwYSGvw1r7WDTmUeA+RorH/OmtTMeInjefy6ejDCB9fWDgJ
         KVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8X5YjQNJp39iICiFELV0b1qxV/uVuwr9QMF6V7zHUxY=;
        b=opN989nKGeo8WLAIXbasGj1zc81kp+7DbtGN5QoPBKoCP4dFDNgeKWtWBJJo+JsMXq
         BOGujMMdX/6RQoC3NEBRrfThpM3ZPwtsf36/Rwf258OOHq4desohdJknATdoNfa7Y1ne
         JCT1QhCufveWkovujECbQiJrAPA2JIjJv1FFMMIa40/qO4b9zMwxUE8pr040O2fz9df8
         mRVlhXAK1MPrFSWaX3d+4MWWpYWjWpBSHne8TbsCtt1Fj6a0pIzIUFFL2xnTzNvfQiHE
         K3iJ+hJ5fdJw/MYEeYtP7MI2zkBnMcpzhIUYLvVAs3UxGjNpBlrA1918uStVQ6DcAEqT
         bROg==
X-Gm-Message-State: ACgBeo3fnYhJqtcl/ex8hkM4d2PWAx9V454/iqMlcNaYyTK/vG4HAOb0
        0YBzP1A7kzTIwMVmBLOKXF/fdxBCdiG6OVz5pm2zaw==
X-Google-Smtp-Source: AA6agR68CUs4tpfbfp8kj9DAeooSSm7aH73eubHHbwmQKwY97xpqUebCJm1z0yVmeoQG0pXFFa0zFxf1rZye5JI1d7c=
X-Received: by 2002:a17:90a:4008:b0:1fd:9c55:fdfb with SMTP id
 u8-20020a17090a400800b001fd9c55fdfbmr13725403pjc.89.1661843850136; Tue, 30
 Aug 2022 00:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
 <CAAPL-u9HRHyQEw7q+bTUvYRQWwii7DWYyx3DCgmxJu+u3panbQ@mail.gmail.com> <22cb7a8a-84fe-04c7-41ea-50eff8184dc1@linux.ibm.com>
In-Reply-To: <22cb7a8a-84fe-04c7-41ea-50eff8184dc1@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 30 Aug 2022 00:17:18 -0700
Message-ID: <CAAPL-u-YuecdVsyr_Tdery8qqPDnzHxGaQL+CSO8x5xv8QH7kg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:46 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 8/30/22 12:01 PM, Wei Xu wrote:
> > On Sun, Aug 28, 2022 at 11:08 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> This patch adds /sys/devices/virtual/memory_tiering/ where all memory =
tier
> >> related details can be found. All allocated memory tiers will be liste=
d
> >> there as /sys/devices/virtual/memory_tiering/memory_tierN/
> >>
> >> The nodes which are part of a specific memory tier can be listed via
> >> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> >>
> >> The abstract distance range value of a specific memory tier can be lis=
ted via
> >> /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
> >>
> >> A directory hierarchy looks like
> >> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
> >> memory_tier4/
> >> =E2=94=9C=E2=94=80=E2=94=80 abstract_distance
> >> =E2=94=9C=E2=94=80=E2=94=80 nodes
> >> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tierin=
g
> >> =E2=94=94=E2=94=80=E2=94=80 uevent
> >>
> >> All toptier nodes are listed via
> >> /sys/devices/virtual/memory_tiering/toptier_nodes
> >>
> >> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
> >> 0,2
> >> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
> >> 0,2
> >> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/abstract_distan=
ce
> >> 512 - 639
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>  .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  41 +++++
> >>  mm/memory-tiers.c                             | 155 +++++++++++++++--=
-
> >>  2 files changed, 174 insertions(+), 22 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-t=
iers
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/=
Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> >> new file mode 100644
> >> index 000000000000..6955f69a4423
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> >> @@ -0,0 +1,41 @@
> >> +What:          /sys/devices/virtual/memory_tiering/
> >> +Date:          August 2022
> >> +Contact:       Linux memory management mailing list <linux-mm@kvack.o=
rg>
> >> +Description:   A collection of all the memory tiers allocated.
> >> +
> >> +               Individual memory tier details are contained in subdir=
ectories
> >> +               named by the abstract distance of the memory tier.
> >> +
> >> +               /sys/devices/virtual/memory_tiering/memory_tierN/
> >> +
> >> +
> >> +What:          /sys/devices/virtual/memory_tiering/memory_tierN/
> >> +               /sys/devices/virtual/memory_tiering/memory_tierN/abstr=
act_distance
> >> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> >> +Date:          August 2022
> >> +Contact:       Linux memory management mailing list <linux-mm@kvack.o=
rg>
> >> +Description:   Directory with details of a specific memory tier
> >> +
> >> +               This is the directory containing information about a p=
articular
> >> +               memory tier, memtierN, where N is derived based on abs=
tract distance.
> >> +
> >> +               A smaller value of N implies a higher (faster) memory =
tier in the
> >> +               hierarchy.
> >
> > Given that abstract_distance is provided, it would be more flexible if
> > we don't commit to the interface where N in memtierN also indicates
> > the memory tier ordering.
>
>
> IIUC this is one of the request that Johannes had ie, to be able to under=
stand the
> memory tier hierarchy based on memtier name.
>
> >> +
> >> +               abstract_distance: The abstract distance range this sp=
ecific memory
> >> +               tier maps to.
> >
> > I still think the name of "abstract distance" is kind of confusing
> > because it is not clear what is the other object that this distance
> > value is relative to.  Do we have to expose this value at this point
> > if N in memtierN can already indicate the memory tier ordering?
> >
>
> I do agree that abstract distance is confusing. But IIUC we agreed that i=
t is much better
> than other names suggested and is closer to already understood "numa dist=
ance" term.
>
> https://lore.kernel.org/linux-mm/YuLF%2FGG8x5lQvg%2Ff@cmpxchg.org/
>

"NUMA distance" measures the distance between two NUMA nodes.

I bring it up again because this name will become a user visible
kernel interface, which we will need to live with for a long time.
Even if we decide to keep the name, it would be better if we can
define between which two (abstract) points the abstract distance
reports.

Another option is to remove this interface for now until it becomes
necessary to report abstract distances to userspace.

> >> +               nodes: NUMA nodes that are part of this memory tier.
> >> +
> >> +
> >> +What:          /sys/devices/virtual/memory_tiering/toptier_nodes
> >> +Date:          August 2022
> >> +Contact:       Linux memory management mailing list <linux-mm@kvack.o=
rg>
> >> +Description:   Toptier node mask
> >> +
> >> +               A toptier is defined as the memory tier from which mem=
ory promotion
> >> +               is not done by the kernel.
> >> +
> >> +               toptier_nodes: NUMA nodes that are part of all the mem=
ory tiers
> >> +               above a topier tier.
> >
> > Nit: topier -> toptier
> >
> > toptier_nodes should be the union of NUMA nodes that are part of each
> > toptier, not above a toptier, right?
> >
>
> I will update the wording. Yes. it is the union of NUMA nodes that are
> part of each toptier.
>
> >> +
> >> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >> index c4bd6d052a33..d4648d4e4d54 100644
> >> --- a/mm/memory-tiers.c
> >> +++ b/mm/memory-tiers.c
> >> @@ -19,6 +19,7 @@ struct memory_tier {
> >>          * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
> >>          */
> >>         int adistance_start;
> >> +       struct device dev;
> >>         /* All the nodes that are part of all the lower memory tiers. =
*/
> >>         nodemask_t lower_tier_mask;
> >>  };
> >> @@ -36,6 +37,13 @@ static DEFINE_MUTEX(memory_tier_lock);
> >>  static LIST_HEAD(memory_tiers);
> >>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >>  static struct memory_dev_type *default_dram_type;
> >> +
> >> +#define to_memory_tier(device) container_of(device, struct memory_tie=
r, dev)
> >> +static struct bus_type memory_tier_subsys =3D {
> >> +       .name =3D "memory_tiering",
> >> +       .dev_name =3D "memory_tier",
> >> +};
> >> +
> >>  #ifdef CONFIG_MIGRATION
> >>  static int top_tier_adistance;
> >>  /*
> >> @@ -98,8 +106,73 @@ static int top_tier_adistance;
> >>  static struct demotion_nodes *node_demotion __read_mostly;
> >>  #endif /* CONFIG_MIGRATION */
> >>
> >> +static __always_inline nodemask_t get_memtier_nodemask(struct memory_=
tier *memtier)
> >> +{
> >> +       nodemask_t nodes =3D NODE_MASK_NONE;
> >> +       struct memory_dev_type *memtype;
> >> +
> >> +       list_for_each_entry(memtype, &memtier->memory_types, tier_sibi=
ling)
> >> +               nodes_or(nodes, nodes, memtype->nodes);
> >> +
> >> +       return nodes;
> >> +}
> >> +
> >> +static void memory_tier_device_release(struct device *dev)
> >> +{
> >> +       struct memory_tier *tier =3D to_memory_tier(dev);
> >> +       /*
> >> +        * synchronize_rcu in clear_node_memory_tier makes sure
> >> +        * we don't have rcu access to this memory tier.
> >> +        */
> >> +       kfree(tier);
> >> +}
> >> +
> >> +static ssize_t nodes_show(struct device *dev,
> >> +                         struct device_attribute *attr, char *buf)
> >> +{
> >> +       int ret;
> >> +       nodemask_t nmask;
> >> +
> >> +       mutex_lock(&memory_tier_lock);
> >> +       nmask =3D get_memtier_nodemask(to_memory_tier(dev));
> >> +       ret =3D sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
> >> +       mutex_unlock(&memory_tier_lock);
> >> +       return ret;
> >> +}
> >> +static DEVICE_ATTR_RO(nodes);
> >> +
> >> +static ssize_t abstract_distance_show(struct device *dev,
> >> +                                     struct device_attribute *attr, c=
har *buf)
> >> +{
> >> +       int ret;
> >> +       struct memory_tier *memtier =3D to_memory_tier(dev);
> >> +
> >> +       mutex_lock(&memory_tier_lock);
> >> +       ret =3D sysfs_emit(buf, "%d - %d\n", memtier->adistance_start,
> >> +                        memtier->adistance_start + MEMTIER_CHUNK_SIZE=
 - 1);
> >> +       mutex_unlock(&memory_tier_lock);
> >> +       return ret;
> >> +}
> >> +static DEVICE_ATTR_RO(abstract_distance);
> >> +
> >> +static struct attribute *memtier_dev_attrs[] =3D {
> >> +       &dev_attr_nodes.attr,
> >> +       &dev_attr_abstract_distance.attr,
> >> +       NULL
> >> +};
> >> +
> >> +static const struct attribute_group memtier_dev_group =3D {
> >> +       .attrs =3D memtier_dev_attrs,
> >> +};
> >> +
> >> +static const struct attribute_group *memtier_dev_groups[] =3D {
> >> +       &memtier_dev_group,
> >> +       NULL
> >> +};
> >> +
> >>  static struct memory_tier *find_create_memory_tier(struct memory_dev_=
type *memtype)
> >>  {
> >> +       int ret;
> >>         bool found_slot =3D false;
> >>         struct memory_tier *memtier, *new_memtier;
> >>         int adistance =3D memtype->adistance;
> >> @@ -123,15 +196,14 @@ static struct memory_tier *find_create_memory_ti=
er(struct memory_dev_type *memty
> >>
> >>         list_for_each_entry(memtier, &memory_tiers, list) {
> >>                 if (adistance =3D=3D memtier->adistance_start) {
> >> -                       list_add(&memtype->tier_sibiling, &memtier->me=
mory_types);
> >> -                       return memtier;
> >> +                       goto link_memtype;
> >>                 } else if (adistance < memtier->adistance_start) {
> >>                         found_slot =3D true;
> >>                         break;
> >>                 }
> >>         }
> >>
> >> -       new_memtier =3D kmalloc(sizeof(struct memory_tier), GFP_KERNEL=
);
> >> +       new_memtier =3D kzalloc(sizeof(struct memory_tier), GFP_KERNEL=
);
> >>         if (!new_memtier)
> >>                 return ERR_PTR(-ENOMEM);
> >>
> >> @@ -142,8 +214,23 @@ static struct memory_tier *find_create_memory_tie=
r(struct memory_dev_type *memty
> >>                 list_add_tail(&new_memtier->list, &memtier->list);
> >>         else
> >>                 list_add_tail(&new_memtier->list, &memory_tiers);
> >> -       list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
> >> -       return new_memtier;
> >> +
> >> +       new_memtier->dev.id =3D adistance >> MEMTIER_CHUNK_BITS;
> >> +       new_memtier->dev.bus =3D &memory_tier_subsys;
> >> +       new_memtier->dev.release =3D memory_tier_device_release;
> >> +       new_memtier->dev.groups =3D memtier_dev_groups;
> >> +
> >> +       ret =3D device_register(&new_memtier->dev);
> >> +       if (ret) {
> >> +               list_del(&memtier->list);
> >> +               put_device(&memtier->dev);
> >> +               return ERR_PTR(ret);
> >> +       }
> >> +       memtier =3D new_memtier;
> >> +
> >> +link_memtype:
> >> +       list_add(&memtype->tier_sibiling, &memtier->memory_types);
> >> +       return memtier;
> >>  }
> >>
> >>  static struct memory_tier *__node_get_memory_tier(int node)
> >> @@ -275,17 +362,6 @@ static void disable_all_demotion_targets(void)
> >>         synchronize_rcu();
> >>  }
> >>
> >> -static __always_inline nodemask_t get_memtier_nodemask(struct memory_=
tier *memtier)
> >> -{
> >> -       nodemask_t nodes =3D NODE_MASK_NONE;
> >> -       struct memory_dev_type *memtype;
> >> -
> >> -       list_for_each_entry(memtype, &memtier->memory_types, tier_sibi=
ling)
> >> -               nodes_or(nodes, nodes, memtype->nodes);
> >> -
> >> -       return nodes;
> >> -}
> >> -
> >>  /*
> >>   * Find an automatic demotion target for all memory
> >>   * nodes. Failing here is OK.  It might just indicate
> >> @@ -432,11 +508,7 @@ static struct memory_tier *set_node_memory_tier(i=
nt node)
> >>  static void destroy_memory_tier(struct memory_tier *memtier)
> >>  {
> >>         list_del(&memtier->list);
> >> -       /*
> >> -        * synchronize_rcu in clear_node_memory_tier makes sure
> >> -        * we don't have rcu access to this memory tier.
> >> -        */
> >> -       kfree(memtier);
> >> +       device_unregister(&memtier->dev);
> >>  }
> >>
> >>  static bool clear_node_memory_tier(int node)
> >> @@ -563,11 +635,50 @@ static int __meminit memtier_hotplug_callback(st=
ruct notifier_block *self,
> >>         return notifier_from_errno(0);
> >>  }
> >>
> >> +static ssize_t toptier_nodes_show(struct device *dev,
> >> +                                    struct device_attribute *attr, ch=
ar *buf)
> >> +{
> >> +       int ret;
> >> +       nodemask_t nmask, top_tier_mask =3D NODE_MASK_NONE;
> >> +       struct memory_tier *memtier =3D to_memory_tier(dev);
> >> +
> >> +       mutex_lock(&memory_tier_lock);
> >> +       list_for_each_entry(memtier, &memory_tiers, list) {
> >> +               if (memtier->adistance_start >=3D top_tier_adistance)
> >
> > It is kind of confusing that a tier with top_tier_adistance is not
> > considered as a toptier.  Can we redefine top_tier_adistance to be the
> > inclusive upper bound of toptiers?
> >
>
> Agreed. I will fix that up by doing
>
> top_tier_adistance =3D memtier->adistance_start + MEMTIER_CHUNK_SIZE - 1;
>
>
> >> +                       break;
> >> +               nmask =3D get_memtier_nodemask(memtier);
> >> +               nodes_or(top_tier_mask, top_tier_mask, nmask);
> >> +       }
> >> +
> >> +       ret =3D sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&top_tier_=
mask));
> >> +       mutex_unlock(&memory_tier_lock);
> >> +       return ret;
> >> +}
> >> +static DEVICE_ATTR_RO(toptier_nodes);
> >> +
> >> +static struct attribute *memtier_subsys_attrs[] =3D {
> >> +       &dev_attr_toptier_nodes.attr,
> >> +       NULL
> >> +};
> >> +
> >> +static const struct attribute_group memtier_subsys_group =3D {
> >> +       .attrs =3D memtier_subsys_attrs,
> >> +};
> >> +
> >> +static const struct attribute_group *memtier_subsys_groups[] =3D {
> >> +       &memtier_subsys_group,
> >> +       NULL
> >> +};
> >> +
> >>  static int __init memory_tier_init(void)
> >>  {
> >> -       int node;
> >> +       int ret, node;
> >>         struct memory_tier *memtier;
> >>
> >> +       ret =3D subsys_virtual_register(&memory_tier_subsys, memtier_s=
ubsys_groups);
> >> +       if (ret)
> >> +               panic("%s() failed to register memory tier subsystem\n=
", __func__);
> >> +
> >>  #ifdef CONFIG_MIGRATION
> >>         node_demotion =3D kcalloc(nr_node_ids, sizeof(struct demotion_=
nodes),
> >>                                 GFP_KERNEL);
> >> --
> >> 2.37.2
> >>
>
