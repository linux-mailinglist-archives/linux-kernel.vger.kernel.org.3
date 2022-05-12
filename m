Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119ED5247B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbiELIPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiELIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:15:16 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A55DBE5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:15:15 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z144so4352799vsz.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kBci1W7ElbeGBHJ1hfhdl2XSbKvaGs7BroRgBbCQZo=;
        b=Cd4mlvT0wAHMlu843hQ2fzttNtiSDYFX+5ywjAiSsqWPmY57usrCShYlfN7Mbvcdmt
         +qeiNNzs5TbqihtFVYSQa4/oqgA+cdzNuCbcBTKqHXQiZB3VBzDEb0zyW5IP2hU8iUII
         irzbNiNQIkxIRIKpkjbR1gPvZhqcX2dyMBKtxVQhObyyR0c36cSht3LXMNWgqNsc5FWU
         UqNji9+7nuSdOIs5zagiM3WPA45ZOYxSUgBTQpYpfkI0xL0AGy71tTQX8WUQLexeLZaD
         0Lsf9FtQcdudxyDWy/DDjg6H1OW0zJUmFJM4Wqw1qVDDA/R/bVlHQpm5EefWU6EGXkxI
         0B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kBci1W7ElbeGBHJ1hfhdl2XSbKvaGs7BroRgBbCQZo=;
        b=KLQqunuxrh0cDPqrFZ6n9fp6NWDfEmKudeUKAbGw4Q8k6P4Q7+tctwd90J/vPPRe7s
         s6vLHwGG6HTOF3uNF/SZZjpO5gW8kY6uzS3YL4yeVlbTkXrHY5kcwRSpRjZvFTPmuzvp
         ieog6cPLoUyAp9kxsr9WvUWQ7Me3Vpxeu4Ike36Q4OxsZFadga1t0MndKteuSOXfguLF
         +9EgCbApUMzvM2aj6IdSwbJbqvkl7Ew62QbZAAGe67gGTMkdqNtje7au2xZfWdpvQwIl
         9PmV6dr/eNex6ugFjPTOg/1BJZWBA/tpmHTx2KKAcKokQqSld1r9NByaQnS8zyMJ1/ee
         w3nQ==
X-Gm-Message-State: AOAM532l0TudK5dBIEaISX376vA3BrLJs+lF7VYdMCsN+iMBxsTQ2/Vc
        WlPvbdPw4QnJ628DyxPG0zP4Bom/iShgHipyke7erg==
X-Google-Smtp-Source: ABdhPJzPzd2BDtAqiKjsVfbVTVxWDPHGxJVJh1u7ZlaNKMR+DgMc23NLeblIidUa31ZpEUGf+a+M1cWxPuob2yA73Ck=
X-Received: by 2002:a67:f343:0:b0:32c:c4b7:e238 with SMTP id
 p3-20020a67f343000000b0032cc4b7e238mr14522518vsm.77.1652343314311; Thu, 12
 May 2022 01:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
 <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com> <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
 <87y1z7jj85.fsf@linux.ibm.com>
In-Reply-To: <87y1z7jj85.fsf@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 12 May 2022 01:15:03 -0700
Message-ID: <CAAPL-u90Gzrepbsdpc62FGRBYOx1LAVwZWHg1E7UyVD_CmcROw@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 12, 2022 at 12:36 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> > On Thu, May 12, 2022 at 12:12 AM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
> >> > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> >> >> Sysfs Interfaces
> >> >> ================
> >> >>
> >> >> * /sys/devices/system/memtier/memtierN/nodelist
> >> >>
> >> >>    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> >> >>
> >> >>    Format: node_list
> >> >>
> >> >>    Read-only.  When read, list the memory nodes in the specified tier.
> >> >>
> >> >>    Tier 0 is the highest tier, while tier 2 is the lowest tier.
> >> >>
> >> >>    The absolute value of a tier id number has no specific meaning.
> >> >>    What matters is the relative order of the tier id numbers.
> >> >>
> >> >>    When a memory tier has no nodes, the kernel can hide its memtier
> >> >>    sysfs files.
> >> >>
> >> >> * /sys/devices/system/node/nodeN/memtier
> >> >>
> >> >>    where N = 0, 1, ...
> >> >>
> >> >>    Format: int or empty
> >> >>
> >> >>    When read, list the memory tier that the node belongs to.  Its value
> >> >>    is empty for a CPU-only NUMA node.
> >> >>
> >> >>    When written, the kernel moves the node into the specified memory
> >> >>    tier if the move is allowed.  The tier assignment of all other nodes
> >> >>    are not affected.
> >> >>
> >> >>    Initially, we can make this interface read-only.
> >> >
> >> > It seems that "/sys/devices/system/node/nodeN/memtier" has all
> >> > information we needed.  Do we really need
> >> > "/sys/devices/system/memtier/memtierN/nodelist"?
> >> >
> >> > That can be gotten via a simple shell command line,
> >> >
> >> > $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
> >> >
> >>
> >> It will be really useful to fetch the memory tier node list in an easy
> >> fashion rather than reading multiple sysfs directories. If we don't have
> >> other attributes for memorytier, we could keep
> >> "/sys/devices/system/memtier/memtierN" a NUMA node list there by
> >> avoiding /sys/devices/system/memtier/memtierN/nodelist
> >>
> >> -aneesh
> >
> > It is harder to implement memtierN as just a file and doesn't follow
> > the existing sysfs pattern, either.  Besides, it is extensible to have
> > memtierN as a directory.
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6248326f944d..251f38ec3816 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -1097,12 +1097,49 @@ static struct attribute *node_state_attrs[] = {
>         NULL
>  };
>
> +#define MAX_TIER 3
> +nodemask_t memory_tier[MAX_TIER];
> +
> +#define _TIER_ATTR_RO(name, tier_index)                                        \
> +       { __ATTR(name, 0444, show_tier, NULL), tier_index, NULL }
> +
> +struct memory_tier_attr {
> +       struct device_attribute attr;
> +       int tier_index;
> +       int (*write)(nodemask_t nodes);
> +};
> +
> +static ssize_t show_tier(struct device *dev,
> +                        struct device_attribute *attr, char *buf)
> +{
> +       struct memory_tier_attr *mt = container_of(attr, struct memory_tier_attr, attr);
> +
> +       return sysfs_emit(buf, "%*pbl\n",
> +                         nodemask_pr_args(&memory_tier[mt->tier_index]));
> +}
> +
>  static const struct attribute_group memory_root_attr_group = {
>         .attrs = node_state_attrs,
>  };
>
> +
> +#define TOP_TIER 0
> +static struct memory_tier_attr memory_tiers[] = {
> +       [0] = _TIER_ATTR_RO(memory_top_tier, TOP_TIER),
> +};
> +
> +static struct attribute *memory_tier_attrs[] = {
> +       &memory_tiers[0].attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group memory_tier_attr_group = {
> +       .attrs = memory_tier_attrs,
> +};
> +
>  static const struct attribute_group *cpu_root_attr_groups[] = {
>         &memory_root_attr_group,
> +       &memory_tier_attr_group,
>         NULL,
>  };
>
>
> As long as we have the ability to see the nodelist, I am good with the
> proposal.
>
> -aneesh

I am OK with moving back the memory tier nodelist into node/.  When
there are more memory tier attributes needed, we can then create the
memory tier subtree and replace the tier nodelist in node/ with
symlinks.

So the revised sysfs interfaces are:

* /sys/devices/system/node/memory_tierN (read-only)

  where N = 0, 1, 2

  Format: node_list

* /sys/devices/system/node/nodeN/memory_tier (read/write)

  where N = 0, 1, ...

  Format: int or empty
