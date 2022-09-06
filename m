Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320E5AEF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiIFPw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiIFPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:51:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505F7E033
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:07:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j17so8204131qtp.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=usKTDfUV5JUHwrmzML8CHQv6Sdl6UiTt8WKJcG5cc0k=;
        b=WMQqLPKoIGPawv9TD/4gjWW8unF1uqVZZW9WvW/8KFTkXVZ1DwdhVpUtdBN0lYmp+V
         CwNZqS/I33yxUtjV5qg2VbegyYOW+7eO+ezSC8KZQ9RLanjsgCqTIUcBaa+SMDmx3Pkr
         YTv1YKKYClbF0GzbOw0DsxktdU7d6Je9K0zqBIK08NT3sTUmLxXe5CjB76rmnKuaWrha
         PsYU0GP4VlZN++L1cGPcFWCjk8GXftc8u3AScpy1TBp0fEJBq16C6zkm3vgqwknIEXBp
         FLjzVPje4m2NGyJhni/o2fbF+RcIg3UY1/QoWU1JNjU9M9z8u0FXGCV9fM595QqbfHGv
         mvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=usKTDfUV5JUHwrmzML8CHQv6Sdl6UiTt8WKJcG5cc0k=;
        b=JS56nyrk8xEJRt/UIJEOx/QJFX+7PSkoUG03S4eynJy36NbYkBH+SElCEZTfutzd6C
         15r6dbiTL/4dBzHmJPZUDUykDSDQWom0NjGdsLCyLCltkyGpqcZUABrpNoa4Ewb56WbH
         fm/AFs//tVfyj+xioF3HNcQ4OI9GimqVV3vdVcEkCsJARcPQH/14Get4knsvJpiU17kV
         NwVxq2OAwlT3/wI+TIoiGpsfWY+xLK4rHZ/8zyC8I4RtXSh/WeiMdZxp+MHgoCRiFNzE
         DQfTOg7Fr7Vh2VyDoy6MgLlwvi3Ur3UvG7hTHnc2kD7yO6xQhN8l/uKbfP94KOH5ZUAa
         0eTg==
X-Gm-Message-State: ACgBeo2qDlnZlgYTXVK+KRxcNKK/HwqI5wRqUKCHyevNzF+W2Bo34FXR
        q4hiTOezP7qC7yk5EHCCxHI=
X-Google-Smtp-Source: AA6agR5w6ATExXnqgdXm2pa4QCimazG+RO+XeiwGoxQom8NqKRwDJCJNFc4bwZi33m34029AQKiDkg==
X-Received: by 2002:a05:622a:82:b0:344:f8ed:1ce6 with SMTP id o2-20020a05622a008200b00344f8ed1ce6mr45187819qtw.390.1662476864080;
        Tue, 06 Sep 2022 08:07:44 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:20bc:1817:1631:6d06])
        by smtp.gmail.com with ESMTPSA id j25-20020ac85519000000b0034308283775sm9744262qtq.21.2022.09.06.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:07:43 -0700 (PDT)
Date:   Tue, 6 Sep 2022 08:07:43 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 1/5] smp: don't declare nr_cpu_ids if NR_CPUS == 1
Message-ID: <YxdiP9+zGdrMCarC@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
 <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
 <YxdT5w9Qd5SxK1wl@yury-laptop>
 <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:36:39PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 07:06:31AM -0700, Yury Norov wrote:
> > On Tue, Sep 06, 2022 at 10:53:53AM +0200, Peter Zijlstra wrote:
> > > On Mon, Sep 05, 2022 at 04:08:16PM -0700, Yury Norov wrote:
> > > > SMP and NR_CPUS are independent options, hence nr_cpu_ids may be
> > > > declared even if NR_CPUS == 1, which is useless.
> > > 
> > > I'm thikning you're fixing the wrong problem here.
> > 
> > I'm removing dead code. If NR_CPUS == 1, nr_cpu_ids does exist, exported
> > as an interface variable, but never normally reached, because in some
> > other piece of code (not even in smp.h) it's declared conditionally. 
> 
> Can't you simply disallow NR_CPUS==1 for SMP builds? It doesn't make
> sense anyway.

There are SMP_ON_UP and SMP_UP options in arm and mips configs. I have
no idea what do they do, but disallowing NR_CPUS==1 && SMP=y looks
unsafe...

 
> > > Why do we need extra source complexity for this?
> > 
> > To have effective code generation for UP builds.
> 
> Again, who cares... isn't it hard to find actual UP chips these days?

What about UP VMs? People are interested in UP. Check for example the
recent b81dce77cedce ("cpumask: Fix invalid uniprocessor mask assumption")

> It was suggested the other day we remove a whole bunch of SMP=n code and
> unconditionally use SMP code, even if its pointless on UP just to make
> the source simpler.

So while SMP=n is there, let's keep the code base coherent?
