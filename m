Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B2F55299F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiFUDLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiFUDLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:11:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A711C109
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:11:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d128so9151639qkg.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VwtrkCyUs94Mby5M4DxsvnJMAG0rgaBoGLdHEt+Fwzo=;
        b=IT7i6qpkzPP+/B8tR3+2O0f/z5jek6NcrA1b8mQf14+DJksUQjM32sIi6dVwNFOpMw
         9cuKnA/jlIqlFcda0c72VqV5MJXOVPPflMokzlYZQD1bMNpjDWpr05TVOkOKZ/l0WB03
         ea+Hl16MM3s+Bg4l7AMwnTbci7t+tzE5ftuu75m4Vc0xFR6pTCYiPsbUt+QupQTSOrHb
         0HZLrKryjd1McRzKDcFKU8eQsO2Vkur3hlWvxNy33L2Fovzv2MnggsozuUnXaO6xE1cc
         Pb0VqyffkjSNGPT/sbysr1Ks9z5mxZTLe0Z2lYQw67Mg871s3zWiCHcNfFKFBepxaZff
         2Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VwtrkCyUs94Mby5M4DxsvnJMAG0rgaBoGLdHEt+Fwzo=;
        b=ZQQbpZHZ+1WWJvfv0TlSXSAyvsRHd6YUvbiKGYBUknM2UkIIgVQpwP0QFXuJaiXDVj
         MVGU9lDHeKxkNjhitsdZ48CqXr4tqAOanSPp2yGMAxr+bvAtGWRPqnyOCO3j+EkSE5xs
         WP1IfbTSkhfCI6xjjyFan7sMxBHvQB3pI21hEkOWx4+nsblZxNEp6uekDUEI8Pcw/+3u
         KwlbPDRnpy1sq8Uf6CWY7KUYVQW67Ndgr15VJNuCg5uiw/WEHJlJ+d8F2GJyiiC7JITe
         jXqCLtlt/hJO+yj/SiLz2CWGjvkYz2k6CoGvkhZUlEdidYIKcuC/lbTt8QC35FArwnUM
         ecsQ==
X-Gm-Message-State: AJIora/gnp7sxg2th/dVCew5mdj7a1ADB7EkAmcOcjVhS6+oyWBw5fg1
        Sshe5n3eZR9HBWh+DA/p/w==
X-Google-Smtp-Source: AGRyM1u6rlI+7jxlDfwReGjJwiNc3ZmlhiTHDLDcH9/FMxzHU+kQWUvCmtXlItRTLwc/8HvCK17Igg==
X-Received: by 2002:a05:620a:1336:b0:6a6:b5fe:44cf with SMTP id p22-20020a05620a133600b006a6b5fe44cfmr17941191qkj.525.1655781062424;
        Mon, 20 Jun 2022 20:11:02 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t9-20020a37ea09000000b006a6be577535sm13767332qkj.85.2022.06.20.20.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 20:11:01 -0700 (PDT)
Date:   Mon, 20 Jun 2022 23:11:01 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220621031101.ex3qwbyywwyy5ctk@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> I really think that is a bad idea.
> printk() already uses a lot of stack, anything doing a recursive
> call is just making that worse.
> Especially since these calls can often be in error paths
> which are not often tested and can already be on deep stacks.

So it seems this is something you never actually checked, and I naively assumed
that you might actually know what you were talking about - an understandable
mistake, I think, because vsprintf.c is _a fucking mess_ and high stack usage
would be believable.

But the main part we're concerned with here, snprint() or prt_printf(), has no
such stack usage problems. On v5.18, the frame size is under 64 bytes. On my
branch, it's 72 bytes - higher because we do need to save arguments on the stack
for the pretty-printer invocation, and there's no way around that without
dropping to asm - although I'm allowing up to 8 arguments (besides the printbuf
itself), which is probably excessive.

So I'm not seeing what you're talking about.

In the leaf functions, the individual pretty-printers/%p extensions, those are
doing completely ridiculous things and I have fixed them all except
symbol_string() on my branch, and I'll get to that one.

Having a proper string library with useful helpers really makes things easier,
it turns out.

As for recursive %pf() invocations blowing the stack? I seriously fucking doubt
it, once you're in a pretty-printer where you've already got a printbuf you can
output to there's not much reason to be doing recursive calls to prt_printf()
passing it yet another pretty printer - that's not where %pf() is convenient,
what it makes convenient is using pretty printers when you're calling printk()
directly. In a pretty printer fuction, if you want to do recursive
pretty-printer calls you'd just call it directly! prt_printf(out, "%pf(%p)"),
foo_to_text, foo) is silly when you can just call foo_to_text(out, foo).

Now, I ask both of you please take your bureaucratic nitpicky nonsense and,
kindly, pretty please with sugar on top - stuff it. I much prefer to work with
people who don't waste my time, and who have actual _taste_.
