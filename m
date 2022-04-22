Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABA50BD50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449786AbiDVQqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiDVQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:46:20 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5915F24B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:43:25 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id b81so4110005vkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfldpI9oi8kVFYnmBkkOAScpC5PXCn0pztq/ETktsAc=;
        b=jEwYwv/rumKCYNVVaMnj8kBBhU6cQnouB8pPysucenEkQjCJD7hXBsfNnGlvyUvZu7
         l9o6GV3rFOjXra2Jruj3NaZldSbvoyYzAhObo1Jb4JjpZZCePNV7JWKe5ZykonMVk1m6
         itXvBPciGj16vokkLRApOeNCvi+96hn75J3pBDY1DmDVjJlMDcu4m/FdEQ+TWLFl9KZg
         C6FMQgF5gGUAPkuQ9PRMwiea6j+ho1o4HX66Bhp6Uirv3g/UdLay8zL6sFO0Vj4j3P2p
         LCdVxAf1orZ6Qt5QV1kmvPOXywGuPKHiIoos2Tfs4sZ/XuBGrYyI1R7HQFTTUKRUZgAn
         u13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfldpI9oi8kVFYnmBkkOAScpC5PXCn0pztq/ETktsAc=;
        b=S3aBb0BnguME85Uy2vXvLF82XB98kI3Trz3fyP6F9MvFDZ0KlwJkvfOMj31vbOUnV/
         u+Kegh36YWAwIFqXT3kiBtoW2XSE2YovfR5bqWi6MrAul0w92GT32L8lREL+24lLQ2ZE
         3SoUqcXFXxDyxvWwu+SnFj0d0Y0QZyDgwju1MOT54zsICPyoFKj689k9xuS33I1KrBF2
         J6ssmPRu0Ok8wPVF7Fxjd0OPHagvAkEseHF0l0rds2FiEwkVXOxr+XFrG1FI2bn6MtsR
         ZxrRyobTNbt4uN6uXAKTRIZZdQmgBQkg6nkwd8b6tRAZ8RE4l4Eg7SUCWRTXg6ihuqqp
         nNsA==
X-Gm-Message-State: AOAM533rBe4DiVHueqByZrN7bJtSlKnW2GWFRXaxUSBzc+vXAsBzNXn1
        y7PLqqXT8rr0QP0OGdF0U+3hy6qo0k+RbOxRNfzjt1h62o0=
X-Google-Smtp-Source: ABdhPJwoIlhbwLkf5nUF9rGOiaJ8lISXTZWKrFaJ68Gnfo8SAsM2H5U9yFp/2giGO6lJf8ruWCj8M2ASwasIJNNOoes=
X-Received: by 2002:a1f:38c2:0:b0:349:9667:9232 with SMTP id
 f185-20020a1f38c2000000b0034996679232mr2035742vka.16.1650645804000; Fri, 22
 Apr 2022 09:43:24 -0700 (PDT)
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
 <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com> <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
In-Reply-To: <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 22 Apr 2022 09:43:07 -0700
Message-ID: <CAAPL-u8VHgobpRTrSf8RgPNz=ZKWsXvkBt0OnjyfDqLPS2V2uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
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

On Fri, Apr 22, 2022 at 4:00 AM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>
> On Fri, Apr 22, 2022 at 02:21:47PM +0800, ying.huang@intel.com wrote:
> > On Thu, 2022-04-21 at 23:13 -0700, Wei Xu wrote:
> > > On Thu, Apr 21, 2022 at 10:40 PM ying.huang@intel.com
> > > <ying.huang@intel.com> wrote:
> > > >
> > > > On Thu, 2022-04-21 at 21:46 -0700, Wei Xu wrote:
> > > > > On Thu, Apr 21, 2022 at 5:58 PM ying.huang@intel.com
> > > > > <ying.huang@intel.com> wrote:
> > > > > >
> > > > > > On Thu, 2022-04-21 at 11:26 -0700, Wei Xu wrote:
> > > > > > > On Thu, Apr 21, 2022 at 12:45 AM ying.huang@intel.com
> > > > > > > <ying.huang@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, 2022-04-21 at 00:29 -0700, Wei Xu wrote:
> > > > > > > > > On Thu, Apr 21, 2022 at 12:08 AM ying.huang@intel.com
> > > > > > > > > <ying.huang@intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, 2022-04-20 at 23:49 -0700, Wei Xu wrote:
> > > > > > > > > > > On Wed, Apr 20, 2022 at 11:24 PM ying.huang@intel.com
> > > > > > > > > > > <ying.huang@intel.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, 2022-04-20 at 22:41 -0700, Wei Xu wrote:
> > > > > > > > > > > > > On Wed, Apr 20, 2022 at 8:12 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Apr 14, 2022 at 12:00 AM ying.huang@intel.com
> > > > > > > > > > > > > > <ying.huang@intel.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > > > > > > > > > > > > > > > Current implementation to find the demotion targets works
> > > > > > > > > > > > > > > > based on node state N_MEMORY, however some systems may have
> > > > > > > > > > > > > > > > dram only memory numa node which are N_MEMORY but not the
> > > > > > > > > > > > > > > > right choices as demotion targets.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This patch series introduces the new node state
> > > > > > > > > > > > > > > > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > > > > > > > > > > > > > > > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > > > > > > > > > > > > > > > is used to hold the list of nodes which can be used as demotion
> > > > > > > > > > > > > > > > targets, support is also added to set the demotion target
> > > > > > > > > > > > > > > > list from user space so that default behavior can be overridden.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It appears that your proposed user space interface cannot solve all
> > > > > > > > > > > > > > > problems.  For example, for system as follows,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> > > > > > > > > > > > > > > node 0,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > available: 3 nodes (0-2)
> > > > > > > > > > > > > > > node 0 cpus: 0 1
> > > > > > > > > > > > > > > node 0 size: n MB
> > > > > > > > > > > > > > > node 0 free: n MB
> > > > > > > > > > > > > > > node 1 cpus:
> > > > > > > > > > > > > > > node 1 size: n MB
> > > > > > > > > > > > > > > node 1 free: n MB
> > > > > > > > > > > > > > > node 2 cpus: 2 3
> > > > > > > > > > > > > > > node 2 size: n MB
> > > > > > > > > > > > > > > node 2 free: n MB
> > > > > > > > > > > > > > > node distances:
> > > > > > > > > > > > > > > node   0   1   2
> > > > > > > > > > > > > > >   0:  10  40  20
> > > > > > > > > > > > > > >   1:  40  10  80
> > > > > > > > > > > > > > >   2:  20  80  10
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Demotion order 1:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > node    demotion_target
> > > > > > > > > > > > > > >  0              1
> > > > > > > > > > > > > > >  1              X
> > > > > > > > > > > > > > >  2              X
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Demotion order 2:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > node    demotion_target
> > > > > > > > > > > > > > >  0              1
> > > > > > > > > > > > > > >  1              X
> > > > > > > > > > > > > > >  2              1
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The demotion order 1 is preferred if we want to reduce cross-socket
> > > > > > > > > > > > > > > traffic.  While the demotion order 2 is preferred if we want to take
> > > > > > > > > > > > > > > full advantage of the slow memory node.  We can take any choice as
> > > > > > > > > > > > > > > automatic-generated order, while make the other choice possible via user
> > > > > > > > > > > > > > > space overridden.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I don't know how to implement this via your proposed user space
> > > > > > > > > > > > > > > interface.  How about the following user space interface?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 1. Add a file "demotion_order_override" in
> > > > > > > > > > > > > > >         /sys/devices/system/node/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 2. When read, "1" is output if the demotion order of the system has been
> > > > > > > > > > > > > > > overridden; "0" is output if not.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 3. When write "1", the demotion order of the system will become the
> > > > > > > > > > > > > > > overridden mode.  When write "0", the demotion order of the system will
> > > > > > > > > > > > > > > become the automatic mode and the demotion order will be re-generated.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 4. Add a file "demotion_targets" for each node in
> > > > > > > > > > > > > > >         /sys/devices/system/node/nodeX/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 5. When read, the demotion targets of nodeX will be output.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 6. When write a node list to the file, the demotion targets of nodeX
> > > > > > > > > > > > > > > will be set to the written nodes.  And the demotion order of the system
> > > > > > > > > > > > > > > will become the overridden mode.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > TBH I don't think having override demotion targets in userspace is
> > > > > > > > > > > > > > quite useful in real life for now (it might become useful in the
> > > > > > > > > > > > > > future, I can't tell). Imagine you manage hundred thousands of
> > > > > > > > > > > > > > machines, which may come from different vendors, have different
> > > > > > > > > > > > > > generations of hardware, have different versions of firmware, it would
> > > > > > > > > > > > > > be a nightmare for the users to configure the demotion targets
> > > > > > > > > > > > > > properly. So it would be great to have the kernel properly configure
> > > > > > > > > > > > > > it *without* intervening from the users.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So we should pick up a proper default policy and stick with that
> > > > > > > > > > > > > > policy unless it doesn't work well for the most workloads. I do
> > > > > > > > > > > > > > understand it is hard to make everyone happy. My proposal is having
> > > > > > > > > > > > > > every node in the fast tier has a demotion target (at least one) if
> > > > > > > > > > > > > > the slow tier exists sounds like a reasonable default policy. I think
> > > > > > > > > > > > > > this is also the current implementation.
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is reasonable.  I agree that with a decent default policy,
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > I agree that a decent default policy is important.  As that was enhanced
> > > > > > > > > > > > in [1/5] of this patchset.
> > > > > > > > > > > >
> > > > > > > > > > > > > the
> > > > > > > > > > > > > overriding of per-node demotion targets can be deferred.  The most
> > > > > > > > > > > > > important problem here is that we should allow the configurations
> > > > > > > > > > > > > where memory-only nodes are not used as demotion targets, which this
> > > > > > > > > > > > > patch set has already addressed.
> > > > > > > > > > > >
> > > > > > > > > > > > Do you mean the user space interface proposed by [3/5] of this patchset?
> > > > > > > > > > >
> > > > > > > > > > > Yes.
> > > > > > > > > > >
> > > > > > > > > > > > IMHO, if we want to add a user space interface, I think that it should
> > > > > > > > > > > > be powerful enough to address all existing issues and some potential
> > > > > > > > > > > > future issues, so that it can be stable.  I don't think it's a good idea
> > > > > > > > > > > > to define a partial user space interface that works only for a specific
> > > > > > > > > > > > use case and cannot be extended for other use cases.
> > > > > > > > > > >
> > > > > > > > > > > I actually think that they can be viewed as two separate problems: one
> > > > > > > > > > > is to define which nodes can be used as demotion targets (this patch
> > > > > > > > > > > set), and the other is how to initialize the per-node demotion path
> > > > > > > > > > > (node_demotion[]).  We don't have to solve both problems at the same
> > > > > > > > > > > time.
> > > > > > > > > > >
> > > > > > > > > > > If we decide to go with a per-node demotion path customization
> > > > > > > > > > > interface to indirectly set N_DEMOTION_TARGETS, I'd prefer that there
> > > > > > > > > > > is a single global control to turn off all demotion targets (for the
> > > > > > > > > > > machines that don't use memory-only nodes for demotion).
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > There's one already.  In commit 20b51af15e01 ("mm/migrate: add sysfs
> > > > > > > > > > interface to enable reclaim migration"), a sysfs interface
> > > > > > > > > >
> > > > > > > > > >         /sys/kernel/mm/numa/demotion_enabled
> > > > > > > > > >
> > > > > > > > > > is added to turn off all demotion targets.
> > > > > > > > >
> > > > > > > > > IIUC, this sysfs interface only turns off demotion-in-reclaim.  It
> > > > > > > > > will be even cleaner if we have an easy way to clear node_demotion[]
> > > > > > > > > and N_DEMOTION_TARGETS so that the userspace (post-boot agent, not
> > > > > > > > > init scripts) can know that the machine doesn't even have memory
> > > > > > > > > tiering hardware enabled.
> > > > > > > > >
> > > > > > > >
> > > > > > > > What is the difference?  Now we have no interface to show demotion
> > > > > > > > targets of a node.  That is in-kernel only.  What is memory tiering
> > > > > > > > hardware?  The Optane PMEM?  Some information for it is available via
> > > > > > > > ACPI HMAT table.
> > > > > > > >
> > > > > > > > Except demotion-in-reclaim, what else do you care about?
> > > > > > >
> > > > > > > There is a difference: one is to indicate the availability of the
> > > > > > > memory tiering hardware and the other is to indicate whether
> > > > > > > transparent kernel-driven demotion from the reclaim path is activated.
> > > > > > > With /sys/devices/system/node/demote_targets or the per-node demotion
> > > > > > > target interface, the userspace can figure out the memory tiering
> > > > > > > topology abstracted by the kernel.  It is possible to use
> > > > > > > application-guided demotion without having to enable reclaim-based
> > > > > > > demotion in the kernel.  Logically it is also cleaner to me to
> > > > > > > decouple the tiering node representation from the actual demotion
> > > > > > > mechanism enablement.
> > > > > >
> > > > > > I am confused here.  It appears that you need a way to expose the
> > > > > > automatic generated demotion order from kernel to user space interface.
> > > > > > We can talk about that if you really need it.
> > > > > >
> > > > > > But [2-5/5] of this patchset is to override the automatic generated
> > > > > > demotion order from user space to kernel interface.
> > > > >
> > > > > As a side effect of allowing user space to override the default set of
> > > > > demotion target nodes, it also provides a sysfs interface to allow
> > > > > userspace to read which nodes are currently being designated as
> > > > > demotion targets.
> > > > >
> > > > > The initialization of demotion targets is expected to complete during
> > > > > boot (either by kernel or via an init script).  After that, the
> > > > > userspace processes (e.g. proactive tiering daemon or tiering-aware
> > > > > applications) can query this sysfs interface to know if there are any
> > > > > tiering nodes present and act accordingly.
> > > > >
> > > > > It would be even better to expose the per-node demotion order
> > > > > (node_demotion[]) via the sysfs interface (e.g.
> > > > > /sys/devices/system/node/nodeX/demotion_targets as you have
> > > > > suggested). It can be read-only until there are good use cases to
> > > > > require overriding the per-node demotion order.
> > > >
> > > > I am OK to expose the system demotion order to user space.  For example,
> > > > via /sys/devices/system/node/nodeX/demotion_targets, but read-only.
> > >
> > > Sounds good. We can send out a patch for such a read-only interface.
> > >
> > > > But if we want to add functionality to override system demotion order,
> > > > we need to consider the user space interface carefully, at least after
> > > > collecting all requirement so far.  I don't think the interface proposed
> > > > in [2-5/5] of this patchset is sufficient or extensible enough.
> > >
> > > The current proposed interface should be sufficient to override which
> > > nodes can serve as demotion targets.  I agree that it is not
> > > sufficient if userspace wants to redefine the per-node demotion
> > > targets and a suitable user space interface for that purpose needs to
> > > be designed carefully.
> > >
> >
> > IMHO, it's better to define both together.  That is, collect all
> > requirement, and design it carefully, keeping extensible in mind.  If
> > it's not the good timing yet, we can defer it to collect more
> > requirement.  That's not urgent even for authors' system, because they
> > can just don't enable demotion-in-reclaim.
> >
> > Best Regards,
> > Huang, Ying
>
> I think it is necessary to either have per node demotion targets
> configuration or the user space interface supported by this patch
> series. As we don't have clear consensus on how the user interface
> should look like, we can defer the per node demotion target set
> interface to future until the real need arises.
>
> Current patch series sets N_DEMOTION_TARGET from dax device kmem
> driver, it may be possible that some memory node desired as demotion
> target is not detected in the system from dax-device kmem probe path.
>
> It is also possible that some of the dax-devices are not preferred as
> demotion target e.g. HBM, for such devices, node shouldn't be set to
> N_DEMOTION_TARGETS. In future, Support should be added to distinguish
> such dax-devices and not mark them as N_DEMOTION_TARGETS from the
> kernel, but for now this user space interface will be useful to avoid
> such devices as demotion targets.
>
> We can add read only interface to view per node demotion targets
> from /sys/devices/system/node/nodeX/demotion_targets, remove
> duplicated /sys/kernel/mm/numa/demotion_target interface and instead
> make /sys/devices/system/node/demotion_targets writable.
>
> Huang, Wei, Yang,
> What do you suggest?

This sounds good to me.

I don't know a clear use case where we want to set per-node demotion
order from the userspace.  In the long term, in my view, it would be
better that per-node demotion order is still only initialized by the
kernel, just like the allocation zonelist, but with the help of more
hardware information (e.g. HMAT) when available.  Userspace can still
control which nodes can be used for demotion on a process/cgroup
through the typical NUMA interfaces (e.g. mbind, cpuset.mems).

Wei
