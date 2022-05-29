Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E482537223
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiE2SQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiE2SQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:16:03 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DD85EEB;
        Sun, 29 May 2022 11:16:02 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id el14so1630992qvb.7;
        Sun, 29 May 2022 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hhle5SlXF7GWN568wF6/BUIAe2M7L4YD+7P2ydMa3hs=;
        b=SoSsqXPDwzFkBVjevXcjgnDb+ttHq9Qz+lZxLMadexERcKkRn+NpxTmC8oQqL31bV1
         yGcP1fBAo+bzD/mkhuRwuiex9VLk8y+Y7xejGE+PG8emXR5YxLXGEIZwTTw0wKsM3AL5
         HRljSlSq6mCoQvwVB16fZtYnkSd0mwJKf6+gZfq9mUGjMhZV7FvahuSnTb7XIArzE0iQ
         VjXu8cda7Jgq8nNG9+tEFsu+vHyeufGP95uVhC0j2rP53YxcEdFadBXi9aogEs3GPQPl
         JCgGkEcM0Ft7yQSDJWxuBdh3g05QHQcJSQ7KcirfMya3n0dZCUkO0x1uamZqgALnW9AT
         udOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hhle5SlXF7GWN568wF6/BUIAe2M7L4YD+7P2ydMa3hs=;
        b=3F78zzw+Ak/znYRbGOyMhxV37Cikb4Mly4hhasgonJnpdTSS6eK4ynRJq47b1WfHFq
         Q/edcSNJh3UbGqW2OaqPPPQWnJhdTqE20wpdDQDZ+FvegxPMkBBI5NaOjjw8MLYmQpYA
         Pv1HOv0NKH1lRdrz+wU56cquQdduhGUO1QOlaZsstKVwhjCBy0vNYXyCi0cR7YqBlG0B
         FZedGEIJNiB+7VDyQuXBFAwBpd73c1T0McxHVBXAxFaW+PuHFMJM0pRXxxg+TeySUgYx
         RcOmpRHV8geA3JeUQtfv9eKWi5lClLUc8a2tlFe5tDTP7Gb/i5/lIgduR8W5hL79zZL9
         GH9g==
X-Gm-Message-State: AOAM5337K+NHjmoTDvJFxJdUjcwDKUQ7gG1fILZ0xUBwTk/tNILa2o+s
        mrhdV4AkR/0txQmev4VPxOpIXqIMog==
X-Google-Smtp-Source: ABdhPJxZ83y8KdlQCucXKyyYQj8mKyCi2GBon2ZAjLxwEAIshsWpoTFETjASvaB9izGNJ12YWIsjqw==
X-Received: by 2002:a05:6214:27ce:b0:461:dec4:1bb6 with SMTP id ge14-20020a05621427ce00b00461dec41bb6mr42794790qvb.46.1653848161324;
        Sun, 29 May 2022 11:16:01 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y9-20020ac87089000000b002f9114d2ebcsm6086613qto.17.2022.05.29.11.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:16:00 -0700 (PDT)
Date:   Sun, 29 May 2022 14:15:58 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <20220529181558.pg4knymlixphra5i@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-2-kent.overstreet@gmail.com>
 <Yo+XZ4YtU9fN/sGE@alley>
 <20220526152127.gw7gb4jnoikop4hl@moria.home.lan>
 <YpCoADIEWi9flgSf@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpCoADIEWi9flgSf@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:29:20PM +0200, Petr Mladek wrote:
> I would really like to keep the three APIs separated and easy to
> distinguish. They are principally different:
> 
> 1. pr_*() API:
> 
>        + wrapper to printk(). They makes the messages available on
> 	 console and for user-space log daemons while printf()
> 
>       + the various pr_*() variants are used to define kernel
> 	specific features and behavior, for example:
> 	loglevel, ratelimit, only once. deferred console handling.
> 
>        + uses implicit (system) buffer
> 
>        + The message format is defined by the 1st parameter. It
> 	 is the same way as printf() in user-space.
> 
>        + It is inspired by printf() from user-space that prints
> 	 the messages to the standard output.
> 
> 
> 2. *s*printf() APIs:
> 
>        + basically duplicate the same user-space API. It supports
> 	 some extra %p modifiers. There might be few more
> 	 incompatibilities.
> 
>        + use simple "char *" buffer provided as the 1st parameter
> 
>        + the messages format is defined the same way as in
> 	 the user-space counterparts.

After printbufs are merged, I think we should consider formally deprecating
sprintf/snprintf, certainly for new code. As you saw from the vsprintf.c
cleanup, printbufs are _much_ nicer than passing around char */length - it's
2022, we shouldn't be doing that anymore!

> 
> 
> 3. printbuf API:
> 
>        + append messages into the given printbuf by small pieces
> 
>        + format defined by the suffix, for example, _char(),
> 	 bytes(), units_64(), _tab(), indent()
> 
>        + allows to do special operations on the buffer,
> 	 for example, _reset(), make_room(), atomic_inc()

atomic_inc() should not exist in the long term - we _really_ need
memalloc_nowait_(save|restore), that's the correct way to do this.

>        + it will be used as low-level API for vscnprinf()
> 	 implementation, pretty printing API, or
> 	 stand alone uses.
> 
>        + I wonder if there will be variant that will allow
> 	 to pass the format in the printf() way, e.g.
> 	 int pb_printf(printbuf *buf, const char *fmt, ...);

That's pr_buf()/vpr_buf(), and I heavily use pr_buf() in my own code.

snprintf() is just a wrapper around pr_buf() now.

>        + is there any user space counter part?

I've been using the previous version of this code in userspace that was part of
bcachefs, and my intention is very much for this code to also be used in
userspace as well.

Bringing the base printbuf API to userspace is trivial - i.e. doing it as a
wrapper around snprintf(), which is how printbufs started. However, the %(%p)
format string extension for calling pretty-printers directly - which I badly
want and think is far superior to what glibc has [1], will also require patching
glibc (and gcc, to get the format string that we want).

So that'll be a little ways off.

> Now, it is clear that printfbuf API must be distinguished by another
> prefix:
> 
>        + it must be clear that it stores the output into printbuf.
> 	 It is similar to dprintf(), fprintf(), sprintf().
> 
>        + It can't be done by the suffix because it is already used
> 	 to define format of the appended string or extra operation.
> 
>        + It must be clear what is low-level API used to implement
> 	 vsprintf() and high-level API that uses vsprintf().
> 	 I mean pb_char() vs. pb_printf().

I'm coming around to the pb_* naming idea. pbprintf() doesn't roll off the
tongue in the same way that pr_buf() does, but I guess I can live with that.

1: https://www.gnu.org/software/libc/manual/html_node/Printf-Extension-Example.html
