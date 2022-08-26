Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87275A2400
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbiHZJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiHZJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:16:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4977ED1E33
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:16:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o4so1061201pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8JkET+M6JudLsbBuC9noyGBV8761Vdk3MiQ4Gj3TP64=;
        b=g6yLbjzWZuEFnACRvvSR6Adru4uTw/gGAP8IJNcaVUWwTnvbMLYZt3WL2LyN/FOJFp
         kBye54Rg63Bmpyz2mlYRrr85ZkCzdXYbAMa6WJlE/M+WQhd7kK3FdK4uQOl4PPmnKmWg
         CfBL/7ns8M+T1fwjHLb1H73YxxHhS1RF2DlgU4fkHg+hVoxqseAqK/AkgLaGhq9ZY9bc
         tQk/Q4zZrvmL3rCKHu+vstq5o3S4kw53SvWTOxrzgUCQceMpMukGRUD31q4g2AI/Lblt
         ANwz7+ntVAJCfFVV6cQxYoZ8p5uEd+FvOiK0Q31Zprnp4cgygJVx/uXHLLMc05UVTuup
         hd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8JkET+M6JudLsbBuC9noyGBV8761Vdk3MiQ4Gj3TP64=;
        b=CJ1I+q8f0dSO8vvFKDETDkapf1n5lw0+ZJN6sJC/h2UneVeteOHwG1r8fWuVSmcQxY
         glz37xdQLCstcLNhwMvs6zkcfSzjVsSqoAMg5yniubmBph/1UxFgvMjdUy8KRYr/nNie
         IHyqpvYyAjZdSaweN3C4rXf1MmWSheTvoYHvVFz5YEomxFsZBEBDkUOsLD67Zz8CNxVQ
         45hpA0JRtUgyyEdLh94W2S/sWwvkGwVASlcDo++djyLCb+780m1nkc7MjXq9KgfA8urj
         SWbrh0N1h6W9WJBnlQzr2iWzmrcwOlCCJOob0l6Yi9p58nrgj9Q9ds0vzSLou93K3/7u
         AXvw==
X-Gm-Message-State: ACgBeo1uhy3lT1n8WJZS7360GXlE3Dfc4UwSUhNpnM6fcfRQz6g/BnSG
        X4TJVjqK2NFM42Hijtlt7h8dG1+UeB1InNydL/Aitg==
X-Google-Smtp-Source: AA6agR6pLmtwtrIZjtq/uf4J+tCnWLD3/QKIIUwGVBXNRbfKwUf4NIYdl+0IKMavTxhCIcoJr1gggCaPHxCmXpc0w+8=
X-Received: by 2002:a17:90b:1804:b0:1f5:946:6b6f with SMTP id
 lw4-20020a17090b180400b001f509466b6fmr3414480pjb.160.1661505362672; Fri, 26
 Aug 2022 02:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
 <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com> <e2f20ae9-5761-c170-a4e7-121d6b69ebfb@linux.ibm.com>
 <CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com> <4abb84e8-8035-65aa-941a-98f0d7902c42@linux.ibm.com>
In-Reply-To: <4abb84e8-8035-65aa-941a-98f0d7902c42@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 26 Aug 2022 02:15:51 -0700
Message-ID: <CAAPL-u_d_vozgSum7gX8Ecvh2ZY75KmB0+Z3d0yf7McqsfOU2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm/demotion: Expose memory type details via sysfs
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 1:05 AM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 8/26/22 1:30 PM, Wei Xu wrote:
> > On Thu, Aug 25, 2022 at 8:00 PM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 8/26/22 7:20 AM, Huang, Ying wrote:
> >>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >>>
> >>>> This patch adds /sys/devices/virtual/memtier/ where all memory tier related
> >>>> details can be found. All allocated memory types will be listed there as
> >>>> /sys/devices/virtual/memtier/memtypeN/
> >>>
> >>> Another choice is to make memory types and memory tiers system devices.
> >>> That is,
> >>>
> >>> /sys/devices/system/memory_type/memory_typeN
> >>> /sys/devices/system/memory_tier/memory_tierN
> >>>
> >>
> >> subsys_system_register() documentation says
> >>
> >>  * Do not use this interface for anything new, it exists for compatibility
> >>  * with bad ideas only. New subsystems should use plain subsystems; and
> >>  * add the subsystem-wide attributes should be added to the subsystem
> >>  * directory itself and not some create fake root-device placed in
> >>  * /sys/devices/system/<name>.
> >>
> >> memtier being a virtual device, I was under the impression that /sys/devices/virtual
> >> is the recommended place.
> >>
> >>> That looks more natural to me.  Because we already have "node" and
> >>> "memory" devices there.  Why don't you put memory types and memory tiers
> >>> there?
> >>>
> >>> And, I think we shouldn't put "memory_type" in the "memory_tier"
> >>> directory.  "memory_type" isn't a part of "memory_tier".
> >>>
> >>
> >> I was looking consolidating both memory tier and memory type into the same sysfs subsystem.
> >> Your recommendation imply we create two subsystem memory_tier and memtype. I was
> >> trying to avoid that. May be a generic term like "memory_tiering" can help to
> >> consolidate all tiering related details there?
> >>
> >
> > A generic term "memory_tiering" sounds good to me.
> >
> > Given that this will be a user-facing, stable kernel API, I think we'd
> > better to only add what is most useful for userspace and don't have to
> > mirror the kernel internal data structures in this interface.
> >
> > My understanding is that we haven't fully settled down on how to
> > customize memory tiers from userspace.  So we don't have to show
> > memory_type yet, which is a kernel data structure at this point.
> >
> > The userspace does need to know what are the memory tiers and which
> > NUMA nodes are included in each memory tier.  How about we provide the
> > "nodelist" interface for each memory tier as in the original proposal?
> >
> > The userspace would also like to know which memory tiers/nodes belong
> > to the top tiers (the promotion targets).  We can provide a "toptiers"
> > or "toptiers_nodelist" interface to report that.
> >
>
> How about also including abstract distance range of a memory tier?
> That will be useful to derive the hierarchy.

With the base abstract distance in the memtier name, do we need to
show the abstract distance range if we don't customize memory tiers?

> > Both should still be useful even if we decide to add memory_type for
> > memory tier customization.
> >
>
> -aneesh
