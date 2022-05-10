Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5B522341
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbiEJSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiEJSJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:09:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC550FF1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:05:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so34559041ejw.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZ5VYfHOn5Pnj/a/F1cEw6h3YGRZnSCs6LxmmCbpo9M=;
        b=Jbq1zZRw7qvAHeuBtsAOHB+74mcPf8IEkkh12elG1m9IvrvUo1rjeZdIyWRMIlN9/A
         GWG834bkq0zFSt94OyWBBe70mo3c8KtSK3AEGjrw5gxFpNsr10pq44OvK6poM2jnma5/
         iRNbwMU4oQc+Bi0B31Na/m1aYVsTHJk81OOZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZ5VYfHOn5Pnj/a/F1cEw6h3YGRZnSCs6LxmmCbpo9M=;
        b=JNEkeu+WgH4K3F29iM2d/y7qsF5B1Ow3nZR3UTS3Fyw5KEvYZg3eKknAsuMJpVaoNZ
         UjSkud/y6csqUMI4NBcKnrD27FI0oPcWFPip405IhCrJqWRM08bFDOrT3PLle0WlKgII
         +bPCtZ+8fj7MHDKQYYVC3VDZAvC9TAdFKx5Op0i4iYFTXxt2tb0cTHrQOpj4Clu1Mt0d
         WCqoAQjAyrLeNiI+F6xoqXqxA14s5gSLkeb+h4MLQWm/ZIyukje0a+2v4PnrN1frNIAn
         TDjSX15RKX1Up6L4NI9eR2vwgCNCqBb586/YH8u78MT5l5h/LRvefq7VVGMCo63OHsmN
         OvtA==
X-Gm-Message-State: AOAM532gmo/ySmsYNLOVbbC9EdwGP6QlFLMzDQ/VcrDNldMHN1yIIhyg
        T2vzqbouOm5ZLuMCa/QN/0ULbe1BCnqo9OjIIP4=
X-Google-Smtp-Source: ABdhPJwraQychmLHYGJ7jlqg4NtiVHPox/fuwMC4pUKYYwXx7PmTAAezsy2hnkkSXkgq8+mrN90Ocw==
X-Received: by 2002:a17:906:6a0e:b0:6f5:30c9:7c7d with SMTP id qw14-20020a1709066a0e00b006f530c97c7dmr18935660ejc.63.1652205919959;
        Tue, 10 May 2022 11:05:19 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906195300b006f3ef214dbdsm24420eje.35.2022.05.10.11.05.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 11:05:18 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id x18so24950504wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:05:18 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr19438990wrn.97.1652205918020; Tue, 10
 May 2022 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220420013526.GB14333@xsang-OptiPlex-9020> <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1> <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1> <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com> <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com> <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
In-Reply-To: <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 May 2022 11:05:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
Message-ID: <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0% regression
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding locking people in case they have any input ]

On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> >
> > Can you point me to the regression report? I would like to take a look,
> > thanks.
>
> https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/

Hmm.

That explanation looks believable, except that our qspinlocks
shouldn't be spinning on the lock itself, but spinning on the mcs node
it inserts into the lock.

Or so I believed before I looked closer at the code again (it's been years).

It turns out we spin on the lock itself if we're the "head waiter". So
somebody is always spinning.

That's a bit unfortunate for this workload, I guess.

I think from a pure lock standpoint, it's the right thing to do (no
unnecessary bouncing, with the lock releaser doing just one write, and
the head waiter spinning on it is doing the right thing).

But I think this is an example of where you end up having that
spinning on the lock possibly then being a disturbance on the other
fields around the lock.

I wonder if Waiman / PeterZ / Will have any comments on that. Maybe
that "spin on the lock itself" is just fundamentally the only correct
thing, but since my initial reaction was "no, we're spinning on the
mcs node", maybe that would be _possible_?

We do have a lot of those spinlocks embedded in other data structures
cases. And if "somebody else is waiting for the lock" contends badly
with "the lock holder is doing a lot of writes close to the lock",
then that's not great.

                  Linus
