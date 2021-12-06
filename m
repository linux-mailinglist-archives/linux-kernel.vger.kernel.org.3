Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC046A8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349854AbhLFUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbhLFUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:54:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A60C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:51:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so842646pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mCJ4nBf6Lo40Ydhx+IIYyWq/GXNaQKH4uw6Hx68amJM=;
        b=QceAsGJixEdXIWVajZC5pj9oUyYkkA0rPKztynGXnWuxeFiY0GJd+OQq9CK2s1yJ3p
         EbXNWRJrSEFMK3AEUhNiBSDkAESrXDEQHGYA+aKlcYeMWdAx4UYED5QzvVP7v54+hMir
         2sE2cxDNiWuV1nJxEy0i7mZpkdfCeSVN0PM1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mCJ4nBf6Lo40Ydhx+IIYyWq/GXNaQKH4uw6Hx68amJM=;
        b=uf7b5hImSezgNuzu1Wx5aERc9SNbozfC2LmNj0zNcCjlwkRWBrJXVfY1ZvvP0+qwjQ
         vXe2tb4X1WOvwSRifkcAuaX492btiGqmNNHKAQZhvDaXfUjS4fusUiapyYt2a6tiwaXQ
         OuvYdEGfQV7UOR3u2jlJnJkLL5N2zSFTFP+LfRMUuetR+qQbob0qMhk6ynHfPIPlVQv5
         2sUwd8JRdzZ6XJTREFvV5CSwJpy3hnf9jPN3SqDPMxpnHVBdCq9RiA8D/Pl7zmmZyPZn
         b0hvLq9DUap92NBidU0nWATrltFZervHRiZn5EDjWXcYPDvc7tqUQ0QyCu0gYAyoeV8e
         hnEw==
X-Gm-Message-State: AOAM533kNwRjDei9C782A96PdvqNsqGqsMw1KwlY166x3QHSwLW4y7cR
        sOQZZcW1zDrjxhUHu2Qip0YjGlkR1Ufm6A==
X-Google-Smtp-Source: ABdhPJwd0z0OTzz0qvWpgQZFBgki7hiRllcp5VHVPHHFHjy1Xg4vtrktWWvpzaosTDvFAvoPlVV+Vw==
X-Received: by 2002:a17:90a:5883:: with SMTP id j3mr1117921pji.13.1638823881893;
        Mon, 06 Dec 2021 12:51:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm13750950pfi.46.2021.12.06.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:51:21 -0800 (PST)
Date:   Mon, 6 Dec 2021 12:51:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <202112061247.C5CD07E3C@keescook>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:13:20AM -0700, Jens Axboe wrote:
> On 12/6/21 10:35 AM, Linus Torvalds wrote:
> > On Mon, Dec 6, 2021 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> Quite; and for something that pretends to be about performance, it also
> >> lacks any actual numbers to back that claim.
> >>
> >> The proposed implementation also doesn't do nearly as much as the
> >> refcount_t one does.
> > 
> > Stop pretending refcoutn_t is that great.
> > 
> > It's horrid. The code it generators is disgusting. It should never
> > have been inlines in the first place, and the design decsisions were
> > questionable to begin with.
> > 
> > There's a reason core stuff (like the page counters) DO NOT USE REFCOUNT_T.
> > 
> > I seriously believe that refcount_t should be used for things like
> > device reference counting or similar issues, and not for _any_ truly
> > core code.

I'd like core code to be safe too, though. :)

> Maybe we just need to embrace it generically, took a quick stab at it
> which is attached. Totally untested...

As long as we have an API that can't end up in a pathological state, I'm
happy. The problem with prior atomic_t use was that it never noticed
when it was entering a condition that could be used to confuse system
state (use-after-free, etc). Depending on people to "use it correctly"
or never make mistakes is not sufficient: we need an API that protects
itself. We have to assume there are, and will continue to be, bugs with
refcounting.

-- 
Kees Cook
