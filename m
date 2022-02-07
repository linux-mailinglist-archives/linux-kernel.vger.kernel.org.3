Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3B4AB420
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbiBGFwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349441AbiBGC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 21:58:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBBC043180
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:58:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so12036308pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxExIV77Tn6LTPoKZIRsR52CbJyPFso/VdKEunHEkBw=;
        b=S7jQ23s8oyEzwMduypPD3WabdNlC9spE9m3Kp9V+vzRoH/cm/FwunXNxpa1ssKTugi
         qcIL8WI1Wc5t0QkN/MpKucZlCvlLRDQ13BBLq/ypDhwEO1gO0VwdwNUueWi0I4Z0hMhl
         sN0+Z4irV0bTGVKeLxH1EPYrNFPxV/SA4kCXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxExIV77Tn6LTPoKZIRsR52CbJyPFso/VdKEunHEkBw=;
        b=rLECX0/nsKrKd4mgTdHW1rsmRV1E6RqOpX0w6oHQHQdfiPni0Oo58HTeklR4DrxhJr
         cR0X+xO+DejVANa7M0K1H04bieE5ylYXBRIBzo4f9RfnroThGVqQBe930nrDznnXAO2Z
         V8sVf+mUCbH67nz0JrQ4kvxDL1P7DiS7vyqDPmUwRjiGFu5QOXjpTyR7gO42k1e/FUZr
         a8JBxM42N2PJ579DDypfog0cFjDL8xnujvUhepqL27RgTzCK2lESAvn2uTHTybokimy0
         CH/NmXAV3zw2y5MtxnR3eMtNNFi8ZuiCNG5bWou1jpp6LRShFOLZZCyo3NlosZjfbsRv
         LvzA==
X-Gm-Message-State: AOAM531B35jmy9+CMuIdXP6vSpbgPFxg9pIUHdh5d27NxIEa1HQkVwNX
        M2JRH6ZNcTh1Iu5a5YZcf3nv77w3EBFikg==
X-Google-Smtp-Source: ABdhPJxWKveza+zkkF09dV74hhKksjFAaFudcZ5ZAuZ08pfsZe1frMkRh60VirGM4nvUEKziJSRZNw==
X-Received: by 2002:a17:903:32c6:: with SMTP id i6mr14627977plr.60.1644202680932;
        Sun, 06 Feb 2022 18:58:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kx5sm2167786pjb.16.2022.02.06.18.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 18:58:00 -0800 (PST)
Date:   Sun, 6 Feb 2022 18:57:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <202202061856.EBC48533B@keescook>
References: <20220202001918.4104428-1-keescook@chromium.org>
 <20220206115816.GA23216@worktop.programming.kicks-ass.net>
 <202202060819.3C86C47DCA@keescook>
 <YgAyL2D25nweODX3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgAyL2D25nweODX3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 09:40:15PM +0100, Peter Zijlstra wrote:
> On Sun, Feb 06, 2022 at 08:46:47AM -0800, Kees Cook wrote:
> > On Sun, Feb 06, 2022 at 12:58:16PM +0100, Peter Zijlstra wrote:
> > > On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> > > > Is it correct to exclude .noinstr.text here? That means any functions called in
> > > > there will have their stack utilization untracked. This doesn't seem right to me,
> > > > though. Shouldn't stackleak_track_stack() just be marked noinstr instead?
> > > 
> > > This patch is right. stackleak_track_stack() cannot be marked noinstr
> > > becaues it accesses things that might not be there.
> > 
> > Hmm, as in "current()" may not be available/sane?
> 
> Exactly the case; if we lift the PTI address space swizzle, we start
> with C without having the kernel mapped or even the per-cpu segment
> offset set. So things like current will explode.
> 
> The whole noinstr thing was invented to get back to C as portable
> Assembler, with the express purpose to lift a bunch of entry code to C.
> 
> > > Consider what happens if we pull the PTI page-table swap into the
> > > noinstr C part.
> > 
> > Yeah, I see your point. I suspect the reason this all currently works
> > is because stackleak is supposed to only instrument leaf functions that
> > have sufficiently large (default 100 bytes) stack usage.
> > 
> > What sorts of things may end up in .noinstr.text that are 100+ byte stack
> > leaf functions that would be end up deeper in the call stack? (i.e. what
> > could get missed from stack depth tracking?) Interrupt handling comes
> > to mind, but I'd expect that to make further calls (i.e. not a leaf).
> 
> All the syscall/exception/interrupt entry stuff is noinstr; I don't
> think we have huge stackframes, but with all that in C that's much
> easier to do than with then in asm.
> 
> If you worry about this, it should be possible to have objtool warn
> about excessive stack frames for noinstr code I suppose, it already
> tracks the stack anyway.

Yeah, I think we should be okay at least for now.

Let me know what you think of
https://lore.kernel.org/linux-hardening/20220206174508.2425076-1-keescook@chromium.org/
and if you like it I can send a v2 Linus's way...

-Kees

-- 
Kees Cook
