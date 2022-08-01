Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5940586B48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiHAMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiHAMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA33491D3
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:41:10 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:41:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659357668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=La2sbQ9QHGRUYZeHQhEJSOuqoc7oXDJqO4gi+SxeHE8=;
        b=g7WTH7re7ZeZ2PTHIMVLw4W612ntnqV5R97nPX9pjQ1rDRsUFCWw2KI+FqF81OOIV3fxyN
        bk8WXwLY9sd+zAPeSWk+sx5s8w8GsmnnXxbpCelhP4+0i88AF3ow2IoPSGL4yB90VTRpaa
        6MGFl1bMz/GUijKfSQwOhwKrDVD7/OsfjbAUDDCmOjL/rdADb2wnuvvVozoGluxURK58YR
        W3w0E6sF3p/5Eg/RGIk4Io/F5VxhM7cnMgeFv6yBh87F/6TbMU6t82kKYQ/kp1IC4CRYnQ
        ruyrC0qbof9J4vB/hV8GGCyK4u+hU/BEM7olXO7+tqbqOUdhda1LBjlYntgnCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659357668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=La2sbQ9QHGRUYZeHQhEJSOuqoc7oXDJqO4gi+SxeHE8=;
        b=KguD+Vtr7UZic0QgcmAYIFkCfTBpIfIMZkxXrisPfa4p+DJMOxtgwAakLf3oWn5hvU9dXE
        LEXdlciV5FJUAHAw==
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
Subject: Re: [PATCH 2/2 v3] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YufJ4vQyAMkU9HBx@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
 <YuRtSGCfe2qxHrqT@zx2c4.com>
 <YueBnnnnvpxxjE4N@linutronix.de>
 <YueeIgPGUJgsnsAh@linutronix.de>
 <YufHN7fF0dROMETj@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufHN7fF0dROMETj@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 14:36:48 [+0200], Jason A. Donenfeld wrote:
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -751,31 +751,39 @@ static int __init debug_boot_weak_hash_e
> >  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
> >  
> >  static bool filled_random_ptr_key;
> > +static siphash_key_t ptr_key __read_mostly;
> > +static void fill_ptr_key_workfn(struct work_struct *work);
> > +static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
> > +
> > +static void fill_ptr_key_workfn(struct work_struct *work)
> > +{
> > +	if (!rng_is_initialized()) {
> > +		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
> > +		return;
> > +	}
> 
> This seems kind of crazy and over-complex. You only need this on RT,
> right? Because of the raw lock issue? So just schedule it for the right
> time on RT and not elsewhere.

Then we have two code paths for RT and !RT and I would to avoid that
especially if it ends up as a user visible change.
And then there is lockdep which might yell on !RT if you acquire a
spinlock_t from context which won't work on RT.

> I'll send a more basic patch.

oki.

> Jason

Sebastian
