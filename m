Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B961D5423AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiFHCSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391773AbiFHBw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 21:52:56 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55F1CF15D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:18:43 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id m10so6185106uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnwEpfB2bSSlI/sDocPm/aLibJux3ex7zyjvAuXKleM=;
        b=Q970Q+TTRk2mNBIP+W7nqQ1owOGjhQkURSJAN/rlGK7DCp3E8IuFXHlQ6omQurFMML
         P00hc7svC+IK1CNZOppZboVBoaIGFJYRFdJonvAhEDdzFhkJZiMGPTaIRdh3oBjNXitU
         bQSDjgOStKKB+M0qguoq133Jm0jlrHr+nXhCe9V2351Xfl7wTlbSxLV2U0CKWCejpvIw
         3wR6dNTZKgdzOY/1uSwwbhWlqS/f25Ht0Xja29KhmJ5Xmztq3pdy+gSGpg5V6BKVZngK
         wWU7YFIoWgrOPOsJROn2B6qwjFEBqs77UXKyIFNNGNXLBtypzXYg/IIMOilCDFfmxES/
         a/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnwEpfB2bSSlI/sDocPm/aLibJux3ex7zyjvAuXKleM=;
        b=UIa3v7PZBMsw/rexcxQefP2Lk0I68pT9q84sO7hZ1WRm4zhQr9YKtlUC5uZmsK/DEb
         6myHNnAk9d/cG7hzBQa9yTlLmC9GK/4R6TQ5xP8yLh0Lm2viwdCGW0+ZTzGHMc3rGMkC
         aprYw0Yp/aoXiaislFVziTOuRuHR6S9LkKSnMYmG65b4B5EpM51gWT2f2IO5MbWRQCSj
         bxsCI/N1RpCgtinOYMFRwsRcdFspKrjQk8ThBBXGkChcPBH3HKcO81lL1h2lpOCA0UpD
         YLwPOEh8nTZEohRL+knVo3pRWIjPdtlZlyYEhMs386B3x3PJ8zvfy/0EdzsxYP2QNA6a
         5M4Q==
X-Gm-Message-State: AOAM5337mnQOC4rNvf7/lycpFO4HMn/7RnfKit3nKMo51oJky+R5c09b
        E4v4WqL3WUovqq9ZIWDxc73QeRzkV2Hevo8KduZoew==
X-Google-Smtp-Source: ABdhPJxVJB6Dm8XEawl4PpBTwoDSrTFqr21rPVQiWO7fECO+iwYALaOcxZffBDNGyU6ZOPxOwnW7Awb3DeiEEuO+UNk=
X-Received: by 2002:ab0:349a:0:b0:35c:b898:a733 with SMTP id
 c26-20020ab0349a000000b0035cb898a733mr34099691uar.85.1654633122327; Tue, 07
 Jun 2022 13:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com> <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
In-Reply-To: <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 7 Jun 2022 13:18:31 -0700
Message-ID: <CAAPL-u96pwSEA00NM_km6VD8FbxDtZbZpm3or_byZT2FGbvwFg@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
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

On Tue, Jun 7, 2022 at 11:43 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> >
> >
> > The nodes which are part of a specific memory tier can be listed
> > via
> > /sys/devices/system/memtier/memtierN/nodelist
> >
> > "Rank" is an opaque value. Its absolute value doesn't have any
> > special meaning. But the rank values of different memtiers can be
> > compared with each other to determine the memory tier order.
> >
> > For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
> > their rank values are 300, 200, 100, then the memory tier order is:
> > memtier0 -> memtier2 -> memtier1,
>
> Why is memtier2 (rank 100) higher than memtier1 (rank 200)?  Seems like
> the order should be memtier0 -> memtier1 -> memtier2?
>                     (rank 300)  (rank 200)  (rank 100)

I think this is a copy-and-modify typo from my original memory tiering
kernel interface RFC (v4,
https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com/T/):
where the rank values are 100, 10, 50 (i.e the rank of memtier2 is
higher than memtier1).

> > where memtier0 is the highest tier
> > and memtier1 is the lowest tier.
>
> I think memtier2 is the lowest as it has the lowest rank value.
> >
> > The rank value of each memtier should be unique.
> >
> >
> > +
> > +static void memory_tier_device_release(struct device *dev)
> > +{
> > +     struct memory_tier *tier = to_memory_tier(dev);
> > +
>
> Do we need some ref counts on memory_tier?
> If there is another device still using the same memtier,
> free below could cause problem.
>
> > +     kfree(tier);
> > +}
> > +
> >
> ...
> > +static struct memory_tier *register_memory_tier(unsigned int tier)
> > +{
> > +     int error;
> > +     struct memory_tier *memtier;
> > +
> > +     if (tier >= MAX_MEMORY_TIERS)
> > +             return NULL;
> > +
> > +     memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> > +     if (!memtier)
> > +             return NULL;
> > +
> > +     memtier->dev.id = tier;
> > +     memtier->rank = get_rank_from_tier(tier);
> > +     memtier->dev.bus = &memory_tier_subsys;
> > +     memtier->dev.release = memory_tier_device_release;
> > +     memtier->dev.groups = memory_tier_dev_groups;
> > +
>
> Should you take the mem_tier_lock before you insert to
> memtier-list?
>
> > +     insert_memory_tier(memtier);
> > +
> > +     error = device_register(&memtier->dev);
> > +     if (error) {
> > +             list_del(&memtier->list);
> > +             put_device(&memtier->dev);
> > +             return NULL;
> > +     }
> > +     return memtier;
> > +}
> > +
> > +__maybe_unused // temporay to prevent warnings during bisects
> > +static void unregister_memory_tier(struct memory_tier *memtier)
> > +{
>
> I think we should take mem_tier_lock before modifying memtier->list.
>
> > +     list_del(&memtier->list);
> > +     device_unregister(&memtier->dev);
> > +}
> > +
> >
>
> Thanks.
>
> Tim
>
>
