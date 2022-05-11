Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CA523B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbiEKRHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiEKRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:07:19 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792382AC5E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:07:18 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c62so2637566vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPjT4Tguvue9a0veAerAix8NTcDtIksBUNaqTLtFpVY=;
        b=oxIxs731TckUq39OFqmh2ZtrR6f8sLVnMrH18gQRtD6lH2xniXwZqEBcvirowpPT7d
         a4x7dACQZsVurhabC77aNfJYHlYNWiwSdacEph6jwylnQ/D/zi0vu+ruzbjx1Fy3Ba8K
         PNccUNTcP/Dc6LLMaRs1Xq87UhYHnt7WjycpTHB8EECy1zTo1fTqvbCMGN/86vK7Ws0d
         QE3J+hwb9IszsXRf0INIKjPqY8PdPOSPSlffenAEgYETCUqlqjhJMLOOonyZNn2n3877
         kqgrAn87aa0PkNl0o1pcUg86V7xx1LL1PUSYkWq9wKIBEAR7MWU1J02p4/OLmx2kngx/
         9yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPjT4Tguvue9a0veAerAix8NTcDtIksBUNaqTLtFpVY=;
        b=qoBBI60RcLtRZqyhe3ob42Gazc0213MAanrwASqlYKTaeH8LGzjp/3LMWAcKNL3v5Q
         KjoNP2jj1ahM4PN1eC5YuSwLSLWMtLkiFLa7ZnF59aVDVZRRrHleZrMP4k9CibbF+Xui
         e0KI+v+hGQwxHtxpxrGV0WjxzrvxNPSv/dXCZYPsrW7MBjJTKPL0l0Csd2mGqO96wjPF
         L3ANkwImEDyp7/D4xzjMSbRnvzNIDovLJ+KXeyc7WOXn2Zmb1DXlDCeOAMEh0iHC87C0
         OGVkGNCg7DOIwx463Jxex8+tG+7NJLuuLkjSGrAszfZ3ZnyTp3tiCO9gdY94+pYSsTWl
         Ephg==
X-Gm-Message-State: AOAM531IpXlwEuIpRIy7+bQDFEUHvvCZ7ReueHguJoufNPI8LFSwx+UA
        5jjGt7IJzbvIl/5Bvt6KCD9MmbtP13ahoTIu/RGonHMmekr+2w==
X-Google-Smtp-Source: ABdhPJw7/UQbmPRX/v1nQHdA2Ljp9qeqEevxnUd5JK3u+Rv8Kd8WJ8JVe2T3su6fZVja5UUUE8F4tLMIDm9wdTwYsMM=
X-Received: by 2002:a05:6102:3ecf:b0:320:7c27:5539 with SMTP id
 n15-20020a0561023ecf00b003207c275539mr15026770vsv.59.1652288836875; Wed, 11
 May 2022 10:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <87tua3h5r1.fsf@nvdebian.thelocal> <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
 <875ymerl81.fsf@nvdebian.thelocal> <87fslhhb2l.fsf@linux.ibm.com>
 <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com> <68333b21a58604f3fd0e660f1a39921ae22849d8.camel@intel.com>
In-Reply-To: <68333b21a58604f3fd0e660f1a39921ae22849d8.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 11 May 2022 10:07:05 -0700
Message-ID: <CAAPL-u80BFYTKK=0HRBXOeDTULyPOtbgu5V3fEYDOczTMxgJ1g@mail.gmail.com>
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

On Wed, May 11, 2022 at 12:49 AM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Tue, 2022-05-10 at 22:30 -0700, Wei Xu wrote:
> > On Tue, May 10, 2022 at 4:38 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > Alistair Popple <apopple@nvidia.com> writes:
> > >
> > > > Wei Xu <weixugc@google.com> writes:
> > > >
> > > > > On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
> > > > > >
> > > > > > Wei Xu <weixugc@google.com> writes:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Tiering Hierarchy Initialization
> > > > > > > > > `=============================='
> > > > > > > > >
> > > > > > > > > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> > > > > > > > >
> > > > > > > > > A device driver can remove its memory nodes from the top tier, e.g.
> > > > > > > > > a dax driver can remove PMEM nodes from the top tier.
> > > > > > > >
> > > > > > > > With the topology built by firmware we should not need this.
> > > > > >
> > > > > > I agree that in an ideal world the hierarchy should be built by firmware based
> > > > > > on something like the HMAT. But I also think being able to override this will be
> > > > > > useful in getting there. Therefore a way of overriding the generated hierarchy
> > > > > > would be good, either via sysfs or kernel boot parameter if we don't want to
> > > > > > commit to a particular user interface now.
> > > > > >
> > > > > > However I'm less sure letting device-drivers override this is a good idea. How
> > > > > > for example would a GPU driver make sure it's node is in the top tier? By moving
> > > > > > every node that the driver does not know about out of N_TOPTIER_MEMORY? That
> > > > > > could get messy if say there were two drivers both of which wanted their node to
> > > > > > be in the top tier.
> > > > >
> > > > > The suggestion is to allow a device driver to opt out its memory
> > > > > devices from the top-tier, not the other way around.
> > > >
> > > > So how would demotion work in the case of accelerators then? In that
> > > > case we would want GPU memory to demote to DRAM, but that won't happen
> > > > if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
> > > > only override available with this proposal would move GPU memory into a
> > > > lower tier, which is the opposite of what's needed there.
> > >
> > > How about we do 3 tiers now. dax kmem devices can be registered to
> > > tier 3. By default all numa nodes can be registered at tier 2 and HBM or
> > > GPU can be enabled to register at tier 1. ?
> >
> > This makes sense.  I will send an updated RFC based on the discussions so far.
>
> Are these tier number fixed?  If so, it appears strange that the
> smallest tier number is 0 on some machines, but 1 on some other
> machines.

When the kernel is configured to allow 3 tiers, we can always show all
the 3 tiers. It is just that some tiers (e.g. tier 0) may be empty on
some machines.

BTW, the userspace should not assume a specific meaning of a
particular tier id because it can change depending on the number of
tiers that the kernel is configured with.  For example, the userspace
should not assume that tier-2 always means PMEM nodes.  In a system
with 4 tiers, PMEM nodes may be in tier-3, not tier-2.

> Best Regards,
> Huang, Ying
>
>
