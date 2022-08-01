Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D393A586B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiHAMtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiHAMtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569149B65
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:41:45 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:41:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659357704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpIqKYelvYVhBD9gTR+G4G3xo/eCXNkgJOTuuEra6qU=;
        b=MIggd8TRbRIf64PsbfADmjxM+uVbpVs/8kxN7fQMNVEwQW+1Jayqp0hzUAQW0ekHFCgYXJ
        NR3Jbhb7bMTEDnem0GkamnY6VLJ/UCb38tGrDyL2tmH0Uh++FND/k5pcGLkhRfXsywwckW
        2Sm1PiLNinu6eCd4hocUOcrnqcXS7VZx9Z0hvsYMnGjrqiSaAPuyJjsbs9pYHxkFrO4Zy/
        rRb/fVJWfvpVmbCGuxIK9pCo4BqAkPsop05AFB7l1TlkZt6s4UUabn9f5ztCwLxg3j6BH6
        mxowF+U3AkgVotRgx9bD79KgY8S2dQIKHaBTR38RHV91WTbVKquhNc/0eLUyFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659357704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpIqKYelvYVhBD9gTR+G4G3xo/eCXNkgJOTuuEra6qU=;
        b=QRFr/csGAcUWzG94Ru431DgKRbvMNmpAuUYBFPhxwZMWcrOUOGkw7+ePEE241+iee3qLW2
        075xT9TvE9K1u/BQ==
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
Message-ID: <YufKBytKQOoXgFae@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-2-bigeasy@linutronix.de>
 <YufC9XCej2qmcH8p@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufC9XCej2qmcH8p@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 14:11:33 [+0200], Jason A. Donenfeld wrote:
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -750,12 +750,7 @@ static int __init debug_boot_weak_hash_e
> >  }
> >  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
> >  
> > -static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
> > -
> > -static void enable_ptr_key_workfn(struct work_struct *work)
> > -{
> > -	static_branch_enable(&filled_random_ptr_key);
> > -}
> > +static bool filled_random_ptr_key;
> 
> This should be __read_mostly, right? Just like ptr_key.

could be, yes.

> Jason

Sebastian
