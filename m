Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B01C534069
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbiEYPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiEYPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:32:49 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC93A473
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:32:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id w10so19271062vsa.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6fNtaXrpXPdwdoGVh0BHVRTyE3sTb/7nc/NM05nCe0=;
        b=oQsvSC8oEHuqSFLW0whM02wczKQrPEEyRwIDRWwKX2XQlCFjJgF1jeOh3dWrRdAhxz
         5QNtkOQPmwuEEU4WUXD6nT8XpGKYuGjk+lxGtK+D+45zA4+MJqiez/ARh+JvFvf3/sqO
         X7qsNSRhDYk71RwEdVZunX92MESwEbYDHgHjBUDmVlq4/jQkfMvHEJltFjx15HUWOQms
         nyHD80H+FKu+bcFqd4WGgRowmWb4MrB7vtNFuMp0w0xQq85Xx6egFuyCJ768m8KyqjiQ
         pm+TrxzQWv5tK1z/uLYkU9kG7wE2Ikibo0FMRjl1dDZJpmBpvnyW6ZNniXd3QO+RQfa1
         UJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6fNtaXrpXPdwdoGVh0BHVRTyE3sTb/7nc/NM05nCe0=;
        b=z7DHS8gma3niPK1kji6KhRJtZUHLVjujbIW/QiiF5l6sMHcVARK52zi4o58zhvNSUz
         lvs0t1ePWyj3jTfRvZmFNMI2BUFt0h2tsXRk5HI09lt8Oo8gJjhor5i3rug0yjRXasVJ
         cYzVTSNHQAVuS2U6tppsUoLNfCAuh3UZFYvPWyZhRl9Q0NHi4D2n/pVRF2eM4JVKNgMB
         CcUi2JgWUVaa3IxYsRfkOUSvF6bGu9cr1kQc7KDCyavjVhrYN1WN5HSc7CqPYZ3JVfls
         Lqle4fnG+EETvzMQOYquJfCUXVRRYzxgE3oPL8tGImxxiQI2RNE3T5A2B12TRR6Rb9IL
         mH/g==
X-Gm-Message-State: AOAM531EXRpzNSQzotvLC/nJqJb6IsxNlQZ7TeivUW4YWbUBYHITShqi
        9eR3qltFin5qiUoYipEu0sd8hbpPLII5U/l297D3Vg==
X-Google-Smtp-Source: ABdhPJxDq3R3pD+aS09hMGojTfBgBObu+GY+RmXYJHjBNu/MchSvwaaOQN5cX9hIB9bfhPbd9+MIazpOvNFY2jmTTb0=
X-Received: by 2002:a67:ed88:0:b0:328:27d9:1381 with SMTP id
 d8-20020a67ed88000000b0032827d91381mr13563848vsp.12.1653492764752; Wed, 25
 May 2022 08:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com> <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <20220518130037.00001cce@Huawei.com> <CAAPL-u_c+q_uCMJXOtYGg42Fj2gSnD6c8vgYQmi1iVpRwHiQTw@mail.gmail.com>
 <8735gzdpsx.fsf@linux.ibm.com> <CAAPL-u_ZtCsuNNu2SoqCeqQqrGQxjcsjrbu0ooP3y5Zw802daA@mail.gmail.com>
 <87h75ef3y5.fsf@nvdebian.thelocal> <20220525124847.00007a16@Huawei.com>
In-Reply-To: <20220525124847.00007a16@Huawei.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 25 May 2022 08:32:33 -0700
Message-ID: <CAAPL-u9g-yhHEO++tyWChxh4LMEkKnhWuauXT7YqsWM_vjRTGg@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
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

On Wed, May 25, 2022 at 4:48 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 25 May 2022 17:47:33 +1000
> Alistair Popple <apopple@nvidia.com> wrote:
>
> > Wei Xu <weixugc@google.com> writes:
> >
> > > On Tue, May 24, 2022 at 6:27 AM Aneesh Kumar K.V
> > > <aneesh.kumar@linux.ibm.com> wrote:
> > >>
> > >> Wei Xu <weixugc@google.com> writes:
> > >>
> > >> > On Wed, May 18, 2022 at 5:00 AM Jonathan Cameron
> > >> > <Jonathan.Cameron@huawei.com> wrote:
> > >> >>
> > >> >> On Wed, 18 May 2022 00:09:48 -0700
> > >> >> Wei Xu <weixugc@google.com> wrote:
> > >>
> > >> ...
> > >>
> > >> > Nice :)
> > >> >>
> > >> >> Initially I thought this was over complicated when compared to just leaving space, but
> > >> >> after a chat with Hesham just now you have us both convinced that this is an elegant solution.
> > >> >>
> > >> >> Few corners probably need fleshing out:
> > >> >> *  Use of an allocator for new tiers. Flat number at startup, or new one on write of unique
> > >> >>    value to set_memtier perhaps?  Also whether to allow drivers to allocate (I think
> > >> >>    we should).
> > >> >> *  Multiple tiers with same rank.  My assumption is from demotion path point of view you
> > >> >>    fuse them (treat them as if they were a single tier), but keep them expressed
> > >> >>    separately in the sysfs interface so that the rank can be changed independently.
> > >> >> *  Some guidance on what values make sense for given rank default that might be set by
> > >> >>    a driver. If we have multiple GPU vendors, and someone mixes them in a system we
> > >> >>    probably don't want the default values they use to result in demotion between them.
> > >> >>    This might well be a guidance DOC or appropriate set of #define
> > >> >
> > >> > All of these are good ideas, though I am afraid that these can make
> > >> > tier management too complex for what it's worth.
> > >> >
> > >> > How about an alternative tier numbering scheme that uses major.minor
> > >> > device IDs?  For simplicity, we can just start with 3 major tiers.
> > >> > New tiers can be inserted in-between using minor tier IDs.
> > >>
> > >>
> > >> What drives the creation of a new memory tier here?  Jonathan was
> > >> suggesting we could do something similar to writing to set_memtier for
> > >> creating a new memory tier.
> > >>
> > >> $ echo "memtier128" > sys/devices/system/node/node1/set_memtier
> > >>
> > >> But I am wondering whether we should implement that now. If we keep
> > >> "rank" concept and detach tier index (memtier0 is the memory tier with
> > >> index 0) separate from rank, I assume we have enough flexibility for a
> > >> future extension that will allow us to create a memory tier from userspace
> > >> and assigning it a rank value that helps the device to be placed before or
> > >> after DRAM in demotion order.
> > >>
> > >> ie, For now we will only have memtier0, memtier1, memtier2. We won't add
> > >> dynamic creation of memory tiers and the above memory tiers will have
> > >> rank value 0, 1, 2 according with demotion order 0 -> 1 -> 2.
> > >
> > > Great. So the consensus is to go with the "rank" approach.  The above
> > > sounds good to me as a starting point.
> >
> > The rank approach seems good to me too.
>
> Rank is good, but I do slightly worry about accidentally defining ABI
> that people care about with the particular numbers used for the initial ranks.
>
> Maybe just x100 on all of them to allow things in between with no change to
> this initial set of 3?  So 0, 100, 200

I strongly support this, which is also my original intention for rank
values. I'd suggest to even remove 0 to avoid it becoming a special
value that userspace depends on.

> Jonathan
>
> >
> >  - Alistair
> >
> > >> -aneesh
>
