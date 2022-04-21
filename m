Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD25096EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384504AbiDUFoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDUFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:44:14 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF2D1263A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:41:25 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id az19so1128679uab.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmThAYEYivgdwp2Y4vIa0rs/3WUEoOgz2c6GWGEeEYs=;
        b=mxxQ8j+tAbN/MZaYJhis9U4lQT0GJ5t+sKgp86dl/89Bz532XTlCrm7DmckAypK1sL
         1B9ujG5fVQXS8a0/VKHQ/89kIV1EzS5Ce/O8GVNb+CFR+9Nw+iIbKB2S32JkEn3FyFrJ
         3feiwR2tZaPYywb/3N+QE2nFPE0JsAi2IRmCzKZqaprVQmSYDFQgRk1vQ8m6/IVDJ1sK
         Ml8i1d2pUOkifGyW4Wwty5Dbd3k+vpzrOTxk7lN+Yy9SGCndUqWV/Qf7wWA04DnH7KTs
         7txauOo9EKdDi5zUK7QjcXg8zNJCqRmKk1w0KW/JuPC2wuLfssJpqRsGp+AhYpq5wDEq
         ynUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmThAYEYivgdwp2Y4vIa0rs/3WUEoOgz2c6GWGEeEYs=;
        b=f5oDwwiMjCg17B04qhcBwFJbaC0wbxhsvkqgUcL3AwiyBwz4SttBdtLGQzmFckJUkR
         Xx9Ek1OfrR2qEJ0IZT7AFpExAmpTj3oM62/i5KS+UkTWVRwQqhTK6sPZi0DLZdSjEZ3e
         dGnek9fLjBziJB5S5tjPhykwSbrEgoltLPLx+Pm6pxX2373YmJ9wfnLw+/89XlPlhUP9
         QSUGZQG6qpobZ4C+ZCyH0A0IzPeGzt0EbP7FTDtEzi0ZZA7ZFLi8hq0P5i3GEhCp8rxC
         XDZE5RVYUoy4DqEwbbIfPzASXfwvvHFCO9hUf70msUy7QhoaY2drzZQey+fDAtlAdJkO
         oXCw==
X-Gm-Message-State: AOAM530CnkJUYO6MO66H4DBBYuopWHVu3pOsu/k/U1/44YUxGO+siU0p
        Yr7hAKya3rkIp+uJBwMHPaqKVPVR7LV3z72QIql0AQ==
X-Google-Smtp-Source: ABdhPJxEZUsT+ouvZ1sWpwuNn9WrVFzpBFkyYi+xuSv9JHBXoJU99/G8Iafsa8jVMhG9J6JoVJClTC0vHphcip+YMHU=
X-Received: by 2002:ab0:72c4:0:b0:360:2eb9:8711 with SMTP id
 g4-20020ab072c4000000b003602eb98711mr828650uap.4.1650519684266; Wed, 20 Apr
 2022 22:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com> <CAHbLzkpGzEaSDfM=GBzBxw=dZTBy12vgDDhMG+q4dbG+bCgR6A@mail.gmail.com>
In-Reply-To: <CAHbLzkpGzEaSDfM=GBzBxw=dZTBy12vgDDhMG+q4dbG+bCgR6A@mail.gmail.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 20 Apr 2022 22:41:13 -0700
Message-ID: <CAAPL-u9=-OHuUk=ZkNRDf3Dm_+3cBd2APL5MQpQr3_sVk_voJg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     Yang Shi <shy828301@gmail.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Thelen <gthelen@google.com>
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

On Wed, Apr 20, 2022 at 8:12 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Apr 14, 2022 at 12:00 AM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> >
> > On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > > Current implementation to find the demotion targets works
> > > based on node state N_MEMORY, however some systems may have
> > > dram only memory numa node which are N_MEMORY but not the
> > > right choices as demotion targets.
> > >
> > > This patch series introduces the new node state
> > > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > > is used to hold the list of nodes which can be used as demotion
> > > targets, support is also added to set the demotion target
> > > list from user space so that default behavior can be overridden.
> >
> > It appears that your proposed user space interface cannot solve all
> > problems.  For example, for system as follows,
> >
> > Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> > node 0,
> >
> > available: 3 nodes (0-2)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus:
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus: 2 3
> > node 2 size: n MB
> > node 2 free: n MB
> > node distances:
> > node   0   1   2
> >   0:  10  40  20
> >   1:  40  10  80
> >   2:  20  80  10
> >
> > Demotion order 1:
> >
> > node    demotion_target
> >  0              1
> >  1              X
> >  2              X
> >
> > Demotion order 2:
> >
> > node    demotion_target
> >  0              1
> >  1              X
> >  2              1
> >
> > The demotion order 1 is preferred if we want to reduce cross-socket
> > traffic.  While the demotion order 2 is preferred if we want to take
> > full advantage of the slow memory node.  We can take any choice as
> > automatic-generated order, while make the other choice possible via user
> > space overridden.
> >
> > I don't know how to implement this via your proposed user space
> > interface.  How about the following user space interface?
> >
> > 1. Add a file "demotion_order_override" in
> >         /sys/devices/system/node/
> >
> > 2. When read, "1" is output if the demotion order of the system has been
> > overridden; "0" is output if not.
> >
> > 3. When write "1", the demotion order of the system will become the
> > overridden mode.  When write "0", the demotion order of the system will
> > become the automatic mode and the demotion order will be re-generated.
> >
> > 4. Add a file "demotion_targets" for each node in
> >         /sys/devices/system/node/nodeX/
> >
> > 5. When read, the demotion targets of nodeX will be output.
> >
> > 6. When write a node list to the file, the demotion targets of nodeX
> > will be set to the written nodes.  And the demotion order of the system
> > will become the overridden mode.
>
> TBH I don't think having override demotion targets in userspace is
> quite useful in real life for now (it might become useful in the
> future, I can't tell). Imagine you manage hundred thousands of
> machines, which may come from different vendors, have different
> generations of hardware, have different versions of firmware, it would
> be a nightmare for the users to configure the demotion targets
> properly. So it would be great to have the kernel properly configure
> it *without* intervening from the users.
>
> So we should pick up a proper default policy and stick with that
> policy unless it doesn't work well for the most workloads. I do
> understand it is hard to make everyone happy. My proposal is having
> every node in the fast tier has a demotion target (at least one) if
> the slow tier exists sounds like a reasonable default policy. I think
> this is also the current implementation.
>

This is reasonable.  I agree that with a decent default policy, the
overriding of per-node demotion targets can be deferred.  The most
important problem here is that we should allow the configurations
where memory-only nodes are not used as demotion targets, which this
patch set has already addressed.

> >
> > To reduce the complexity, the demotion order of the system is either in
> > overridden mode or automatic mode.  When converting from the automatic
> > mode to the overridden mode, the existing demotion targets of all nodes
> > will be retained before being changed.  When converting from overridden
> > mode to automatic mode, the demotion order of the system will be re-
> > generated automatically.
> >
> > In overridden mode, the demotion targets of the hot-added and hot-
> > removed node will be set to empty.  And the hot-removed node will be
> > removed from the demotion targets of any node.
> >
> > This is an extention of the interface used in the following patch,
> >
> > https://lore.kernel.org/lkml/20191016221149.74AE222C@viggo.jf.intel.com/
> >
> > What do you think about this?
> >
> > > node state N_DEMOTION_TARGETS is also set from the dax kmem
> > > driver, certain type of memory which registers through dax kmem
> > > (e.g. HBM) may not be the right choices for demotion so in future
> > > they should be distinguished based on certain attributes and dax
> > > kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> > > however current implementation also doesn't distinguish any
> > > such memory and it considers all N_MEMORY as demotion targets
> > > so this patch series doesn't modify the current behavior.
> > >
> >
> > Best Regards,
> > Huang, Ying
> >
> > [snip]
> >
