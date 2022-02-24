Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028274C28AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiBXJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiBXJ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E87C285A81;
        Thu, 24 Feb 2022 01:55:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D208F1F39D;
        Thu, 24 Feb 2022 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645696533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V64EY2xZ8VQBJVMum6ehFvzyW9PFd84v2yMNlyQX8xw=;
        b=lOMKdP9vM+dUcGysGquWFo/cCNKdSUpiiRkrtifeupt+MPJOMb/sCRwXRW1ExpI6NzjvLF
        DZCqhAkZ4xPnyW01xRlKrsRFxila/FIGWZFnazGpIk2POlKI4bp5uPXYHptdG6fizeqjmN
        G24L9LhOOxz0L1ZpbdNR52arfbLgCJM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8BF72A3B8A;
        Thu, 24 Feb 2022 09:55:33 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:55:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Message-ID: <YhdWFRGHpeOn+e0F@alley>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
 <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
 <CANiq72=mNh415UG_nxDQc=9SCSVSPnqcAbgFZKzavnmsim_L0Q@mail.gmail.com>
 <YhSs5ZTL9ixdCCU9@alley>
 <10bbffc2-f144-8555-d41b-fede69a13c16@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bbffc2-f144-8555-d41b-fede69a13c16@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 11:35:39, Rasmus Villemoes wrote:
> On 22/02/2022 10.29, Petr Mladek wrote:
> > On Mon 2022-02-14 13:12:24, Miguel Ojeda wrote:
> >> On Mon, Feb 14, 2022 at 11:52 AM Rasmus Villemoes
> >> <linux@rasmusvillemoes.dk> wrote:
> >>>
> >>> I think the point is for vsnprintf() to call (back) into Rust code.
> >>
> >> Indeed, this is the case.
> >>
> >>> That said, I don't like the !CONFIG_RUST version to return NULL, that
> >>> will surely crash moments later.
> >>>
> >>> So I prefer something like
> >>>
> >>> [rust.h]
> >>> // no CONFIG_RUST conditional
> >>> +char *rust_fmt_argument(char* buf, char* end, void *ptr);
> >>>
> >>> [vsprintf.c]
> >>> +       case 'A':
> >>> +               if (IS_ENABLED(CONFIG_RUST))
> >>> +                   return rust_fmt_argument(buf, end, ptr);
> >>> +               else
> >>> +                   return string_nocheck(buf, end, "[%pA in non-Rust
> >>> code?!]", default_str_spec);
> > 
> > Any long message might cause buffer overflow when the caller expects
> > fixed short string.
> 
> If the caller (1) uses a %p extension from C code which should only be
> used from Rust and (2) uses sprintf() or another variant where he
> doesn't provide the real buffer bounds, well, then he certainly gets to
> keep the pieces.
> 
> It is a much worse problem that if CONFIG_RUST is enabled, we can't know
> that we were actually called from Rust (but when !CONFIG_RUST, we
> certainly know that we weren't), so we could call into rust_fmt_argument
> with a pointer which certainly doesn't point to the/a data structure
> which that Rust code expects. But we can't do anything about it, we will
> just have to rely on static analysis to flag any use of %pA in C code.

Yeah. !CONFIG_RUST would trigger the warning and help to find the
sinners but it is not reliable. Static analysic might be better...

> > The most safe solution would be to use WARN_ONCE(). 
> 
> Preferably no, we shouldn't call into the printk machinery from within
> vsnprintf(). I know I've added a few myself (AFAIR for use of %n or
> other unsupported specifiers, and for overflow of precision/field
> width), and I've often thought about a way to get rid of them while
> still making sure some message eventually gets logged (once).

WARN_ONCE() in vsprintf() code is much more acceptable these days
with the lockless ringbuffer.

Best Regards,
Petr
