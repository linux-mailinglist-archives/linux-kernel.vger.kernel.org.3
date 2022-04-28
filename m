Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C250512A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiD1EPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiD1EO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:14:58 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2720120BF9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:11:45 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id f32so3556733vsv.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPHxqBSJHjTyBBNkveNlu/+ImQludYrH8gxylsd2L5U=;
        b=O4Nl7pqqsJE65cqguD/4cmcrVpUgkZGe+2BSVVxY6VkzL+o6Ksebcd8Slb/EKpTn09
         NXw8kb2/lD7b4M8ivoBVpG8ftb353M1m5QBr1uOinHAAjfidMBAZMCnfuFG7lZYl2smM
         xeNsh/GOaVBXstcbTEpd0JpyNFuI4NH93/EDh/XOi+bMD8RObE0LXeDXXV83BZCuvY31
         tUWTi6hLa19LZ3LhP48ShyRHMmwCxbWARo5B5prR+bSjsuE/gAboYCWA/Yr6BaUEFuDr
         eghY5J1nS73KamQajOQ5JWHcfYn6m9Blbu7AA7zgQu4StcKrM80/hMeT5bwDGtRN4LqV
         KvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPHxqBSJHjTyBBNkveNlu/+ImQludYrH8gxylsd2L5U=;
        b=SSYVTM2iXy/ymKwxOn0Z/ZFOpY0AeUJg42YAQLwmExeMwX7LH37QdXgJIEdBnZ2Jvl
         STbC60A2oestq92G+wHQ7anX2k9FhxvivWRD8CneOBXQg0GHONVCQ83TuOBunkSYr49B
         Km8lbAHKZMtk5LVCDaI5Ox5gsLDJSCXTTgs08ck8WFXaboAJVfC0Liw0xpa0RGT37GH6
         r4PKcp8o/+VPWEob/3+/jkcWSROoJeOblt077sLHVqr4Z49L3NbxJKM6LCB97cT4wbKR
         uzX4fvoKsV/TOGOC9JAc04jnrDuWlzm5F58V99x+4fafPfXg1Dw2XSpP4i206ZaL0cFz
         9OEw==
X-Gm-Message-State: AOAM530qrKBNnrwtiPKY9Eka+9SEk3en7TrRcM2l4NSV5gp3y+tc2MNd
        SCv80BcufqzbibiaPropNmkzbwtOHzgzfheYzdFRKw==
X-Google-Smtp-Source: ABdhPJwhHhVDXgZlnm6v5QaRfQFSBgYyHfAycGpQOqoNK0EmkTaf4aG90EBvcPNN6afAKH8nP9h1JQBWuXcy8TEycKs=
X-Received: by 2002:a67:f343:0:b0:32c:c4b7:e238 with SMTP id
 p3-20020a67f343000000b0032cc4b7e238mr5905913vsm.77.1651119103832; Wed, 27 Apr
 2022 21:11:43 -0700 (PDT)
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
 <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
 <CAAPL-u94H9FLjVtYLhi_A2AqLTOCTMRh6=Sx9cX8A3WGNM-OdA@mail.gmail.com>
 <b1f58fd4-e23b-f617-b4a7-b80b1ffbe13f@linux.ibm.com> <CAAPL-u9ZDcM48-76+wJeP-HeJf92YdA8ad3qX65p5d+0A9Puuw@mail.gmail.com>
 <9d9ef67127b1e2cf0b6c72f60cb7304dc573c28b.camel@intel.com>
In-Reply-To: <9d9ef67127b1e2cf0b6c72f60cb7304dc573c28b.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 27 Apr 2022 21:11:32 -0700
Message-ID: <CAAPL-u-sSg=p1n_Trm9TyrgdCCO1zZ-LbKM=tkp3M827gLv=CA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>, feng.tang@intel.com
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

On Wed, Apr 27, 2022 at 5:56 PM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Wed, 2022-04-27 at 11:27 -0700, Wei Xu wrote:
> > On Tue, Apr 26, 2022 at 10:06 PM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > On 4/25/22 10:26 PM, Wei Xu wrote:
> > > > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> > > > <ying.huang@intel.com> wrote:
> > > > >
> > >
> > > ....
> > >
> > > > > 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> > > > >
> > > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow
> > > > > memory node near node 0,
> > > > >
> > > > > available: 3 nodes (0-2)
> > > > > node 0 cpus: 0 1
> > > > > node 0 size: n MB
> > > > > node 0 free: n MB
> > > > > node 1 cpus:
> > > > > node 1 size: n MB
> > > > > node 1 free: n MB
> > > > > node 2 cpus: 2 3
> > > > > node 2 size: n MB
> > > > > node 2 free: n MB
> > > > > node distances:
> > > > > node   0   1   2
> > > > >    0:  10  40  20
> > > > >    1:  40  10  80
> > > > >    2:  20  80  10
> > > > >
> > > > > We have 2 choices,
> > > > >
> > > > > a)
> > > > > node    demotion targets
> > > > > 0       1
> > > > > 2       1
> > > > >
> > > > > b)
> > > > > node    demotion targets
> > > > > 0       1
> > > > > 2       X
> > > > >
> > > > > a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> > > > > traffic.  Both are OK as defualt configuration.  But some users may
> > > > > prefer the other one.  So we need a user space ABI to override the
> > > > > default configuration.
> > > >
> > > > I think 2(a) should be the system-wide configuration and 2(b) can be
> > > > achieved with NUMA mempolicy (which needs to be added to demotion).
> > > >
> > > > In general, we can view the demotion order in a way similar to
> > > > allocation fallback order (after all, if we don't demote or demotion
> > > > lags behind, the allocations will go to these demotion target nodes
> > > > according to the allocation fallback order anyway).  If we initialize
> > > > the demotion order in that way (i.e. every node can demote to any node
> > > > in the next tier, and the priority of the target nodes is sorted for
> > > > each source node), we don't need per-node demotion order override from
> > > > the userspace.  What we need is to specify what nodes should be in
> > > > each tier and support NUMA mempolicy in demotion.
> > > >
> > >
> > > I have been wondering how we would handle this. For ex: If an
> > > application has specified an MPOL_BIND policy and restricted the
> > > allocation to be from Node0 and Node1, should we demote pages allocated
> > > by that application
> > > to Node10? The other alternative for that demotion is swapping. So from
> > > the page point of view, we either demote to a slow memory or pageout to
> > > swap. But then if we demote we are also breaking the MPOL_BIND rule.
> >
> > IMHO, the MPOL_BIND policy should be respected and demotion should be
> > skipped in such cases.  Such MPOL_BIND policies can be an important
> > tool for applications to override and control their memory placement
> > when transparent memory tiering is enabled.  If the application
> > doesn't want swapping, there are other ways to achieve that (e.g.
> > mlock, disabling swap globally, setting memcg parameters, etc).
> >
> >
> > > The above says we would need some kind of mem policy interaction, but
> > > what I am not sure about is how to find the memory policy in the
> > > demotion path.
> >
> > This is indeed an important and challenging problem.  One possible
> > approach is to retrieve the allowed demotion nodemask from
> > page_referenced() similar to vm_flags.
>
> This works for mempolicy in struct vm_area_struct, but not for that in
> struct task_struct.  Mutiple threads in a process may have different
> mempolicy.

From vm_area_struct, we can get to mm_struct and then to the owner
task_struct, which has the process mempolicy.

It is indeed a problem when a page is shared by different threads or
different processes that have different thread default mempolicy
values.

On the other hand, it can already support most interesting use cases
for demotion (e.g. selecting the demotion node, mbind to prevent
demotion) by respecting cpuset and vma mempolicies.

> Best Regards,
> Huang, Ying
>
> > >
> > > > Cross-socket demotion should not be too big a problem in practice
> > > > because we can optimize the code to do the demotion from the local CPU
> > > > node (i.e. local writes to the target node and remote read from the
> > > > source node).  The bigger issue is cross-socket memory access onto the
> > > > demoted pages from the applications, which is why NUMA mempolicy is
> > > > important here.
> > > >
> > > >
> > > -aneesh
>
>
