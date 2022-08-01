Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8D586B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiHAMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiHAMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774C103
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:42:26 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:42:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659357744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJsPGtEi3Iln+558Jldw3Iv4IN5TJ47fe8SK6ZlLY5o=;
        b=hD2gkX1P3hPSkoAxHscnXMw9Blj33qs2rY4PFw5WWLWLQBU2eN+1e0OtjHs+NYKTJmrySW
        9KorD0yljbYci65tOrxyQY6gE4bUgAgrreO3Mv3Z9l203EvW5LxHMQhftUQ8V5ElpWDnKP
        g4Ol+zcejI3vAyZYVibTKxTC+iZ5IVK+wa+Ib/e1APgS2bLvdwrkZgQ/PEAAohIRInbZPQ
        RnEiDY9o4mFurFlh8JXMHLMdJH2DKgXYvaK8xIvysRLsxaPzJz0VkiEtfKTCspuKVwvwnI
        UP7qBD2YxcKb3j64i0ICsnxvRua6+rkCfaoVna+yV2d+1ZPgOYM/a6M9L3VDiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659357744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJsPGtEi3Iln+558Jldw3Iv4IN5TJ47fe8SK6ZlLY5o=;
        b=QukwVvpQ1UUF1WTBE1R7OAo/WYfuWlvmwgV5o6jbwxQNaFNE/xC0bXWyoR0JQ3tg+HbgzP
        jfKHSWNcMRtUQwBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2 v2] lib/vsprintf: Remove static_branch_likely() from
 __ptr_to_hashval().
Message-ID: <YufKL+3AKhLmlAcK@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-2-bigeasy@linutronix.de>
 <YufDcPfth9JH6SaV@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufDcPfth9JH6SaV@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 14:13:36 [+0200], Jason A. Donenfeld wrote:
> Also,
> 
> On Fri, Jul 29, 2022 at 05:47:15PM +0200, Sebastian Andrzej Siewior wrote:
> >  		if (!filled) {
> >  			get_random_bytes(&ptr_key, sizeof(ptr_key));
> > -			queue_work(system_unbound_wq, &enable_ptr_key_work);
> > +			/* Pairs with smp_rmb() before reading ptr_key. */
> > +			smp_wmb();
> > +			WRITE_ONCE(filled_random_ptr_key, true);
> >  			filled = true;
> 
> Also, should `filled` be changed there?

you change `filled` as in read_mostly?

> Jason

Sebastian
