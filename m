Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE80549C29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiFMSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiFMSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:50:42 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E822EE8D4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:50:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p63so4301517qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H0T+Ju0FY0ctldM76CfR3ifPomNMCFqKjz28sSDHzOo=;
        b=CRP/awNTFqsFKDaZFcnWqTMwOfEC1FNH1yVjUL6uKl/vBwqyravouD90Jv5QMA7cm0
         qW1ubwVfAbdEKIgaIf3TK6U+mPjYw2RqW26CSKTQ6fC0Wqi238uRtSPqXUhgp/c8YXWC
         +03V571nkBn5BKJFt7qABBhZxie8tWshu/fvvWYkfhJZytIailOGrLJr/gwJui+pfRc+
         Qgca9fqO+EGc5a20FwGUwksH4Razm9mopNFgEWMomWdAzJ4KtEMQd9dBOwqaMQyrSkHq
         NX8JdM6Y3zmdpzIr8nLxJDt6mLdZtiG5mXqVQWfsIl1ollke0vCuWEAf0iyLrFdVg+d+
         zLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H0T+Ju0FY0ctldM76CfR3ifPomNMCFqKjz28sSDHzOo=;
        b=kj8MgEYkHCPmn5wjUBdzZO/O7cjVqVB43AmpPVLWrLclPBynTq4xSYJp93xMz6TZj2
         CUBtdJq0HFsda3eRzg6qHdrW63PRJiTq3jD77cCHBFNCW0eniS/K0u5nVRrxyxrowvOV
         DXp/6gAOqZiWa4W6D1p7u0WPzEo+prR044pOvH1WmATaYMU0V//0fBPglZgClePMGkCE
         6wA6Nqdk2FMKEfUPWS3koDq3l2N5YdK/9kQVsDzQehqg5jBUlbPUOSQcTnuWvBLIV+eG
         U47TK9dLtWTnaQYj0wKvKuiL+YPgAExkb9mQDkuoLmPecM54koOL9PZ23rFU2lfJ4DiB
         5XHQ==
X-Gm-Message-State: AOAM531HVMP0C3w1JmadNmANLw1mNR2DJ+kCi4b4cJEP9Ap+WRb/n15X
        kAVES8B0ZEK1xI7bHowY6nhnTw==
X-Google-Smtp-Source: ABdhPJz6KlDsQy5A8f6VgC3uqf5VsQ54EDxPFTNE5iUKh8DjJ8U/91+syvnkllo6PVOdof4Zs7pmGQ==
X-Received: by 2002:a05:620a:4e9:b0:6a7:8357:303d with SMTP id b9-20020a05620a04e900b006a78357303dmr467386qkh.105.1655135457443;
        Mon, 13 Jun 2022 08:50:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2c45])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a0a4400b006a684c87f4bsm6839593qka.68.2022.06.13.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:50:57 -0700 (PDT)
Date:   Mon, 13 Jun 2022 11:50:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
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
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <Yqdc4DE8gYJ3zesO@cmpxchg.org>
References: <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org>
 <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org>
 <20220610105708.0000679b@Huawei.com>
 <YqdEEhJFr3SlfvSJ@cmpxchg.org>
 <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:
> On 6/13/22 7:35 PM, Johannes Weiner wrote:
> > On Fri, Jun 10, 2022 at 10:57:08AM +0100, Jonathan Cameron wrote:
> > > I'm not sure completely read only is flexible enough (though mostly RO is fine)
> > > as we keep sketching out cases where any attempt to do things automatically
> > > does the wrong thing and where we need to add an extra tier to get
> > > everything to work.  Short of having a lot of tiers I'm not sure how
> > > we could have the default work well.  Maybe a lot of "tiers" is fine
> > > though perhaps we need to rename them if going this way and then they
> > > don't really work as current concept of tier.
> > > 
> > > Imagine a system with subtle difference between different memories such
> > > as 10% latency increase for same bandwidth.  To get an advantage from
> > > demoting to such a tier will require really stable usage and long
> > > run times. Whilst you could design a demotion scheme that takes that
> > > into account, I think we are a long way from that today.
> > 
> > Good point: there can be a clear hardware difference, but it's a
> > policy choice whether the MM should treat them as one or two tiers.
> > 
> > What do you think of a per-driver/per-device (overridable) distance
> > number, combined with a configurable distance cutoff for what
> > constitutes separate tiers. E.g. cutoff=20 means two devices with
> > distances of 10 and 20 respectively would be in the same tier, devices
> > with 10 and 100 would be in separate ones. The kernel then generates
> > and populates the tiers based on distances and grouping cutoff, and
> > populates the memtier directory tree and nodemasks in sysfs.
> > 
> 
> Right now core/generic code doesn't get involved in building tiers. It just
> defines three tiers where drivers could place the respective devices they
> manage. The above suggestion would imply we are moving quite a lot of policy
> decision logic into the generic code?.

No. The driver still chooses its own number, just from a wider
range. The only policy in generic code is the distance cutoff for
which devices are grouped into tiers together.

> At some point, we will have to depend on more attributes other than
> distance(may be HMAT?) and each driver should have the flexibility to place
> the device it is managing in a specific tier? By then we may decide to
> support more than 3 static tiers which the core kernel currently does.

If we start with a larger possible range of "distance" values right
away, we can still let the drivers ballpark into 3 tiers for now (100,
200, 300). But it will be easier to take additional metrics into
account later and fine tune accordingly (120, 260, 90 etc.) without
having to update all the other drivers as well.

> If the kernel still can't make the right decision, userspace could rearrange
> them in any order using rank values. Without something like rank, if
> userspace needs to fix things up,  it gets hard with device
> hotplugging. ie, the userspace policy could be that any new PMEM tier device
> that is hotplugged, park it with a very low-rank value and hence lowest in
> demotion order by default. (echo 10 >
> /sys/devices/system/memtier/memtier2/rank) . After that userspace could
> selectively move the new devices to the correct memory tier?

I had touched on this in the other email.

This doesn't work if two drivers that should have separate policies
collide into the same tier - which is very likely with just 3 tiers.
So it seems to me the main usecase for having a rank tunable falls
apart rather quickly until tiers are spaced out more widely. And it
does so at the cost of an, IMO, tricky to understand interface.

In the other email I had suggested the ability to override not just
the per-device distance, but also the driver default for new devices
to handle the hotplug situation.

This should be less policy than before. Driver default and per-device
distances (both overridable) combined with one tunable to set the
range of distances that get grouped into tiers.

With these parameters alone, you can generate an ordered list of tiers
and their devices. The tier numbers make sense, and no rank is needed.

Do you still need the ability to move nodes by writing nodemasks? I
don't think so. Assuming you would never want to have an actually
slower device in a higher tier than a faster device, the only time
you'd want to move a device is when the device's distance value is
wrong. So you override that (until you update to a fixed kernel).
