Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2B525413
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357285AbiELRty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357283AbiELRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:49:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5C1FC7C7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:49:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so11689462ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2rQByg8zgc+HF8Kk0b5UhwCnCqFJu0XeJMRMnUubP4=;
        b=hQCDnuOiRDAfjb566SDsAuhMZtfYydXMJWNTiXviylyOTuWKwRNr/yhTZJtQ7Rl3CG
         A7N2tVbkUqoa4kcxh8BagYehWy7EziQ7fQlaG6vGRw+5gKndrEbBrpA6FG2xHm837fLw
         YVrFUtBoXf4X3nG+M16IVVJry4+tbviGnwkNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2rQByg8zgc+HF8Kk0b5UhwCnCqFJu0XeJMRMnUubP4=;
        b=vSu63p6zQHhPD4CcI5BTzPZfdP3WjUw6wPZgBV3ih1vXLefooHDw1TAWHEx2Ja5D7h
         tXG154OzyGuSug4lmqpNjGB8mHMwDc58BxJ8qfRaCsuVP6mGQ1dtBUx1PRkMjXnCz4Vm
         98UbgXQQR+lnwxfOiIwbh18Ux00NrmhL4D3MNyy5FzmCoyZwtoHwJT04amWzFYsQ3i0Z
         Sc4Ziv41lye3hgcWDS87sc8iL7wA2GoR4MvJLjWhgV8qeHE0mfdxyGFbFH4dnXhrcbds
         70Rk1qy6hk1Ig3PmACWTux15ESb/OO5UuisKPecckgVqmQwmuPRX5cWjnZPfD77uBraG
         QMPQ==
X-Gm-Message-State: AOAM530b5CZf2ymwuQ0Lj2gkgzzCDOKe3+k5diHlDt8g9fppkOFS/67B
        SDC5KqIw5BmHhDj8dvrJd8K6C5Iy9gDforiWy4Y=
X-Google-Smtp-Source: ABdhPJzHhE9y+7fHV0OFH3dD+gY27TFMettFIpLWjN+mxMqwUAaX6DVHUWIkvtf/tyIPWKV08eI2WQ==
X-Received: by 2002:a17:907:1b14:b0:6ef:a5c8:afbd with SMTP id mp20-20020a1709071b1400b006efa5c8afbdmr960025ejc.151.1652377786166;
        Thu, 12 May 2022 10:49:46 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id bd23-20020a056402207700b0042617ba63a3sm2755251edb.45.2022.05.12.10.49.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:49:45 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id j6so11664570ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:49:45 -0700 (PDT)
X-Received: by 2002:a5d:6dad:0:b0:20c:4dc1:e247 with SMTP id
 u13-20020a5d6dad000000b0020c4dc1e247mr702827wrs.274.1652377345676; Thu, 12
 May 2022 10:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <YnXnLuYjmEWdVyBP@ziqianlu-desk1> <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com> <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com> <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
 <YnuYV3J2ljY88DyQ@ziqianlu-desk1> <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
 <Yn0BeRaUC9ailyzz@ziqianlu-desk1>
In-Reply-To: <Yn0BeRaUC9ailyzz@ziqianlu-desk1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 May 2022 10:42:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmeWNC-YH_cGRofdW3Spt8Y5nfWpoX=CipQ5pBYgnt2g@mail.gmail.com>
Message-ID: <CAHk-=whmeWNC-YH_cGRofdW3Spt8Y5nfWpoX=CipQ5pBYgnt2g@mail.gmail.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0% regression
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
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

On Thu, May 12, 2022 at 5:46 AM Aaron Lu <aaron.lu@intel.com> wrote:
>
> When nr_process=16, zone lock contention increased about 21% from 6% to
> 27%, performance dropped 17.8%, overall lock contention increased 14.3%:

So the contention issue seems real and nasty, and while the queued
locks may have helped a bit, I don't think they ended up making a
*huge* change: the queued locks help make sure the lock itself doesn't
bounce all over the place, but clearly if the lock holder writes close
to the lock, it will still bounce with at least *one* lock waiter.

And having looked at the qspinlock code, I have to agree with Waiman
and PeterZ that I don't think the locking code can reasonably eb
changed - I'm sure this particular case could be improved, but the
downsides for other cases would be quite large enough to make that a
bad idea.

So I think the issue is that

 (a) that zone lock is too hot.

 (b) given lock contention, the fields that get written to under the
lock are too close to the lock

Now, the optimal fix would of course be to just fix the lock so that
it isn't so hot. But assuming that's not possible, just looking at the
definition of that 'struct zone', I do have to say that the
ZONE_PADDING fields seem to have bit-rotted over the years.

The whole and only reason for them would be to avoid the cache
bouncing, but commit 6168d0da2b47 ("mm/lru: replace pgdat lru_lock
with lruvec lock") actively undid that for the 'lru_lock' case, and
way back when commit a368ab67aa55 ("mm: move zone lock to a different
cache line than order-0 free page lists") tried to make it true for
the 'lock' vs free_area[] cases, but did it without actually using the
ZONE_PADDING thing, but by moving things around, and not really
*guaranteeing* that 'lock' was in a different cacheline, but really
just making 'free_area[]' aligned, but still potentially in the same
cache-line as 'lock' (so now the lower-order 'free_area[]' entries are
not sharing a cache-line, but the higher-order 'free_area[]' ones
probably are).

So I get the feeling that those 'ZONE_PADDING' things are a bit random
and not really effective.

In a perfect world, somebody would fix the locking to just not have as
much contention. But assuming that isn't an option, maybe somebody
should just look at that 'struct zone' layout a bit more.

                     Linus
