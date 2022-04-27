Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77051216A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiD0Sq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiD0SqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:46:06 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F69EA348
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:27:26 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q2so2513437vsr.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sELzMdbj5+HZ4sGPHJZnRGAhIQ7BCXymuFnX9zGs7BE=;
        b=aKHzEIuoGKVkf9zlW8zxPtiBPQ/ymiQxLmKRNGnk7xORraxDYRsElCIWngY5ooRyKp
         BEEVgfDboWTK5Yxqc66S6yaldjAO/UTqXcjqUK+5zGIPcI6i2aLPQUMuQ++aUUPicFoG
         1SE6YGgtyypuRBiNpPX6WPwZ+xGkO8tqFY3aquNvWu+cZvbyRJ99jWnFLf1G758dK/Jb
         gTZ6mit2qD+ZZGJvDwcgsJtWk7jwO7v8zmFRy9HJPiJ5bB94OA+uTGX/3o83Aw9zhYJK
         TFJbf++ohKYiCl07NsotAoYyIsdg5shKj+hJ/eKvZKuOYQS7rYv44kIKvCJVByKAvLo/
         ESoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sELzMdbj5+HZ4sGPHJZnRGAhIQ7BCXymuFnX9zGs7BE=;
        b=V4DNvfps4+NTkoONNmT8p/3zQP+MmUglgeoFNijDnFfojTW345mBf9iR2gN3mLG+aK
         Zx0ssJUyC6M+Duat7AXCJl8CZxRgwxli/2zhAQY7ilrYOAZohpTnd3BaKzrcny8+Ni1M
         /l7XNRDdUeUCguKIMnzfAdsz6pb06rxmKgTbUwkV2KH8div6NJWCZVIspLlhfqv3Uy/N
         8AjkBoja/eN93uTnu1lCzDg3Ht36hUVhysd+SDS8mSHtX4d4LB5giePN/o3iden5jJxH
         nn7tPOc/wjX0lhK2LVW/K2b5Skyv2vF8ZP+hP7MRDhXHXeFeO0aY12ZQgaOqqYABu6Bt
         SYqg==
X-Gm-Message-State: AOAM531tYR3n71HKltgAoNlUsV3pllX9nQeHhkZc+DLwjx5DMn4uYB/l
        eubPWq8ve5UwQph4oatxQgRA4bQcSUkZxpzqC14+Kw==
X-Google-Smtp-Source: ABdhPJwMlTmX7Q/LveWpSiwFwkoDsE2uLsTku/YPhVr4222dTua2gX1SootBCrzpOGqZ2CHVbzB80SUQGSgfEm4GfWw=
X-Received: by 2002:a67:fd0b:0:b0:31b:e36d:31b1 with SMTP id
 f11-20020a67fd0b000000b0031be36d31b1mr9727091vsr.44.1651084045851; Wed, 27
 Apr 2022 11:27:25 -0700 (PDT)
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
 <CAAPL-u94H9FLjVtYLhi_A2AqLTOCTMRh6=Sx9cX8A3WGNM-OdA@mail.gmail.com> <b1f58fd4-e23b-f617-b4a7-b80b1ffbe13f@linux.ibm.com>
In-Reply-To: <b1f58fd4-e23b-f617-b4a7-b80b1ffbe13f@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 27 Apr 2022 11:27:14 -0700
Message-ID: <CAAPL-u9ZDcM48-76+wJeP-HeJf92YdA8ad3qX65p5d+0A9Puuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
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

On Tue, Apr 26, 2022 at 10:06 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 4/25/22 10:26 PM, Wei Xu wrote:
> > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> >>
>
> ....
>
> >> 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> >>
> >> Node 0 & 2 are cpu + dram nodes and node 1 are slow
> >> memory node near node 0,
> >>
> >> available: 3 nodes (0-2)
> >> node 0 cpus: 0 1
> >> node 0 size: n MB
> >> node 0 free: n MB
> >> node 1 cpus:
> >> node 1 size: n MB
> >> node 1 free: n MB
> >> node 2 cpus: 2 3
> >> node 2 size: n MB
> >> node 2 free: n MB
> >> node distances:
> >> node   0   1   2
> >>    0:  10  40  20
> >>    1:  40  10  80
> >>    2:  20  80  10
> >>
> >> We have 2 choices,
> >>
> >> a)
> >> node    demotion targets
> >> 0       1
> >> 2       1
> >>
> >> b)
> >> node    demotion targets
> >> 0       1
> >> 2       X
> >>
> >> a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> >> traffic.  Both are OK as defualt configuration.  But some users may
> >> prefer the other one.  So we need a user space ABI to override the
> >> default configuration.
> >
> > I think 2(a) should be the system-wide configuration and 2(b) can be
> > achieved with NUMA mempolicy (which needs to be added to demotion).
> >
> > In general, we can view the demotion order in a way similar to
> > allocation fallback order (after all, if we don't demote or demotion
> > lags behind, the allocations will go to these demotion target nodes
> > according to the allocation fallback order anyway).  If we initialize
> > the demotion order in that way (i.e. every node can demote to any node
> > in the next tier, and the priority of the target nodes is sorted for
> > each source node), we don't need per-node demotion order override from
> > the userspace.  What we need is to specify what nodes should be in
> > each tier and support NUMA mempolicy in demotion.
> >
>
> I have been wondering how we would handle this. For ex: If an
> application has specified an MPOL_BIND policy and restricted the
> allocation to be from Node0 and Node1, should we demote pages allocated
> by that application
> to Node10? The other alternative for that demotion is swapping. So from
> the page point of view, we either demote to a slow memory or pageout to
> swap. But then if we demote we are also breaking the MPOL_BIND rule.

IMHO, the MPOL_BIND policy should be respected and demotion should be
skipped in such cases.  Such MPOL_BIND policies can be an important
tool for applications to override and control their memory placement
when transparent memory tiering is enabled.  If the application
doesn't want swapping, there are other ways to achieve that (e.g.
mlock, disabling swap globally, setting memcg parameters, etc).

> The above says we would need some kind of mem policy interaction, but
> what I am not sure about is how to find the memory policy in the
> demotion path.

This is indeed an important and challenging problem.  One possible
approach is to retrieve the allowed demotion nodemask from
page_referenced() similar to vm_flags.

>
> > Cross-socket demotion should not be too big a problem in practice
> > because we can optimize the code to do the demotion from the local CPU
> > node (i.e. local writes to the target node and remote read from the
> > source node).  The bigger issue is cross-socket memory access onto the
> > demoted pages from the applications, which is why NUMA mempolicy is
> > important here.
> >
> >
> -aneesh
