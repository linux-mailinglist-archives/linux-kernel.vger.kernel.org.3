Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1AD594465
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiHOWOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350296AbiHOWMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:12:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805711C945
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9QzkD1r7Z2AxBwRWsq7AvaSoMqrd2iT90cH3Q6yYS18=; b=kT3Ho+pNVZj3d2wQZJbx8/jmdR
        3b1dVFURYZg8t52HmHPCOIrFOToVT0hN6FALvZ1UZzG243Gyfuw8iQM3L1kFsg755r/SElJNtIO69
        3AO/JCDTno8+/IqhgKzIxIv3MYqy3y2oOH0PwDxfKbMcyBnrHuifJb3CTQp5s1iolByb7Gu3ssjZ/
        VEnQcD8WRlp29mDH9NBw2oDjyn1Bn5lreTp2QmtceGIrJDIKDviS4wEd7r0E9KH7Ns20s3dcmQ+9a
        TQbCP4t6zh/Mq2o8EIt5QvFcj8QRJm4iBhsXP4vzYHUrlKDXwLOL4afWGNJQ9TDPJPs5ZEVBFdfgj
        daGwkqOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNfvB-002kMX-R2; Mon, 15 Aug 2022 19:38:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57D35980264; Mon, 15 Aug 2022 21:38:41 +0200 (CEST)
Date:   Mon, 15 Aug 2022 21:38:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Asahi Linux <asahi@lists.linux.dev>,
        Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Debugging a TTY race condition on M1 (memory ordering dragons)
Message-ID: <YvqgwVzlM9vfb8Ko@worktop.programming.kicks-ass.net>
References: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
 <20220815134711.GA10374@willie-the-truck>
 <63cd54a8-3c48-d1b9-406a-c521bd02ee4a@marcan.st>
 <YvqKtJn5eBsDJXBI@boqun-archlinux>
 <8ccfdd2d-ef77-4586-e50c-985e1d13726a@marcan.st>
 <YvqXbApYbGGEqQl+@boqun-archlinux>
 <f3f84fc1-50be-0a9b-0538-6ea26dd93b16@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f84fc1-50be-0a9b-0538-6ea26dd93b16@marcan.st>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:15:00AM +0900, Hector Martin wrote:

> FWIW, I didn't actually use a full barrier in my patch. I just replaced
> the test_and_set_bit() with the underlying atomic op, sans early exit path.

That isn't quite true; you used atomic_long_fetch_or() which is used in
the generic implementation, but x86 would end up using "LOCK BTS" for
arch_test_and_set_bit(), while atomic_*fetch_or() ends up being a "LOCK
CMPXCHG" loop (which is significantly worse, performance wise).

That said; I don't have a nice solution that works well across the
various architectures.

(in one previous instance of this problem we ended up using a
cmpxchg_relaxed() coupled with an smp_mb__before_atomic(), but there is
no relaxed version of test_and_set_bit())
