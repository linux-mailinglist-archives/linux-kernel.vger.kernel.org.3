Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261555A5033
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiH2PbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2PbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:31:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B17756F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:31:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z41so3220582ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=4GZfrKETqCN4WV0RcBTx+A5dfB7EbMYh6SgbrUrxycs=;
        b=djDBoBkjjDIo3NAlpnob16fAeEmMg5TdOYSeZ3wHtO91q12UaWuvy/FSKiQU3z7yuW
         MtqUjZmaJKg989COiBCWkxO0O/+9PUoMY0+GZloI+z4cU4wRdsHCUfu2QHZf4GFpeQWd
         d79Uc1zMXrqwddcyPSTtbGGkLPOt2KNcfAZqz15kYm7csjw65LFLvJu8TmjP33h5jW7z
         cpBEd8B27LptyNm85qYFiqLnKuU4az2N/AcP8D00pV5s7zPdwJNP4eDerMrvgqm0vqHZ
         xemXzoCg2y0KGWtM3P2tU7ZayUtHQM4GmEcIIxp+iC/vzLtKSaz2q6GPdcrYft1hcl/d
         bm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4GZfrKETqCN4WV0RcBTx+A5dfB7EbMYh6SgbrUrxycs=;
        b=g87nTCblOqfwQH+FLiiotnIm+YrRGaCFvs9thtOYEzLaPweJ8/3NJM9/MfM7xh+4Be
         qHx/dgJx+3jG/6oIqqOtKVnOLAs08CwqM+mGVIdFO1ASvf7rdaV65j+96dGa/HAFsB9Q
         +hsAfDPuF7HAzM7UPrEaaqea6I6lJPYGp+GcUT2dsjsu3sI7yjPDSnTK8fveQGJMrZV5
         mnDevc8JetM6LDuiiuwcQnx+tVc5LeGPYd9f1r3lPDUy1HvzwqjNtpLEBYu1SkiqsdT0
         qzFyEXYsEBjOk4Um3hnzL5VW3JkQ+Y6VN7W2lBJgZGb0qyolBOOeRH2p2IlNFnRhbTYb
         +/Rw==
X-Gm-Message-State: ACgBeo0H1nR+5s3vJdRb1ZYXajnSsx+4xJbFKKiGBlZ2i2RDK4vVkdOQ
        7wSUgSN27iYmoEqupM3PvROwtQ==
X-Google-Smtp-Source: AA6agR4rFv/Pvbt5CxSNB1vRJ+eQmxxXybKAyTdJ5W9xLCVUNxnWaGcMTsgaOQ+WRRDq80v1auOEFQ==
X-Received: by 2002:a50:9f4f:0:b0:447:8aff:d312 with SMTP id b73-20020a509f4f000000b004478affd312mr16735179edf.110.1661787068843;
        Mon, 29 Aug 2022 08:31:08 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709063b8f00b00730b61d8a5esm4557456ejf.61.2022.08.29.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:31:08 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:31:05 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <YwzbuWdSYZr+w/At@google.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
 <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
 <YwzL1eJUIReAEv0l@google.com>
 <YwzOf5WV5G8dQBGb@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwzOf5WV5G8dQBGb@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 Aug 2022 at 16:34:39 (+0200), Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 02:23:17PM +0000, Quentin Perret wrote:
> > FWIW. Typically a larger half-life will be fine with predictable
> > workloads with little inputs from users (e.g. fullscreen video playback)
> > while a lower one can be preferred in highly interactive cases (games,
> 
> As per always; consider the combined workload.

That's the problem of whoever is going to decide which HL should be
used, which would all fall in userspace policy land. And yes that
userspace agent would have to know quite a bit about what is going on in
the system to make 'sane' decisions, but that is the case in Android.

The fact that choosing the right HL for a combined workload is hard
(that userspace agent might want to just default to a safe value?)
doesn't mean there is no value in other cases though...

I mean, if we agree that tuning the PELT HL makes sense at all (even as
a cmdling arg, or sched_feat or whatever), there is only one small step
to say the right PELT HL should indeed depend on the workload you're
currently running (especially with _vastly_ different usage patterns
seen in mobile).

> > ...). The transient state is fun to reason about, but it really
> > shouldn't be too common AFAIK.
> 
> Once you give away control there is no taking it back, and userspace
> *will* do stupid things and expect unicorns.

Sure. If you do stupid, at some point you get(/deserve) what you asked
for... We could perhaps rate-limit changes or something if we want to
make that clear?
