Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E938249D7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiA0CUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiA0CUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:20:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:20:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so2328563wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irIwWJy603Qxo+dhI+0ZurEBEeIfLdRgAJSY+8tlXwY=;
        b=ONgoXgiUT2wCVoWow8Kr8Bj290mv2hublYsDDNUZW3mgaXwY4u7/H0MBfLXD40mM0j
         HJordW5x+vb5g81d6q0QlQhN3/hSqC+lTQwYeCXmV8UUeAY5IjZLTCUaY4Krqwjlslg+
         j9j8Mo0EofrmhDZh3rIKhRyYjzBKQIYAwPSLlVsGQyKZFWp9KBVANU+14Xu2IS8Kn3Qd
         lFiCwqogNEYW3ISK2aI7+8k6tXoV0hqxGTpfUoNPtpJFEWeofyCdrFKT47H+1wPy2j+r
         L7rPjF7cp6DRMcd6+EOPHDpGQqpp1nqb+g3oCLAsTFibdAYtLVbPALIBoUuG/nu7rfsr
         e+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irIwWJy603Qxo+dhI+0ZurEBEeIfLdRgAJSY+8tlXwY=;
        b=68pYyybSwSsFitR1LLdWuE/t+e8gwDC3UOKGI8OqYmxHfB5TqyWL6bTccdJPvaY1CU
         pQ0IDkTvusQq3OYw/H9s2Y89KbdDW/S/28NCE6iEmuWqY6qpvoTz1ndlluYM2MrbLGWN
         4GMVC4ZP4d9uBVG/cTqe21kBL9Ms0IuOsP1TbMV/77stOPGc6jbFEYMsjXwbje2rreQ7
         DWLjlBkXb8ZX4qJiwOOtU1wegXFEsjz+CMnCgsd6dMQNG9Zrumjv+MAUBGAhSn8XB3BV
         ADG8xY3LJKxtmZ1Gzb29Ck1X8JZPXO89BUxLIDzRxcjyVwu5xokU0PkKE41QiSx4D26D
         ec4Q==
X-Gm-Message-State: AOAM533IBZitqnhsSvFTFl9KPIbA5pOmf5czCelFbZK5sQ6PyG7A3zwr
        kxR0KgMMGLJstIa5ZWtWbIlNftkD2Hpx3U/+bBqU3w==
X-Google-Smtp-Source: ABdhPJyEh7M6xKyAwygYkLTsrsFF1tjSwVXPUsRWCi11iR2Y0inbuF6mQ6Pq4T7QsPZlC393PfLAx2/Jlg5rGCF9yvQ=
X-Received: by 2002:a05:600c:1e2a:: with SMTP id ay42mr9718512wmb.131.1643250044209;
 Wed, 26 Jan 2022 18:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com> <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
In-Reply-To: <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Jan 2022 10:20:32 +0800
Message-ID: <CABVgOSnmfhPcMCy5yQEymyBnTWSqEFbmTnSbHYL7D1D=eJOk5A@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:55 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > That being said, I can live with the current solution, but'd ideally
> > > like a comment or something to make the return value Tuple a bit more
> > > obvious.
> >
> > A comment to explain that Tuple == multiple return values from a func?
> > Or something else?
>
> Friendly ping.
> Do we want a comment like this?
>
> # Note: Python uses tuples internally for multiple return values
> def foo() -> Tuple[int, int]
>    return 0, 1
>

Whoops -- forgot to send my response to this.

I was less worried about explaining the concept of multiple return
values, and more about naming what the return values were: that the
first one is the result information, and the second is the parsed
test.

That being said, it's reasonably obvious from the types in this case,
so I'm okay leaving this as-is, though in general I'm wary of tuples
when the order doesn't matter, and a struct-style thing (with named
members) fits that better.

I'm no Python expert though, so don't let my whinging get too much in the way.

-- David
