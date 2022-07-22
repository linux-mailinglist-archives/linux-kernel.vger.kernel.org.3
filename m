Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9974357D7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiGVAQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:16:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCDB1054E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:16:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so6772961pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u/7fNiPODzfNSY8xglDMrNgh+Uge6m986wMEeL9p7bI=;
        b=OYXiFFdKLiJasr7Ms3YN0oM0sfXeyJvx409brzZxSYQkTBECYyqnwd04V/wl1FHGrs
         uxT1wFXSwl7ZRo9v42KgMXBGyZMunMFN2KSCvKZKcJhxMROnkkgXQGpObYNoQaj6eYxR
         gZZiWzvhe6O/3lCqgWBlWsTjmk8YTQ4YX++OhgYV1L+s4FnGgU5b0YB+H9RerMKLcE5a
         5tay/wZinslnm2QQn5oBam3oVyXiaY6LXmn6HVKjPBr1gjkGWVZ6kJYAjfyqDtY78j6K
         ScKXpReCWxriBni4velseVW8mxaaARx8p5XD8+fBe2GplVH22HAQaYP3RoxDdENUR+Zm
         qe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u/7fNiPODzfNSY8xglDMrNgh+Uge6m986wMEeL9p7bI=;
        b=EBfNERLCJPwy/8kNWz/YcXcCLJvW7gHTwPVeirJT2YXfugMgVYjE4JyvbvNIqYUwD3
         VJuX4EKB1RRaNOOQitm/kRSylUjQgY6i1vJwd+sOxHqZK8FEi0uSZ4C0IMbrJVIjLZeq
         WMB7QRZs8ql7OoAHq7hUPdoFmijrEqGmiZsc3ehCVrCtJcV1O5azQvuct94VT+EGD07G
         DEuYYHZF+a4ZY2BRD6fpDMLYLRVYlTXGwKzTmIPxbKo7+rdOrLNrrrjOT1st8a8thfIy
         8iVLBj7pD4fMr8t/GHCTx8hxJpSlvhjazND7nsGR9EXTR24hrSj1J0zvlwlbwdxkTE89
         qmaQ==
X-Gm-Message-State: AJIora85+/2nmDieGFKEdPtBLGVPVlBiDqtWTRBXxeaIajqPL++defRI
        Yhls5JLjcgl5wqXK31N7XfVTPA==
X-Google-Smtp-Source: AGRyM1voq5HgqtR8sPujqGWhymdlgs9P8bYofxJ14eKjtXY4phhwK3iHPaa1Z0mwhIqTJe1nPhGATg==
X-Received: by 2002:a17:902:8647:b0:16c:e60e:570a with SMTP id y7-20020a170902864700b0016ce60e570amr784158plt.77.1658448981870;
        Thu, 21 Jul 2022 17:16:21 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:9655:152c:19f:5d09])
        by smtp.gmail.com with ESMTPSA id z10-20020a170903018a00b0016bfb09be10sm2292188plg.305.2022.07.21.17.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:16:21 -0700 (PDT)
Date:   Thu, 21 Jul 2022 17:16:14 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtnsTs8XkPS4nXdi@google.com>
References: <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
 <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:27:12PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 21, 2022 at 11:06:42AM -0700, Linus Torvalds wrote:
> > On Thu, Jul 21, 2022 at 10:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > this seems to work, let me go hack the kernel..
> > 
> > Am I missing something?
> > 
> > Isn't this generating
> > 
> >         movl $~IMM,%r10d
> >         negl %r10d
> >         cmpl %r10d,-4(%calldest)
> > 
> > for the sequence?
> > 
> > That seems bogus for two reasons:
> > 
> >  (a) 'neg' is not the opposite of '~'. Did you mean 'notl' or did you mean '-'?
> > 
> >      Or am I missing something entirely?
> 
> No, you're right, I'm being daft again.
> 
> >  (b) since you have that r10 use anyway, why can't you just generate the simpler
> > 
> >         movl $-IMM,%r10d
> >         addl -4(%calldest),%r10d
> > 
> >      instead? You only need ZF anyway.
> 
> Right, lemme see if I can wrangle llvm to generate that.

That looks good to me. I updated my LLVM tree to generate this code
for the checks:

https://github.com/samitolvanen/llvm-project/commits/kcfi

Sami
