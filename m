Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F9525526
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357789AbiELSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiELSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:50:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8B24578E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:50:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p18so7326221edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N01o2MK9zpj/dh2u/Xpb3w8n7ZmHwYIRG43aX5zXwiY=;
        b=VWqHFI6m05UgCKkAS3BZUIFsXQjlgwwShbmz9escP9uC5aEVY1Vps5DpBBWix+aUxd
         zVQZ3JYk3AK8ULZM9+xfniceVs9q7vYitugCHm+IZnF3iL8JSQl8hAtFz4apJ7E2MtG6
         ffGWoPzzvS9CZHryhRuDMzgfRU98gnKDPZWUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N01o2MK9zpj/dh2u/Xpb3w8n7ZmHwYIRG43aX5zXwiY=;
        b=gA+w7Tt8p/yKos83xG13vMECYPk3VwihuqdnkUw5YyV15c9C7G7KaSblPAqs401vz6
         kiBRTrFCjxdUlX2eHt5M0pI5mcHvsT3AQ5D9/NwqjjnGv6stiVTdKttvIKAWDYMB3wiw
         em+0P5arAWIj2G9Nn4gcrzAsbde78nBrTJGSM+qBj4Q7neHthr7LQJx5q5drWTJ/19/5
         24qbKMqbzuPsxwOALzq63IFZs9JSLXuZApVva+W7LlsW6lseqiNX+Ee7y9lvJ5skthWa
         Jj5lWl4mAv6lQcG7jYosJmba+Qch7c7iPNFpneqn9R2jLtKOYqgjQ5k/qpXQVB9XCSEq
         rhlg==
X-Gm-Message-State: AOAM533aIazHjfCMupUPvxyWFEWR1ksulRoGwMnJfD6czW1GcjApKT1S
        KoY/AUj4+LGhQ0ynbcsz8jU8Lg3oGsveM/nuHCE=
X-Google-Smtp-Source: ABdhPJxbzxT203OiorZp5GZl2yOfYEk0n88QwghfIZCTAszbxz9eKC0P2uZxu3Fx/FvylK42he+ctw==
X-Received: by 2002:a05:6402:2291:b0:425:deb5:73be with SMTP id cw17-20020a056402229100b00425deb573bemr36167690edb.392.1652381413086;
        Thu, 12 May 2022 11:50:13 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id g5-20020a50ee05000000b0042617ba639esm46638eds.40.2022.05.12.11.50.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 11:50:10 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id d5so8502096wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:50:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr865946wry.193.1652381409749; Thu, 12 May
 2022 11:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <YnXnLuYjmEWdVyBP@ziqianlu-desk1> <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com> <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com> <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
 <YnuYV3J2ljY88DyQ@ziqianlu-desk1> <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
 <Yn0BeRaUC9ailyzz@ziqianlu-desk1> <CAHk-=whmeWNC-YH_cGRofdW3Spt8Y5nfWpoX=CipQ5pBYgnt2g@mail.gmail.com>
 <20220512110634.712057e4663ecc5f697bf185@linux-foundation.org>
In-Reply-To: <20220512110634.712057e4663ecc5f697bf185@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 May 2022 11:49:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyjnKiCZyou+fHYi7tNh1FC-BYy_kubusd+jrkDRsExA@mail.gmail.com>
Message-ID: <CAHk-=wiyjnKiCZyou+fHYi7tNh1FC-BYy_kubusd+jrkDRsExA@mail.gmail.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0% regression
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:06 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 12 May 2022 10:42:09 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > In a perfect world, somebody would fix the locking to just not have as
> > much contention. But assuming that isn't an option, maybe somebody
> > should just look at that 'struct zone' layout a bit more.
>
> (hopefully adds linux-mm to cc)

So I suspect the people who do re-layout would have to be the intel
people who actually see the regression.

Because the exact rules are quite complicated, and currently the
comments about the layout don't really help much.

For example, the "Read-mostly fields" comment doesn't necessarily mean
that the fields in question should be kept away from the lock.

Even if they are mostly read-only, if they are only read *under* the
lock (because the lock still is what serializes them), then putting
them in the same cacheline as the lock certainly won't hurt.

And the same is actually true of things that are actively written to:
if they are written to under the lock, being in the same cacheline as
the lock can be a *good* thing, since then you have only one dirty
cacheline.

It only becomes a problem when (a) the lock is contended (so you get
the bouncing from other lockers trying to get it) _and_ (b) the
writing is fairly intense (so you get active bouncing back-and-forth,
not just one or two bounces).

And so to actually do any real analysis, you probably have to have
multiple sockets, because without numbers to guide you to exactly
_which_ writes are problematic, you're bound to get the heuristic
wrong.

And to make the issue even murkier, this whole thread is mixing up two
different regressions that may not have all that much in common (ie
the subject line is about one thing, but then we have that whole
page_fault1 process mode results, and it's not clear that they have
anything really to do with each other - just different examples of
cache sensitivity).

                   Linus
