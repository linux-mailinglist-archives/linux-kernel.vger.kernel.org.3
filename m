Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ADD53422B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiEYR16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiEYR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:27:55 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A4344FE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:27:54 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id z25so436214uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zijcLucoahr/KM0XRPqCphI5ViCGOh6UFjc4PGTwq4Y=;
        b=gtdQv6bn8yOWe1FGW+kl87jckZbV4SJiVYvJ7mCXXXw0tm7rAKODCYottupNSWmXiU
         qKn30BjsCkVht5P7kz0a3OAIspZH1Nq6VG8TdN0iHAviS6ypYMwtc+j90L7HmtM0BNVr
         rB8nivjIMbgLXXJos3NsWu+H8lCfb6NHvDtFEP1jlbS2YJzxHS2T5DLGIZxZJ9dGDqwg
         /r2fvwfqtpIQ1dkDhnGEVj9YixHnbScGUvk9jLw31f37Qkzc2McZ8XTjrY6H40P0N1bX
         TnkO08Q0ZIpnF+YThhPHk22XpCxFu6nFAbFfUXl4UVIx5lGg4zMwBuMScNiCUEKa1/VJ
         67Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zijcLucoahr/KM0XRPqCphI5ViCGOh6UFjc4PGTwq4Y=;
        b=s6mta1HTeMX/be66WFSkbcG0iqvp50O5r/+L2Ed/873WJhdUELMwVIUM+GCMhIhcYx
         sbcWtN2D7VxhsCMPl3y9i3vuQksxXhToRia8RLU2Vdlg2jFk5yowDa4tfVV9mr4I01FA
         5TSID7JsNDzU3Dw9ejjtzXZSRscRMVzm9CO7BpB/4ijdE10er2XLz8LquSUBEiYs+Gt2
         k0zuGmRhbs7T59nGWpLvdBxax+1Twr2tNmpcNsLXHUFL4O70Nz7aeKTHYKdFlSjMwu99
         PULFqhR+1mJg0IjJ1gggra2eYGFcyVemGr2eh5OO09pbZJGMrkfbQC9pO0TGCnpZ0Kh2
         lE2Q==
X-Gm-Message-State: AOAM531pPdPQhFS4zQOLhfbDqWXLvMiRYwroMqzN6yVFlEz33acdf5E8
        1NnCMJGdX+A5gXupal+lZo159ohM13o4gIl+OsHSZg==
X-Google-Smtp-Source: ABdhPJy1+s4Gu1zZChXpIjTnE0q75s/SccD4qDFE/02Lgz1c0LK6Jt4wQeM+E5FqKMWp2YAHrA1xU1yAInoYQCLNLBo=
X-Received: by 2002:ab0:e14:0:b0:360:e13:e5d7 with SMTP id g20-20020ab00e14000000b003600e13e5d7mr11614478uak.95.1653499673748;
 Wed, 25 May 2022 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com> <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <6b7c472b50049592cde912f04ca47c696caa2227.camel@intel.com>
 <CAAPL-u-NAJkSXHzQr8OtEEGnnUrsCE9US6c5S5Rv0xutASxv1Q@mail.gmail.com>
 <ad1bc96a86b21b8f46d356f0c0b7449be38b2220.camel@intel.com>
 <CAAPL-u8XzJnrew4vuFq7GgwgjjBff8MwRFGTDmUc9DOwa+q=FA@mail.gmail.com>
 <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com> <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
In-Reply-To: <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 25 May 2022 10:27:42 -0700
Message-ID: <CAAPL-u-3-iOoSK07TE=gUN8a+TsXNNEiFaEArf7+zvTgxDJnRQ@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Ying Huang <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Wed, May 25, 2022 at 3:01 AM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/25/22 2:33 PM, Ying Huang wrote:
> > On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:
> >> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wrote:
> >>>
> >>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:
> >>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com> wrote:
> >>>>>
>
> ...
>
> >
> > OK.  Just to confirm.  Does this mean that we will have fixed device ID,
> > for example,
> >
> > GPU                   memtier255
> > DRAM (with CPU)               memtier0
> > PMEM                  memtier1
> >
> > When we add a new memtier, it can be memtier254, or memter2?  The rank
> > value will determine the real demotion order.
> >
> > I think you may need to send v3 to make sure everyone is at the same
> > page.
> >
>
> What we have implemented which we will send as RFC shortly is below.
>
> cd /sys/dekvaneesh@ubuntu-guest:~$ cd /sys/devices/system/
> kvaneesh@ubuntu-guest:/sys/devices/system$ pwd
> /sys/devices/system
> kvaneesh@ubuntu-guest:/sys/devices/system$ ls
> clockevents  clocksource  container  cpu  edac  memory  memtier  mpic
> node  power
> kvaneesh@ubuntu-guest:/sys/devices/system$ cd memtier/
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ pwd
> /sys/devices/system/memtier
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ ls
> default_rank  max_rank  memtier1  power  uevent
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat default_rank
> 1
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat max_rank
> 3

For flexibility, we don't want max_rank to be interpreted as the
number of memory tiers.  Also, we want to leave spaces in rank values
to allow new memtiers to be inserted when needed.  So I'd suggest to
make max_rank a much larger value (e.g. 255).

> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
> nodelist  power  rank  subsystem  uevent
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelist
> 0-3
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat rank
> 1
> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cd
> ../../node/node1/
> kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$ cat memtier
> 1
> kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$
> root@ubuntu-guest:/sys/devices/system/node/node1# echo 0 > memtier
> root@ubuntu-guest:/sys/devices/system/node/node1# cat memtier
> 0
> root@ubuntu-guest:/sys/devices/system/node/node1# cd ../../memtier/
> root@ubuntu-guest:/sys/devices/system/memtier# ls
> default_rank  max_rank  memtier0  memtier1  power  uevent
> root@ubuntu-guest:/sys/devices/system/memtier# cd memtier0/
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat nodelist
> 1
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat rank
> 0

It looks like the example here demonstrates the dynamic creation of
memtier0.  If so, how is the rank of memtier0 determined?  If we want
to support creating new memtiers at runtime, I think an explicit
interface that specifies both device ID and rank is preferred to avoid
implicit dependencies between device IDs and ranks.

> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# echo 4 > rank
> bash: rank: Permission denied
> root@ubuntu-guest:/sys/devices/system/memtier/memtier0#
