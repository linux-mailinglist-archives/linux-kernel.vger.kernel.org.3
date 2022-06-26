Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2355D55B411
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiFZUwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFZUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:52:01 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782F81175
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:52:00 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 89so12382451qvc.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uMJf4FJG/5wuR5sGkF8+rRgoUV4V+m2L2oEIirjeF8=;
        b=SKI1T/TZ191ugcTzlr53quPp0usXsnPGme2ITPQplFyNs5QQ6Wa3ttioJeMUtV0wBY
         RJT7Qn6mMyi3+QZ+q5TvcJBb5aEemux4u0+kwYFYHmCZb3WopQrN1UxbnR/6eXUPYzpR
         5CKVYPs38K4NQxhj2z3eiAoeAfHleFPWtG0FjTPDdF+G6mW4KL2j+h9pIjykZ0cauwns
         vTjEq86u9NpTh/Xem6IcE5ML1my0X8std/QeU1U8EovJyukiyCadPWADP8aAMhyvnl4S
         fg10GYyjCP+L/EyvqArtGapezu9XOG81BHOyBvT2Ta/hM6waPUorVEt5wQLy9D2OWrKC
         1GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uMJf4FJG/5wuR5sGkF8+rRgoUV4V+m2L2oEIirjeF8=;
        b=HLP987+YjN5u3mkD3y8dTHTY4P7kFKcKL8x2E8xjW8LGH8f2b1Aex939vD5DacS4E2
         C93ChpYfGmhp9vyIylxxA6sC3vb2RbwZcZ9bgqCMbE7ZNtPHnCh8reYw5027ZMyljn2n
         s3zV0dZxz0xhyPfCxJAKQF294EsQJPdNQqmjEPymF5mDXEOHwgTWwmyo58KhQqCL/qX1
         NpHmoIe4CJKgQK1eQOLmnSd19F8WQMlia6rn1Wy/4Xppes5uN6GI2vLCwOGtkHW7mTKe
         +wnLRnbpIQ2CDE0VRA3aVUmTywZTtUxxcFFD+yHl9FMTCFC+n/o8LQ6xtW/sNptCzG2I
         SydA==
X-Gm-Message-State: AJIora+wrFxT/a18fqWmibYj4qZV6mlDQnUPwPW7NfdwiE6E3mHEKP1x
        AD75+aNJYrfk/C3JL0kVuuMp0uFPTawhfPw5Wg==
X-Google-Smtp-Source: AGRyM1s0/7XqSbpTLPbt4CnLr4T/V3zTpGusZFFoFg9i+FFHWwKSNLcYjUDpNMwqcGFidyAiKaYu0Q==
X-Received: by 2002:a05:6214:76a:b0:470:b527:a3f8 with SMTP id f10-20020a056214076a00b00470b527a3f8mr4021308qvz.110.1656276719619;
        Sun, 26 Jun 2022 13:51:59 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j9-20020a05620a410900b006a740bb8578sm7402075qko.83.2022.06.26.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 13:51:58 -0700 (PDT)
Date:   Sun, 26 Jun 2022 16:51:58 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC[ Alloc in vsprintf
Message-ID: <20220626205158.bqeyetui3cromscp@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
 <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
 <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
 <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
 <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 01:39:01PM -0700, Joe Perches wrote:
> On Sun, 2022-06-26 at 13:19 -0700, Linus Torvalds wrote:
> > On Sun, Jun 26, 2022 at 12:53 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > In a reply to the printbufs thread, I wrote a proposal to use an
> > > alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.
> > > 
> > > No one has replied to this but I think it's somewhat sensible.
> > 
> > I think that's a bad idea.
> 
> Somewhat sensible not sensible...
> 
> > Those things are *literally* called from panic situations, which may
> > be while holding core memory allocation locks, or similar.
> 
> True, and special_hex_number was used on alloc failure.
> 
> > Now, you are correct that the stack buffer is annoying. But I think
> > the proper way to fix that is to say "we already *have* the target
> > buffer, let's use it".
> 
> OK, and that's true for all the temp stack buffers in every %p<foo>.

Serious question: why are you trying to half-ass just _one_ of these functions
when I've been working on solving stack allocations in all of them? I've already
killed every single stack buffer in the last patch series that was posted except
for symbol_string(). I would welcome the help if you wanted to tackle that one.

It's not completely trivial because while kallsyms_expand_symbol() can be
trivially converted to printbufs - it just outputs one char at a time, so that
becomes prt_char() - it's not a output-once-and-done algorithm:
cleanup_symbol_name() then goes back over the output buffer and modifies it in
place (ew), because of weird clang things that it's got #ifdefs for.

Specifically, it's truncating the output at the first period (easy to convert;
just stop when we see a period) but then it truncates at the last $ - why? do we
have symbols when building with gcc that legitimately have dollar signs in them?
One would hope we could drop the #ifdefs but that needs to be checked.

That's as far as I got looking at it just now. It will be some time before I
have time to do it properly and run tests and research what I'm doing (because
I am completely buried in bcachefs bugs to work through at the moment, and
getting sucked into working on test automation _again_ when I have a million
more valuable things I could be working on because the test infrastructure story
for the kernel is still a shitshow, but that's another rant).

Anayways, I'm trying to take the time to do this stuff right, but there's a
_lot_ of work involved, so if you want to help out instead of just slag what I'm
doing... well, it'd be nice...

Cheers,
Kent
