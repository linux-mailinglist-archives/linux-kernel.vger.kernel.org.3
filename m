Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48D552C60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347552AbiFUHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFUHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:52:03 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD57245AB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:52:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id y14so13896824qvs.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oBi1GtdcKMWmT1bDHc11If7BFUljocWb98H7N/H6xs0=;
        b=SGPJ5m4tvIHRyjwwdQIIal8VjxuNUxpv23Qai8KBUFCze0qz9KMZRvu8ZUqU3eN3Ku
         fl4o56SOitD/EI4WXS5RhK3oGUbWPgnOyKgfDrGciUttk7igTulNAjflhz1fpUnQN4lX
         aRimKlcstTq4qTa0Gf9IOTzFsnalN0nboEJh3CcPDXUjN0h8kDOh8EpqDRKAC+ZOB7cn
         FHXXrWylD4MypmamELDdF1j65iVrsu5e9H3g2wQ6mOaVmFOdv6gw/bEleMWXTm7wQea1
         2u+2YtFlgloF51zN4dc7ehszwNHr+Vw4YfOlPRw55uWxOJjFdXbhGorhz6P8E1OuNeTd
         91sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBi1GtdcKMWmT1bDHc11If7BFUljocWb98H7N/H6xs0=;
        b=KNykt835viq/pVUKTOJcML70Mxjdn/QiSZJeBLNWqyxc07qu5woWpD9B9JWsFSGxMA
         C9qYFE3UX+d8649aVofQGjYHDXOOvL8PQHcS9Kpvk1y7y9LN47qSDPLYD66xOex3TAyp
         7Ztx0jLhGy7iwZjYYhO0kAMJxIk8X/QFYG0cbRAotQh4h4hCViqszJ5TyzHoz7nCIusF
         q2yt0wvmIUsmlYUwyzeiHBlKv0+lflkMyzyBy+YlnOpFqClIbK1DnQ28AcvFOFPzLNV+
         V59g8rSGvCVI3bbpCm/i8eqjArKpD1Ex/ct9CmVD82PoQa1rv7K0gm4oWMfukGgWJSB3
         LHwg==
X-Gm-Message-State: AJIora8Txjr4i0wkAMllf8hQYmCS/9RUJoFID8QfnoD+OP1aScAbXOiy
        KQfjJdLlAq1p4sIQ2HJb3Q==
X-Google-Smtp-Source: AGRyM1uldbQ+FF0ReOT1dCERxSwSqnUWwf/gHG/zCBzt2IGMN+ewK96Jq0luXf2dgWYAW+ncZVhwDw==
X-Received: by 2002:a05:6214:5199:b0:464:58c0:3926 with SMTP id kl25-20020a056214519900b0046458c03926mr21833952qvb.48.1655797921656;
        Tue, 21 Jun 2022 00:52:01 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l16-20020a05620a28d000b006a6cadd89efsm14678198qkp.82.2022.06.21.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:52:00 -0700 (PDT)
Date:   Tue, 21 Jun 2022 03:51:59 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
Subject: Re: [PATCH v4 05/34] vsprintf: %pf(%p)
Message-ID: <20220621075159.m67qzftqulvphivw@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-6-kent.overstreet@gmail.com>
 <f9224687-ce0c-b41b-f158-1b679a70c2d5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9224687-ce0c-b41b-f158-1b679a70c2d5@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:04:38AM +0200, Rasmus Villemoes wrote:
> On 20/06/2022 02.42, Kent Overstreet wrote:
> > +Note that a pretty-printer may not sleep, if called from printk(). If called
> > +from pr_buf() or sprintf() there are no such restrictions.
> 
> I know what you're trying to say, but if the sprintf() call itself is
> from a non-sleepable context this is obviously not true. So please just
> make the rule "A pretty-printer must not sleep.". That's much simpler
> and less error-prone. Otherwise I guarantee you that somebody is going
> to add a sleeping pretty-printer for their own need, use it in a couple
> of safe places, and then somebody wants to add a printk() in that driver
> and sees "hey, I can get all this state dumped very easily with this
> pretty-printer".

Kernel programmers are used to having to consider the context they're in and
what the functions they're calling might do, a pretty-printer being called
indirectly via sprintf() is absolutely no different. 

> >  struct printf_spec {
> > @@ -2520,7 +2521,16 @@ int format_decode(const char *fmt, struct printf_spec *spec)
> >  		return ++fmt - start;
> >  
> >  	case 'p':
> > -		spec->type = FORMAT_TYPE_PTR;
> > +		fmt++;
> > +		if (fmt[0] == 'f' &&
> > +		    fmt[1] == '(') {
> > +			fmt += 2;
> > +			spec->type = FORMAT_TYPE_FN;
> > +		} else
> > +			spec->type = FORMAT_TYPE_PTR;
> > +		return fmt - start;
> > +	case '(':
> > +		spec->type = FORMAT_TYPE_FN;
> >  		return ++fmt - start;
> 
> NAK. Don't implement something that will never be tested nor used.
> There's not a snowball's chance in hell that we'll ever build the kernel
> without -Wformat.

We're not stopping here. Matthew is taking this to WG14 and I'll be working on
adding this functionality to glibc next, and %() is the syntax we intend to take
to the working group.

But the working group is naturally going to want to see that a working
implementation of it exists.

> Sorry, but this is way too ugly, and the prospect of at some point in
> the future invoking libffi to do something even naster... eww. We do not
> need more functions with completely generic prototypes with no
> typechecking and making it extremely hard to teach one of our static
> analyzers (smatch has some %pX checking) to do that typechecking.
> 
> There are at least two ways you can achieve this passing of a variable
> number of arguments with proper types.
> 
> (1) Each pretty-printer comes with a struct wrapping up its real
> arguments and a macro for creating a compound literal passing those
> arguments.
> 
> struct foo_pp {
>   void (*func)(struct printbuf *pb, void *ctx); /* always first */
>   int x;
>   long y;
> };
> void foo_pp(struct printbuf *pb, void *ctx)
> {
>   struct foo_pp *f = ctx;
>   pr_printf(pb, "%d %ld", f->x, f->y);
> }
> 
> #define FOO_PP(_x, _y) (struct foo_pp){.func = foo_pp, .x = (_x), .y = (_y)}
> 
> printk("bla bla %pf\n", &FOO_PP(aa, bb));

Hellllllllll no.

All that's missing right now is gcc checking that the function signature matches
the args specified within the (). That will come. No way in hell am I going to
implement some half baked hacked up macro crap - I intend to do this right.

> (2) Let the pretty-printer itself extract the varargs it expects. To
> portably pass around a va_list by reference it needs to be wrapped, so
> this would be
> 
> struct wva { va_list ap; };
> 
> void foo_pp(struct printbuf *pb, struct wva *w)
> {
>   int x = va_arg(w->ap, int);
>   long y = va_arg(w->ap, long);
>   pr_printf(pb, "%d %ld", x, y);
> }
> 
> printk("bla bla %pf(%d, %ld)\n", foo_pp, aa, bb)
> 
> with the core printf implementation internally using such a wrapped
> va_list, and after a %pf( relying on the pretty-printer having consumed
> the arguments up until the closing ). It would probably be a good idea
> to give the pretty-printer a pointer to that opening '(' or one-past-it
> as well so it could do a sanity check.

Also no. Varargs is terrible in most situations, and should only be used for
functions that actually want to take variable numbers of arguments - that
doesn't apply to pretty printers.
