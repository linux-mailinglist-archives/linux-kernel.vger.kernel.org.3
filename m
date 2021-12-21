Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF547BCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhLUJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhLUJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:23:40 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:23:39 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id m186so11960207qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xzwisqb1Sy2od8aWgP/bz4IaYgTJ8bQBQSdhNAj9vNM=;
        b=VyLPgc+N3ejMZB5IuZpuMhrPHt40i6UgHuVzvVUlYzns/vLh7SllYTfzOm95Ydu08d
         bx7Ijb4zr3t69OAIEg9m0V6YlE33teplPktDpkPw0gG63SHbfd16CU+wVWw+Oef1tcku
         P/vcm1/Ru/jSA5g0tcErfFLo7NpZdN66pUoNO53kYQf3CiY4BMfHPfNhbFjVvTFOKqWp
         iaGgdXRexxwOQKTIM3+EhOj9fgBa4giaI8mSMwEdsb5MTMgEUJDkb8OulUL+3ClUD/Ub
         AZVUBHrqVyBimX6Rl6yaNdzGUI1dm7GgJgbXeDKaxqHBSAY0bTYqzWr9wU6738yOmXy5
         IWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xzwisqb1Sy2od8aWgP/bz4IaYgTJ8bQBQSdhNAj9vNM=;
        b=RI6XN4VweUkMwjxF3XQ+FyOAdyyUt5rYVnZMoeGVkpvnSoNgvXxgRMxdoXfhEcIpC8
         IePNudxWX2cGT+NVtLw7UXXkS2PB+qx4Krjxu4dUN5O/TH3YJrBWxnPaI6oP9n5P3LeU
         l+7TKAkN9X7UszwVMnCtxkXyk1ElsDQJy2Nu9Q4w1mw6fwTK272NhoA7Mxk2KBop8W1N
         9QiivtdArpY1wHn4rZJmPETUMXsQiAMrcpr2FRz/hJOhNwYE59pb+bEokyUPvgQHNgad
         ixLWVnlhBcRQTOxg5JQv4TKLUBaLdciL8zAxlmLpnia+RrRV3TslU7KCXL2R28H7GSY6
         BmbQ==
X-Gm-Message-State: AOAM532FAVqPQs4sN6Ry+xS6Qw7G3kYjWcDthSWKdjs50HXqJRjYTsvH
        vYtj3fjdAfKD11wW2B4H9C69AzPohCFVVTALUgcx8w==
X-Google-Smtp-Source: ABdhPJwUQwtUA7ETB7iiXK+EgRxi4jixcxQLCwfTNYX/jDe2+vsavoXHf7aXOqIotNdigbbLBx3ZmfbySHD7LauTBvM=
X-Received: by 2002:a05:620a:2848:: with SMTP id h8mr1353598qkp.610.1640078618621;
 Tue, 21 Dec 2021 01:23:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <b929882627e19a4a2d02c13788bd2d343f3e5573.1640036051.git.andreyknvl@google.com>
In-Reply-To: <b929882627e19a4a2d02c13788bd2d343f3e5573.1640036051.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Dec 2021 10:23:02 +0100
Message-ID: <CAG_fn=W_6j08zxpgWeCX_uxN+Jqi93XYtQ_GY-Gjs_Ru2Hb2aQ@mail.gmail.com>
Subject: Re: [PATCH mm v4 16/39] kasan: define KASAN_VMALLOC_INVALID for SW_TAGS
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
> In preparation for adding vmalloc support to SW_TAGS KASAN,
> provide a KASAN_VMALLOC_INVALID definition for it.
>
> HW_TAGS KASAN won't be using this value, as it falls back onto
> page_alloc for poisoning freed vmalloc() memory.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
