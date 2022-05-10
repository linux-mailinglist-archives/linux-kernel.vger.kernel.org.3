Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E752247B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiEJTDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiEJTDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:03:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7809725C59
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:03:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so34794070ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EsOzeDPWL4ZwKkamcod1HHCvU1KgPnKnC1i1038w8U=;
        b=ZOQ8FjNGYMnLI+QWc8PMGUliO/aRnvQ2zUa/9W+UFyuXaI2EgGQ2HpmGliR3ZoMc8z
         /C2vjZQqVDHVrPNe6nFOeB3xWJ3qQfX/n3jY+DW2fDuAl8UEs2YEHFSzh92osAAf9dbM
         jjsUGFUVDswAwtXizpqMnL744RKvNDkMP5eoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EsOzeDPWL4ZwKkamcod1HHCvU1KgPnKnC1i1038w8U=;
        b=CNr64FZtd08tvbfreslvrWyfvaIRRtQTrV4K0XJO0aD2Sm9Xeq9Ds/i1sXi6+HEjmX
         apSDdv5H/UXI0DfUJcLQpeRa10ltJLC7SSFjiu9wgbzLXae5l0WHURtEp2LPISxx0Ik6
         i5lpYmhVkyOQ+yWMG5Dl1m4QDuHDF1XX9Teqm5Z7EkQ9CmDJV7BZqydK8pau246k6OMc
         0dpL1hKoDxWoVH5FZpXs+w1KWwpibPEe5aFu2o3xeY++fCbrLKOWhtG9wCe0JFURZIQL
         CLPI7oRrFKgj1yRawAEusWxXFKHgjsvj0M2grOX+TCCpJwlEsNBkhUooS3sTsiuycri1
         BGPQ==
X-Gm-Message-State: AOAM531kVhrDtsngvkIvXsbexNii02q88xC1MEokmYLqVJnTHXh03lQY
        +f/eufnqXrOLK//SbecBoBSWrewi+0BFoeuiNXk=
X-Google-Smtp-Source: ABdhPJxOpyhOABwWWz0SUi4JQfMVZHOVoI3xPm7xWF3KlBI8CgOhkyWWEItKgy21752F3zCKeRyndQ==
X-Received: by 2002:a17:907:7ba5:b0:6f4:693d:9f8a with SMTP id ne37-20020a1709077ba500b006f4693d9f8amr20234323ejc.442.1652209423705;
        Tue, 10 May 2022 12:03:43 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id u5-20020a50d505000000b0042617ba63cdsm8019255edi.87.2022.05.10.12.03.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 12:03:42 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id x18so551wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:03:41 -0700 (PDT)
X-Received: by 2002:adf:ec08:0:b0:20a:d39d:6ab6 with SMTP id
 x8-20020adfec08000000b0020ad39d6ab6mr19661667wrn.442.1652209421071; Tue, 10
 May 2022 12:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220420013526.GB14333@xsang-OptiPlex-9020> <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1> <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1> <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com> <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com> <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com> <56474c28-e62a-36b1-257b-9e5ffb11b0e2@redhat.com>
In-Reply-To: <56474c28-e62a-36b1-257b-9e5ffb11b0e2@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 May 2022 12:03:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEtdHOeBti66NpSZDQw0KxcU45UNHaO-+Zwbiq3JEu+g@mail.gmail.com>
Message-ID: <CAHk-=wiEtdHOeBti66NpSZDQw0KxcU45UNHaO-+Zwbiq3JEu+g@mail.gmail.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0% regression
To:     Waiman Long <longman@redhat.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Aaron Lu <aaron.lu@intel.com>,
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

On Tue, May 10, 2022 at 11:47 AM Waiman Long <longman@redhat.com> wrote:>
> Qspinlock still has one head waiter spinning on the lock. This is much
> better than the original ticket spinlock where there will be n waiters
> spinning on the lock.

Oh, absolutely. I'm not saying we should look at going back. I'm more
asking whether maybe we could go even further..

> That is the cost of a cheap unlock. There is no way to eliminate all
> lock spinning unless we use MCS lock directly which will require a
> change in locking API as well as more expensive unlock.

So there's no question that unlock would be more expensive for the
contention case, since it would have to always not only clear the lock
itself, as well as update the noce it points to.

But does it actually require a change in the locking API?

The qspinlock slowpath already always allocates that mcs node (for
some definition of "always" - I am obviously ignoring all the trylock
cases both before and in the slowpath)

But yes, clearly the simply store-release of the current
queued_spin_unlock() wouldn't work as-is, and maybe the cost of
replacing it with something else is much more expensive than any
possible win.

I think the PV case already basically does that - replacing the the
"store release" with a much more complex sequence. No?

         Linus
