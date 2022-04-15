Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B875033CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356469AbiDOX1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiDOX07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:26:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C22708
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:24:27 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eafabbc80aso94884137b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cxt2uEcbDsT/cVcss+Oed++7USVk9BRG70PSqUV2sRA=;
        b=o9JWs2FyVHQ7Re6QVoMehMOzM6wRTq38a1AwTqjPdmACMonccCQgZUIu3hGbqNbJGx
         wG6Ywd7yrWJXfrT0+MC5+2bGIlqnVT5IHEfmuOTHvVf3hLqCXV4HwsD4O6rPbjnXUjRR
         85H1+co/bpMt/xuuPrqSMl4Vq6wIMi0oV2WPxV0DWonzWkDVQwCV1gB3W7mm1pQVkmVS
         6wLhUCv9gVewt3r87ikTO6Kik6eHhGJ8GRUds3XTucwSHGoDk4tmpVJCdHvpEF3etP0m
         ZHTzPxj9tBWm+We0AMjhwDY/56vmdkPbHw2Us46AGziCJkmE0qntu2e9QCTthSKSy3jw
         l8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cxt2uEcbDsT/cVcss+Oed++7USVk9BRG70PSqUV2sRA=;
        b=f8cyC83T/933MGLT47NGj5TCvTnwyNerl7i8lp3S/j3NR4TfJwXWclcYZYvNAl2sgl
         Q8EgkZcTUSlCyBJQN2BajdGg803Lbega0wDpOnnZOtUrux9JV9BJ7Xsfj3J6i5UpKftD
         nzhwdTuRjzmhz4P5Zw9WplHqGKcCXacJfmAnrkikJXsoVyM0eyOYFC4+bcux/VHaynyD
         SCCcQ7PPWxKGd3jz8i23DtRgz5yGoO85qVdIq+HuzS+/jcKRwe8u3+ViUWYPVCQRuxiU
         7x427Sy5LvkM0byaMwxXz/s7MTrDWskMpLybiSrKcB4/eAGmgRkrlth/NTjP3gWeQPVh
         R5fg==
X-Gm-Message-State: AOAM532nZ7RBSpJKuKFgPtC7tEmRxtcYgwMJrjkkUZiel0/boxPlqwSq
        qPPD2RsoqVOaKFx+upm7+PG/j5mcyv75MDDtIFdqIw==
X-Google-Smtp-Source: ABdhPJymSM8rAJqKJqvQgojVsV7KVaqMaDPb49Py0OCI7oQ+4nknrXkY/Mk29hxHQ9wU+twofcB4rQhyzFE0gK9E3ow=
X-Received: by 2002:a81:78c9:0:b0:2eb:469b:e788 with SMTP id
 t192-20020a8178c9000000b002eb469be788mr1158786ywc.34.1650065066420; Fri, 15
 Apr 2022 16:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
 <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
 <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
 <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
 <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
 <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
 <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
 <CAHk-=whvkRTVBhAamt0kYyp925jk_+g7T0CyPke_FbCWGQ1VvA@mail.gmail.com>
 <CAOUHufZ4KrjFTYH8wtwMGd9AriZfZtO4GhbiK1SuNbY31VTT9w@mail.gmail.com> <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
In-Reply-To: <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Fri, 15 Apr 2022 16:24:14 -0700
Message-ID: <CAJmaN=mJKAhRjDHbsLrqyK_uvuysx596jEcTwV2fwx4UOe4oow@mail.gmail.com>
Subject: Re: [page-reclaim] Re: [PATCH v10 08/14] mm: multi-gen LRU: support
 page table walks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Justin Forbes <jforbes@fedoraproject.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 4:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 15, 2022 at 3:58 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > BUG_ONs are harmful but problems that trigger them would be
> > presummingly less penetrating to the user base; on the other hand,
> > from my experience working with some testers (ordinary users), they
> > ignore WARN_ON_ONCEs until the kernel crashes.
>
> I don't understand your argument.
>
> First you say that VM_BUG_ON() is only for VM developers.
>
> Then you say "some testers (ordinary users) ignore WARN_ON_ONCEs until
> the kernel crashes".
>
> So which is it?
>
> VM developers, or ordinary users?
>
> Honestly, if a VM developer is ignoring a WARN_ON_ONCE() from the VM
> subsystem, I don't even know what to say.
>
> And for ordinary users, a WARN_ON_ONCE() is about a million times
> better, becasue:
>
>  - the machine will hopefully continue working, so they can report the warning
>
>  - even when they don't notice them, distros tend to have automated
> reporting infrastructure
>
> That's why I absolutely *DETEST* those stupid BUG_ON() cases - they
> will often kill the machine with nasty locks held, resulting in a
> completely undebuggable thing that never gets reported.
>
> Yes, you can be careful and only put BUG_ON() in places where recovery
> is possible. But even then, they have no actual _advantages_ over just
> a WARN_ON_ONCE.

Generally agreed, and not to belabor this relatively small issue, but in some
environments like cloud or managed client deployments, a crash can actually
be preferable so we can get a dump, reboot the machine, and get things going
again for the application or user, then debug offline.  So having the
flexibility to
do that in those situations is helpful.  And there, a full crash dump is better
than just a log report with the WARN info, since debugging may be easier with
all the kernel memory.

Jesse
