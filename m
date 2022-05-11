Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27C6523452
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiEKNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiEKNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:35:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E018AABF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=11UTZ+quzH0SN0pcT+pV2U1BMSV8hfaYXX76Jhby3b8=; b=XPH88GZU9Ke9hJFvogGD70ml9o
        aHx0IwApx4Yzgoc5xjmFFpCrGUJ2UAtgO1dtBP2UjiLY0w7+C63mo9xjXReE1Y3Q4/tjEOMKZsrzy
        Hq5+I+qwsUFD2og9wmLTyLid3LJk3Q95kRl0WzCbD0hDd3G4SpxSpHXd8ypUCu+4aSPf0HATtZ13J
        EfQMeTUFYKaTNtsZM3UecqhUkiBGqxmZcIDw/onxgNnOvortoFAeyqKKALnZNj4RJW/IvdUTMRVcF
        MX4MaPY4tnEqlTu2sMweHnT3yTGHcb+/dGcrMhnbH/bYt8+XBdi484O4DV0weZdyOmGjtfzdow3G+
        hjy7Eyig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nomUY-00DBEG-12; Wed, 11 May 2022 13:35:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C89D980E5D; Wed, 11 May 2022 15:35:00 +0200 (CEST)
Date:   Wed, 11 May 2022 15:34:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for
 rwlocks used in interrupt context
Message-ID: <20220511133459.GZ76023@worktop.programming.kicks-ass.net>
References: <20220510192134.434753-1-longman@redhat.com>
 <20220510192134.434753-2-longman@redhat.com>
 <20220511083036.GY76023@worktop.programming.kicks-ass.net>
 <7eff9889-56fe-503c-94ea-376054c6579b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eff9889-56fe-503c-94ea-376054c6579b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:44:55AM -0400, Waiman Long wrote:

> > I'm confused; prior to this change:
> > 
> > 	CPU0			CPU1
> > 
> > 	write_lock_irq(&l)
> > 				read_lock(&l)
> > 				<INRQ>
> > 				  read_lock(&l)
> > 				  ...
> > 
> > was not deadlock, but now it would AFAICT.
> 
> Oh you are right. I missed that scenario in my analysis. My bad.

No worries; I suppose we can also still do something like:

void queued_read_lock_slowpath(struct qrwlock *lock, int cnts)
{
	/*
	 * the big comment
	 */
	if (unlikely(in_interrupt())) {
		/*
		 * If not write-locked, insta-grant the reader
		 */
		if (!(cnts & _QW_LOCKED))
			return;

		/*
		 * otherwise, wait for the writer to go away.
		 */
		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
		return;
	}

	...
}

Which saves one load in some cases... not sure it's worth it though.

