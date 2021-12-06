Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560746A936
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbhLFVOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350208AbhLFVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:14:21 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD97C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:10:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z18so14564955iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXJ5BBUpsFZd0oJ0emE1suTXpCCWYGGbU7EtYyrQXzw=;
        b=ifoMfxOxt4HtajTMYM1EA8JKQGJ5N6IhbluDBp7uT/iOvk3S9i0Nmy1voX96Ce4VBh
         sBPwLk4ZMvmxTeMMeFPRMzT7B6FPnUzOPa/UnJLOmqVEYnRqkdPUMBbeWsEdxENHLo5W
         GY51npFpVoptplSrV98snWJwGm3+vFabTiK6toh54VSiq8F+RmLCghOeFOH3i5KDsCC0
         k6KRM+oCXwqtRrkLBizlxMRaPNKe7MxIrD6NRJM9glIZBaToojxAZFa4SHx4nRbDlNaT
         4Ah0/Or5f9BKrldEgke0NMXyW1M5jaNhaEj0o6ZduQUVzrI+5vwtpK/KlkyYfmDPxChr
         R2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXJ5BBUpsFZd0oJ0emE1suTXpCCWYGGbU7EtYyrQXzw=;
        b=jH76/kLXJbhAtzvuLDAjV/nDYpsqHbRkYYC6kba+vAd22wL0VlkfjF7FduFsIcBaho
         1CiaHyclnwTGE8ElarHe3HhljM3rIu/R/qvtUd1kQAUVQwTD/WZ1J3RzV1nDprVV1/cU
         49A5Y+ibz91B/sc1HurnRTga5RdAkmjpWSMDLUAKVIw8lxpSU+ygu/4m8T2pT+PGK9bF
         eOO7n6JEYhNBtSRksYZYbXvb8Rr6xvo1/fn51fJt/oOZdRMWW1/F21i3Ef8XSOZ2a/p/
         H8h/oKc7fbJfdBFFrtWNpbOIjV8evnBYFo09V7/6YO02FqimRNbVjH1J+Jh6eit+Ox4d
         NojA==
X-Gm-Message-State: AOAM531M7rVFLgmBcu7Nqbd8eHplNdF3/p5BJbu60pSKjC8tnvdRJb7x
        0HJwvXHHpkJhcFHGUeykax+b4xRzBqxo5w7sOzw=
X-Google-Smtp-Source: ABdhPJzia03cqQ5DmIa+f/pkiNcI21/HHtv9fYmkqMg3vUiwrZJ5UG40kE8IsRbqT12HR037c/YDpbirs9nazNzj8NE=
X-Received: by 2002:a05:6638:2257:: with SMTP id m23mr45136036jas.17.1638825051087;
 Mon, 06 Dec 2021 13:10:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
 <YaoQM7xWVKISa5Yb@elver.google.com>
In-Reply-To: <YaoQM7xWVKISa5Yb@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:10:40 +0100
Message-ID: <CA+fCnZcv+cAhNY4N5z+=5Pa9sbTXtr4fMU_23OA_-T4nsYqvjQ@mail.gmail.com>
Subject: Re: [PATCH 29/31] kasan, arm64: allow KASAN_VMALLOC with HW_TAGS
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

On Fri, Dec 3, 2021 at 1:40 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > vmalloc tagging support for HW_TAGS KASAN is now complete.
> >
> > Allow enabling CONFIG_KASAN_VMALLOC.
> >
> > Also adjust CONFIG_KASAN_VMALLOC description:
> >
> > - Mention HW_TAGS support.
> > - Remove unneeded internal details: they have no place in Kconfig
> >   description and are already explained in the documentation.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/Kconfig |  3 +--
> >  lib/Kconfig.kasan  | 20 ++++++++++----------
>
> Like in the SW_TAGS case, consider moving the lib/Kconfig.kasan change
> to the final "kasan, vmalloc: add vmalloc support to HW_TAGS" and only
> leave the arm64 in its own patch.

Will do in v2. Thanks!
