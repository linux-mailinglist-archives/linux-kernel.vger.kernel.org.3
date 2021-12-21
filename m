Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8635947C161
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhLUOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhLUOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:22:21 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:22:20 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f9so942470qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqzH7iHpoKe60vr6KOoVUYsNEptHbcvizk4re1JPTdE=;
        b=jV5Jbe2GBFu8oyTJx4ZHnaWzgAyun7fl4S4epfttsEyTUBciPs7eWLbG2e7hQdUySS
         WS1cor/eUzz2QFRvS1Wg0WRwtO9prjpnCHaxVp1Zl1WKJuQ2brvLR8en+Vl1LvgS4rFm
         9Bd+gSTB7+f6lV3S2Rm7pNYUQWRh1SewpNSMg4mMe0ednhWiJoYz5bjl8SQ2kisQHVaK
         ulcBGFD0P/jWcJhofcOWqMQ5RemmhcIWIhziLlQvNdHalbzwEf36wOZBS4hUb5JMxG0X
         ltJKuk2SPw+WQOjgm8nL2mFqMrtF9yg+nT1sfe4ZsOZVnSI+IP9cJbWj5wKB7axGzf1L
         ZBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqzH7iHpoKe60vr6KOoVUYsNEptHbcvizk4re1JPTdE=;
        b=rarJedAef+qJ9/rSSx2vROi5mX/IVTAFnuZgSkFkprXrGi5YTeEuve1HGKwBwVu9ZN
         J47I3DBYm8vf5fV1oR/WRm7yVowVt5VZXDFNX/mDVL4pbnYw192yjPRgZjWDNWZiyZWq
         znAWn1SoXFo7fXI0gCpcbhA8+1w8Q8q8+a4f1sgcdXhsnSfC8ceB2LXdY10JijXvh3wT
         HKIEfQ+7xwrgJiYJIQ04Uky1rdSb30NvlRPaKdbiPlY7G+N++Ky7WH4OYu1elOU9Er7Y
         2toSmiuPvzCGwS5okEKgC1/1tsw5fXxMUJHTDQLsRQOHEjGZ0kxc+pv5EiHAsGhgW/g/
         wPKw==
X-Gm-Message-State: AOAM531Zw/rWEkGNhYWXfSW5LiDI8UeFidfY+FGzUJgfttzWTwfB1rKN
        jQ0oodPWqG2lVmUawT55H2D/Mfr9KzCz0xDM6W0ZNA==
X-Google-Smtp-Source: ABdhPJyIRj+X7Pfcx9pnvQ/OB+zKcWDtxTmLwHZ8fuFXxhN0JmK16o+uPCMMP0szgBHw1ZAC0Sip5mirgZQ/gQ8PaEg=
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr2375326qtk.492.1640096539840;
 Tue, 21 Dec 2021 06:22:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <f69174e2f6196fb502afa5785612e3a30e6a71c7.1640036051.git.andreyknvl@google.com>
In-Reply-To: <f69174e2f6196fb502afa5785612e3a30e6a71c7.1640036051.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Dec 2021 15:21:43 +0100
Message-ID: <CAG_fn=WUEDxwSRP5U+3ybXLfWUtHDb66_GVabNWrxKLSD3sZ7w@mail.gmail.com>
Subject: Re: [PATCH mm v4 20/39] kasan: add wrappers for vmalloc hooks
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
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

On Mon, Dec 20, 2021 at 11:00 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Add wrappers around functions that [un]poison memory for vmalloc
> allocations. These functions will be used by HW_TAGS KASAN and
> therefore need to be disabled when kasan=off command line argument
> is provided.
>
> This patch does no functional changes for software KASAN modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
