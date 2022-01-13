Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFCA48DCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiAMRPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiAMRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:15:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349D8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:15:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i5so25615506edf.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kS0t9n6WxIZ4bWLd5wtbwG6/RZMrpLppDsAbCaXE63M=;
        b=YxzTX5Uhqq8IWsJVPAOhmMK2xnzPz7eAXueVAcwmhnWzlL8a0IUxHPtVCqGhIxIINq
         u5etVqmHwf1LHxwq5QG/zTCtvahIR9hBSYDsx4/mvVoAiR7Hh9WZpYSQZEPo2pUACeva
         2JHZIo/uFA2x3txdZZgzgpCWkBdVOVqolnhzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kS0t9n6WxIZ4bWLd5wtbwG6/RZMrpLppDsAbCaXE63M=;
        b=6eBT74HivAyBUXRT7BxQ2jakuey5xjRhEjyYBKqB1reiEq9XMCvHHjOAPwnbLh9Wkl
         vCqSR5d+Vay5bG6x94HozJzeTvSP2VH35V/XhGMdz/OtGIRzfkmQg5RbyI4FuFsQCQtN
         twJdIUWiGKUlscGRiGu14sfHPLnbTUZa78uaPVsLe979SdePqSpEoQMwsu66qFShf9qQ
         3W6maOd/18GroKyk6+FyhDSNm8EqMstoG7UqHQt2wta72rkx+lITI9OF9ajcetK9fVEC
         QhDGkPLW/SbRWSrMd+CN3mIwTXiC8O5X3uNjX7+UsYSy5XHJVgi2Y3abRQUZwoPF46gN
         R/tQ==
X-Gm-Message-State: AOAM531JaRINmz5FHFGs8jq3Qx//VSRNnPhPCqkZdRuf0HHi+VYZGtTk
        fXalX+BM0Oxvw5Yj7prSqxHxb9rYX0yX5pDL
X-Google-Smtp-Source: ABdhPJx7WhP5r2DJnV1h1KQiYyh09N4Dg66ECBiTYzDOhHMHWTmuMRRL/mfRqbT8pPSk6ir+vgZzug==
X-Received: by 2002:a50:8e4b:: with SMTP id 11mr5017153edx.272.1642094107350;
        Thu, 13 Jan 2022 09:15:07 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id k22sm1415538edv.22.2022.01.13.09.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 09:15:04 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id k18so11325333wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:15:04 -0800 (PST)
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr4710646wri.193.1642094104088;
 Thu, 13 Jan 2022 09:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org> <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
In-Reply-To: <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jan 2022 09:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
Message-ID: <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 8:48 AM David Hildenbrand <david@redhat.com> wrote:
>
> I'm wondering if we can get rid of the mapcount checks in
> reuse_swap_page() and instead check for page_count() and swapcount only.

Honestly, I think even checking page_count() is pointless.

If the page has users, then that's fine. That's irrelevant for whether
it's a swap page or not, no?

So if you want to remove it from the swap cache, all that matters is that

 (a) you have it locked so that there can be no new users trying to mix it up

 (b) there are no swapcount() users of this page (which don't have a
ref to the page itself, they only have a swap entry), so that you
can't have somebody trying to look it up (whether some racy
"concurrent" lookup _or_ any later one, since we're about to remove
the swap cache association).

Why would "map_count()" matter - it's now many times the *page* is
mapped, it's irrelevant to swap cache status? And for the same reason,
what difference does "page_count()" have?

One big reason I did the COW rewrite was literally that the rules were
pure voodoo and made no sense at all. There was no underlying logic,
it was just a random collection of random tests that didn't have any
logical architecture to them.

Our VM is really really complicated already, so I really want our code
to make sense.

So even if I'm entirely wrong in my swap/map-count arguments above,
I'd like whatever patches in this area to be really well commented and
have some fundamental rules and logic to them so that people can read
the code and go "Ok, makes sense".

Please?

         Linus
