Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5965AA872
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiIBHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIBHCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:02:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7905BC101
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:02:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so4663801pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uXkNYxalU3/JcnK0TgVrr2SUQW7bkm9aHsz+BnGWP4M=;
        b=bUW/6CvLUDYW0zbfCP9LCMgQ6TAJJPu2/+w9PaaDjrm5uRaLAErHNIrLG35W+7dPBp
         iz4APoLne29HYgGTr3djCIrRA2QO6RIDrM/7gmuZibGir+ybNjWk4Tc6evIgdn6epN+i
         95os2rQS+J+e90fqJA91RsJfiKAKCeWjnEJvgWDKYFrS2wWv0ank1E/tAAEqQfmjIHwm
         BvgN05t5fibh9LeV1OnGnc875ySVeP090LPZOvIi5iCd+nVfyYOW/7WkGLGDg3EPlPY/
         yrZRwr0dC84rQ6GseSm35y1jdepf+X8hFuYHdbS2Mif2s5/rQ0cg2yOa9qq38vFxnf86
         56kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uXkNYxalU3/JcnK0TgVrr2SUQW7bkm9aHsz+BnGWP4M=;
        b=51JOWMmfp6jjtS2zu9V7rC/6aKg1AuK2/AG8JtM+lZ19WdpD453JQZYirzEsWpy0iQ
         VApqjHFgejWbO3Lf7Sh9sDjjd0zrGC3wtn/0yeh2AnBhYedIZNwdk1kW4rdmrMP6scWQ
         N2FsIFmIlzEaY8LzufU1KJSKDp7UHL0BEeXBj1HbXctjqyjy5w1t/QV8e43Eh9qlyiGu
         42oYhOPH3tvykZOYq7UHcIDoaIEHcpdgvGbGseCE25+MvpSbiQ7xUgFuEvc30G/5xYFY
         46XZxnMwXdxJ4W1ySM6et6nxs2Wz3PFh7Dafqxe7eAM0F9noiiX4wL8rIboyp5XSdJBV
         WrHA==
X-Gm-Message-State: ACgBeo1zxFeyuU4pkpTL9bSw7gGcJg8GE0GNKorKobtt1yqwSWRoLekY
        /OsoiDM50Eg9AYje5UA28F36Z9Kk9E0SW65amMSXDw==
X-Google-Smtp-Source: AA6agR5uR6LpAtH7c6bzY90OocFiB2zuRBrqhgIN4W1VlfMx9LRsS/Ozz4xK6EFFpJ7aOlMcyK5rZc+IYGh+WDK5hbc=
X-Received: by 2002:a17:902:e5cc:b0:16f:1e31:da6c with SMTP id
 u12-20020a170902e5cc00b0016f1e31da6cmr34239381plf.66.1662102137014; Fri, 02
 Sep 2022 00:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
 <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com> <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
 <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
 <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com> <87fshaz63h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <698120ce-d4df-3d13-dea9-a8f5c298783c@linux.ibm.com> <87bkryz4nh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2b4ddc45-74ae-27df-d973-6724f61f4e18@linux.ibm.com> <877d2mz3c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <45488760-02b5-115b-c16d-5219303f2f33@linux.ibm.com>
In-Reply-To: <45488760-02b5-115b-c16d-5219303f2f33@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 2 Sep 2022 00:02:05 -0700
Message-ID: <CAAPL-u_UoAQ9koo892sG-Tx4bi4xDRe9PUtjmFSsn90uU-n31g@mail.gmail.com>
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via sysfs
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, Sep 1, 2022 at 11:44 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 9/2/22 12:10 PM, Huang, Ying wrote:
> > Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> >
> >> On 9/2/22 11:42 AM, Huang, Ying wrote:
> >>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> >>>
> >>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
> >>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> >>>>>
> >>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
> >>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>>>>>>>
> >>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> >>>>>>>>
> >>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
> >>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >>>>>>>>>>
> >>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
> >>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
> >>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
> >>>>>>>>>>>
> >>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
> >>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> >>>>>>>>>>
> >>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
> >>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
> >>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
> >>>>>>>>>> preference.
> >>>>>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4
> >>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
> >>>>>> including memory type in the future. This is as per discussion
> >>>>>>
> >>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
> >>>>>
> >>>>> I don't think that it's a good idea to mix 2 types of devices in one
> >>>>> subsystem (bus).  If my understanding were correct, that breaks the
> >>>>> driver core convention.
> >>>>>
> >>>>
> >>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
> >>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
> >>>> details of memory tiers and can possibly contain details of different memory types .
> >>>
> >>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
> >>> almost totally different attributes (sysfs file).  So, we should create
> >>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
> >>> isn't a subsystem.
> >>
> >> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
> >> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
> >> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier.
> >>
> >> /sys/devices/virtual/memory_tiering/memory_tierN
> >> /sys/devices/virtual/memory_tiering/memory_typeN
> >
> > I think we should add
> >
> >  /sys/devices/virtual/memory_tier/memory_tierN
> >  /sys/devices/virtual/memory_type/memory_typeN
> >
>
> I am trying to find if there is a technical reason to do the same?
>
> > I don't think this is complex.  Devices of same bus/subsystem should
> > have mostly same attributes.  This is my understanding of driver core
> > convention.
> >
>
> I was not looking at this from code complexity point. Instead of having multiple directories
> with details w.r.t memory tiering, I was looking at consolidating the details
> within the directory /sys/devices/virtual/memory_tiering. (similar to all virtual devices
> are consolidated within /sys/devics/virtual/).
>
> -aneesh

Here is an example of /sys/bus/nd/devices (I know it is not under
/sys/devices/virtual, but it can still serve as a reference):

ls -1 /sys/bus/nd/devices

namespace2.0
namespace3.0
ndbus0
nmem0
nmem1
region0
region1
region2
region3

So I think it is not unreasonable if we want to group memory tiering
related interfaces within a single top directory.

Wei
