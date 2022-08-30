Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C65A5BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiH3GbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH3GbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:31:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C14186D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:31:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 72so10393805pfx.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kRrTAo8daY4XFPJzzujJBwELH2FLL+aCQ7HxRf6l2Fg=;
        b=KnuzT4G4A4+o4hLLipG5ZVCHsIIIclmUzrhCyj/a6DT6QzlXMBn2dTkgzB4f+9K0DO
         Z98kmgHtvs9lVUk4jh1N98hcQT6jv6gPycCWTmqGVKlwcnJ7lFjbvBN0BXvZ2oH4OqWZ
         36WCsIVrPIgtPOo+dlpTW/oV4tTWBEc+mZWf6abluxyF+Ud1xPPqX1Hojkrl1GnqxNSn
         22c0o5JQ6BjRmT+GUj5rXwIJlCsGXwLeMabe8dvXoLbjTJMRRHPZGopJzrrp079yucF1
         kgv02QWmWCqufqauuD9zCUxiPS6suuulBiF/PbGO6GSKXJ0htLGG1brQSPFJw6CPBQH6
         I4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kRrTAo8daY4XFPJzzujJBwELH2FLL+aCQ7HxRf6l2Fg=;
        b=8J1cV9KFJ/bdJIacKLTqC6vQdL3OWxhTPDORgMReMbZZGXjTctGhJIRmFKlhTt9uH2
         NlfMRQ9HLL6Ki16+3talJuGJ4W197NK0WAyBMhQHSYkMjj3Arb7qmD2efoRdpvjQrrmX
         TzZppKHNth34QbWEwXq1QfS6b0Y9DDr1eJ2qNeCc4VgPwQGdqp32NTGmAiWSNzZxYyyd
         B26TQHl7scrzby2WTJEXSflW6u2zaeSzNQriRuncbOq7CaQ9VKr2/pdct9m414vnQPhI
         E63CUmzfztZpMZ5pQwZyLs9MIvWyDSZN6JkXAxgqtCJF6TssOk+G6z3l5iJ2W2z2Rq44
         D1Lw==
X-Gm-Message-State: ACgBeo3CXO6BFLMhFsuJSgfplhEVIOgY4keJsV+Nu8ry9UXxFsSFqcDd
        iBrURvUVHoW5zrjHRCdcQMbijyYYH5a8Nd+72/uC5g==
X-Google-Smtp-Source: AA6agR6zA8pPQxj3vn4SjOHDVmXoyzrIhWwvsRLk0uKVTgviVLur2pUxJ31jB2lSsM3Rqplsc4PL78sQdVP4WzSZPK4=
X-Received: by 2002:a65:46c7:0:b0:42a:c9db:cb7 with SMTP id
 n7-20020a6546c7000000b0042ac9db0cb7mr17184925pgr.515.1661841078722; Mon, 29
 Aug 2022 23:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 29 Aug 2022 23:31:07 -0700
Message-ID: <CAAPL-u9HRHyQEw7q+bTUvYRQWwii7DWYyx3DCgmxJu+u3panbQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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

On Sun, Aug 28, 2022 at 11:08 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tie=
r
> related details can be found. All allocated memory tiers will be listed
> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>
> The nodes which are part of a specific memory tier can be listed via
> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>
> The abstract distance range value of a specific memory tier can be listed=
 via
> /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
>
> A directory hierarchy looks like
> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
> memory_tier4/
> =E2=94=9C=E2=94=80=E2=94=80 abstract_distance
> =E2=94=9C=E2=94=80=E2=94=80 nodes
> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tiering
> =E2=94=94=E2=94=80=E2=94=80 uevent
>
> All toptier nodes are listed via
> /sys/devices/virtual/memory_tiering/toptier_nodes
>
> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
> 0,2
> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
> 0,2
> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/abstract_distance
> 512 - 639
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  41 +++++
>  mm/memory-tiers.c                             | 155 +++++++++++++++---
>  2 files changed, 174 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tier=
s
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Doc=
umentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> new file mode 100644
> index 000000000000..6955f69a4423
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> @@ -0,0 +1,41 @@
> +What:          /sys/devices/virtual/memory_tiering/
> +Date:          August 2022
> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
> +Description:   A collection of all the memory tiers allocated.
> +
> +               Individual memory tier details are contained in subdirect=
ories
> +               named by the abstract distance of the memory tier.
> +
> +               /sys/devices/virtual/memory_tiering/memory_tierN/
> +
> +
> +What:          /sys/devices/virtual/memory_tiering/memory_tierN/
> +               /sys/devices/virtual/memory_tiering/memory_tierN/abstract=
_distance
> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> +Date:          August 2022
> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
> +Description:   Directory with details of a specific memory tier
> +
> +               This is the directory containing information about a part=
icular
> +               memory tier, memtierN, where N is derived based on abstra=
ct distance.
> +
> +               A smaller value of N implies a higher (faster) memory tie=
r in the
> +               hierarchy.

Given that abstract_distance is provided, it would be more flexible if
we don't commit to the interface where N in memtierN also indicates
the memory tier ordering.

> +
> +               abstract_distance: The abstract distance range this speci=
fic memory
> +               tier maps to.

I still think the name of "abstract distance" is kind of confusing
because it is not clear what is the other object that this distance
value is relative to.  Do we have to expose this value at this point
if N in memtierN can already indicate the memory tier ordering?

> +               nodes: NUMA nodes that are part of this memory tier.
> +
> +
> +What:          /sys/devices/virtual/memory_tiering/toptier_nodes
> +Date:          August 2022
> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
> +Description:   Toptier node mask
> +
> +               A toptier is defined as the memory tier from which memory=
 promotion
> +               is not done by the kernel.
> +
> +               toptier_nodes: NUMA nodes that are part of all the memory=
 tiers
> +               above a topier tier.

Nit: topier -> toptier

toptier_nodes should be the union of NUMA nodes that are part of each
toptier, not above a toptier, right?

> +
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index c4bd6d052a33..d4648d4e4d54 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -19,6 +19,7 @@ struct memory_tier {
>          * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
>          */
>         int adistance_start;
> +       struct device dev;
>         /* All the nodes that are part of all the lower memory tiers. */
>         nodemask_t lower_tier_mask;
>  };
> @@ -36,6 +37,13 @@ static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  static struct memory_dev_type *default_dram_type;
> +
> +#define to_memory_tier(device) container_of(device, struct memory_tier, =
dev)
> +static struct bus_type memory_tier_subsys =3D {
> +       .name =3D "memory_tiering",
> +       .dev_name =3D "memory_tier",
> +};
> +
>  #ifdef CONFIG_MIGRATION
>  static int top_tier_adistance;
>  /*
> @@ -98,8 +106,73 @@ static int top_tier_adistance;
>  static struct demotion_nodes *node_demotion __read_mostly;
>  #endif /* CONFIG_MIGRATION */
>
> +static __always_inline nodemask_t get_memtier_nodemask(struct memory_tie=
r *memtier)
> +{
> +       nodemask_t nodes =3D NODE_MASK_NONE;
> +       struct memory_dev_type *memtype;
> +
> +       list_for_each_entry(memtype, &memtier->memory_types, tier_sibilin=
g)
> +               nodes_or(nodes, nodes, memtype->nodes);
> +
> +       return nodes;
> +}
> +
> +static void memory_tier_device_release(struct device *dev)
> +{
> +       struct memory_tier *tier =3D to_memory_tier(dev);
> +       /*
> +        * synchronize_rcu in clear_node_memory_tier makes sure
> +        * we don't have rcu access to this memory tier.
> +        */
> +       kfree(tier);
> +}
> +
> +static ssize_t nodes_show(struct device *dev,
> +                         struct device_attribute *attr, char *buf)
> +{
> +       int ret;
> +       nodemask_t nmask;
> +
> +       mutex_lock(&memory_tier_lock);
> +       nmask =3D get_memtier_nodemask(to_memory_tier(dev));
> +       ret =3D sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
> +       mutex_unlock(&memory_tier_lock);
> +       return ret;
> +}
> +static DEVICE_ATTR_RO(nodes);
> +
> +static ssize_t abstract_distance_show(struct device *dev,
> +                                     struct device_attribute *attr, char=
 *buf)
> +{
> +       int ret;
> +       struct memory_tier *memtier =3D to_memory_tier(dev);
> +
> +       mutex_lock(&memory_tier_lock);
> +       ret =3D sysfs_emit(buf, "%d - %d\n", memtier->adistance_start,
> +                        memtier->adistance_start + MEMTIER_CHUNK_SIZE - =
1);
> +       mutex_unlock(&memory_tier_lock);
> +       return ret;
> +}
> +static DEVICE_ATTR_RO(abstract_distance);
> +
> +static struct attribute *memtier_dev_attrs[] =3D {
> +       &dev_attr_nodes.attr,
> +       &dev_attr_abstract_distance.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group memtier_dev_group =3D {
> +       .attrs =3D memtier_dev_attrs,
> +};
> +
> +static const struct attribute_group *memtier_dev_groups[] =3D {
> +       &memtier_dev_group,
> +       NULL
> +};
> +
>  static struct memory_tier *find_create_memory_tier(struct memory_dev_typ=
e *memtype)
>  {
> +       int ret;
>         bool found_slot =3D false;
>         struct memory_tier *memtier, *new_memtier;
>         int adistance =3D memtype->adistance;
> @@ -123,15 +196,14 @@ static struct memory_tier *find_create_memory_tier(=
struct memory_dev_type *memty
>
>         list_for_each_entry(memtier, &memory_tiers, list) {
>                 if (adistance =3D=3D memtier->adistance_start) {
> -                       list_add(&memtype->tier_sibiling, &memtier->memor=
y_types);
> -                       return memtier;
> +                       goto link_memtype;
>                 } else if (adistance < memtier->adistance_start) {
>                         found_slot =3D true;
>                         break;
>                 }
>         }
>
> -       new_memtier =3D kmalloc(sizeof(struct memory_tier), GFP_KERNEL);
> +       new_memtier =3D kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>         if (!new_memtier)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -142,8 +214,23 @@ static struct memory_tier *find_create_memory_tier(s=
truct memory_dev_type *memty
>                 list_add_tail(&new_memtier->list, &memtier->list);
>         else
>                 list_add_tail(&new_memtier->list, &memory_tiers);
> -       list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
> -       return new_memtier;
> +
> +       new_memtier->dev.id =3D adistance >> MEMTIER_CHUNK_BITS;
> +       new_memtier->dev.bus =3D &memory_tier_subsys;
> +       new_memtier->dev.release =3D memory_tier_device_release;
> +       new_memtier->dev.groups =3D memtier_dev_groups;
> +
> +       ret =3D device_register(&new_memtier->dev);
> +       if (ret) {
> +               list_del(&memtier->list);
> +               put_device(&memtier->dev);
> +               return ERR_PTR(ret);
> +       }
> +       memtier =3D new_memtier;
> +
> +link_memtype:
> +       list_add(&memtype->tier_sibiling, &memtier->memory_types);
> +       return memtier;
>  }
>
>  static struct memory_tier *__node_get_memory_tier(int node)
> @@ -275,17 +362,6 @@ static void disable_all_demotion_targets(void)
>         synchronize_rcu();
>  }
>
> -static __always_inline nodemask_t get_memtier_nodemask(struct memory_tie=
r *memtier)
> -{
> -       nodemask_t nodes =3D NODE_MASK_NONE;
> -       struct memory_dev_type *memtype;
> -
> -       list_for_each_entry(memtype, &memtier->memory_types, tier_sibilin=
g)
> -               nodes_or(nodes, nodes, memtype->nodes);
> -
> -       return nodes;
> -}
> -
>  /*
>   * Find an automatic demotion target for all memory
>   * nodes. Failing here is OK.  It might just indicate
> @@ -432,11 +508,7 @@ static struct memory_tier *set_node_memory_tier(int =
node)
>  static void destroy_memory_tier(struct memory_tier *memtier)
>  {
>         list_del(&memtier->list);
> -       /*
> -        * synchronize_rcu in clear_node_memory_tier makes sure
> -        * we don't have rcu access to this memory tier.
> -        */
> -       kfree(memtier);
> +       device_unregister(&memtier->dev);
>  }
>
>  static bool clear_node_memory_tier(int node)
> @@ -563,11 +635,50 @@ static int __meminit memtier_hotplug_callback(struc=
t notifier_block *self,
>         return notifier_from_errno(0);
>  }
>
> +static ssize_t toptier_nodes_show(struct device *dev,
> +                                    struct device_attribute *attr, char =
*buf)
> +{
> +       int ret;
> +       nodemask_t nmask, top_tier_mask =3D NODE_MASK_NONE;
> +       struct memory_tier *memtier =3D to_memory_tier(dev);
> +
> +       mutex_lock(&memory_tier_lock);
> +       list_for_each_entry(memtier, &memory_tiers, list) {
> +               if (memtier->adistance_start >=3D top_tier_adistance)

It is kind of confusing that a tier with top_tier_adistance is not
considered as a toptier.  Can we redefine top_tier_adistance to be the
inclusive upper bound of toptiers?

> +                       break;
> +               nmask =3D get_memtier_nodemask(memtier);
> +               nodes_or(top_tier_mask, top_tier_mask, nmask);
> +       }
> +
> +       ret =3D sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&top_tier_mas=
k));
> +       mutex_unlock(&memory_tier_lock);
> +       return ret;
> +}
> +static DEVICE_ATTR_RO(toptier_nodes);
> +
> +static struct attribute *memtier_subsys_attrs[] =3D {
> +       &dev_attr_toptier_nodes.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group memtier_subsys_group =3D {
> +       .attrs =3D memtier_subsys_attrs,
> +};
> +
> +static const struct attribute_group *memtier_subsys_groups[] =3D {
> +       &memtier_subsys_group,
> +       NULL
> +};
> +
>  static int __init memory_tier_init(void)
>  {
> -       int node;
> +       int ret, node;
>         struct memory_tier *memtier;
>
> +       ret =3D subsys_virtual_register(&memory_tier_subsys, memtier_subs=
ys_groups);
> +       if (ret)
> +               panic("%s() failed to register memory tier subsystem\n", =
__func__);
> +
>  #ifdef CONFIG_MIGRATION
>         node_demotion =3D kcalloc(nr_node_ids, sizeof(struct demotion_nod=
es),
>                                 GFP_KERNEL);
> --
> 2.37.2
>
