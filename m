Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6115AF32B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIFRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIFRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:54:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068165A1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GiUXHVc1KGNBibjdaKh+j2gIWazpgOCP8xIokdYlFQM=; b=QQLrDYzV9wr4utEH9S2536+iTk
        tD10XRPwpcK63Nbc7cNBic/QE+NKY51nfBRi+2T9fmZtpjweSqHxuojRioKp6WpUUKx6vZe/D9WhT
        CaPpNJzD2NzhTqxD/EFK8Ja0tx7ipNvN02Z2Ay3JUl+MWh4U1RJ4OdvOk4QClo+JIbQgjH9309hwQ
        ZipxdF91K4MwkSJsClUM1nl71UhJIkD0r1+JIkdj7iqy9FlhM6Dn0b9MJpAxNFb0yprl9m39sIR/1
        cEkE9Zn7bV8B29wp2/UCwtaq1kyKCUC1ovm3MoM7Km1FD+b62LqH7hNK0iRUMSoqPp7U+sUBCeAzI
        QVoZoC9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVclu-00Adcv-CD; Tue, 06 Sep 2022 17:54:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66626300023;
        Tue,  6 Sep 2022 19:53:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1AA32B94A784; Tue,  6 Sep 2022 19:53:57 +0200 (CEST)
Date:   Tue, 6 Sep 2022 19:53:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <YxeJNXBeQRAAP15o@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
 <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
 <YxdT5w9Qd5SxK1wl@yury-laptop>
 <Yxda9/XP85D1sR39@hirez.programming.kicks-ass.net>
 <Yxdgrbvtv36C4zcJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxdgrbvtv36C4zcJ@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 06:01:01PM +0300, Andy Shevchenko wrote:

> For the record, Intel produced somewhat a volume of Intel Quark chips [1],
> that are UP (in 2013-2019).

The day we drop 32bit x86 support can't be soon enough ;-)
