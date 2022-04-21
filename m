Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FE509542
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383874AbiDUDPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiDUDPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:15:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16311C08
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:12:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x1so3759119pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8nlYJJByzgCZasS+QQtgZ5i6UwrzduBVdGuHcM+l0A=;
        b=BGjMt2iIkd/Gg+XyrG00dTdJirg9xfCetF8oWpolsr4pnzd0A67TQcOFdxokTOM2SH
         9Z8F006qMtYAMZsT253Jkp+e9sF28E8k0GdaurkPZ2ZzY0PXrh4pztSxsCSEiJ10z3ie
         WRbh7nISZ96o2eSiYdt4wt7UFhGxT2XMotfhEmoHs+QiqOiRS6pX3Bnx+Cq6ErAd8CR2
         yxdCON2i4Lsa/HB9JTxWXBU4qWmO8YG4DoJ2Xz0ZPekNeiRK5WZLwwVc+fu9dl8E+lBT
         sq+30AlmpkdbvbkQeZ9sr+2ToiXzZxUq9kG4upxg63ELiwaVxrQUpJi5qhTRprTfN5H5
         eaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8nlYJJByzgCZasS+QQtgZ5i6UwrzduBVdGuHcM+l0A=;
        b=1XNzxioCKPwI2KsViv9i8b5tfzH7sRkfaPuwwe7eTdaEfSHY5aer+4bULsWN9N6kUO
         l0S7DVqd2tY1WymLrX+byEO7z4ItFFqsJP2pSRa33fOvunmYxKHH9NL9My3MmziEI2xu
         xuPcnZjVq0NaLLb30sbfoxntxfVBE4dnIISJpR2LquwJ7txnBa/ieNfXIRgIWFAdHY4I
         ucZZA2Zb03pQtl6yKQl3XGbHXSdTTGxjtrn+oMZi2cKlowO0NVgfwZVMaOo9I4fom9RR
         kIWYS+jZNP2g6FIVBxGrhxFgsWjvU0r9Ix/GuKUXZqZ7F2dzJUcLxAAdh7CX7u+kJRz9
         VwOg==
X-Gm-Message-State: AOAM531WpSnN8mMSKerqnxvwS6m2qVroOruZ3mVk+/XN1I3ZprBj4Gp+
        Gbf1dz9uNiCojsm0Z6XpORRBVldkacUkl/wl5P8=
X-Google-Smtp-Source: ABdhPJwt7Wu/uM0JgmIs2/vqGMqlROVb2o39eLG+CQMO9oRaZPT/KmADYSmCPXZyftkZ55NaP67yKfSyn1kjBHjHJVw=
X-Received: by 2002:a63:901:0:b0:39d:9197:abc7 with SMTP id
 1-20020a630901000000b0039d9197abc7mr22000223pgj.206.1650510732103; Wed, 20
 Apr 2022 20:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092206.73974-1-jvgediya@linux.ibm.com> <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
In-Reply-To: <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Apr 2022 20:11:59 -0700
Message-ID: <CAHbLzkpGzEaSDfM=GBzBxw=dZTBy12vgDDhMG+q4dbG+bCgR6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:00 AM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > Current implementation to find the demotion targets works
> > based on node state N_MEMORY, however some systems may have
> > dram only memory numa node which are N_MEMORY but not the
> > right choices as demotion targets.
> >
> > This patch series introduces the new node state
> > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > is used to hold the list of nodes which can be used as demotion
> > targets, support is also added to set the demotion target
> > list from user space so that default behavior can be overridden.
>
> It appears that your proposed user space interface cannot solve all
> problems.  For example, for system as follows,
>
> Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> node 0,
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
> Demotion order 1:
>
> node    demotion_target
>  0              1
>  1              X
>  2              X
>
> Demotion order 2:
>
> node    demotion_target
>  0              1
>  1              X
>  2              1
>
> The demotion order 1 is preferred if we want to reduce cross-socket
> traffic.  While the demotion order 2 is preferred if we want to take
> full advantage of the slow memory node.  We can take any choice as
> automatic-generated order, while make the other choice possible via user
> space overridden.
>
> I don't know how to implement this via your proposed user space
> interface.  How about the following user space interface?
>
> 1. Add a file "demotion_order_override" in
>         /sys/devices/system/node/
>
> 2. When read, "1" is output if the demotion order of the system has been
> overridden; "0" is output if not.
>
> 3. When write "1", the demotion order of the system will become the
> overridden mode.  When write "0", the demotion order of the system will
> become the automatic mode and the demotion order will be re-generated.
>
> 4. Add a file "demotion_targets" for each node in
>         /sys/devices/system/node/nodeX/
>
> 5. When read, the demotion targets of nodeX will be output.
>
> 6. When write a node list to the file, the demotion targets of nodeX
> will be set to the written nodes.  And the demotion order of the system
> will become the overridden mode.

TBH I don't think having override demotion targets in userspace is
quite useful in real life for now (it might become useful in the
future, I can't tell). Imagine you manage hundred thousands of
machines, which may come from different vendors, have different
generations of hardware, have different versions of firmware, it would
be a nightmare for the users to configure the demotion targets
properly. So it would be great to have the kernel properly configure
it *without* intervening from the users.

So we should pick up a proper default policy and stick with that
policy unless it doesn't work well for the most workloads. I do
understand it is hard to make everyone happy. My proposal is having
every node in the fast tier has a demotion target (at least one) if
the slow tier exists sounds like a reasonable default policy. I think
this is also the current implementation.

>
> To reduce the complexity, the demotion order of the system is either in
> overridden mode or automatic mode.  When converting from the automatic
> mode to the overridden mode, the existing demotion targets of all nodes
> will be retained before being changed.  When converting from overridden
> mode to automatic mode, the demotion order of the system will be re-
> generated automatically.
>
> In overridden mode, the demotion targets of the hot-added and hot-
> removed node will be set to empty.  And the hot-removed node will be
> removed from the demotion targets of any node.
>
> This is an extention of the interface used in the following patch,
>
> https://lore.kernel.org/lkml/20191016221149.74AE222C@viggo.jf.intel.com/
>
> What do you think about this?
>
> > node state N_DEMOTION_TARGETS is also set from the dax kmem
> > driver, certain type of memory which registers through dax kmem
> > (e.g. HBM) may not be the right choices for demotion so in future
> > they should be distinguished based on certain attributes and dax
> > kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> > however current implementation also doesn't distinguish any
> > such memory and it considers all N_MEMORY as demotion targets
> > so this patch series doesn't modify the current behavior.
> >
>
> Best Regards,
> Huang, Ying
>
> [snip]
>
