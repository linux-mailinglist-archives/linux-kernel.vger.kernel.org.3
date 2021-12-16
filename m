Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435EC476F60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhLPLAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhLPLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:00:38 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6AEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:00:38 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t6so22954997qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9LMQS5ekai6MAbxEJCeesPT3tP3d4FnUmO5zDtlQSo=;
        b=aiqQ046+OnlAW4ysF+RdzMUEp3WkMkLWXxWTxIBk9GSU+32J0Jvlt47rUi8dfPFJKs
         /0YWdyrwjFD0TB6SdSEhojovhlhOClM5De9xzeCBE5KMuraK8GSm6DO2Lv13aCCAb/IH
         Rg2AbeCUl+GrwkGHHfbJ7DYOSK6f82A5Ziurd+X349+t1RlKI1YpE57u45KcUBiluTYy
         pKz8CTDGlsTRf35jixhkYIEam/wDY7WuTXYhI3x2cx2z4z0OFD3S6S+Ab0zcx41pZalt
         eVaSIebuVbFzbSH74Z9tcXQXgIk+J/EyW73pp9PnCMi0GstL24Ktrsp97iHWo99Owmbz
         26KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9LMQS5ekai6MAbxEJCeesPT3tP3d4FnUmO5zDtlQSo=;
        b=r0hHu7vSCaWH0vctoLqXbr9aMRKi5imH3jEUPbJInukJkMPLogeP4YE1R8i0IXqHAD
         yf2DNcEhqEBxREsN1Y6Yai82zHgyWVsileM/+PQ8DcHmd4HCR6xrnAKyPrzECSpQGeRW
         N/80wq2DIk15+iHBCAbjJceJVlU4rZuLqX8Pdi/sCmyA86Su3wig6ywup/dqzIvrY7i7
         YrZ95sgxEZusFDfMl66KIzY7J43/ODueawxw4MDerIhdW0TKETBDL+fnzj8yG1uOmGk3
         ldz72CLSujjAd9+867xsKPmWVWr2YSHhcWNcc1HT965FG8CS8bUiVgpi16KTcXqpcdra
         nvMw==
X-Gm-Message-State: AOAM5325bbBDgOOzvyHPrCAwOxopZTub0aCm2WXgQTFSBNFqutZN6CIQ
        9WNaatEiU0JmFQETQ7prWECg2y9Za6EJiiFCzLLJ7w==
X-Google-Smtp-Source: ABdhPJxYkKm4B0r+pxgh6vtlXgZnaHPQOlaqXfRolBKnofS789WhIRiIVZdN8a1NYRkKJ0rCpuKlVRMdgw2Nn3kjpqc=
X-Received: by 2002:a05:620a:2955:: with SMTP id n21mr11520118qkp.581.1639652437249;
 Thu, 16 Dec 2021 03:00:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <6f430d8dd55a22e141b0000357890d872b8cd487.1639432170.git.andreyknvl@google.com>
In-Reply-To: <6f430d8dd55a22e141b0000357890d872b8cd487.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 12:00:00 +0100
Message-ID: <CAG_fn=VXu-XVd8LMqU5g-rOup=8iPWuuL8Z4MtYjGQwbNwHHTg@mail.gmail.com>
Subject: Re: [PATCH mm v3 13/38] kasan, page_alloc: move kernel_init_free_pages
 in post_alloc_hook
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:53 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Pull the kernel_init_free_pages() call in post_alloc_hook() out of the
> big if clause for better code readability. This also allows for more
> simplifications in the following patch.
>
> This patch does no functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
