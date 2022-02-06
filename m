Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F534AB161
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346603AbiBFStV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiBFStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:49:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C6C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:49:17 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h125so9727987pgc.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2v4Bkm8br56s9qLPALsh3pbC7ql67TUJ0yFnLPxLRHk=;
        b=bHu48kLEfO0BvtG6X0aiGbTtRNOUTWieaRIPaWNVq0kGREyeoBqdU0yjw4IOPe9Tj0
         nAeJ7SVbj1adJGvHFKz1t/wqHo3Mbb0w2OoGbI2MoGZAFeXUAzWY7vREhLb1/qR4N82D
         TvFOCCgbiwXQhtyaCLILTjc57sTV0acdHDw/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2v4Bkm8br56s9qLPALsh3pbC7ql67TUJ0yFnLPxLRHk=;
        b=RU7QfOImDDSba/77mFy0bUXGGic1rL/8dIg333RJN4czGaVtr/rt9BMEp0+CwFkctZ
         SB11Qwp+hgBs+FYqAJ0jcecGos7yqjKRESpvXl6kiSvQO/WXo8PIwcWnUd3zHD39Ho1J
         Hr6API2lb3kG5oRxpaZgVEH6IqFiwe+0360YWaTqpoGZ9srmrKS/RHBrilP3nzXZlgth
         ySazmuGZFnfA/v7hJx1//CWs9Q7TQohB0spdMJHFRx+P+pN3SahKho4k7V8hFeYWoYaT
         7gfhZFD7ULtBehheVGrRljlM5h/+90mKdJ/9LzKAev6qiwNJF+jZF55qv/lsyKUDKLHo
         EW/Q==
X-Gm-Message-State: AOAM5305d6exMfYfYAJq4+6LHxAIWC/zUkVRjQmx3aTyFZY7jCsHRB5H
        zaxGIsPaQpcFS5MIAV+GYzkHmw==
X-Google-Smtp-Source: ABdhPJyWqmFuqt/fFPdQlg8sO5tyPVSj3BV1IVOc6TI82qubKGsKg0BvZ/UnZK/5jEFTljEBuu8E2Q==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr6839350pgj.487.1644173356941;
        Sun, 06 Feb 2022 10:49:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm1758823pgg.50.2022.02.06.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 10:49:16 -0800 (PST)
Date:   Sun, 6 Feb 2022 10:49:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] gcc-plugins/stackleak: Exactly match strings instead
 of prefixes
Message-ID: <202202061046.040D6A0A0@keescook>
References: <20220206174508.2425076-1-keescook@chromium.org>
 <20220206174508.2425076-3-keescook@chromium.org>
 <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 10:34:11AM -0800, Linus Torvalds wrote:
> On Sun, Feb 6, 2022 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +       return !strncmp(TREE_STRING_POINTER(node), string, length);
> 
> Why is this "strncmp()"? That makes no sense when you've just checked
> the exact lengths of both sides.
> 
> You're not comparing strings any more, you've already checked the end
> of the string - you are comparing memory contents.
> 
> So make it just do a "memcmp()".

Yeah, good point. I'll change this for v2, pending more feedback.

> > +#define STRING_EQUAL(node, str)        string_equal(node, str, strlen(str))
> 
> .. and please change this name too, since it's not comparing two
> strings. The first argument is something else entirely.
> 
> It's checking the node value of a section, give it some name related to that.

Technically, yes. The naming bikeshed here is odd since it's called
"STRING" by gcc internals, and it *might* be a "C string", etc etc. I'll
rename it...

> I do also get the feeling that the nodes should actually be checked to
> be a STRING_CST rather than these blind TREE_VALUE() following things,
> but I don't really know the rules for gcc plugin internals very well -
> or at all, really.

I'll double-check this, but if it's not a STRING_CST something else has
gone very wrong already. But I'm a fan of robustness, so sure. :)

-Kees

-- 
Kees Cook
