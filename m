Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98979481FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhL3TTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbhL3TTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:19:13 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD110C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:19:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s6so21679717ioj.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUj31a0vWo3+lEkWZ+Adl6dlbYeVbADGrJgYxEnUpUg=;
        b=mbg/EqmGC4aKsDVdK+LUwUmyuc8RJbrhQq7fn5O/VePmeXQxMEt4E2QMXeAsvIwjq3
         qF6t+DKdExmjPyMrouBwqZOQJqa5b1kbDFye72VO+jcsL3RNqd+sKUNJ7UJEL0fu787s
         +d2d0EVglT//LUZQ2sGy3DVYIkNtImWqumqekWT2ydDz47FaV294nvXPm9lE2ue1/QdE
         JOw9/fi6sR+vXltb8tWq+ZNMsjmUOafqJ7QOizA/1xWtpjRhkAfCwzcTCOWRuIWkYaUY
         Lfsn848MsXSY9UrLAR/WZRj5s9qEy5URi5cpQJbmPfF7s0PJyW+wrpzS6S/P0KaUlLx+
         TakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUj31a0vWo3+lEkWZ+Adl6dlbYeVbADGrJgYxEnUpUg=;
        b=FJszSIfMjom4W0df+wz2PQ+7Q/DdwvzJ/V3JIJoU/YV2xxXmZqt6x/QqzcKEvXSdrv
         qkULU6uvCw2SqsuvK1UO2UVrYTnm3+1z1riBzS71coV4y/R3Uo3L6npO3fEcSfCDV874
         Rl8KGYJTUZMW+7BIcpyHLUnlfh0iWdddvlAJQudZXqnPEKJncYfeOtUm+S7ugTk/KyJ6
         A7IIwOqjFlnbVyhrRVGPZ6aZBBD8Kb/2pkGd/DklumFvsIJtXZdJI5XDElRUzv8eg/Va
         jCJOwX2u1IvrRYUQM8/C6wEGVvXfsuq3RZQOLrsDV507ucUcH28HeqK0ONfxXuBKSOFI
         Z5ug==
X-Gm-Message-State: AOAM532KOnZuqzDpF25DXnfZBYWLiFt6ioQB9I/ZoCcSGtSXtgOMWXqx
        mFCdFr4ysneathywt89aENDvq7yda5qvIZGXGD7mHLHb
X-Google-Smtp-Source: ABdhPJxihgVqz3Jf8c6xjbs24o35Y/OGcfau8t919A9kb5IZPmf4DcDe2qcv+0r86e2Yaeo/TW3QxXTqc5chjXCQn1Y=
X-Received: by 2002:a05:6638:2404:: with SMTP id z4mr9960690jat.9.1640891952203;
 Thu, 30 Dec 2021 11:19:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640891329.git.andreyknvl@google.com>
In-Reply-To: <cover.1640891329.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:19:01 +0100
Message-ID: <CA+fCnZd+sBzecOGBD8zR3CxXS1yjV-X3-epAb6N=ZT8rJdCU6A@mail.gmail.com>
Subject: Re: [PATCH mm v5 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
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
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 8:12 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Hi,
>
> This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
> KASAN modes.
>
> The tree with patches is available here:
>
> https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v5-akpm
>
> About half of patches are cleanups I went for along the way. None of
> them seem to be important enough to go through stable, so I decided
> not to split them out into separate patches/series.
>
> The patchset is partially based on an early version of the HW_TAGS
> patchset by Vincenzo that had vmalloc support. Thus, I added a
> Co-developed-by tag into a few patches.
>
> SW_TAGS vmalloc tagging support is straightforward. It reuses all of
> the generic KASAN machinery, but uses shadow memory to store tags
> instead of magic values. Naturally, vmalloc tagging requires adding
> a few kasan_reset_tag() annotations to the vmalloc code.
>
> HW_TAGS vmalloc tagging support stands out. HW_TAGS KASAN is based on
> Arm MTE, which can only assigns tags to physical memory. As a result,
> HW_TAGS KASAN only tags vmalloc() allocations, which are backed by
> page_alloc memory. It ignores vmap() and others.
>
> Thanks!

Hi Andrew,

Could you PTAL and consider taking this into mm?

Thanks!
