Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3246A940
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbhLFVQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbhLFVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:16:08 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDFCC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:12:39 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id j21so11639629ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WX4eafM7XhN/ysEQz94cWOqdqAJNO4s4yHfaCN6LFrM=;
        b=a7s44yX/G/AazNfR6mMKB05zFGA+bvHIBBmyalE+/MFrGhfLosJWrCOtebUpxYqqlb
         5TaPh1SfZZOidPIvbPa0iljl+pLyN9A1AML3++tPDK6Z3sIPNcReIa0dvxdRdZpupvCw
         kVN6OQ7akCjS1F8593fMAM0RDEgObW1EYH+DJ6LyCaU9Jt2vKPVjFgCOAIrvXjqyoJbr
         BwwLzOs4wqlQJNoOMTsJrOEJgXnZ1vGIoUGxTMmHDHY6X16yhmILJkJwdB4mw3M609gv
         gtM2xOpNtxeOUiWsW9fa04S5tJDZPAttnW0vYTjBEQ44i/6n6m+oFmAY8isgVPr+lHDd
         1VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WX4eafM7XhN/ysEQz94cWOqdqAJNO4s4yHfaCN6LFrM=;
        b=qe528Sn3XV3TWm/AH6qq39caU8qS+v+3vt/w2OwX2XQPXYQieJSGddLlomY1ovsLJm
         yqrZxUUJqdSln8vGOYhLPM8ONet13UzheevJ8PCpIJOL2zUZ0Hh4hSdw+HnxwgmkMrK8
         eLOEboXOphLW1LDUNV/ii1WF6W3cCA9eWkHRyQ/O7sVkIJ9bFK2yLMKX/SlLdIy4U6S2
         u1C3BNvtgZAO1cfPNZvLgBpVlR+S13HhPkOEp5rwC3A06P9NjKq3UPD6FYl1XgrHK26t
         tLqISSGH1VfMFGac/XjKfUuZxHf+uYIV+rDu/dTXoY+9F4z6i8+Dz4QvYmsIdFsGC5g+
         ySYw==
X-Gm-Message-State: AOAM530gDQYWeoGefUMxIpvwFbbuaTp1LGdGZWA1HJ3tb44w1GPL5uIg
        C4HbQ1CVwK6UyuFB8+MAM8+U+FmM/znaWjsRNKW9P9PBEyI=
X-Google-Smtp-Source: ABdhPJyg921Y+M9sfYj+3RNZXwJKhGfiGimgdocguthZUeHI+TeBhlANZ0rmC91vuJj3ytkOWhNo/7oTfCXUC6UbVFs=
X-Received: by 2002:a05:6e02:1d1b:: with SMTP id i27mr37229873ila.248.1638825159053;
 Mon, 06 Dec 2021 13:12:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <8557e32739e38d3cdf409789c2b3e1b405c743f4.1638308023.git.andreyknvl@google.com>
 <YaoQos9Fevz32h6+@elver.google.com>
In-Reply-To: <YaoQos9Fevz32h6+@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:12:28 +0100
Message-ID: <CA+fCnZdOuQCCTphqnfUP3Us+fgXpA-arS+z3avHAtNVybhxMSA@mail.gmail.com>
Subject: Re: [PATCH 24/31] kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:42 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > HW_TAGS KASAN relies on ARM Memory Tagging Extension (MTE). With MTE,
> > a memory region must be mapped as MT_NORMAL_TAGGED to allow setting
> > memory tags via MTE-specific instructions.
> >
> > This change adds proper protection bits to vmalloc() allocations.
> > These allocations are always backed by page_alloc pages, so the tags
> > will actually be getting set on the corresponding physical memory.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> This is also missing Signed-off-by from Vincenzo.

Same here. Thanks!
