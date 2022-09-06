Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB65AEEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbiIFP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiIFP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:26:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE61BFE99
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nGbmOt5qy6TtbRFBf3a33ifWuRBuC92wFOBE6Y9UGY8=; b=sZEcCcyvLBfpVsh1VqMtAebfcn
        /ZO+fsyVSLofYcDi+RB4BzURacE+guSMmhUVPf5FVg2qV4FpGBhQYvtJh3X2+V/g7YTFlDsPXC7yM
        RacspXu1s2GhpS+VJKoIc20myDCELKyki7SGc7HR5HcRXcbYdJYM15q+ia2vYkCnEStgiTWUK8qeP
        EKRtXLNVZwHxrWQ07gppnxo0jPHgT9IvE+oLrZFyDEmytzwNGmEiZJg3xAPz0F/0cK4BDnqIdLULC
        dAGtYhPqqCCAxPve8WDovQxM7rP6/5QOp0TFEFWPe4Iu7nZCsfkzgsQosxQTKfyQ66b+qwd6Uf/oX
        sVPdOGlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVZgz-00AVAC-2X; Tue, 06 Sep 2022 14:36:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDFF7300023;
        Tue,  6 Sep 2022 16:36:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B79C2012A05B; Tue,  6 Sep 2022 16:36:39 +0200 (CEST)
Date:   Tue, 6 Sep 2022 16:36:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
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
Message-ID: <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
 <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
 <YxdT5w9Qd5SxK1wl@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxdT5w9Qd5SxK1wl@yury-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 07:06:31AM -0700, Yury Norov wrote:
> On Tue, Sep 06, 2022 at 10:53:53AM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 05, 2022 at 04:08:16PM -0700, Yury Norov wrote:
> > > SMP and NR_CPUS are independent options, hence nr_cpu_ids may be
> > > declared even if NR_CPUS == 1, which is useless.
> > 
> > I'm thikning you're fixing the wrong problem here.
> 
> I'm removing dead code. If NR_CPUS == 1, nr_cpu_ids does exist, exported
> as an interface variable, but never normally reached, because in some
> other piece of code (not even in smp.h) it's declared conditionally. 

Can't you simply disallow NR_CPUS==1 for SMP builds? It doesn't make
sense anyway.

> > Why do we need extra source complexity for this?
> 
> To have effective code generation for UP builds.

Again, who cares... isn't it hard to find actual UP chips these days?

It was suggested the other day we remove a whole bunch of SMP=n code and
unconditionally use SMP code, even if its pointless on UP just to make
the source simpler.
