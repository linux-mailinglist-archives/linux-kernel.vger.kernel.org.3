Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B755A2286
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbiHZIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiHZIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:01:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8021CD3E71
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:01:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i8-20020a17090a65c800b001fd602afda2so953146pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ZXxV5H02sTf27cGjR4xFe9u/ajRHs1osMk1ZZ7VKeFA=;
        b=GZ9AZ3KmTgLjSIPCC9LY9iLyjXG05/sw6lrzkIivXH45QE0379fs/LAe6C0lMHu0wo
         cf0J0z/P1iD36Iq2KzxKO3pMAKh36CIW8t1q29VJVXWNEXZYkfZRnXoZADo9PSiuH0Cr
         4qTdTNOSHOX5ejQSovpO6oP4GRp6d8v7+Dj6GKgYCysZ4GnI+WBZD/1T0g0MBVrpHCG6
         sbx0NcdX0JMzRepJgi9zWFSJbtWvNXxuwE6ci5R4ttKYrcUhOjJ+LIxLItLdm2gk1nob
         PaZTmEfZ+RbWMijQBTI6ELPlGBoGB3n4XOQ+Kqc3y77dUouCKgIDH0siLGpwFz7i6GLL
         5vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ZXxV5H02sTf27cGjR4xFe9u/ajRHs1osMk1ZZ7VKeFA=;
        b=fav3W6q2nkw7znn9DF5I2iVrGxakyZwBoZItkXjv7exyerS9k7ftiMa7T//T1yFlMq
         3vTc/yhKMxKqzGK3WAXKTWrXgv1eNDIGTDsHUQ7lxDZVcnOO2CYwgOkYd7IrnEGaTeCr
         zk/DKa3XYRLr8P3PGlhbvGfwHsxNlbvwRsy3MOx6QZurxCjb/iqpKGIkm0RNU5/ZEifW
         AUQFHqP7erdgdsJqblyEToLeVEWYRV20UqygXjfFzt7ctqO9kvIHrM6U/rxXoXdhu9cG
         xpe50zOBA2PCqgYgOOTKW+eoQJ/rXNHrYYk48Om2sX/wAimikGNYZt5kQ4FxhuWZp07c
         8wjQ==
X-Gm-Message-State: ACgBeo2c4b2PRIRM14A2jMP/ik55ckrx98ESkl0u9hDC7j+mTuoH0/UM
        JvUB0Cn6ql1x63nVQ38rmPcSwav/qvOg09GRgrrgLQ==
X-Google-Smtp-Source: AA6agR4Wl3OSQI8TTZZEDjCFzfdhMn02PO6KNg3osP2Wr6z+vXCI1pzBuek699RxCaUvkzjWdvEMDg27yJWC274avaI=
X-Received: by 2002:a17:902:d643:b0:172:84c4:d513 with SMTP id
 y3-20020a170902d64300b0017284c4d513mr2653434plh.138.1661500868782; Fri, 26
 Aug 2022 01:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
 <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com> <e2f20ae9-5761-c170-a4e7-121d6b69ebfb@linux.ibm.com>
In-Reply-To: <e2f20ae9-5761-c170-a4e7-121d6b69ebfb@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 26 Aug 2022 01:00:57 -0700
Message-ID: <CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com>
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

On Thu, Aug 25, 2022 at 8:00 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 8/26/22 7:20 AM, Huang, Ying wrote:
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >
> >> This patch adds /sys/devices/virtual/memtier/ where all memory tier re=
lated
> >> details can be found. All allocated memory types will be listed there =
as
> >> /sys/devices/virtual/memtier/memtypeN/
> >
> > Another choice is to make memory types and memory tiers system devices.
> > That is,
> >
> > /sys/devices/system/memory_type/memory_typeN
> > /sys/devices/system/memory_tier/memory_tierN
> >
>
> subsys_system_register() documentation says
>
>  * Do not use this interface for anything new, it exists for compatibilit=
y
>  * with bad ideas only. New subsystems should use plain subsystems; and
>  * add the subsystem-wide attributes should be added to the subsystem
>  * directory itself and not some create fake root-device placed in
>  * /sys/devices/system/<name>.
>
> memtier being a virtual device, I was under the impression that /sys/devi=
ces/virtual
> is the recommended place.
>
> > That looks more natural to me.  Because we already have "node" and
> > "memory" devices there.  Why don't you put memory types and memory tier=
s
> > there?
> >
> > And, I think we shouldn't put "memory_type" in the "memory_tier"
> > directory.  "memory_type" isn't a part of "memory_tier".
> >
>
> I was looking consolidating both memory tier and memory type into the sam=
e sysfs subsystem.
> Your recommendation imply we create two subsystem memory_tier and memtype=
. I was
> trying to avoid that. May be a generic term like "memory_tiering" can hel=
p to
> consolidate all tiering related details there?
>

A generic term "memory_tiering" sounds good to me.

Given that this will be a user-facing, stable kernel API, I think we'd
better to only add what is most useful for userspace and don't have to
mirror the kernel internal data structures in this interface.

My understanding is that we haven't fully settled down on how to
customize memory tiers from userspace.  So we don't have to show
memory_type yet, which is a kernel data structure at this point.

The userspace does need to know what are the memory tiers and which
NUMA nodes are included in each memory tier.  How about we provide the
"nodelist" interface for each memory tier as in the original proposal?

The userspace would also like to know which memory tiers/nodes belong
to the top tiers (the promotion targets).  We can provide a "toptiers"
or "toptiers_nodelist" interface to report that.

Both should still be useful even if we decide to add memory_type for
memory tier customization.

> >> The nodes which are part of a specific memory type can be listed via
> >> /sys/devices/system/memtier/memtypeN/nodes.
> >
> > How about create links to /sys/devices/system/node/nodeN in
> > "memory_type".  But I'm OK to have "nodes" file too.
> >
> >> The adistance value of a specific memory type can be listed via
> >> /sys/devices/system/memtier/memtypeN/adistance.
> >>
> >> A directory listing looks like:
> >> :/sys/devices/virtual/memtier# tree memtype1
> >> memtype1
> >> =E2=94=9C=E2=94=80=E2=94=80 adistance
> >
> > Why not just use "abstract_distance"?  This is user space interface,
> > it's better to be intuitive.
> >
> >> =E2=94=9C=E2=94=80=E2=94=80 nodes
> >> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memtier
> >> =E2=94=94=E2=94=80=E2=94=80 uevent
> >>
> >> Since we will be using struct device to expose details via sysfs, drop=
 struct
> >> kref and use struct device for refcounting the memtype.
> >>
> >
> > Best Regards,
> > Huang, Ying
>
