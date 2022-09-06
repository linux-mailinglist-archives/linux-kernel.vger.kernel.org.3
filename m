Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114AB5AEEBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiIFP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiIFP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:27:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09949A98F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i2K+zsZ9EXbekOb4heRlLQlVokCHO5dRmwI+nz26n3A=; b=di0JtVQZMXTnCJcsT4GLigE/Kf
        MW5nVcA458rEOrI6L3XF88dRom9j4fzqVxVV9dh7OIM4gTzsqYCXdE5xn8dmFOtzoFg+X4Lyr84kX
        Igc9mmjcepfe6CNfoVDrvySXBDelvYOpLL88d4Ltx1aMTiL7cAMbrVlH2Z7/3z3taxciaFVpYt6oF
        rb0qvNv2ibxDeKQHK1gfDmA8yJpYtICxEVVA1K/ZqTWKSQtBU8Urzx6q7fqmAqRvkd/XdUMGpnG7m
        BNIR7piR47RwKJI4HaeHgD7X9pnuyPcm7aSIdZQG/ngccMWY2GbJAVlapyINrQ+Dm27cStf1RACwh
        ehki9Dfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVZil-00AVFv-Rm; Tue, 06 Sep 2022 14:38:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4194300023;
        Tue,  6 Sep 2022 16:38:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE2C32012A05B; Tue,  6 Sep 2022 16:38:33 +0200 (CEST)
Date:   Tue, 6 Sep 2022 16:38:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits
 mess
Message-ID: <YxdbaWaO8lWWqT9q@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
 <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 01:06:47PM +0100, Valentin Schneider wrote:

>   #define nr_cpumask_bits nr_cpu_ids

That assumes the CPU space is dense; is this so? That is, you can have 4
CPUs while the highest cpu number is vastly larger than 4.

It's uncommon, but not unheard of I think. ISTR some BIOSes leaving
holes in the CPU space when there were empty CPU sockets on the
motherboard.

