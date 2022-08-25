Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E159C5A085E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiHYFPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHYFPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:15:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A55FAE5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:15:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so16929533pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IoTGWLwyvop2rVJHP5oZfbgjn5SZOhi7mBp2mLs3b8o=;
        b=hWS35hzvkklbPcmzwr0ke1xSxxNLIZKEBgu4EdC6aCEgE6xHVkCoEu2kno5YJ6tfXm
         8kVoPTREEk7eK5hr/lSMQHfXsHXXJrTryQ5SQuOYIMm1SxLSGqxQaj5cxlwMFR7NVMUA
         J+9VxSCRchN1w/+Nl0TqCDp8XsDn+ieiGDZemsR78I7kLEd9Xv2+/uwr1JUvdqDJcOIW
         dheI0IvamqlSUVySz9mq5CJM7QA+N+r8QkOHViKrdXOyfS/FAD3OND17l86YOmln2Mgb
         uxVlZ27HeQ1GGSTVTUs/pWpqZRyfZMdKCr0ejgTmPmh5aOWXZR92En4revU68HT6uMt2
         pgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IoTGWLwyvop2rVJHP5oZfbgjn5SZOhi7mBp2mLs3b8o=;
        b=PBfGJHJvCRID3kfMWSK8eeCJLod3/KTMm7RB71bMY2/BMQAw8+an7JmPyN1PjSw2HK
         PsjbuJQpbLLzKkXJwR/7J5Ln5DLhV+whb105Vz2GMGMcMRsOLF4QUi3MoioDJ2P5jJSk
         GzhiSqNXnxujMtAy+41J8fXgbSYoBkp06LDICneNtvsJ393DnAVjXVINidE/CX2+8UWV
         +PnLMP8OP03X4qux2FiYG+3k3t4QrjxNnxorAtPDUqs0PqFnC3CKIIRbd8SfLktObTeT
         WgvyeupQIz3Bp9ab/56J4pFfhxPCPgdIjRXtdjJbm8Shw6v8/IW1sfe/RLBK/RnrdUnV
         rgNg==
X-Gm-Message-State: ACgBeo1StgttvA0OTstoZHZFdZC0ybCBCGROQkAJbhBJNpBmkBI474EG
        BHSFFo+EFMLuqYCqdKjysQ8=
X-Google-Smtp-Source: AA6agR4r1V9IbnMNeexhhTPrl4XJ3D41ExWsIOPUH4wsZ2kpePU5MZBWLgwlH6ZGFjXh5lysPMXwLQ==
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id bt19-20020a056a00439300b0052f3603e62fmr2492716pfb.23.1661404513144;
        Wed, 24 Aug 2022 22:15:13 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h20-20020aa796d4000000b0053671a241a5sm8763912pfq.191.2022.08.24.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 22:15:12 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:15:06 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Message-ID: <YwcFWsO/iNE534dp@hyeyoo>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
 <alpine.DEB.2.22.394.2208181136560.1901102@gentwo.de>
 <5679405a-b3c3-6dc5-783f-7ebeda7c9bf0@suse.cz>
 <alpine.DEB.2.22.394.2208191655540.2139415@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2208191655540.2139415@gentwo.de>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:04:31PM +0200, Christoph Lameter wrote:
> On Thu, 18 Aug 2022, Vlastimil Babka wrote:
> 
> > On 8/18/22 11:42, Christoph Lameter wrote:
> > > On Wed, 17 Aug 2022, Sebastian Andrzej Siewior wrote:
> > >
> > >> + *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
> > >> + *   which means the lockless fastpath cannot be used as it might interfere with
> > >> + *   an in-progress slow path operations. In this case the local lock is always
> > >> + *   taken but it still utilizes the freelist for the common operations.
> > >
> > > The slub fastpath does not interfere with slow path operations and the
> >
> > That's true on !PREEMPT_RT because a slowpath operation under
> > local_lock_irqsave() will disable interrupts, so there can't be a
> > fastpath operation in an interrupt handler appearing in the middle of a
> > slowpath operation.
> >
> > On PREEMPT_RT local_lock_irqsave() doesn't actually disable interrupts,
> > so that can happen. IIRC we learned that the hard way when Mike
> > Galbraith was testing early versions of my PREEMPT_RT changes for SLUB.
> 
> Well yes if you enable interrupts during the slowpath then interrupts may
> use the fastpath. That is a basic design change to the way concurrency is
> handled in the allocators.
> 
> There needs to be some fix here to restore the exclusion of the fastpath
> during slow path processing. This could be
> 
> A) Exclude the fastpath during slowpath operations
> 
> This can be accomplished by setting things up like in the debug mode
> that also excludes the fastpath.

I think we can do that by disabling preemption (for a short period, I think)
in slowpath on RT (like disabling irq in non-RT)

But I wonder if RT guys will prefer that?

> B) Force interrupt allocations to the slowpath.
> 
> Check some flag that indicates an interrupt allocation is occurring and
> then bypass the fastpath.

There is nothing special about interrupt allocation on RT.
All users of SLUB on RT must not be in hardirq context.

So I don't think it is possible to distingush between a thread being preempted
and another thread that preempts it.

-- 
Thanks,
Hyeonggon
