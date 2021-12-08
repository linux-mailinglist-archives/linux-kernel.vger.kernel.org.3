Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FD46D9D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhLHRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhLHRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:39:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A887C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:35:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so10779944edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ckibsje4Fnd3VY4SP1aED1W0LwwcbRPFpcYTanTTjQ=;
        b=enTUXU/e68+ySvnKJb/1GHyj4UVaV7OmU+vMxb/UK4v+JppxeTCBTukW3Xl7q+pd93
         XEwYEcchfKiFKmmzAgmXDudTVKUpUgL4Nm2/EozStJQ/7z6Rnw3WtBEsIH3rXytLa8ag
         FBmrkAhHTJJtcP0SQb7fzFD50hNhpaBo4WssVoYDJ02np4SGajxqv0jUNt9pjNpkx9PO
         /V57V/cG0Qq2A1t5ksgJAtjCchc/v2qRybRN8ikKgW73/vaZOhJrtobKUoAgzFwk/Ffp
         SWwIYOR0BhQapaV4f+YnSliF5YFYxbRmZhGrrKswP2vKFzzg3vvZ2dNorKvIvnOayALL
         urJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ckibsje4Fnd3VY4SP1aED1W0LwwcbRPFpcYTanTTjQ=;
        b=gWj4sN1txBMBUiQmUvYNHZJa+XU5lza1blBUz54Wg+zv/RLlDEsNwhd0l8/xn2jR47
         8TS5YVP4nGXtYlhd+b+FN3F3AXT7axDmF7KRL1MWrR0cj1E+3wX1yKnEOdJgZMaW29Ut
         2y2vpZWGMYJfog37yryCJrJMbcAl53anRugQzc3Bl/EV64gsHjhb4oqGhMm7xwmzIj0y
         b7GdyXzX6dIHCki2SUtRCS13n2+2Ku6UDH7b36su+psSVQWsjh3UQlYL00CruxR3q2v9
         4Gir6xdOIzNp8ffKgBLtRRJvUmkSDChe4Lzir324fJzHrx1E/fFBhtcIK1ZsIJwTIegQ
         6flQ==
X-Gm-Message-State: AOAM533E1U3/lAxaQpuqHtf/uz99+bPdSbHqX0Kf0JML3ooZZgeIo2wR
        pwxfJptOGoNnc3p0k49uQJP9dZ7adGA8iPpAzzne8Q==
X-Google-Smtp-Source: ABdhPJxDn+3oG2kajdaXYIT7+4MrjY5A2Tbh/5sjaO7xfTGiXHZv73W078zOwbCjUIuzDoViD65s1US3GEIGqaBK13U=
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr9218020ejr.435.1638984939594;
 Wed, 08 Dec 2021 09:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
 <20211204182314.1470076-4-pasha.tatashin@soleen.com> <20211207160508.6ef48f273c1ae14c0d02c6ac@linux-foundation.org>
In-Reply-To: <20211207160508.6ef48f273c1ae14c0d02c6ac@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 8 Dec 2021 12:35:02 -0500
Message-ID: <CA+CK2bBanZtit4Ck3wy_9bPha-Frw-SsV4UV4+GneTrcp4qN1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: page table check
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Fusion Future <qydwhotmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 7:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat,  4 Dec 2021 18:23:13 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > Check user page table entries at the time they are added and removed.
> >
> > Allows to synchronously catch memory corruption issues related to double
> > mapping.
> >
> > When a pte for an anonymous page is added into page table, we verify that
> > this pte does not already point to a file backed page, and vice versa if
> > this is a file backed page that is being added we verify that this page
> > does not have an anonymous mapping
> >
> > We also enforce that read-only sharing for anonymous pages is allowed
> > (i.e.  cow after fork).  All other sharing must be for file pages.
> >
> > Page table check allows to protect and debug cases where "struct page"
> > metadata became corrupted for some reason.  For example, when refcnt or
> > mapcount become invalid.
> >
> > ...
> >
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1307,6 +1307,9 @@ config HAVE_ARCH_PFN_VALID
> >  config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> >       bool
> >
> > +config ARCH_SUPPORTS_PAGE_TABLE_CHECK
> > +     bool
> > +
>
> I guess a dependency on CONFIG_DEBUG_VM would be appropriate?

I do not think CONFIG_DEBUG_VM is needed here. We would like to have
page table check enabled on some production machines to ensure there
are no double mappings. With CONFIG_DEBUG_VM enabled that would not be
possible. For example, CONFIG_PAGE_OWNER, also uses extended struct
page entries and does not depend on CONFIG_DEBUG_VM

Pasha
