Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E088E586C35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiHANrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHANrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:47:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04833404
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:47:06 -0700 (PDT)
Date:   Mon, 1 Aug 2022 15:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659361624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBegCjVa+YzCsgk81wGrCFIlyLBGmWu7lUSG3BH6/uQ=;
        b=Ewn1KI66JzdtCoadPTYqizLiCfOYv4H1Src3G6SiJqBqib1VcwMDRn3bbBj00z6Lqc2E8R
        1uyJJRFJqhjXuT+szjYcQA6urCajVwWIoYFlYv2ejMN3yyIZ52jiWZKjqIXulbSInc2GMd
        34gYF2hA6k796vet3DSPB+31qkmwBk27ftdsjmI88R2SzarSPmpyfx58+lu0GHi9ZhFHHe
        GEXV9ET0C165uA9rYmuIGN07KmNB7Pv7P007Au7g7KJei6+YxyKDap+dMTqeAX10GFWYV1
        x3SkIxZQvZCx/lFjB438DgGZ7bgCFyt+zlRq3sLyeRVbX1hkEqq6xMvOdsOG2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659361624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBegCjVa+YzCsgk81wGrCFIlyLBGmWu7lUSG3BH6/uQ=;
        b=axeBgm9iMjeWW5TrcalRl7NmWF9Cfjr5oXBzNZgJZu597V13wWKvNuq2mmovuKc//9DhQ6
        UwbmsUFlvAVPNQAQ==
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
Subject: Re: [PATCH v4] lib/vsprintf: defer filling siphash key on RT
Message-ID: <YufZVy5adMfl3n9g@linutronix.de>
References: <YufHN7fF0dROMETj@zx2c4.com>
 <20220801123945.43081-1-Jason@zx2c4.com>
 <YufLK6hio/v1gfmq@linutronix.de>
 <YufW4G/A3eQKpdjj@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufW4G/A3eQKpdjj@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 15:36:32 [+0200], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> > Can have the same behaviour regardless of CONFIG_PREEMPT_RT? Here
> > lockdep _may_ yell with !RT because it is broken for RT.
> > If we agree that we drop the first %p print here, can we do this on
> > both (regardless of CONFIG_PREEMPT_RT)?
> 
> "Lockdep may yell" -- but this would be when lockdep is turned on to
> catch RT bugs, not to catch non-RT bugs. The actual bug only exists on
> RT. This is an RT problem. Stop pretending that this is a real issue
> outside of RT. It isn't. This is *only* an RT issue. So why would we
> make things worse for an issue that doesn't actually exist on non-RT?

You do remember the warning that poped up in random core with
CONFIG_PROVE_RAW_LOCK_NESTING enabled? Where I said it does not affect
!RT it just points out a RT problem in a !RT config?
If you fix this with one code path for RT and another one for !RT then
you will have this warning _if_ the caller has a raw_spinlock_t
acquired.

> I too generally prefer having only one code path and not two. But the
> way this patch is written, the worker function just gets reused with a
> straight call on the non-RT case, so it doesn't actually require
> duplicating code.

> Jason

Sebastian
