Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198994733D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhLMSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbhLMSTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:19:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F7FC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:19:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o29so12630179wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OM0RS/4bEYmzkb9wmK02QC04dFh1YvAbp87+pL7noW8=;
        b=BMcDL/gwlViNI5XNTl34omHGZDYecsknOLJjqmetHyruLvQ2QI6Wp2EDZk4WOougGA
         kNHEfgBgyamtywoXmHXWfEkKeCfh4s6cyiAaP53jZwBipeDtq0Bfxew2qcw3sEzI5oUh
         chJuRxzaSxoW7SfoyL8ABghOyFu2lQBDV/P8LNFpBHRHVY8DlIk7lqaWb+sfZlR9rOUg
         4aLmczl199NCdwK67YTJ476yllx4YdNaA4xmbz+D/XMsUymwC1XQWTVBo69Mwt5LfXHC
         cbkKmOKjyFpt4zXpNKyyFTuKDUzLqnHBfZuGmsOvz02wlvFBodzVslq4SdQg4FnJ8y5E
         FGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OM0RS/4bEYmzkb9wmK02QC04dFh1YvAbp87+pL7noW8=;
        b=g61YRqkVBMQOUxVNMlvCAAxsl3lly9fhl16NyBEkrjdJcJdugaCtPLZ7gqHxKVtd8g
         xoPg26/j1vdWcG7nXNn6t2V6fESwn+YBYpEVXXluhjhNPwA0Mm9Zj/NBvw91vX2lIkCE
         gm6Xc90L1PmyX6ESD8GVIttXYxWu/TTo5GDoQKlEkIIKlMRote0ze3tsSYNDA+zR57ps
         WERU67gjt3H83m7IAbuG3nGHCfiNcI2RLZ9cPIoMXTTQ2/cVRajHD0Ib6kqxPVz01cC6
         jkZpjSVEDeFG7755tZ7O0FwPyzkp0w/7JQ7q/jVqtMQis/fC22A2gpaNfMSIb6ePl9KU
         hbYQ==
X-Gm-Message-State: AOAM533f6EDBgiSxvmGtu2xleQVixVDRlaSWPA2D7JwGlM9AI0A3X/lS
        eeG6obYmpaDLKFvChUMgvRBHjw==
X-Google-Smtp-Source: ABdhPJyYjsl88orioG6x9zoD5L79uSDcSZJnQKHTscgPxEOiHB0syLqiVUVfXeiKBNe6rGrAyjnnrQ==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr401949wmj.12.1639419540517;
        Mon, 13 Dec 2021 10:19:00 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:984e:fd4e:47c7:18be])
        by smtp.gmail.com with ESMTPSA id o5sm11294525wrx.83.2021.12.13.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:18:59 -0800 (PST)
Date:   Mon, 13 Dec 2021 19:18:54 +0100
From:   Marco Elver <elver@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
Message-ID: <YbeOjq20FCdzcK1Q@elver.google.com>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.857673010@infradead.org>
 <20211213164334.GY16608@worktop.programming.kicks-ass.net>
 <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:11AM -0800, Linus Torvalds wrote:
> On Mon, Dec 13, 2021 at 8:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So Marco was expressing doubt about this exact interface for the
> > atomic_*_overflow() functions, since it's extremely easy to get the
> > whole ATOMIC_OVERFLOW_OFFSET thing wrong.
> 
> I missed that discussion (maybe it was on irc? Or maybe I just get too
> much email).
> 
> Anyway, my preferred solution would simply be to make the ref-counting
> atomics use a different type.
> 
> Voilà, problem solved. You can't really misuse them by mistake,
> because you can't access it by mistake.
> 
> Sure, it could be a wrapper around 'atomic_t' on architectures that
> end up using the generic fallback, so it might be as simple as
> 
>    typedef atomic_t atomic_ref_t;
> 
> in some asm-generic implementation, although I suspect that you'd want
> type safety even there, and do
> 
>   typedef struct { atomic_t atomic_val; } atomic_ref_t;
> 
> But then on x86 - and other architectures that might prefer to use
> that offset trick because they have flags - I'm not sure it even makes
> sense to have anything to do with 'atomic_t' at all, since there would
> basically be zero overlap with the regular atomic operations (partly
> due to the offset, but partly simply because the 'ref' operations are
> simply different).
> 
> (Wrt naming: I do think this is more about the "ref" part than the
> "overflow" part - thus I'd suggest the "atomic_ref_t" rather than your
> ofl naming).

I'm still genuinely worried about this:

> 	2. Yet another potentially larger issue is if some code
> 	   kmalloc()s some structs containing refcount_t, and relies on
> 	   GFP_ZERO (kzalloc()) to initialize their data assuming that a
> 	   freshly initialized refcount_t contains 0.

Even with everything properly wrapped up in atomic_ref_t, it's not going
to prevent mis-initialization via kzalloc() and friends.

I think C won't let us design that misuse out of existence.

Thanks,
-- Marco
