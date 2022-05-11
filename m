Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905C522BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiEKFmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiEKFmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:42:44 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E6244F19
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:42:42 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id p1so386895uak.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGxPmJDM+cvx1KDtqTZS+UTdKLlUMP0zI7c+wSVmsgY=;
        b=MYGn0ZQ3a43eA+HINVZpZPpyE4SoDYREVL72759FD4eYh5rz+qlhLlfCmgCWrpcmBi
         evBpYgzn2guWEhSpqz6CJ98/Ltf4fUmuFSfsW6iDEMBcu8gvPaRykbJmS19i78/kBMAR
         uU22AwG7xDYnFhs+qFjmYzrgMM8gBmdaGmY9llctP9UQpK5dE9uQlFxkMDWj1TbPgeBM
         InNWP1EFZTG6Ech3/sS5J/POD/aDZ8JWWP/HBAS5KrHoTTRapVEawmHJrWAq8crPfzAn
         +e/mi1ounO+JP2PYmP74INHWma6QVm8Ay92juLa3gq7ne6QxfS8gE5NVXCMhh3XDto8V
         VD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGxPmJDM+cvx1KDtqTZS+UTdKLlUMP0zI7c+wSVmsgY=;
        b=jYNcHo1K2uIctFyFw1hRR+42FP3W1qk9K2VN56Gu8Q6F+biFduqAO44AsTwkN0aRT0
         qmfrfqHzPIJIoACjZGBnil49BFCpV26CRwTotv+jiiR/qX9SSXAJtKatwAgUSfdwBUma
         +spyVOT70kXoaCNdlaspxeOgNnAd+5r5ETQrg73pNRqgiFZUsPPFutIC8EOpqiKTXJGB
         z5w7brGhHfK9cwezuZ1xQRjRSfmqGReE8U9R2bu6chRif/Ll2hteOtlrD0XtxpsMhBO3
         Upjdboo39WW3/HNrVdS0IIiyaCeDUy7NKgOoWMlzY2EsAw6u3Pj9qaAu2X20VIrEILSg
         e6GQ==
X-Gm-Message-State: AOAM533buJCQs7M8dWqd0x8e5K2lKy4Fy/GvIaTv3xli1j4RF1bF0GG1
        UZ+6yuI3ZLxJAtepeZpm/wqd3B88Jkt1cs4A7+tAJw==
X-Google-Smtp-Source: ABdhPJzFPFltZtUFX4vhtGVjtORhdG+McAS0oa6PaWPDH5huwZItLsFCY18KX/JXOqEtg34hf3vp8BO60wHDIsdtDg4=
X-Received: by 2002:ab0:349a:0:b0:35c:b898:a733 with SMTP id
 c26-20020ab0349a000000b0035cb898a733mr12723212uar.85.1652247761972; Tue, 10
 May 2022 22:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
 <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com> <CAHbLzkqBVdaT5wwPuCXUMb8DwLEzHPaQwCKXsjsPBRTgZAAgnw@mail.gmail.com>
 <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com> <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
In-Reply-To: <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 10 May 2022 22:42:30 -0700
Message-ID: <CAAPL-u-Q1_19TM-J-QD9QWXGcp6A9xJS126xO54H83u+c569Tg@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Hesham Almatary <hesham.almatary@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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

On Tue, May 10, 2022 at 5:10 AM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/10/22 3:29 PM, Hesham Almatary wrote:
> > Hello Yang,
> >
> > On 5/10/2022 4:24 AM, Yang Shi wrote:
> >> On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
> >> <hesham.almatary@huawei.com> wrote:
>
>
> ...
>
> >>>
> >>> node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and DDR memory
> >>> in tier 0,
> >>> node 2 has NVMM memory in tier 1, node 3 has some sort of bigger memory
> >>> (could be a bigger DDR or something) in tier 2. The distances are as
> >>> follows:
> >>>
> >>> --------------          --------------
> >>> |   Node 0   |          |   Node 1   |
> >>> |  -------   |          |  -------   |
> >>> | |  DDR  |  |          | |  DDR  |  |
> >>> |  -------   |          |  -------   |
> >>> |            |          |            |
> >>> --------------          --------------
> >>>          | 20               | 120    |
> >>>          v                  v        |
> >>> ----------------------------       |
> >>> | Node 2     PMEM          |       | 100
> >>> ----------------------------       |
> >>>          | 100                       |
> >>>          v                           v
> >>> --------------------------------------
> >>> | Node 3    Large mem                |
> >>> --------------------------------------
> >>>
> >>> node distances:
> >>> node   0    1    2    3
> >>>      0  10   20   20  120
> >>>      1  20   10  120  100
> >>>      2  20  120   10  100
> >>>      3  120 100  100   10
> >>>
> >>> /sys/devices/system/node/memory_tiers
> >>> 0-1
> >>> 2
> >>> 3
> >>>
> >>> N_TOPTIER_MEMORY: 0-1
> >>>
> >>>
> >>> In this case, we want to be able to "skip" the demotion path from Node 1
> >>> to Node 2,
> >>>
> >>> and make demotion go directely to Node 3 as it is closer, distance wise.
> >>> How can
> >>>
> >>> we accommodate this scenario (or at least not rule it out as future
> >>> work) with the
> >>>
> >>> current RFC?
> >> If I remember correctly NUMA distance is hardcoded in SLIT by the
> >> firmware, it is supposed to reflect the latency. So I suppose it is
> >> the firmware's responsibility to have correct information. And the RFC
> >> assumes higher tier memory has better performance than lower tier
> >> memory (latency, bandwidth, throughput, etc), so it sounds like a
> >> buggy firmware to have lower tier memory with shorter distance than
> >> higher tier memory IMHO.
> >
> > You are correct if you're assuming the topology is all hierarchically
> >
> > symmetric, but unfortuantely, in real hardware (e.g., my example above)
> >
> > it is not. The distance/latency between two nodes in the same tier
> >
> > and a third node, is different. The firmware still provides the correct
> >
> > latency, but putting a node in a tier is up to the kernel/user, and
> >
> > is relative: e.g., Node 3 could belong to tier 1 from Node 1's
> >
> > perspective, but to tier 2 from Node 0's.
> >
> >
> > A more detailed example (building on my previous one) is when having
> >
> > the GPU connected to a switch:
> >
> > ----------------------------
> > | Node 2     PMEM          |
> > ----------------------------
> >        ^
> >        |
> > --------------          --------------
> > |   Node 0   |          |   Node 1   |
> > |  -------   |          |  -------   |
> > | |  DDR  |  |          | |  DDR  |  |
> > |  -------   |          |  -------   |
> > |    CPU     |          |    GPU     |
> > --------------          --------------
> >         |                  |
> >         v                  v
> > ----------------------------
> > |         Switch           |
> > ----------------------------
> >         |
> >         v
> > --------------------------------------
> > | Node 3    Large mem                |
> > --------------------------------------
> >
> > Here, demoting from Node 1 to Node 3 directly would be faster as
> >
> > it only has to go through one hub, compared to demoting from Node 1
> >
> > to Node 2, where it goes through two hubs. I hope that example
> >
> > clarifies things a little bit.
> >
>
> Alistair mentioned that we want to consider GPU memory to be expensive
> and want to demote from GPU to regular DRAM. In that case for the above
> case we should end up with
>
>
> tier 0 - > Node3
> tier 1 ->  Node0, Node1
> tier 2 ->  Node2
>
> Hence
>
>   node 0: allowed=2
>   node 1: allowed=2
>   node 2: allowed = empty
>   node 3: allowed = 0-1 , based on fallback order 1, 0

If we have 3 tiers as defined above, then we'd better to have:

node 0: allowed = 2
node 1: allowed = 2
node 2: allowed = empty
node 3: allowed = 0-2, based on fallback order: 1,0,2

The firmware should provide the node distance values to reflect that
PMEM is slowest and should have the largest distance away from node 3.

> -aneesh
>
>
