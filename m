Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9C5AE38D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiIFIzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiIFIzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:55:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7FD1E3D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cnDH3aGYFESl5uaJdCFGIgiBiKllv0MgR28MTTe0OcE=; b=dzthl0OYAiTACcBY2O78kHqySp
        jh4n0xKIRjuI9IWA5k/jeZrfulwuZyAW+wav51BGFjByXMrFmfUBmZZeyqQT+0+9bwliK2lKYf67R
        rgEB8uZhfFWjQwok86IxZ5FJJDglYENieMEw+xTUgxVudkwnKscv+ePyRRvbsyU1VPxUp75oK4qEl
        qQGSakOvXtx7yUkDIo07g6AbBd579ae94sGewdyvfrXcxlJWK1pMrKo8X4d1iy+NHZvkBeemqNOGu
        EdN8drIWrZgPEPoxMCQ9TUsTwX/MjsrfkV2EULty/7OeSdV6hyiEZioeDnmB+M/8SXqQGJ06Sne1I
        1saYuSlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVUMc-00AFO9-Cr; Tue, 06 Sep 2022 08:55:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E7E6300244;
        Tue,  6 Sep 2022 10:55:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F1A1209D2D1D; Tue,  6 Sep 2022 10:55:20 +0200 (CEST)
Date:   Tue, 6 Sep 2022 10:55:20 +0200
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
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits
 mess
Message-ID: <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905230820.3295223-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:08:15PM -0700, Yury Norov wrote:
> cpumask subsystem uses nr_cpu_ids and nr_cpumask_bits interchangeably
> despite that the variables have different meaning and purpose. It makes
> some cpumask functions broken.
> 
> This series cleans that mess and adds new config FORCE_NR_CPUS that
> allows to optimize cpumask subsystem if the number of CPUs is known
> at compile-time.

Who will use this? Distro's can't, which means 99% of people will not
use this ever. Is it worth it?
