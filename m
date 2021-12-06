Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A218446AE78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbhLFXcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbhLFXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:32:03 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AA1C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:28:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so517608pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYlong7BFeAPBAo6aJJAOLFXmMpt5I92OzI5hHT+4DQ=;
        b=ZFk8Cpau3VRTYxRul9UaQIlSGM1KPnxNcxeXeHXgHZ1BacepQ3f1pgT4knSx9jmYc+
         MC3RIYSKIZjytMmU+O0sZzWJ1Lc+lpKz3pOqma7LdlkdgiHo0ZHwOvixT+EJ95A+zKai
         2UISRN7nlqeo9huTXdu07jKzUWlLecF5mo29Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYlong7BFeAPBAo6aJJAOLFXmMpt5I92OzI5hHT+4DQ=;
        b=c7Q0j6R1QKKkiUcrGegN37WVuxzy8JltXpHoz3GIs0nX4ge8SUTB++ZmpGM9BRknR6
         Qqyf6FOobc8BVia1euShbw9RSAWJe7ajnUKyQZ8qs+x08ZJGHXEgNn3NqxPIDW+8lfDz
         FEMKlUIctkytOAZsepQhBqwo5PmhLB1L/CrvLY7UIyTZh3dHZbyLZXtuzya3gYWeQJyt
         cec79xQzRoEjnFj3tBT/rZFn/q/+WVwFi+z0GeHPmmkAMU+KmlU4Q+bnOwhOWG0KgjvF
         1FfKaEbn1jxxlRdMEIo1F+FwiGTXl2Qkcld3YfXFXFz3bkrI7HaCfO9dO9u+OhK9VZjb
         9JcQ==
X-Gm-Message-State: AOAM532oUrfNIkcfZCvgs80e/h9NUM58n/1XPlmc5siDTLTLu3Mgwzs7
        8ZArG0lRdz8lYaxVRb7ebofrGHW0Azha3A==
X-Google-Smtp-Source: ABdhPJyCWRhj7VPjT3NxliyEgMqe+IoDoJvad+ognPbn+ZXCLt+PZpfUdmrv3Mxw6QhEAAsGSoanww==
X-Received: by 2002:a17:90b:4b4d:: with SMTP id mi13mr2027431pjb.192.1638833313291;
        Mon, 06 Dec 2021 15:28:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13sm10625918pgg.16.2021.12.06.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:28:33 -0800 (PST)
Date:   Mon, 6 Dec 2021 15:28:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <202112061455.F23512C3CB@keescook>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
 <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 01:17:17PM -0800, Linus Torvalds wrote:
> End result: atomics are _better_ in the overflow case, and it's why
> the page counters could not use the garbage that is refcount_t, and
> instead did it properly.
> 
> See? In absolutely neither case is recount_t "safer". It's only worse.

Right, I understand your objection; it is valid. One of the dimensions of
"safe" is "not exploitable", which is _also_ a valid concern. As you
say, refcount_t works for the "never make them all handle overflows
properly" case, and I'm fine with using something else where we need a
better set of behaviors.

> I like Jens' patches. They take the _good_ code - the code we use for
> page counters - and make that proper interface available to others.

I am fine with whatever can be made safe in all dimensions, but I don't
want to lose sight of the exploitability dimension. This is a lot like
the BUG vs WARN situation: BUG is unfixable because there is no recovery.
WARN allows the code to do something sensible in the pathological case,
but the code needs to have been designed to handle that case. The
widely used older atomic_t reference counting code pattern had no path
to handling failure.

In the proposed API, we get a warning (sometimes) in bad states, but
there is no handling of the broken reference counter. For example,
with atomic_ref_inc_not_zero():

- there's no __must_check hint for callers to actually check it happened
- overflow is silent, so wrapping around to 1 and then having a
  call to atomic_ref_put_and_test() has no protection against exploitation
  at all. This particular code pattern mistake (missed "put") is the
  fundamental path to nearly all the refcount overflow exploits of the
  past couple decades. e.g. see:
	- CVE-2016-0728 - Keyring refcount overflow.
	  Exploit: https://www.exploit-db.com/exploits/39277/
	- CVE-2016-4558 - BPF reference count mishandling.
          Explot: https://www.exploit-db.com/exploits/39773/
  Losing that protection is just inviting these exploits back again (of
  which we've had none in the past few years).

For the API generally, nothing about the type stops someone from
accidentally using the standard atomic_t helpers instead, accidentally
bypassing any potential WARNs. It should do something similar to
refcount_t so the compiler can help guide people correctly instead of
blindly accepting an accident.

And if we're speaking to safety/robustness generally, where are the unit
tests, run-time tests (LKDTM provides this for refcount_t so it should
be easy to repurpose them), kern-doc, etc?

I'm not arguing for refcount_t -- I'm arguing for an API that isn't a
regression of features that have been protecting the kernel from bugs.

-- 
Kees Cook
