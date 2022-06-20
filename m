Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D604552104
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbiFTPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244360AbiFTPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:30:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8026B51
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:30:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n197so8045426qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tIziweDctphrivbBNtLrv59ERoNt4/d4pW20tuqw9bg=;
        b=lwW5J7l5zU0wTj82HmB/JO+Q5uM/Yv5b5EXsCh1LDLa86XlOqlvDHaZo3JbcEqHRuA
         QktymIv5mLPXxfRkVFK6Zv5Y0tYIiEGrmjwEnEeHxs3lOO12ZEk4tsMmrld09ZlQPKf3
         0Sy5UM3DEJ/J3oLz+0VP422Vi5Ju8Knbsg+POXuMN509+y9EQRn4dCtSJ5YH9ASbgIdO
         +M64pFNnPB2u1pnfYku6Ztv1MCpUU21Fie4cBs9QcQVt8EfutszanPfy6pBA9Opgi7k/
         992rEYF5RAuEtZjDzmVm5Cr1A5NcHn1RXjnhWFV9B4nchZsf7kvKOXiW2dlxPo0tSgzD
         gO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tIziweDctphrivbBNtLrv59ERoNt4/d4pW20tuqw9bg=;
        b=aySA31+WGeupOgNEclmuTJRpct0OeOuizhEvHjfGMnULhbBrlwbIGcf8NMHcKL5dBv
         T/2PRhpr+RBAINrvRK93+QJE2Zar7P4f9GQFucpxr7XSib/DTvY394RkLQLKsQ1PSc8D
         bhm2fscVM5tY/EiShDTlmaEKGT0h+H0TuyXvdcQWYTtnyF6uEY1io9EBomZLUCx+eDKf
         1DkhBtFhljIdGMHPlV4iIWqVeRTewG55rgaWSHTmA0TNHTwhSYmAb5OXyAfxmwc59MqP
         2dX5MXIXVq85MyR7UyaLcCPrf+AMwxIyFwWudN9EI08srT3q87AM5cVwJQZxX2jnnjyq
         8Mkg==
X-Gm-Message-State: AJIora+6s+98PAQTxCS3/rXMHqZpaFJHrETwn5iPTU3SpCosjuPUcZef
        OKnSqP1LNzqIgzYbhAuEKg==
X-Google-Smtp-Source: AGRyM1s8AGwv69iI/TzgVnUJsc7kv4ZSNeEzSrXELk9G0F+7vMYnwetu7enrYL5oAhlHhK6x+pkUnA==
X-Received: by 2002:a05:620a:2a08:b0:6a6:c094:e674 with SMTP id o8-20020a05620a2a0800b006a6c094e674mr16700429qkp.226.1655739045840;
        Mon, 20 Jun 2022 08:30:45 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a6a904c0a5sm12107410qkp.107.2022.06.20.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:30:44 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:30:43 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4 01/34] lib/printbuf: New data structure for printing
 strings
Message-ID: <20220620153043.vgtfrltebiyprufz@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-2-kent.overstreet@gmail.com>
 <f0808aaee9ac4b088121c0fbe7e18f0d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0808aaee9ac4b088121c0fbe7e18f0d@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:44:10AM +0000, David Laight wrote:
> From: Kent Overstreet
> > Sent: 20 June 2022 01:42
> > 
> > This adds printbufs: a printbuf points to a char * buffer and knows the
> > size of the output buffer as well as the current output position.
> > 
> > Future patches will be adding more features to printbuf, but initially
> > printbufs are targeted at refactoring and improving our existing code in
> > lib/vsprintf.c - so this initial printbuf patch has the features
> > required for that.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/printbuf.h | 122 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >  create mode 100644 include/linux/printbuf.h
> > 
> > diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> > new file mode 100644
> > index 0000000000..8186c447ca
> > --- /dev/null
> > +++ b/include/linux/printbuf.h
> > @@ -0,0 +1,122 @@
> > +/* SPDX-License-Identifier: LGPL-2.1+ */
> > +/* Copyright (C) 2022 Kent Overstreet */
> > +
> > +#ifndef _LINUX_PRINTBUF_H
> > +#define _LINUX_PRINTBUF_H
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +
> > +/*
> > + * Printbufs: String buffer for outputting (printing) to, for vsnprintf
> > + */
> > +
> > +struct printbuf {
> > +	char			*buf;
> > +	unsigned		size;
> > +	unsigned		pos;
> 
> No naked unsigneds.

This is the way I've _always_ written kernel code - single word type names.

> 
> > +};
> > +
> > +/*
> > + * Returns size remaining of output buffer:
> > + */
> > +static inline unsigned printbuf_remaining_size(struct printbuf *out)
> > +{
> > +	return out->pos < out->size ? out->size - out->pos : 0;
> > +}
> > +
> > +/*
> > + * Returns number of characters we can print to the output buffer - i.e.
> > + * excluding the terminating nul:
> > + */
> > +static inline unsigned printbuf_remaining(struct printbuf *out)
> > +{
> > +	return out->pos < out->size ? out->size - out->pos - 1 : 0;
> > +}
> 
> Those two are so similar mistakes will be make.

If you've got ideas for better names I'd be happy to hear them - we discussed
this and this was what we came up with.

> You can also just return negatives when the buffer has overlowed
> and get the callers to test < or <= as required.

Yeesh, no.

> I also wonder it is necessary to count the total length
> when the buffer isn't long enough?
> Unless there is a real pressing need for it I'd not bother.
> Setting pos == size (after writing the '\0') allows
> overflow be detected without most of the dangers.

Because that's what snprintf() needs.

> > +
> > +static inline unsigned printbuf_written(struct printbuf *out)
> > +{
> > +	return min(out->pos, out->size);
> 
> That excludes the '\0' for short buffers but includes
> it for overlong ones.

It actually doesn't.

> > +}
> > +
> > +/*
> > + * Returns true if output was truncated:
> > + */
> > +static inline bool printbuf_overflowed(struct printbuf *out)
> > +{
> > +	return out->pos >= out->size;
> > +}
> > +
> > +static inline void printbuf_nul_terminate(struct printbuf *out)
> > +{
> > +	if (out->pos < out->size)
> > +		out->buf[out->pos] = 0;
> > +	else if (out->size)
> > +		out->buf[out->size - 1] = 0;
> > +}
> > +
> > +static inline void __prt_char(struct printbuf *out, char c)
> > +{
> > +	if (printbuf_remaining(out))
> > +		out->buf[out->pos] = c;
> 
> At this point it is (should be) always safe to add the '\0'.
> Doing so would save the extra conditionals later on.

True, but at the cost of making the code less straightforward. I may have a look
at it.

> 
> > +	out->pos++;
> > +}
> > +
> > +static inline void prt_char(struct printbuf *out, char c)
> > +{
> > +	__prt_char(out, c);
> > +	printbuf_nul_terminate(out);
> > +}
> > +
> > +static inline void __prt_chars(struct printbuf *out, char c, unsigned n)
> > +{
> > +	unsigned i, can_print = min(n, printbuf_remaining(out));
> > +
> > +	for (i = 0; i < can_print; i++)
> > +		out->buf[out->pos++] = c;
> > +	out->pos += n - can_print;
> > +}
> > +
> > +static inline void prt_chars(struct printbuf *out, char c, unsigned n)
> > +{
> > +	__prt_chars(out, c, n);
> > +	printbuf_nul_terminate(out);
> > +}
> > +
> > +static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
> > +{
> > +	unsigned i, can_print = min(n, printbuf_remaining(out));
> > +
> > +	for (i = 0; i < can_print; i++)
> > +		out->buf[out->pos++] = ((char *) b)[i];
> > +	out->pos += n - can_print;
> > +
> > +	printbuf_nul_terminate(out);
> 
> jeepers - that can be written so much better.
> Something like:
> 	unsigned int i, pos = out->pos;
> 	int space = pos - out->size - 1;
> 	char *tgt = out->buf + pos;
> 	const char *src = b;
> 	out->pos = pos + n;
> 
> 	if (space <= 0)
> 		return;
> 	if (n > space)
> 		n = space;
> 
> 	for (i = 0; i < n; i++)
> 		tgt[i] = src[i];
> 	tgt[1] = 0;
> 

I find your version considerably harder to read, and I've stared at enough
assembly that I trust the compiler to generate pretty equivalent code.

> > +}
> > +
> > +static inline void prt_str(struct printbuf *out, const char *str)
> > +{
> > +	prt_bytes(out, str, strlen(str));
> 
> Do you really need to call strlen() and then process
> the buffer byte by byte?

Versus introducing a branch to check for nul into the inner loop of prt_bytes()?
You're not serious, are you?
