Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4154FB9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383481AbiFQQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383455AbiFQQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:53:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B095A0A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:51:52 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:51:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655484710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UykvkKuHPgfnuKIJnIaYfKgo9S8iB+wmFcj7vk45wVs=;
        b=eUu/qClCX/d2AouxGZPJTmu48AdbHUOAEqK6i7LTOzrgE4GEiltOUP/aJutgp44nPnjM1S
        ulO0fZvQYiVcMfcod60L0fl3em63i+QghmCscjAvwGb0MsWcIiu7iqKCZEdO+OY50UIAWi
        Fzew3TXJ8JyJ31M5UjJ+UNJvMh+wufip+FNl1U45LGUmqJTGg/BwzaScUhjC14W2WpoYGb
        MWR63P+t6DeKQTXOdDHQPaH/tLPjlCbOP0/O0DhvtyiUkuQZUOA81nEFSDVBi44tlsUGpt
        q5eEmHXyFIG5Y6DNq8uYSnfp7/EMsOHcfSZWSQnIs/N65YiLViv4oc/1Ii/WQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655484710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UykvkKuHPgfnuKIJnIaYfKgo9S8iB+wmFcj7vk45wVs=;
        b=+gB6pnNuCevctPh8aBUsQrzYo/gPjJ8DZnaghzrYDBDxO0I6SqrmLwluRFEY2z9zzM9Eox
        CDKIjQ9JrIzSaRBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <YqyxJJ8Jrr4zEPmM@linutronix.de>
References: <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <87y1zkkrjy.fsf@jogness.linutronix.de>
 <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
 <87fske3wzw.fsf@jogness.linutronix.de>
 <YqHgdECTYFNJgdGc@zx2c4.com>
 <CACT4Y+ajfVUkqAjAin73ftqAz=HmLX=p=S=HRV1qe-8_y36J+A@mail.gmail.com>
 <YqHnH+Yc4TCOXa9X@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqHnH+Yc4TCOXa9X@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-09 14:27:11 [+0200], Jason A. Donenfeld wrote:
> Hi Dmitry,
> 
> On Thu, Jun 09, 2022 at 02:18:19PM +0200, Dmitry Vyukov wrote:
> > > AFAIK, CONFIG_PROVE_RAW_LOCK_NESTING is useful for teasing out cases
> > > where RT's raw spinlocks will nest wrong with RT's sleeping spinlocks.
> > > But nobody who wants an RT kernel will be using KFENCE. So this seems
> > > like a non-issue? Maybe just add a `depends on !KFENCE` to
> > > PROVE_RAW_LOCK_NESTING?
> > 
> > Don't know if there are other good solutions (of similar simplicity).
> 
> Fortunately, I found one that solves things without needing to
> compromise on anything:
> https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com/
> 
> > Btw, should this new CONFIG_PROVE_RAW_LOCK_NESTING be generally
> > enabled on testing systems? We don't have it enabled on syzbot.
> 
> Last time I spoke with RT people about this, the goal was eventually to
> *always* enable it when lock proving is enabled, but there are too many
> bugs and cases now to do that, so it's an opt-in. I might be
> misremembering, though, so CC'ing Sebastian in case he wants to chime
> in.

That is basically still the case. If CONFIG_PROVE_RAW_LOCK_NESTING yells
then there will be yelling on PREEMPT_RT, too. We would like to get
things fixed ;)

Without going through this thread, John is looking at printk and printk
triggers a few of those. That is one of reasons why this is not enabled
by default.

> Jason

Sebastian
