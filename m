Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6059481F71
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbhL3TLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241785AbhL3TLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:11:48 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB55C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:48 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y11so25320806iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrhmOz+RWOitrnUQCMaMCSKwtj1JoPe3FFZpv8eycXk=;
        b=eukBzX8N02HpGqLlUkM+JYIlCmS26eqZjqdJOnIrt0PbIj1YnC8TqiKP3Isx3fgEyu
         2wVU810MwxzuDSfXfFtcqp5bVhUxrnqx63Pc8xUREB6hx+8VN10eByOjhokBHpIOXaE9
         5BNXlkwwk1xF+f9FqRhvKHVZLoTAW7LMinOoUGzonBjTSH4uTEuVZVD3aPL7+LR6X435
         gafNfwDI9cbFWaK3TVPyH2Pwpl5ZtSYrWPjM1+9Yb3egXJ794iTHlfqLGwFfoRqhSBNa
         NaHhmgjV4UlipZobOzoZS95UmBgJpD9chYA3ZpN7r8L3TGYShV+2ZekVkAsSzqUwzgTp
         YyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrhmOz+RWOitrnUQCMaMCSKwtj1JoPe3FFZpv8eycXk=;
        b=fI6WVXRmRDVeon0ErE7sgJMM5EMuF/yoEtcOxK5A9TeEM1eI4cTKOQhVQInJk5FohT
         FK+wtzTaSS4XqPpfMtLQlKTYJQKhz0dTfFWpoG8GHeR8Shb2gJMCCqT9ZE55WKfMRxRE
         IdkM05R8J6Jgd3NynNuneBqUWi/zcC/wJdjh73hUu6GihKCPsBE0kkL+HtOqxmPvfnci
         vEbWAb8+MKWrjvxP5nrztTf7jzzjXY1A3GtWkIe30zAv+yZ559n7zLmIDW9+Asn/wUVM
         BYBskbqFgfUkrN1+pcRQn+/+tL2SIvn26/Ke6EqnQNA6LEa74iOsQs8TQFkFtX+oqqdQ
         lXvQ==
X-Gm-Message-State: AOAM531JtGFUTWxFWKkoDjDCmkAhjj3ZZwTV7rhez6WAcpYh9rAFU609
        ZwdKP77liZBYUx5vvIjN4hn2TMh63H5cRGyLPps=
X-Google-Smtp-Source: ABdhPJw2GBQhTSP5t4LHhC2FzGVDRxWuMl52NmFS9MImlEOpRI7vQ5djis8y2IGXBbwfA+BUZlTH6g8lYyFt0siciBg=
X-Received: by 2002:a5e:d502:: with SMTP id e2mr14473843iom.118.1640891507994;
 Thu, 30 Dec 2021 11:11:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
 <YcHI34KT8Am4n45x@elver.google.com>
In-Reply-To: <YcHI34KT8Am4n45x@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:11:37 +0100
Message-ID: <CA+fCnZf21dKQLZZf+NNXQ0J0HAdjQLxbGxZqgfxACBb5kUcgNA@mail.gmail.com>
Subject: Re: [PATCH mm v4 29/39] kasan, page_alloc: allow skipping memory init
 for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 1:30 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
> [...]
> >  /* Room for N __GFP_FOO bits */
> >  #define __GFP_BITS_SHIFT (24 +                                       \
> > +                       IS_ENABLED(CONFIG_KASAN_HW_TAGS) +    \
> >                         IS_ENABLED(CONFIG_KASAN_HW_TAGS) +    \
> >                         IS_ENABLED(CONFIG_KASAN_HW_TAGS) +    \
> >                         IS_ENABLED(CONFIG_LOCKDEP))
>
> Does '3 * IS_ENABLED(CONFIG_KASAN_HW_TAGS)' work?

Yes, will do in v5.
