Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA5552C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347938AbiFUH72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347916AbiFUH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:58:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D8C5F6E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:58:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c2so21046267lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rAupvnq6gF+hfLMwbK5FyshoSuZewieI0Qe5jG8mpEQ=;
        b=SHZB3elG8KdiWQghfW62kq8Y+JxtW3U7O18wzOMTwfPmoGL+RUVIV4mssgQfpyX/rP
         AYyxH5BAB0QHlruVFAoHSzDP3uKW1fHvwoFgiP6f+pR8W7+QfS4k0jmuVeVzhWW8gnxx
         6Ccwc2mdBKx0lDj0U9XrhF+UuQLBKJIJ4Bc4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rAupvnq6gF+hfLMwbK5FyshoSuZewieI0Qe5jG8mpEQ=;
        b=i9ENdQ2fuUDBD2uoxwoBR4mD+MNoBqPoLYrWXPEm/TWlrlrUkaassphM8mEDzo8px5
         ZYiLf5VDTbLDYEzXsUW1BJwjLti9Wrniwel+5ZmJ3WGJdvmF2YKg0FLKm+vjDjXDh0aa
         ZI6OGwR1597b9ztHnPl50OW9PkyiOjxTOwv6UvifzLr7VoueR0XSLSIkLRICG6wu3Xyv
         2zWZJJrBWawOdYf4ubhXIP5rHF2H7Uvi/uIf7w7OUfwBpb+Ihnq10zUxE6Qsjk725hNh
         nBW/O+JeeAic0TMUqTIAQy+Ii5Qp3Q4O2+R9z07ElP7Eru6DLyRr+3ZUj0RDWxBHrSiB
         gd7w==
X-Gm-Message-State: AJIora81UTx9d2XN69achTxV9KptWoTQZhH71iP4uT6KwZweyNX1IxEU
        w3VcZnssebroWLktuFjpMejHXQ==
X-Google-Smtp-Source: AGRyM1uvyHwv5Nms9vMGrT+Pj3Myl57qJQnwG96nAmt2D1U+IkwcRVqRNQQZtUK91Tb/HD+gpUxTMw==
X-Received: by 2002:a05:6512:1523:b0:47f:7940:4a24 with SMTP id bq35-20020a056512152300b0047f79404a24mr2767391lfb.516.1655798301954;
        Tue, 21 Jun 2022 00:58:21 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h20-20020a05651c125400b0024f3d1daea2sm1938664ljh.42.2022.06.21.00.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:58:20 -0700 (PDT)
Message-ID: <44e37b45-55cf-3705-e5e6-e3921d3646c4@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 09:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 07/34] lib/printbuf: Heap allocation
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-8-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220620004233.3805-8-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 02.42, Kent Overstreet wrote:
> This makes printbufs optionally heap allocated: a printbuf initialized
> with the PRINTBUF initializer will automatically heap allocate and
> resize as needed.
> 
> Allocations are done with GFP_KERNEL: code should use e.g.
> memalloc_nofs_save()/restore() as needed. Since we do not currently have
> memalloc_nowait_save()/restore(), in contexts where it is not safe to
> block we provide the helpers
> 
>   printbuf_atomic_inc()
>   printbuf_atomic_dec()
> 
> When the atomic count is nonzero, memory allocations will be done with
> GFP_NOWAIT.
> 
> On memory allocation failure, output will be truncated. Code that wishes
> to check for memory allocation failure (in contexts where we should
> return -ENOMEM) should check if printbuf->allocation_failure is set.
> Since printbufs are expected to be typically used for log messages and
> on a best effort basis, we don't return errors directly.
> 
> Other helpers provided by this patch:
> 
>  - printbuf_make_room(buf, extra)
>    Reallocates if necessary to make room for @extra bytes (not including
>    terminating null).
> 
>  - printbuf_str(buf)
>    Returns a null terminated string equivalent to the contents of @buf.
>    If @buf was never allocated (or allocation failed), returns a
>    constant empty string.
> 
>  - printbuf_exit(buf)
>    Releases memory allocated by a printbuf.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  include/linux/printbuf.h | 120 +++++++++++++++++++++++++++++++++------
>  lib/Makefile             |   2 +-
>  lib/printbuf.c           |  71 +++++++++++++++++++++++
>  3 files changed, 175 insertions(+), 18 deletions(-)
>  create mode 100644 lib/printbuf.c
> 
> diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> index 8186c447ca..382863afa7 100644
> --- a/include/linux/printbuf.h
> +++ b/include/linux/printbuf.h
> @@ -4,19 +4,69 @@
>  #ifndef _LINUX_PRINTBUF_H
>  #define _LINUX_PRINTBUF_H
>  
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> -
>  /*
> - * Printbufs: String buffer for outputting (printing) to, for vsnprintf
> + * Printbufs: Simple strings for printing to, with optional heap allocation
> + *
> + * This code has provisions for use in userspace, to aid in making other code
> + * portable between kernelspace and userspace.
> + *
> + * Basic example:
> + *   struct printbuf buf = PRINTBUF;
> + *
> + *   prt_printf(&buf, "foo=");
> + *   foo_to_text(&buf, foo);
> + *   printk("%s", buf.buf);

So, if prt_printf() and foo_to_text() failed to make room, buf.buf would
still be NULL, right? Sure, vsnprintf() handles that gracefully, but
this is probably not what you intended.

>  struct printbuf {
>  	char			*buf;
>  	unsigned		size;
>  	unsigned		pos;
> +	/*
> +	 * If nonzero, allocations will be done with GFP_ATOMIC:
> +	 */
> +	u8			atomic;
> +	bool			allocation_failure:1;
> +	bool			heap_allocated:1;
>  };
>  
> +int printbuf_make_room(struct printbuf *, unsigned);
> +const char *printbuf_str(const struct printbuf *);
> +void printbuf_exit(struct printbuf *);
> +
> +/* Initializer for a heap allocated printbuf: */
> +#define PRINTBUF ((struct printbuf) { .heap_allocated = true })
> +
> +/* Initializer a printbuf that points to an external buffer: */
> +#define PRINTBUF_EXTERN(_buf, _size)			\
> +((struct printbuf) {					\
> +	.buf	= _buf,					\
> +	.size	= _size,				\
> +})
> +
>  /*
>   * Returns size remaining of output buffer:
>   */
> @@ -49,26 +99,36 @@ static inline bool printbuf_overflowed(struct printbuf *out)
>  
>  static inline void printbuf_nul_terminate(struct printbuf *out)
>  {
> +	printbuf_make_room(out, 1);
> +

Shouldn't this be printbuf_make_room(out, 0)?

Probably this should be split up, so that the functions that also do
printbuf_make_room() which ensures room for a nul-terminator could then
call __printbuf_nul_terminate(), which would just contain the below:

>  	if (out->pos < out->size)
>  		out->buf[out->pos] = 0;
>  	else if (out->size)
>  		out->buf[out->size - 1] = 0;
>  }



> -static inline void __prt_char(struct printbuf *out, char c)
> +/* Doesn't call printbuf_make_room(), doesn't nul terminate: */
> +static inline void __prt_char_reserved(struct printbuf *out, char c)
>  {
>  	if (printbuf_remaining(out))
>  		out->buf[out->pos] = c;
>  	out->pos++;
>  }
>  
> +/* Doesn't nul terminate: */
> +static inline void __prt_char(struct printbuf *out, char c)
> +{
> +	printbuf_make_room(out, 1);
> +	__prt_char_reserved(out, c);
> +}
> +
>  static inline void prt_char(struct printbuf *out, char c)
>  {
>  	__prt_char(out, c);
>  	printbuf_nul_terminate(out);
>  }
>  
> -static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
> +static inline void __prt_chars_reserved(struct printbuf *out, char c, unsigned n)
>  {
>  	unsigned i, can_print = min(n, printbuf_remaining(out));
>  
> @@ -79,13 +139,18 @@ static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
>  
>  static inline void prt_chars(struct printbuf *out, char c, unsigned n)
>  {
> -	__prt_chars(out, c, n);
> +	printbuf_make_room(out, n);
> +	__prt_chars_reserved(out, c, n);
>  	printbuf_nul_terminate(out);
>  }
>  
>  static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
>  {
> -	unsigned i, can_print = min(n, printbuf_remaining(out));
> +	unsigned i, can_print;
> +
> +	printbuf_make_room(out, n);
> +
> +	can_print = min(n, printbuf_remaining(out));
>  
>  	for (i = 0; i < can_print; i++)
>  		out->buf[out->pos++] = ((char *) b)[i];
> @@ -101,22 +166,43 @@ static inline void prt_str(struct printbuf *out, const char *str)
>  
>  static inline void prt_hex_byte(struct printbuf *out, u8 byte)
>  {
> -	__prt_char(out, hex_asc_hi(byte));
> -	__prt_char(out, hex_asc_lo(byte));
> +	printbuf_make_room(out, 2);
> +	__prt_char_reserved(out, hex_asc_hi(byte));
> +	__prt_char_reserved(out, hex_asc_lo(byte));
>  	printbuf_nul_terminate(out);
>  }
>  
>  static inline void prt_hex_byte_upper(struct printbuf *out, u8 byte)
>  {
> -	__prt_char(out, hex_asc_upper_hi(byte));
> -	__prt_char(out, hex_asc_upper_lo(byte));
> +	printbuf_make_room(out, 2);
> +	__prt_char_reserved(out, hex_asc_upper_hi(byte));
> +	__prt_char_reserved(out, hex_asc_upper_lo(byte));
>  	printbuf_nul_terminate(out);
>  }
>  
> -#define PRINTBUF_EXTERN(_buf, _size)			\
> -((struct printbuf) {					\
> -	.buf	= _buf,					\
> -	.size	= _size,				\
> -})
> +/**
> + * printbuf_reset - re-use a printbuf without freeing and re-initializing it:
> + */
> +static inline void printbuf_reset(struct printbuf *buf)
> +{
> +	buf->pos		= 0;
> +	buf->allocation_failure	= 0;
> +}
> +
> +/**
> + * printbuf_atomic_inc - mark as entering an atomic section
> + */
> +static inline void printbuf_atomic_inc(struct printbuf *buf)
> +{
> +	buf->atomic++;
> +}
> +
> +/**
> + * printbuf_atomic_inc - mark as leaving an atomic section
> + */
> +static inline void printbuf_atomic_dec(struct printbuf *buf)
> +{
> +	buf->atomic--;
> +}

So, if I have a printbuf in scope, and I do irq_disable() or spin_lock()
or whatnot, I'm supposed to also call printbuf_atomic_inc(), at least if
the printbuf is used within the locked region.

Honest question: An u8 used for this purpose cannot overflow?

>  #endif /* _LINUX_PRINTBUF_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b9ffc1bd1..b4609a4258 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>  	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
> -	 buildid.o
> +	 buildid.o printbuf.o
>  
>  lib-$(CONFIG_PRINTK) += dump_stack.o
>  lib-$(CONFIG_SMP) += cpumask.o
> diff --git a/lib/printbuf.c b/lib/printbuf.c
> new file mode 100644
> index 0000000000..8c70128e31
> --- /dev/null
> +++ b/lib/printbuf.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: LGPL-2.1+
> +/* Copyright (C) 2022 Kent Overstreet */
> +
> +#ifdef __KERNEL__
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#else
> +#define EXPORT_SYMBOL(x)
> +#endif
> +
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/printbuf.h>
> +
> +int printbuf_make_room(struct printbuf *out, unsigned extra)
> +{
> +	unsigned new_size;
> +	char *buf;
> +
> +	if (!out->heap_allocated)
> +		return 0;

I think that ->allocation_failure should be sticky and make us return an
early error here; if we're under memory pressure we don't want each and
every prt_char() of whatever we're trying to print to end up trying to
do an allocation.

> +	/* Reserved space for terminating nul: */
> +	extra += 1;
> +
> +	if (out->pos + extra < out->size)
> +		return 0;

Are you sure you don't want to be careful about the possibility of
out->pos+extra overflowing? And since extra has been ++'ed, shouldn't
the comparison be <= ? If pos is 0, size is 2, and I want to add one
char (so on entry extra is 1), this should not require a reallocation?

> +	new_size = roundup_pow_of_two(out->size + extra);

Are you sure you don't want to be careful about the possibility of
out->size+extra overflowing, or hitting that with roundup_pow_of_two()
doing that?

> +	buf = krealloc(out->buf, new_size, !out->atomic ? GFP_KERNEL : GFP_NOWAIT);
> +
> +	if (!buf) {
> +		out->allocation_failure = true;
> +		return -ENOMEM;
> +	}
> +
> +	out->buf	= buf;
> +	out->size	= new_size;
> +	return 0;
> +}
> +EXPORT_SYMBOL(printbuf_make_room);
> +
> +/**
> + * printbuf_str - returns printbuf's buf as a C string, guaranteed to be null

Pet peeve: Please use the spelling "nul" consistently.

> + * terminated
> + */
> +const char *printbuf_str(const struct printbuf *buf)
> +{
> +	/*
> +	 * If we've written to a printbuf then it's guaranteed to be a null
> +	 * terminated string - but if we haven't, then we might not have
> +	 * allocated a buffer at all:
> +	 */
> +	return buf->pos
> +		? buf->buf
> +		: "";
> +}
> +EXPORT_SYMBOL(printbuf_str);

I think the documentation lacks some mention of lifetimes and caller
obligations or lack thereof. Especially since the return value could
become dangling not just if the printbuf is destroyed (printbuf_exit),
but also any other use of the printbuf which could cause a realloc.

Rasmus
