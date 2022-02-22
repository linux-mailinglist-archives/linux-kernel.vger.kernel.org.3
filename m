Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC64BF4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiBVJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiBVJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:29:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982781598D8;
        Tue, 22 Feb 2022 01:29:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4F38E210EE;
        Tue, 22 Feb 2022 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645522151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KO9eSAjyIM0oRKAVo7/HRTrFsIPM0SoTnTaPPETnAI=;
        b=gWr9jFCVNMp0NS6myO8IsSwi8Su0xubP8F9Vp/bHj/ai0BWW0aY5D+2bajebQBiFTBviZL
        2O2hsnQv8l3A7/aus7rSDeAuMVy+TwS4/Tk0uXN3QWPmPIDTr8S1I1eC0j2qH4r9BVSMmf
        n+TU4aQxXk1oDl6eGA/jV/P05lOAMVc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5477A3B83;
        Tue, 22 Feb 2022 09:29:10 +0000 (UTC)
Date:   Tue, 22 Feb 2022 10:29:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Message-ID: <YhSs5ZTL9ixdCCU9@alley>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
 <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
 <CANiq72=mNh415UG_nxDQc=9SCSVSPnqcAbgFZKzavnmsim_L0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=mNh415UG_nxDQc=9SCSVSPnqcAbgFZKzavnmsim_L0Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 13:12:24, Miguel Ojeda wrote:
> On Mon, Feb 14, 2022 at 11:52 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > I think the point is for vsnprintf() to call (back) into Rust code.
> 
> Indeed, this is the case.
> 
> > That said, I don't like the !CONFIG_RUST version to return NULL, that
> > will surely crash moments later.
> >
> > So I prefer something like
> >
> > [rust.h]
> > // no CONFIG_RUST conditional
> > +char *rust_fmt_argument(char* buf, char* end, void *ptr);
> >
> > [vsprintf.c]
> > +       case 'A':
> > +               if (IS_ENABLED(CONFIG_RUST))
> > +                   return rust_fmt_argument(buf, end, ptr);
> > +               else
> > +                   return string_nocheck(buf, end, "[%pA in non-Rust
> > code?!]", default_str_spec);

Any long message might cause buffer overflow when the caller expects
fixed short string.

> Sounds good. Or perhaps simply `break` and let it print the pointer
> (to be consistent with `g` case and non-error `e` case).

Also this might cause buffer overflow.

The most safe solution would be to use WARN_ONCE(). The only drawback
is that it might cause panic() when using "panic_on_warn" kernel
parameter. But it will not open security hole.

Best Regards,
Petr
