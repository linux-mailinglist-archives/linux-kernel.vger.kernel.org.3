Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4811950E658
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiDYQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiDYQ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:59:51 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64D038DB5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:56:46 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id e7so7501957vkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZbP7hGOBctfriTB8Bv6qGqglSYGULdw7kcbcsIBen8=;
        b=pi6mzCKN7qkYuXMh1tRBib1eV7FLtozTBRl5Db3XbdIAZajY4LF7yfLSiN0QCGGyEb
         k0/Bscsj+OVWZdgPV6E4NJjtVk6FZPPCRAqx9Pp3YYTJwnFKXT59Ja1uvZpzE9XlyObG
         xfi79e0nrRbCUwBdjcYvNABZ1goWj50HhyTWBjE04WmoFH/6+iAg/ODNAEugbVEFOHE2
         TDrP9msRr1PpBdbeSXbPUCWPb9loXuz1c6DHdmpXo9tmuWRgJ8fQ1eiZtzzbKbbzFIty
         V4HnEVRKEgULTvHD516q+ab1GzEGgM8xMMZSqmCOTtEH4xwM0HhOBhUj+0TxMGExQERx
         3l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZbP7hGOBctfriTB8Bv6qGqglSYGULdw7kcbcsIBen8=;
        b=in4fAX3Z9V2dFidlaFOZnKiYYctrSrEqJlUlTGT1XXt6jHyNuUQpVZwpe+Z9J0X1aF
         wlcoVm4+tZqo4yNYhub7FGwBZMYFWGhM6FlsIr+eYESfdwV7gM4ideGFlSHGdkBt0NAG
         W/sbOV1z1QpVbfr6MmBYvjLa0nDUnRjHk60CRBlcSAOYSRU+IeKPihxdRUfMw7dlyKVj
         Sy6OYQLEmWTcFYgxID7/2luJvQ8wCYmovOJXqotlv9+HlXiVIlW8Fjaf/ZdJ26nG7S1J
         ZUBe7dvJKwj3gNnv2mwafO2f0B2x5jVR5PkjEd6bXSY9P9bAH9BSYluicEP9scBECgcp
         sl7Q==
X-Gm-Message-State: AOAM533TfZ/vZGplnONdLlp40aiVe9fmiHj7iDAJe7Tui8gi58w8I92c
        QRp83eHlY+719X3auDu5cQsDUCKqcIhCs1v0WoGPTPMsVj8=
X-Google-Smtp-Source: ABdhPJyiayRWMyVF2zMeallpNwbqXi+fqoCQhl7rzCrLovIWwx1eCFHb8KA73JSK47lYk9VSvJp+ga1RKTBTDLxpFh4=
X-Received: by 2002:a1f:9b85:0:b0:32d:4d56:cf64 with SMTP id
 d127-20020a1f9b85000000b0032d4d56cf64mr5370192vke.31.1650905805824; Mon, 25
 Apr 2022 09:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
 <ea73f6fda9cafdd0cb6ba8351139e6f4b47354a8.camel@intel.com>
 <CAAPL-u-aeceXFUNdok_GYb2aLhZa0zBBuSqHxFznQob3PbJt7Q@mail.gmail.com>
 <a80647053bba44623094995730e061f0e6129677.camel@intel.com>
 <CAAPL-u89Jxutu1VH0LnO5VGdMbkLvc2M9eapuwP-y9oG9QSsrA@mail.gmail.com>
 <610ccaad03f168440ce765ae5570634f3b77555e.camel@intel.com>
 <CAAPL-u9ktM82zAW_OVwqTmQsr-XC8XOPmAsjoiCLo18cxUWA=A@mail.gmail.com>
 <8e31c744a7712bb05dbf7ceb2accf1a35e60306a.camel@intel.com>
 <CAAPL-u9uP+FUh7Yn0ByOECo+EP32ZABnCvNPKQB9JCA68VHEqQ@mail.gmail.com>
 <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com>
 <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com> <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
In-Reply-To: <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 25 Apr 2022 09:56:34 -0700
Message-ID: <CAAPL-u94H9FLjVtYLhi_A2AqLTOCTMRh6=Sx9cX8A3WGNM-OdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> Hi, All,
>
> On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:
>
> [snip]
>
> > I think it is necessary to either have per node demotion targets
> > configuration or the user space interface supported by this patch
> > series. As we don't have clear consensus on how the user interface
> > should look like, we can defer the per node demotion target set
> > interface to future until the real need arises.
> >
> > Current patch series sets N_DEMOTION_TARGET from dax device kmem
> > driver, it may be possible that some memory node desired as demotion
> > target is not detected in the system from dax-device kmem probe path.
> >
> > It is also possible that some of the dax-devices are not preferred as
> > demotion target e.g. HBM, for such devices, node shouldn't be set to
> > N_DEMOTION_TARGETS. In future, Support should be added to distinguish
> > such dax-devices and not mark them as N_DEMOTION_TARGETS from the
> > kernel, but for now this user space interface will be useful to avoid
> > such devices as demotion targets.
> >
> > We can add read only interface to view per node demotion targets
> > from /sys/devices/system/node/nodeX/demotion_targets, remove
> > duplicated /sys/kernel/mm/numa/demotion_target interface and instead
> > make /sys/devices/system/node/demotion_targets writable.
> >
> > Huang, Wei, Yang,
> > What do you suggest?
>
> We cannot remove a kernel ABI in practice.  So we need to make it right
> at the first time.  Let's try to collect some information for the kernel
> ABI definitation.
>
> The below is just a starting point, please add your requirements.
>
> 1. Jagdish has some machines with DRAM only NUMA nodes, but they don't
> want to use that as the demotion targets.  But I don't think this is a
> issue in practice for now, because demote-in-reclaim is disabled by
> default.
>
> 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
>
> Node 0 & 2 are cpu + dram nodes and node 1 are slow
> memory node near node 0,
>
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node distances:
> node   0   1   2
>   0:  10  40  20
>   1:  40  10  80
>   2:  20  80  10
>
> We have 2 choices,
>
> a)
> node    demotion targets
> 0       1
> 2       1
>
> b)
> node    demotion targets
> 0       1
> 2       X
>
> a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> traffic.  Both are OK as defualt configuration.  But some users may
> prefer the other one.  So we need a user space ABI to override the
> default configuration.

I think 2(a) should be the system-wide configuration and 2(b) can be
achieved with NUMA mempolicy (which needs to be added to demotion).

In general, we can view the demotion order in a way similar to
allocation fallback order (after all, if we don't demote or demotion
lags behind, the allocations will go to these demotion target nodes
according to the allocation fallback order anyway).  If we initialize
the demotion order in that way (i.e. every node can demote to any node
in the next tier, and the priority of the target nodes is sorted for
each source node), we don't need per-node demotion order override from
the userspace.  What we need is to specify what nodes should be in
each tier and support NUMA mempolicy in demotion.

Cross-socket demotion should not be too big a problem in practice
because we can optimize the code to do the demotion from the local CPU
node (i.e. local writes to the target node and remote read from the
source node).  The bigger issue is cross-socket memory access onto the
demoted pages from the applications, which is why NUMA mempolicy is
important here.

> 3. For machines with HBM (High Bandwidth Memory), as in
>
> https://lore.kernel.org/lkml/39cbe02a-d309-443d-54c9-678a0799342d@gmail.com/
>
> > [1] local DDR = 10, remote DDR = 20, local HBM = 31, remote HBM = 41
>
> Although HBM has better performance than DDR, in ACPI SLIT, their
> distance to CPU is longer.  We need to provide a way to fix this.  The
> user space ABI is one way.  The desired result will be to use local DDR
> as demotion targets of local HBM.
>
> Best Regards,
> Huang, Ying
>
