Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D762447B544
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhLTVff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhLTVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:35:30 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:35:30 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id q6so3102663ilt.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcBG8nhHB+sRNlK7pbQ7JuxvUVpSVTkBiRPlBoBdveA=;
        b=Fje853ZVa1sigXm3UGhAHhOugdu5MewkFitIfF+07YtqszK3e4KuesQ5cGsiEPuGER
         7fISAadzACuSMhWy5oZ2uWKqDvMLotfG5hi4QjBLecBHqgBgPbc4dDcvzXWpr07pkrBZ
         1m2DOj9beJqukp7eN7Cye1xhgmoDOrGIwjKzqdI2yHzgLLznOw+/7Hs4aI50M9B/9gqP
         +bx+7ewJAPhM0mh6D0IU4sPJvbqoMkyRoqaKfAb7YkAH2jXp0/9v/vSFyK/NPAV0vTRH
         ff73Q4yuL84ZeqcrAFEr54z7GkfGplMJLZXn9dpfMnq10+1hUWF76b15nuEt0onsOvXK
         vbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcBG8nhHB+sRNlK7pbQ7JuxvUVpSVTkBiRPlBoBdveA=;
        b=BOtIqbY/kC1D01ucB+laQ1Da1V1nrU22Bb3ACEBf6nl6BLvtRpo1HZw9jh2aqyaShG
         KSRsvUuds05qOTbBvULtDOA8Nlru/ughOJWRZMKANXo3Hk6MQiWlutbAzhabX1vZzfTS
         /fe7zZ4RnzVqFIUq2wsz1THRsDroeL8cuiMIKsXHQMv9PHAX5ihRIYYauZTP3ef7x8PJ
         yaibcF3kr1tHGNiJn5CQmqaC1tHt74outPXp9BrQYvy+T9LVldvCmPK7i3TSfv1/rebP
         67X2VLiUGLShDgYdUiN/pLMY7NGpSl8IqGSZ452qyKAKOfkRSin5U8+tmSxEUErpQ94m
         LaAg==
X-Gm-Message-State: AOAM533XQFSBPpNAoR5MfW9wJrvOFa+psHX9n+uEIP3EVoVm8+MztGtT
        NnKr7r3LMCVKGyhcrwyABXFWWg38s5i57Zi/qfk=
X-Google-Smtp-Source: ABdhPJxn8l69Bwc+5olDjlFbHVbTxrTbPDSojODyp/C7RJWQAav70g0ZNdqLGDyfKGvbSH/2pmX5IfUJb7NWccgH+O8=
X-Received: by 2002:a92:d58a:: with SMTP id a10mr9462133iln.81.1640036129810;
 Mon, 20 Dec 2021 13:35:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <1a2b5e3047faf05e5c11a9080c3f97a9b9b4c383.1639432170.git.andreyknvl@google.com>
 <CAG_fn=UWe_wo+E1P-1RyTPRAaSqXcCbhEwLaU=SJ+7ueGSysEg@mail.gmail.com>
In-Reply-To: <CAG_fn=UWe_wo+E1P-1RyTPRAaSqXcCbhEwLaU=SJ+7ueGSysEg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 20 Dec 2021 22:35:19 +0100
Message-ID: <CA+fCnZfHHc9POqt_S78B=xHaqTRZy-5gr1Teix8o5g4jrz73bA@mail.gmail.com>
Subject: Re: [PATCH mm v3 26/38] kasan, vmalloc: don't unpoison VM_ALLOC pages
 before mapping
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
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

On Thu, Dec 16, 2021 at 8:08 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Dec 13, 2021 at 10:54 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Make KASAN unpoison vmalloc mappings after that have been mapped in
> > when it's possible: for vmalloc() (indentified via VM_ALLOC) and
> > vm_map_ram().
>
> The subject says "don't unpoison VM_ALLOC pages", whereas the
> description says "unpoison VM_ALLOC pages", or am I missing something?

Yes :) The title says "don't unpoison *before*", and the body says
"unpoison *after*".

I'll reword the changelog in v4 to make it less confusing.

Thanks!
