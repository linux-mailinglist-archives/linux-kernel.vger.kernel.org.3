Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23F5AE389
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiIFIyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiIFIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:54:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6A7100D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=alfmK5CsaXmtxluoaD5vHSL8C4bCLVhMZTnT0qzCitE=; b=GFNqqzp/JqDIfkpgVxvgO5h9NL
        p24UMQD5gU5Fa8F6x1XPzIHZfIlbnp/y1rJN6iwsW0eOPZO3sTVtWqb0hg8BvndzzhYHe6eUAQdX1
        DdK5o2oySF420nErUYhIrbInReLCuyd95XCxnwwbVEYe7laojSqYcIWvUkR2v+WZhGcmYJqpjuEGA
        zhGDez3iO75FUFDmL/F19NyOXjx2tKOqa2OIGC1y2Xf33tApdId7bJd+F4kdBhriLW3jngVPHETuQ
        Pe7ieKHcXwgpy67/Nyj5UG3jZ74baHkgEiCcni0KsAUr2iE5eiqjFcff0gsMbcjYPbyaQWkdSsT8L
        9j3XkRlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVULF-00AFHm-04; Tue, 06 Sep 2022 08:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B3FC300244;
        Tue,  6 Sep 2022 10:53:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B06B02012A05B; Tue,  6 Sep 2022 10:53:53 +0200 (CEST)
Date:   Tue, 6 Sep 2022 10:53:53 +0200
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
Message-ID: <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905230820.3295223-2-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:08:16PM -0700, Yury Norov wrote:
> SMP and NR_CPUS are independent options, hence nr_cpu_ids may be
> declared even if NR_CPUS == 1, which is useless.

I'm thikning you're fixing the wrong problem here. Also who the heck
cares about SMP=y NR_CPUS=1 anyway?

Why do we need extra source complexity for this?
