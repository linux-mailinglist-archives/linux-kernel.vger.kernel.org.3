Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C85246D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350943AbiELHXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350927AbiELHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:22:48 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0012C662
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:22:45 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y74so4284143vsy.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+47ZJ5j0kmxI/lG0OiobIxpstGwfhpvNpvMEZldSxdk=;
        b=MuT9tsxoUEIIaxiykQc0WLAgcqyuwhOycLY1xIEQd7ISyb9br2bf1LLu+S4UYj8lj3
         8m8ze6NTZqKhc0v5SyIPcQuA1R4qBoZA8Q6lAtk8HXB52Dd5KPqt+Ds+6dH7RyNc3TYi
         4AgMOAq57JN+k1UxDq7cpOQpSH1gnBZ0NE0rApDav0VPZa8lkVnuA+LUVltiiB7L5/LT
         g+vwuxnOgeYHHjNqvZPl+cxcTVHhC6k5l3263yTd4OfbT2B8/zHLPCZKdpEIT8k65Rzx
         nC4cty7D55MnVNslHa/C0HTGsyrzh8pMo1+YsLZSQVkxb3aQMO1mdX3GOhlYcRB2+GJC
         6Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+47ZJ5j0kmxI/lG0OiobIxpstGwfhpvNpvMEZldSxdk=;
        b=xDxCkgYxdMjkxFR89tUwYS2kUM0BJWYMPxY5CL/FKgXAr5J6v5qO/X5qDuBhEbB/B+
         BcngjraXFumFPE8AV20z0Di2cGESliNdkdf8TfdLtaA180NnSotASzNgULIpTqUtXAXg
         ve8L7cIJYSrhFlascy+8ItygxeBqJ7232lPEk5N7eByFk3z7/tBkrvG5bqm1YZBUCHq7
         r/PPzib8GcW4xAvniMCQevc+7q0ksCFupnvuTuZzixRTWrkeOqKcY3yUSlqxdSY7CwdM
         w50ERFrrPX+wlp74ED4Btwur5eEGn9l5mlfmWsaxEjN07w0auC4bTHdfLxq7bRZBZRq1
         WlEA==
X-Gm-Message-State: AOAM5326BPIWzC08SEMyh+uPPljSTKYIqTpkJGNi9Vk/wgQLsLkFiNop
        XdhoIIUjSQ+KXqdhQ5A3Kw44eQuWzTBHui6NA6c4xA==
X-Google-Smtp-Source: ABdhPJwj+V7aWJeyepm6+7W6e91Vry5hHYf2VwL3c0cxba/jMCnceW+EJTNcdKzywIzqMHQW1UknFgcv8buvE+BKFGE=
X-Received: by 2002:a67:2fc6:0:b0:32d:7195:32e9 with SMTP id
 v189-20020a672fc6000000b0032d719532e9mr15747916vsv.44.1652340164357; Thu, 12
 May 2022 00:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com> <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
In-Reply-To: <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 12 May 2022 00:22:33 -0700
Message-ID: <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Thu, May 12, 2022 at 12:12 AM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
> > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> >> Sysfs Interfaces
> >> ================
> >>
> >> * /sys/devices/system/memtier/memtierN/nodelist
> >>
> >>    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> >>
> >>    Format: node_list
> >>
> >>    Read-only.  When read, list the memory nodes in the specified tier.
> >>
> >>    Tier 0 is the highest tier, while tier 2 is the lowest tier.
> >>
> >>    The absolute value of a tier id number has no specific meaning.
> >>    What matters is the relative order of the tier id numbers.
> >>
> >>    When a memory tier has no nodes, the kernel can hide its memtier
> >>    sysfs files.
> >>
> >> * /sys/devices/system/node/nodeN/memtier
> >>
> >>    where N = 0, 1, ...
> >>
> >>    Format: int or empty
> >>
> >>    When read, list the memory tier that the node belongs to.  Its value
> >>    is empty for a CPU-only NUMA node.
> >>
> >>    When written, the kernel moves the node into the specified memory
> >>    tier if the move is allowed.  The tier assignment of all other nodes
> >>    are not affected.
> >>
> >>    Initially, we can make this interface read-only.
> >
> > It seems that "/sys/devices/system/node/nodeN/memtier" has all
> > information we needed.  Do we really need
> > "/sys/devices/system/memtier/memtierN/nodelist"?
> >
> > That can be gotten via a simple shell command line,
> >
> > $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
> >
>
> It will be really useful to fetch the memory tier node list in an easy
> fashion rather than reading multiple sysfs directories. If we don't have
> other attributes for memorytier, we could keep
> "/sys/devices/system/memtier/memtierN" a NUMA node list there by
> avoiding /sys/devices/system/memtier/memtierN/nodelist
>
> -aneesh

It is harder to implement memtierN as just a file and doesn't follow
the existing sysfs pattern, either.  Besides, it is extensible to have
memtierN as a directory.
