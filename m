Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53754FB67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383441AbiFQQtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383444AbiFQQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:49:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59341EC7C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:48:47 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655484524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZNnFZWTpGOh34PezP9zx8zTHJmgqawQXcsCphAXtRE=;
        b=KFIh50AnP7x90rLd8E/Jd7VNTDB0ZjdnIfwtjTnzpDDVeYDHGv7Muoj4Cl3Fztp95DaskO
        PNg9C+ZCvAziko6U2b7b9V/1yj1trHUj08yRmQaTBjkhKkW3UyACv7KHmwJmV9PTOLWYNm
        faQ6O6Vta9dwZ6jyOcRjAbEqyn/2mBxsoc1hhXCgIkQoMzx7zHG+iGArvILTMn3ueX84yF
        54ZaOYZDd2QIYsFxGG0uGhogqVx8SXNXlpbgITLPZZAoetaeHWqL/Zb+julA7RKNBM+Z9z
        xyPIsXpTjWpu51NQg/UVzHoNFJSWMRkTg2O2P0cFA3tJucYFjm40Zk0SDtD0vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655484524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZNnFZWTpGOh34PezP9zx8zTHJmgqawQXcsCphAXtRE=;
        b=2agDK2fIdiLRAg1Gb6wuPEF+97wxLIue6b7U8f1kzU/PN2gSrNNsLC6DRSG1GAVT/JZ6KL
        2PI+jvewV6W2efCA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <YqywapDM7NPC/X+E@linutronix.de>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-05 20:07:27 [+0200], Jason A. Donenfeld wrote:
> One funny aspect of the fact that signal_pending() hasn't worked right
> since the genesis commit is that this has probably led to a lot of
> userspace code that doesn't check the result from read() or
> getrandom(), and that code has worked mostly fine.

:)

> I wonder if we should do something about that. Worth noting is that
> we're no longer contending with /dev/random periodically blocking as
> the "entropy runs out" nonsense. I can think of two possible changes,
> which maybe aren't mutually exclusive:
> 
> 1) Turn signal_pending() into fatal_signal_pending() throughout the file.
> 2) Rather than not checking signal_pending() for reads of length <=
> 256, we could not check for signal_pending() for the first 256 bytes
> of any length read.
> 
> Both of these would be changing userspace behavior, so it should
> probably be considered carefully. Any thoughts?

You are not doing any blocking as far as I can tell so there won't be
any wake up via TASK_INTERRUPTIBLE for you here.
You check for the signal_pending() every PAGE_SIZE so there will be at
least 4KiB of data, not sure where this 256 is coming from.
Since you always return the number of bytes, there won't be any visible
change for requests < PAGE_SIZE. And for requests > PAGE_SIZE your
getrandom() invocation may return less than asked for. This is _now_.

If you drop that signal_pending() check then the user will always get
the number of bytes he asked for. Given that this is *quick* as in
no blocking, then there should be no harm in dropping this signal check.

> Jason

Sebastian
