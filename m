Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8497A55220A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbiFTQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244441AbiFTQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:14:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C920F6C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:14:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g18so9031942qvn.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p4CMxnr4TX5oTAzHAubXZp5xX3+REtv8nCM4eiESU5Q=;
        b=R71i2J2sED1s83Ouq64dlBdAsgl6Hc+byj0jgTAfBVjpFq7/xHf3OP2w+HnJ8mmJ5x
         zjwTLG17LwnFGi/zwaPhTCuQafI6PcICLitDLgiLnvw7axAxXqSdKOih1Ezff8KJghUs
         7OZupfpYvYEJH+xKVcd3+aARs9CbYHe4ZNoeISKMVeB+Bpg2gwX7UUIy4WQjar9mRDjd
         vs78qa26KuW5gQit2fAiUFaE6/XUEcMiakyXens8dSJSaY02+sKtjsZhGYD5UbyyTtVH
         j7PUm+fvN4xa8AT0ug9fRenkTLUeECXlYPxq4NoKviDlBgc1l8fXZl/mnm5pM0SaLh3k
         OXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4CMxnr4TX5oTAzHAubXZp5xX3+REtv8nCM4eiESU5Q=;
        b=Usx9lvkR/xJEqrgxpVKutNpF+EFEsuIbEsA8PXim4/4MeIH1TFO9SP3Z1vPB2y/07e
         qPLDYf8MBXCh4y+goVlBPom2p5prwMmiJhbP/1+p/YtuqhB+f/0xWi0PFK1K6ulJhyez
         +TAU1YQxUr1Chu2KDaV5yrTBbjqaI2IgBlI1XeQWeXZSThLv3tbIRQR3cRl5X1WJLbRy
         ly4IQnYLzXSfSp5BCDwKZsN+lYLMHUbxvQIivg0nHzV8FwBidL43lBwAebpaOLdu/1d/
         PhIFg/UxT4aFFFLiRBDouLzUFt9Wsq2BZ7+qiuuCR+LI9+QeHOU10Bg2akQfVfPCn+qG
         o34Q==
X-Gm-Message-State: AJIora8HfG6UIn8Wu5S14T98QWra+djaTqqHP49tbDL+H83xstbqw1L3
        zI5WmglfRXONJSpMRFK+Gg==
X-Google-Smtp-Source: AGRyM1u8NQs9vos0RvN+IdXTEzRMdEFf/mAMb2m50gpqQYvGPYboO9VcT0Y/URUd//KABL+M7SKtbQ==
X-Received: by 2002:a05:6214:20aa:b0:467:cb4b:a1fa with SMTP id 10-20020a05621420aa00b00467cb4ba1famr19378623qvd.9.1655741669967;
        Mon, 20 Jun 2022 09:14:29 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j17-20020a05622a039100b00304fe96c7aasm11294030qtx.24.2022.06.20.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:14:29 -0700 (PDT)
Date:   Mon, 20 Jun 2022 12:14:28 -0400
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
Message-ID: <20220620161428.xdowwr6zsvfgm5qi@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-2-kent.overstreet@gmail.com>
 <f0808aaee9ac4b088121c0fbe7e18f0d@AcuMS.aculab.com>
 <20220620153043.vgtfrltebiyprufz@moria.home.lan>
 <5156ce6a38ab4f9c87ddf29ee05a266a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5156ce6a38ab4f9c87ddf29ee05a266a@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:53:38PM +0000, David Laight wrote:
> From: Kent Overstreet
> > Sent: 20 June 2022 16:31
> > 
> > On Mon, Jun 20, 2022 at 04:44:10AM +0000, David Laight wrote:
> > > From: Kent Overstreet
> > > > Sent: 20 June 2022 01:42
> > > >
> > > > This adds printbufs: a printbuf points to a char * buffer and knows the
> > > > size of the output buffer as well as the current output position.
> > > >
> > > > Future patches will be adding more features to printbuf, but initially
> > > > printbufs are targeted at refactoring and improving our existing code in
> > > > lib/vsprintf.c - so this initial printbuf patch has the features
> > > > required for that.
> > > >
> > > > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > >  include/linux/printbuf.h | 122 +++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 122 insertions(+)
> > > >  create mode 100644 include/linux/printbuf.h
> > > >
> > > > diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> > > > new file mode 100644
> > > > index 0000000000..8186c447ca
> > > > --- /dev/null
> > > > +++ b/include/linux/printbuf.h
> > > > @@ -0,0 +1,122 @@
> > > > +/* SPDX-License-Identifier: LGPL-2.1+ */
> > > > +/* Copyright (C) 2022 Kent Overstreet */
> > > > +
> > > > +#ifndef _LINUX_PRINTBUF_H
> > > > +#define _LINUX_PRINTBUF_H
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/string.h>
> > > > +
> > > > +/*
> > > > + * Printbufs: String buffer for outputting (printing) to, for vsnprintf
> > > > + */
> > > > +
> > > > +struct printbuf {
> > > > +	char			*buf;
> > > > +	unsigned		size;
> > > > +	unsigned		pos;
> > >
> > > No naked unsigneds.
> > 
> > This is the way I've _always_ written kernel code - single word type names.
> 
> I'm pretty sure the coding standards require 'int'.

I've been contributing code to the kernel for many years and I'm picky about my
style, I'm not about to change now.

> 
> > >
> > > > +};
> > > > +
> > > > +/*
> > > > + * Returns size remaining of output buffer:
> > > > + */
> > > > +static inline unsigned printbuf_remaining_size(struct printbuf *out)
> > > > +{
> > > > +	return out->pos < out->size ? out->size - out->pos : 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Returns number of characters we can print to the output buffer - i.e.
> > > > + * excluding the terminating nul:
> > > > + */
> > > > +static inline unsigned printbuf_remaining(struct printbuf *out)
> > > > +{
> > > > +	return out->pos < out->size ? out->size - out->pos - 1 : 0;
> > > > +}
> > >
> > > Those two are so similar mistakes will be make.
> > 
> > If you've got ideas for better names I'd be happy to hear them - we discussed
> > this and this was what we came up with.
> > 
> > > You can also just return negatives when the buffer has overlowed
> > > and get the callers to test < or <= as required.
> > 
> > Yeesh, no.
> 
> Why not?
> All the callers are internal.
> It saves a test and branch (or cmove).

Because this is a subtle thing and having two separate helpers better documents
the _intent_ of the code. I prioritize having clear and understandable code over
shaving every branch.

printbuf_remaining() is the one almost all callers want to use;
printbuf_remaining_size() is only for a few callers that are doing weird things
and should probably be converted to something more standard.

> 
> > > I also wonder it is necessary to count the total length
> > > when the buffer isn't long enough?
> > > Unless there is a real pressing need for it I'd not bother.
> > > Setting pos == size (after writing the '\0') allows
> > > overflow be detected without most of the dangers.
> > 
> > Because that's what snprintf() needs.
> > 
> > > > +
> > > > +static inline unsigned printbuf_written(struct printbuf *out)
> > > > +{
> > > > +	return min(out->pos, out->size);
> > >
> > > That excludes the '\0' for short buffers but includes
> > > it for overlong ones.
> > 
> > It actually doesn't.
> 
> If size is 2 it goes 0, 1, 2, 2, 2 as bytes are added.
> But the string is "" "a" "a" "a" - never 2 characters. 

Ah, you're right. Ok, that's a bug, I'll fix that.

> As opposed to the one in strlen() ?
> I realise that there are shift and mask algorithms from strlen()
> that are likely faster than a byte scan on 64 bit systems.
> But they are likely slower than the check when you have a loop
> that is scanning byte by byte.
> This is especially true on out of order superscaler cpu when
> the copy loop won't be using all the execution blocks.
> 
> What might be faster on cpu (like x86) where misaligned memory
> access are almost entirely free is to copy 8 bytes at a time
> while checking for a zero at the same time.
> 
> Remember kernel strings are quite often short, the overhead
> costs for 'fast' routines slow things down.
> (As you found when calling memcpy() and memset().)

Look, from scanning the kernel log I get you're the kind of programmer who likes
shaving every branch and instruction.

I've spent a _lot_ of time in my career staring at profiles and assembly and
counting cycles (and was working with someone juinor doing that just last
night), and what I've found over the years is that time and again...  it's
memory accesses and cache misses that matter, and not much else.

I put a lot of effort into writing high performance code, and what I find is
that my time is better spent when I focus on writing clear and understandable
code, and making sure that things are laid out in memory intelligently, instead
of trying to generate the "perfect" assembly from all the code I write.

Perfect can be the enemy of good.

If you want to submit patches later optimizing this stuff, be my guest - _but_,
if it comes at the cost of making the code harder to read I'll want to see
benchmark improvements, and of more than a few percent here and there.
