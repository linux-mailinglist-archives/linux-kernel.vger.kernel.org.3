Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338C544BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiFIM1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiFIM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:27:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99D13EAF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F7D4B82D31
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A28C34114;
        Thu,  9 Jun 2022 12:27:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cL/t578z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654777638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jmAyfJLi9ZPxrr5XglUuWLKXwd2sQ5F4418QWy98e5Q=;
        b=cL/t578zwy2SyTTjrlTP22f5QIRFvmgvvl9HuxtD+7WAkfIJY5OTtDsziFj4ML1n+HfiW8
        W3wiYocFp64vZeE7bjSyNLOazgsL+zYQ+VlLYMb6/H6u2vajPcU9DTyCO1x8eLin2OR6q9
        T6JGHso3VsxHLGkcRD/jFuzU5W2+hFg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 969d3aeb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 9 Jun 2022 12:27:18 +0000 (UTC)
Date:   Thu, 9 Jun 2022 14:27:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        bigeasy@linutronix.de
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <YqHnH+Yc4TCOXa9X@zx2c4.com>
References: <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <87y1zkkrjy.fsf@jogness.linutronix.de>
 <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
 <87fske3wzw.fsf@jogness.linutronix.de>
 <YqHgdECTYFNJgdGc@zx2c4.com>
 <CACT4Y+ajfVUkqAjAin73ftqAz=HmLX=p=S=HRV1qe-8_y36J+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ajfVUkqAjAin73ftqAz=HmLX=p=S=HRV1qe-8_y36J+A@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Jun 09, 2022 at 02:18:19PM +0200, Dmitry Vyukov wrote:
> > AFAIK, CONFIG_PROVE_RAW_LOCK_NESTING is useful for teasing out cases
> > where RT's raw spinlocks will nest wrong with RT's sleeping spinlocks.
> > But nobody who wants an RT kernel will be using KFENCE. So this seems
> > like a non-issue? Maybe just add a `depends on !KFENCE` to
> > PROVE_RAW_LOCK_NESTING?
> 
> Don't know if there are other good solutions (of similar simplicity).

Fortunately, I found one that solves things without needing to
compromise on anything:
https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com/

> Btw, should this new CONFIG_PROVE_RAW_LOCK_NESTING be generally
> enabled on testing systems? We don't have it enabled on syzbot.

Last time I spoke with RT people about this, the goal was eventually to
*always* enable it when lock proving is enabled, but there are too many
bugs and cases now to do that, so it's an opt-in. I might be
misremembering, though, so CC'ing Sebastian in case he wants to chime
in.

Jason
