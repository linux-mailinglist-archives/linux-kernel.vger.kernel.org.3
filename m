Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021D5242D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbiELCkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiELCkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:40:10 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4F414A26B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:40:09 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id c62so3818162vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icP3jC/Does4tQzHYeuiCy0okbheqMveXjX7Z4CT0cw=;
        b=lQo4963bAuTCG1edasgDsyALQjI1RF+agQ4noIHWIXW296r2FUjxbmatSSj4n8P0P9
         rSV9O+t0gNeQRz1TVaxUi6zyl/Uk46S+Lo8broeWtewKbT8HVr+HNSOi5N7C5m9BHCf2
         uAMX3//qj4YyC4De90kQKXPTdPyV+HXZCYPIen8eLd2TphEVpRPVRxUu4GZ0d5OWRgB0
         rspDTXSPqEjll3TrYTzKinD8IBroB/h5lk4fC4KIuPGB64PCfv4y10J7tueRIq/YL3n2
         QJj9/eSBNhimU2mO1F2KpMHLkBs+hlrAFFFDmlkmeccQEfPCldeOsE67TOoK55T1kOz5
         RZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icP3jC/Does4tQzHYeuiCy0okbheqMveXjX7Z4CT0cw=;
        b=m1z0DG063Y8z8ZSe0K+hifXfBav8YMqT7obFLELpxjZgpjN1WEYm8XeFovI8bjKjgx
         qDcU5yt6xXy1YsSwDTKJs1RDtRa+/XIVjmuzL7QE33YovUztRbjImCOd04LRa/Vq/bE6
         DkPvGtG6FWGXg4HKC8HcZPSjZO2N2yfp+kXkXg+/c7WMledFbf8Fftuoob0TKoCxJCAJ
         A63HiP2djGSlg/8/mA25b1RcZOzuptYrAOTY9B15nwDQ3/F034SBukKyV/smS+pmyjYk
         +jY57AjziZw4+HqwvbPO4LoPc6Bbsp9ZTQSrNSK7cMj17WXgXtBRhFY8VXq4WkLd8kYd
         q+DQ==
X-Gm-Message-State: AOAM531ZVa+tZzP+yPEl3nY6LurjLO2tT56TfuXIuQtxUVKBufuGR0Yk
        5TakHynCNQBKCogk1sqFvjFpCxd2KlrzvNekhNCB6CEXyKaqKA==
X-Google-Smtp-Source: ABdhPJzMMxklEwnbtmN2Kn7Nv8S0udxitVkmN6mv/qL26sf344JS7sNKtIk7DyZ5PiCsYP7gKzptjrOHJ0wFsO4nJb8=
X-Received: by 2002:a67:f343:0:b0:32c:c4b7:e238 with SMTP id
 p3-20020a67f343000000b0032cc4b7e238mr14251828vsm.77.1652323208198; Wed, 11
 May 2022 19:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <87tua3h5r1.fsf@nvdebian.thelocal> <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
 <875ymerl81.fsf@nvdebian.thelocal> <87fslhhb2l.fsf@linux.ibm.com>
 <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
 <68333b21a58604f3fd0e660f1a39921ae22849d8.camel@intel.com>
 <CAAPL-u80BFYTKK=0HRBXOeDTULyPOtbgu5V3fEYDOczTMxgJ1g@mail.gmail.com> <0a92d0040edb3b74ac259062d241b8cd28924edf.camel@intel.com>
In-Reply-To: <0a92d0040edb3b74ac259062d241b8cd28924edf.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 11 May 2022 19:39:56 -0700
Message-ID: <CAAPL-u_40Zxe2AtYbOedDXPBfDPDCqi-OS=yYXf2FcZQS-6v4g@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Wed, May 11, 2022 at 6:42 PM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Wed, 2022-05-11 at 10:07 -0700, Wei Xu wrote:
> > On Wed, May 11, 2022 at 12:49 AM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> > >
> > > On Tue, 2022-05-10 at 22:30 -0700, Wei Xu wrote:
> > > > On Tue, May 10, 2022 at 4:38 AM Aneesh Kumar K.V
> > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > >
> > > > > Alistair Popple <apopple@nvidia.com> writes:
> > > > >
> > > > > > Wei Xu <weixugc@google.com> writes:
> > > > > >
> > > > > > > On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
> > > > > > > >
> > > > > > > > Wei Xu <weixugc@google.com> writes:
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Tiering Hierarchy Initialization
> > > > > > > > > > > `=============================='
> > > > > > > > > > >
> > > > > > > > > > > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> > > > > > > > > > >
> > > > > > > > > > > A device driver can remove its memory nodes from the top tier, e.g.
> > > > > > > > > > > a dax driver can remove PMEM nodes from the top tier.
> > > > > > > > > >
> > > > > > > > > > With the topology built by firmware we should not need this.
> > > > > > > >
> > > > > > > > I agree that in an ideal world the hierarchy should be built by firmware based
> > > > > > > > on something like the HMAT. But I also think being able to override this will be
> > > > > > > > useful in getting there. Therefore a way of overriding the generated hierarchy
> > > > > > > > would be good, either via sysfs or kernel boot parameter if we don't want to
> > > > > > > > commit to a particular user interface now.
> > > > > > > >
> > > > > > > > However I'm less sure letting device-drivers override this is a good idea. How
> > > > > > > > for example would a GPU driver make sure it's node is in the top tier? By moving
> > > > > > > > every node that the driver does not know about out of N_TOPTIER_MEMORY? That
> > > > > > > > could get messy if say there were two drivers both of which wanted their node to
> > > > > > > > be in the top tier.
> > > > > > >
> > > > > > > The suggestion is to allow a device driver to opt out its memory
> > > > > > > devices from the top-tier, not the other way around.
> > > > > >
> > > > > > So how would demotion work in the case of accelerators then? In that
> > > > > > case we would want GPU memory to demote to DRAM, but that won't happen
> > > > > > if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
> > > > > > only override available with this proposal would move GPU memory into a
> > > > > > lower tier, which is the opposite of what's needed there.
> > > > >
> > > > > How about we do 3 tiers now. dax kmem devices can be registered to
> > > > > tier 3. By default all numa nodes can be registered at tier 2 and HBM or
> > > > > GPU can be enabled to register at tier 1. ?
> > > >
> > > > This makes sense.  I will send an updated RFC based on the discussions so far.
> > >
> > > Are these tier number fixed?  If so, it appears strange that the
> > > smallest tier number is 0 on some machines, but 1 on some other
> > > machines.
> >
> > When the kernel is configured to allow 3 tiers, we can always show all
> > the 3 tiers. It is just that some tiers (e.g. tier 0) may be empty on
> > some machines.
>
> I still think that it's better to have no empty tiers for auto-generated
> memory tiers by kernel.  Yes, the tier number will be not absolutely
> stable, but that only happens during system bootup in practice, so it's
> not a big issue IMHO.

It should not be hard to hide empty tiers (e.g. tier-0) if we prefer.
But even if tier-0 is empty, we should still keep this tier in the
kernel and not move DRAM nodes into this tier.  One reason is that a
HBM node might be hot-added into tier-0 at a later time.

> And, I still think it's better to make only N-1 tiers writable for
> totally N tiers (or even readable).  Considering "tier0" is written, how
> to deal with nodes in "tier0" before but not after writing?  One
> possible way is to put them into "tierN".  And during a user customize
> the tiers, the union of "N tiers" may be not complete.

The sysfs interfaces that I have in mind now are:

* /sys/devices/system/memtier/memtierN/nodelist (N=0, 1, 2)

This is read-only to list the memory nodes for a specific tier.

* /sys/devices/system/node/nodeN/memtier. (N=0, 1, ...,)

This is a read-write interface. When written, the kernel moves the
node into the user-specified tier.  No other nodes are affected.

This interface should be able to avoid the above issue.

> > BTW, the userspace should not assume a specific meaning of a
> > particular tier id because it can change depending on the number of
> > tiers that the kernel is configured with.  For example, the userspace
> > should not assume that tier-2 always means PMEM nodes.  In a system
> > with 4 tiers, PMEM nodes may be in tier-3, not tier-2.
>
> Yes.  This sounds good.
>
> Best Regards,
> Huang, Ying
>
