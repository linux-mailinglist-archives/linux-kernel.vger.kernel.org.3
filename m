Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB2535E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiE0K3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350988AbiE0K32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:29:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7A12AB05;
        Fri, 27 May 2022 03:29:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED529219AC;
        Fri, 27 May 2022 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653647364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2R9qKdleRs8gByDqtRpf7rFuQ5Wqruhmv5hcFSY20I=;
        b=i+fAIbnglItVLQVZF1/abDNZofHSJPC/FCa/AJX1OKuhIRYYSbcw5kYdtT/ZwfZbX0pjqL
        bD+b3ewbBCzX9zGC/BPLGnB97SjvytIilWbs/Z4Dt7aYVU+EJmbjerXfNBpNm6mMHy0QRq
        KoRTVJSamMXUnOdB+FbSClHdFdVE/Z8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6F66F2C146;
        Fri, 27 May 2022 10:29:24 +0000 (UTC)
Date:   Fri, 27 May 2022 12:29:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <YpCoADIEWi9flgSf@alley>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-2-kent.overstreet@gmail.com>
 <Yo+XZ4YtU9fN/sGE@alley>
 <20220526152127.gw7gb4jnoikop4hl@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526152127.gw7gb4jnoikop4hl@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-05-26 11:21:27, Kent Overstreet wrote:
> On Thu, May 26, 2022 at 05:06:15PM +0200, Petr Mladek wrote:
> > On Thu 2022-05-19 13:23:54, Kent Overstreet wrote:
> > > This adds printbufs: a printbuf points to a char * buffer and knows the
> > > size of the output buffer as well as the current output position.
> > > 
> > > Future patches will be adding more features to printbuf, but initially
> > > printbufs are targeted at refactoring and improving our existing code in
> > > lib/vsprintf.c - so this initial printbuf patch has the features
> > > required for that.
> > 
> > > diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> > > new file mode 100644
> > > index 0000000000..40dc07040d
> > > --- /dev/null
> > > +++ b/include/linux/printbuf.h
> > > +static inline void pr_chars(struct printbuf *out, char c, unsigned n)
> > > +{
> > > +	memset(out->buf + out->pos,
> > > +	       c,
> > > +	       min(n, printbuf_remaining(out)));
> > > +	out->pos += n;
> > > +	printbuf_nul_terminate(out);
> > > +}
> > 
> > This function is not later used. Please, do not add API
> > that will not have users in the same patchset.
> > 
> > There are several other cases. I am not going to comment
> > all of them.
> 
> It is used in this patchset, in lib/vsnprintf.c. You sure about the other cases?

Ah, I used outdated cscope. This was bad example.

> > > +static inline void __pr_char(struct printbuf *out, char c)
> > > +{
> > > +	if (printbuf_remaining(out))
> > > +		out->buf[out->pos] = c;
> > > +	out->pos++;
> > > +}
> > > +
> > > +static inline void pr_char(struct printbuf *out, char c)
> > > +{
> > > +	__pr_char(out, c);
> > > +	printbuf_nul_terminate(out);
> > > +}
> > 
> > The "pr_" prefix is a nightmare for me because the same prefix
> > is used also for printk() API ;-)
> > 
> > Could we please use "pb_" instead?
> 
> I'm not entirely against that, but I see printbufs as already in this patchset
> tightly coupled to vsprintf.c and thus quite related to printk, as well - and
> there aren't that many different pr_ things. So I think the shared prefix makes
> some sense, I'd like to hear what others think before making that change.

I would really like to keep the three APIs separated and easy to
distinguish. They are principally different:

1. pr_*() API:

       + wrapper to printk(). They makes the messages available on
	 console and for user-space log daemons while printf()

      + the various pr_*() variants are used to define kernel
	specific features and behavior, for example:
	loglevel, ratelimit, only once. deferred console handling.

       + uses implicit (system) buffer

       + The message format is defined by the 1st parameter. It
	 is the same way as printf() in user-space.

       + It is inspired by printf() from user-space that prints
	 the messages to the standard output.


2. *s*printf() APIs:

       + basically duplicate the same user-space API. It supports
	 some extra %p modifiers. There might be few more
	 incompatibilities.

       + use simple "char *" buffer provided as the 1st parameter

       + the messages format is defined the same way as in
	 the user-space counterparts.


3. printbuf API:

       + append messages into the given printbuf by small pieces

       + format defined by the suffix, for example, _char(),
	 bytes(), units_64(), _tab(), indent()

       + allows to do special operations on the buffer,
	 for example, _reset(), make_room(), atomic_inc()

       + it will be used as low-level API for vscnprinf()
	 implementation, pretty printing API, or
	 stand alone uses.

       + I wonder if there will be variant that will allow
	 to pass the format in the printf() way, e.g.
	 int pb_printf(printbuf *buf, const char *fmt, ...);

       + is there any user space counter part?


Now, it is clear that printfbuf API must be distinguished by another
prefix:

       + it must be clear that it stores the output into printbuf.
	 It is similar to dprintf(), fprintf(), sprintf().

       + It can't be done by the suffix because it is already used
	 to define format of the appended string or extra operation.

       + It must be clear what is low-level API used to implement
	 vsprintf() and high-level API that uses vsprintf().
	 I mean pb_char() vs. pb_printf().


Best Regards,
Petr

PS: I probably won't find time to write more comments on this patchset
    today. I'll continue the following week. It seems that it will
    be a long journey.
