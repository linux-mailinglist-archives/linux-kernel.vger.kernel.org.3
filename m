Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31374AB0B6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiBFQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiBFQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:46:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4BC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:46:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c9so9401703plg.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AV/FzMjsxogtDwb4DWVIrdYcYlkVfJVUqj5wlwsCnNI=;
        b=IM9nujf2vxUCcqhBkGmCyCSjSPkM/1Z8UCnM9qCzcghIic6L3kdbcJM5Sg/f688jy/
         W6dY+M87VLHAvepwQ6rUnjSZXMumB51f7PU/oCwhuJICX0tXiZseOjojEEhmBUjTqMtO
         jKtbreY27ABOCklcIwgWFLJw4armPQjQIaTlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AV/FzMjsxogtDwb4DWVIrdYcYlkVfJVUqj5wlwsCnNI=;
        b=EHfiPxHLnAxi43Xd6MwvixlnkZgaTQIngIUjLRjZrihQSUJHqDiFaDrD3gZRY5hKip
         g5OrQOoA1LgPs27EzujriJ0hJ1jn4gJICcaYMc9qLX4dWIVWfk/JxtkB+DlnYOPqzrlV
         Snb0W5WKB65x69L40znsyI4blDYmF7j+NuE/6e8iqH55taCUY8j6Uk5NxJTG8LH5cfwT
         USPXTTjfOwSAbG0OLvX8d0ZS7xxf2aWgtpQi5JuYUHEzxyNNll4qej1Wt0Vx7QxcWU67
         6G7M2IMT81wgi6K2vFii57tIprD0HuUyiivbGxC9ylkZ64Y/IfzS3hoVs4Td1AYUIxFr
         SA+A==
X-Gm-Message-State: AOAM533wzs0os1fsfkxrvw4ft0SegVvuXoYd5uLNwuvAgJYoRXN8jFB3
        2EIZFIW3chY5w/77B21bhHcE8A==
X-Google-Smtp-Source: ABdhPJy2qKrHFsxitkkqN9O4RqiQ22JSOYLOpVX3iDRRP/MtqLZZ7QOW64c3Byn6vBd5rthkziC33A==
X-Received: by 2002:a17:902:ed85:: with SMTP id e5mr12436620plj.46.1644166008765;
        Sun, 06 Feb 2022 08:46:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm9273853pfv.24.2022.02.06.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 08:46:48 -0800 (PST)
Date:   Sun, 6 Feb 2022 08:46:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <202202060819.3C86C47DCA@keescook>
References: <20220202001918.4104428-1-keescook@chromium.org>
 <20220206115816.GA23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206115816.GA23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 12:58:16PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> > Is it correct to exclude .noinstr.text here? That means any functions called in
> > there will have their stack utilization untracked. This doesn't seem right to me,
> > though. Shouldn't stackleak_track_stack() just be marked noinstr instead?
> 
> This patch is right. stackleak_track_stack() cannot be marked noinstr
> becaues it accesses things that might not be there.

Hmm, as in "current()" may not be available/sane?

> Consider what happens if we pull the PTI page-table swap into the
> noinstr C part.

Yeah, I see your point. I suspect the reason this all currently works
is because stackleak is supposed to only instrument leaf functions that
have sufficiently large (default 100 bytes) stack usage.

What sorts of things may end up in .noinstr.text that are 100+ byte stack
leaf functions that would be end up deeper in the call stack? (i.e. what
could get missed from stack depth tracking?) Interrupt handling comes
to mind, but I'd expect that to make further calls (i.e. not a leaf).

> > @@ -446,6 +447,8 @@ static bool stackleak_gate(void)
> >  			return false;
> >  		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
> >  			return false;
> > +		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
> > +			return false;
> 
> For paranoia's sake I'd like .entry.text added there as well.

Yeah, that's reasonable. Again, I think I see why this hasn't been an
actual problem before, but given the constraints, I'd agree. It may
allow for the paravirt special-case to be removed as well.

I'll send a follow-up patch...

-- 
Kees Cook
