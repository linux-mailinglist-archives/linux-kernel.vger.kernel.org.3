Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6353994E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348309AbiEaWD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348304AbiEaWDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:03:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DB9A9B7;
        Tue, 31 May 2022 15:03:20 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ew15so3562874qtb.2;
        Tue, 31 May 2022 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=76lHBu9WeEtFRiB08o/XGso0/nY2CeLb14MdKI7nDao=;
        b=mSchy28160Qp1NG35icMcuhuFgpkhU/7MC192l8/Hyp9OUXxeALvLW8Y+6qUgRwTGW
         Iin0Utg6nhNW0kKHn7LkRsXHgeoCacHj73zLWz3+tGlxrQ4EqtugiXw2vsgoab0TofEs
         AUyKdNBTKLAgCQFeAdrnM6CdJ2/xebsPQBf3cL8rRGQ1hzYWxTNK4TdsozgDlGfvJ7z9
         gwOFHPMAMFH9LIp4N3zSuRZsPAF9fI/mqydKFQ4cAfrnVgOTaxrqmCsIo/sO6GSESjdZ
         3RdRYgJJs5QTfjbiqqRxZUZijQQrm8/KxP1gani6jPQgtXeNuyhLASeQHXkbbY44j1XT
         pS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76lHBu9WeEtFRiB08o/XGso0/nY2CeLb14MdKI7nDao=;
        b=2mtWuFcrTjiVqq1IWFNw/vGBVdOUhV98L0BbcT3g58bdBEk1Rf/BuwWKL44YkjvtuH
         p3AQ2mJwQ11MPwCtj7TYjO5i/M9a2AwebhW5VVBUf3JparyhupULO+xspFmFlCwW6Cjh
         kXhDtsc5yiXzPFXv+nG+dPaCNYs3TC+hCMMJ/owiO5PbJ11bMczxc9VkFRorrlp4ONY/
         BPNe/HLCK7qvUT/NPIBgA5cAY/HCf2ULKC64bBULV9oCM3C8aiMHwn1A3qj/TwZb0hjF
         vC2UWAyygS4oyxtpVivcbGkeDGedS8Wfn5EwEp7MzQeQkxkdjQi+O+OL2w8RGZM19y10
         l5Og==
X-Gm-Message-State: AOAM532xD0qn2HmIof8uJqQY1hoIRvJzpFq9RU/ZpD1MKVeBAdi3OBBU
        DRWzzSwx+CbffnyrKztgjw==
X-Google-Smtp-Source: ABdhPJydyWA+tMa+1FNjiHYuTVl++dSGIMc4esAgaWez8ZmLAxIxTNZC9DCXZg5mioKbqao8dQsEEA==
X-Received: by 2002:a05:622a:4cf:b0:2f9:373b:ef0 with SMTP id q15-20020a05622a04cf00b002f9373b0ef0mr36827931qtx.163.1654034599475;
        Tue, 31 May 2022 15:03:19 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g18-20020ac84812000000b002f93aeaf770sm9369618qtq.92.2022.05.31.15.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 15:03:18 -0700 (PDT)
Date:   Tue, 31 May 2022 18:03:16 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <20220531220316.i7wl34puxy73zn46@moria.home.lan>
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

I'd like to get sprintf() style functions - anything that outputs to raw char *
pointers - deprecated. That's going to mean a _lot_ of refactoring (so I don't
know that I'll be the one to do it), but it's mostly easy refactoring.

> 3. printbuf API:
> 
>        + append messages into the given printbuf by small pieces
> 
>        + format defined by the suffix, for example, _char(),
> 	 bytes(), units_64(), _tab(), indent()
> 
>        + allows to do special operations on the buffer,
> 	 for example, _reset(), make_room(), atomic_inc()
> 
>        + it will be used as low-level API for vscnprinf()
> 	 implementation, pretty printing API, or
> 	 stand alone uses.
> 
>        + I wonder if there will be variant that will allow
> 	 to pass the format in the printf() way, e.g.
> 	 int pb_printf(printbuf *buf, const char *fmt, ...);

Right now this is called pr_buf(). I suppose pr_printf()/pb_printf() makes sense
:)

> 
>        + is there any user space counter part?
> 
> 
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

So there's more in the pr_* namespace than I realized - I guess you've convinced
me on not reusing that. Which is a shame, because it rolls off the tongue so
much easier than pb_* and I think otherwise makes more sense here - pr_foo for
"print foo".

However, I'm not going to put special operations on printbufs under the pb_
prefix: I want that naming (whether pb_* or pr_*) to _just_ be for "print foo";
this "print this" prefix should be the common prefix for _any_ pretty printer,
unless it has another subsystem prefix - that means there's going to be a lot of
functions with these prefix. So I'm going to keep "printbuf special operations"
on the printbuf_ prefix.

Also, how about prt_* instead of pb_*? I want something that sounds more like
print, and prt_ isn't taken.
