Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84F48DBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiAMQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiAMQiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:38:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:38:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so25212549edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Cw+BPG1jU+zkMoF65IWzxVy0JjRkQm3f4AM/UiMJ3w=;
        b=cAQMLvY1l+pxTUzA5wD4375Pjo+U8FLdlE1SAXOB4zC66tjEqU49Kkv1M3vtcRqvX/
         y7ehbaOeOoLvUewb1BgOa33+reC3WKmZaGzF/ik+pMaZoN8NBPjb3ZMM6WdV5jYPAPCO
         MCVR3XG4DBGrpONMVQnSsmcNWF0/dsXOu63gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Cw+BPG1jU+zkMoF65IWzxVy0JjRkQm3f4AM/UiMJ3w=;
        b=e6wXx77xGUYiL5ZrdWqAs6y8Is9KQEIU+vgzyKDX3ihlHTQRW6oLPMnxQ3Y0fqdlLu
         Sl+qPTVcVpHQMtiuYvJ8nBanVPGCHH8yEZ0Ny/KTauw9WUwKRHRHiy632RtGavseoZx9
         BFR2mz81sPzxMyjrW8ARnyK8E5NwWXMOxVK+Iy8Lz2On4j5fvepzC9VtSf0pBQyaR9VL
         ZFeVN6PZgofYTV1C8ar8VIYoCpWW+TAEga0D94SSG5WBGdOKl7YFGD1vB7ew+Zpe7ZW4
         OUSWccSGvHGPl9jUk81C5Jg1UBn/hxnloDSR5jjSocJ/21MegP2oQZQoSha0b0JpKDuc
         OLbQ==
X-Gm-Message-State: AOAM532bIpUFqY0/mQRr7MAYDYwMbfJbArr0ReYrmFujVcv8eppk7ZfJ
        1bSK2QQHoiczxKG8p83X+OeiLcQarAMXsL87
X-Google-Smtp-Source: ABdhPJxFiW/XwpkBXIzRtLNMmDtVJ5OC5BunlLgVPgSbd0X2YPwIOND/VryhZEyHBdSeFd1QXlUJcQ==
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr4067830ejc.397.1642091882022;
        Thu, 13 Jan 2022 08:38:02 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id e16sm1356623edu.15.2022.01.13.08.37.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 08:38:00 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id s6-20020a7bc386000000b0034a89445406so1877706wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:37:59 -0800 (PST)
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr4583261wml.144.1642091879565;
 Thu, 13 Jan 2022 08:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20220113140318.11117-1-zhangliang5@huawei.com> <YeA5oP/iaxtVPHb3@casper.infradead.org>
In-Reply-To: <YeA5oP/iaxtVPHb3@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jan 2022 08:37:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
Message-ID: <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Let's bring Linus in on this, but I think this reintroduces all of the
> mapcount problems that we've been discussing recently.
>
> How about this as an alternative?

No, at that point reuse_swap_page() is the better thing to do.

Don't play games with page_count() (or even worse games with
swap_count). The page count is only stable if it's 1. Any other value
means that it can fluctuate due to concurrent lookups, some of which
can be done locklessly under RCU.

The biggest problem in the COW path used to be that it was completely
incomprehensible. Plus it had that pointless synchronization if the
page was locked for entirely unrelated reasons.

Doing a "trylock()" - and just copying if it fails fixes that
pointless "let's wait because we know somebody else is doing something
to this page".

And doing the

               if (PageSwapCache(page) && reuse_swap_page(page, NULL)) {

thing after holding the lock is certainly not incomprehensible.

I just wanted to try to avoid that on the assumption that swap really
isn't all that relevant any more - even swap cache.

The most incomprehensible part in that sequence is actually the KSM
tests. I think they are BS and should be removed (the page_count()
check should be sufficient), but they are so incomprehensible that I
left them when I did my crapectomy.

             Linus
