Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1A51671F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356718AbiEASjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbiEASik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:38:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C52617A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 11:35:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fv2so11085894pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEKLzHDmrjf1i9KSUaOozCHBh8PDFjk1Tl8GhCKHgdo=;
        b=GxjehPULVcq/fzKtlONcVsDXlSml+007HBNIVAwS5tLyal/+nGIbMJGqjftZQyrLM6
         mew7Gtz7zhmlquBaV/NkgJdIGMHy5wyStoFxN7mP7wPcGWm0MtIlqYpFF0dfoX9Mu8KX
         XravQI9uPa5r5MKHo8eRYgVrvYeB1d5TbQOvU/7G+UYwEBn8EW6qXUTjBqk43FOQeAY/
         S38y1+uf4Wby0yDtmPgP5aulnqnGMJfT5cDnJQMqEJTRuPEtzw5i+2bHj+Kq2ANPcig5
         2hfPFka0LVMcH5y5cE9zac5UYwHiA2HWn6OdAtYIrD6WeyzopQubvMyeVKa4iSncTY8R
         1VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEKLzHDmrjf1i9KSUaOozCHBh8PDFjk1Tl8GhCKHgdo=;
        b=dy3lym1tJerGJSyHjbIhSNHEvPuVr43SCC3TGogJHQBa9oSpuFlgTkD9anFw9xWUaL
         16fi96xm31Hl4FTIuoI7U/HUGSFkU2uzCx2vHz8AYaq5GqyqYFK+wMSFHwWWfp4XaU1F
         Q87LqojV18u9XmqdsMzi8SdVqugLgzHGTsqeWS1C8FnZQm0PFcXWDri6iMsyUmL2TwJj
         6juNOoNbY5FIcCxPIdH2IXS2S2EUzvteB83jKG3DdT0Z1NaPAEbhyLcHIPr7kWyClmZC
         Zh19E5CuI6t3xg+Tr4h3A21cpOuDLS8naixOSSQsXKXiob8+DOK/cRbrWl6xC6xBfSi7
         O43g==
X-Gm-Message-State: AOAM533ad8Swd516F8nFhlC2CJJQEYKmhogLqAPBB1ErwPopCoET/5ca
        RBczqSItK3UIOZlfjNGL6NZ1qgYsaToi5r0I+DrgZg==
X-Google-Smtp-Source: ABdhPJzvrBGis6Hl4oe4MkPWYo2Y5jmHdVB2zp8hDYW2UDFqwPAHi080eN8/7jY9cZKpmq6SOt/oJFoLclRRU05e/UE=
X-Received: by 2002:a17:90b:4b01:b0:1d2:abf5:c83f with SMTP id
 lx1-20020a17090b4b0100b001d2abf5c83fmr9201434pjb.93.1651430112699; Sun, 01
 May 2022 11:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
In-Reply-To: <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 1 May 2022 11:35:01 -0700
Message-ID: <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Yang Shi <shy828301@gmail.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 8:59 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Hi Wei,
>
> Thanks for the nice writing. Please see the below inline comments.
>
> On Fri, Apr 29, 2022 at 7:10 PM Wei Xu <weixugc@google.com> wrote:
> >
> > The current kernel has the basic memory tiering support: Inactive
> > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > tier NUMA node to make room for new allocations on the higher tier
> > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > migrated (promoted) to a higher tier NUMA node to improve the
> > performance.
> >
> > A tiering relationship between NUMA nodes in the form of demotion path
> > is created during the kernel initialization and updated when a NUMA
> > node is hot-added or hot-removed.  The current implementation puts all
> > nodes with CPU into the top tier, and then builds the tiering hierarchy
> > tier-by-tier by establishing the per-node demotion targets based on
> > the distances between nodes.
> >
> > The current memory tiering interface needs to be improved to address
> > several important use cases:
> >
> > * The current tiering initialization code always initializes
> >   each memory-only NUMA node into a lower tier.  But a memory-only
> >   NUMA node may have a high performance memory device (e.g. a DRAM
> >   device attached via CXL.mem or a DRAM-backed memory-only node on
> >   a virtual machine) and should be put into the top tier.
> >
> > * The current tiering hierarchy always puts CPU nodes into the top
> >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> >   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> >   with CPUs are better to be placed into the next lower tier.
> >
> > * Also because the current tiering hierarchy always puts CPU nodes
> >   into the top tier, when a CPU is hot-added (or hot-removed) and
> >   triggers a memory node from CPU-less into a CPU node (or vice
> >   versa), the memory tiering hierarchy gets changed, even though no
> >   memory node is added or removed.  This can make the tiering
> >   hierarchy much less stable.
>
> I'd prefer the firmware builds up tiers topology then passes it to
> kernel so that kernel knows what nodes are in what tiers. No matter
> what nodes are hot-removed/hot-added they always stay in their tiers
> defined by the firmware. I think this is important information like
> numa distances. NUMA distance alone can't satisfy all the usecases
> IMHO.

Just want to note here that the platform firmware can only describe
the tiers of static memory present at boot. CXL hotplug breaks this
model and the kernel is left to dynamically determine the device's
performance characteristics and the performance of the topology to
reach that device. Now, the platform firmware does set expectations
for the perfomance class of different memory ranges, but there is no
way to know in advance the performance of devices that will be asked
to be physically or logically added to the memory configuration. That
said, it's probably still too early to define ABI for those
exceptional cases where the kernel needs to make a policy decision
about a device that does not fit into the firmware's performance
expectations, but just note that there are limits to the description
that platform firmware can provide.

I agree that NUMA distance alone is inadequate and the kernel needs to
make better use of data like ACPI HMAT to determine the default
tiering order.
