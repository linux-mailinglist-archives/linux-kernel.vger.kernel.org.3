Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150E449CF08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiAZP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiAZP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:56:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:56:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k17so6209plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1geGSu+egCHyXH+GEeh4Fh8FJrnDZ8GAZN4GNe7VFSE=;
        b=fhy0nMADqT0kgtbLAN3m/Y3M7C3QNtDy9otwevxfHRrcoGKtoVTvAaxbuQwrIc759i
         pyd3tnChhZTRwxCN3i7QbBi3Qa+MyWf/seYQSt8x4nMI/l/4d0ILRcgMbo1sdjtZbAzJ
         4SG1yVRjIPn7CSYtzz5C20Jj25pBxi/bEes66knLT7EQRx40hkItLm7Zpgg2bqOGy+zw
         hkkv5IZl8/I15PmZx8DBjV91wcES79CR5/wNc/+y+CyCRWFy+tpE0Yp04CsWyYKYvvso
         yhjBzvzRdCUw1zqdd2ERTZ2SdybPh1Zvq86K07O8r52qncTUzSxbqyxqVhKDx/kMcJRR
         fz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1geGSu+egCHyXH+GEeh4Fh8FJrnDZ8GAZN4GNe7VFSE=;
        b=zUjP7fIhXmSdbc5WZbb3XQQd5h+MLw0yzmZf3k7tuJ1E4LVST+iObX8zBi+KzXGINT
         LNellRc+nMKzu7RbY4kWco8aFb4aMNksrgllxK0FhIKfdoLm01HBkpLlGpCr+nhnGUQZ
         Ur2AUbnksiGOwUDCVW80+P51L9zr8yLbRfALKj2DS2fVNhaC1I8y5wI8LgTBpNLTHwxv
         ITMo66S6O5oFhYjeXvuVorohknUJKi7DRiIzgpR5W+JdDLWsnBc79jULMok3zGDv3TU/
         UXdOza5p1ZZQhbPitQzFPx4Cz+6+tFfC8PviURuigZMi7Fr9RfpHvKvYuFxbVDaV48Im
         VfJg==
X-Gm-Message-State: AOAM530fd9OMPipveCXa40/FrsujiDqOqY1Cd5S5NX0mfFGaqM+sbOQz
        6q4NAck+4pSBsd4ylHwVO6+McjnX/1mJT1Ldeus=
X-Google-Smtp-Source: ABdhPJyUGfQWmNoBUiG8GUU9NfHa+VWhTXiz+FQzCX06V322Z3D9sVI/CKz2T4LLNgnQQd5dEMFIZ+GCLZGWOjlF+7o=
X-Received: by 2002:a17:902:a5c6:b0:149:c926:7c31 with SMTP id
 t6-20020a170902a5c600b00149c9267c31mr24236146plq.141.1643212587832; Wed, 26
 Jan 2022 07:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-28-yury.norov@gmail.com> <Ye6egq/6It3LZs19@smile.fi.intel.com>
In-Reply-To: <Ye6egq/6It3LZs19@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 26 Jan 2022 07:56:16 -0800
Message-ID: <CAAH8bW-i5C==goN8GoVG70Hivobf1F53vj42VCBwWBHZ8iEcdw@mail.gmail.com>
Subject: Re: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt,
 le} functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 4:42 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Jan 23, 2022 at 10:38:58AM -0800, Yury Norov wrote:
> > Many kernel users use bitmap_weight() to compare the result against
> > some number or expression:
> >
> >       if (bitmap_weight(...) > 1)
> >               do_something();
> >
> > It works OK, but may be significantly improved for large bitmaps: if
> > first few words count set bits to a number greater than given, we can
> > stop counting and immediately return.
> >
> > The same idea would work in other direction: if we know that the number
> > of set bits that we counted so far is small enough, so that it would be
> > smaller than required number even if all bits of the rest of the bitmap
> > are set, we can stop counting earlier.
> >
> > This patch adds new bitmap_weight_cmp() as suggested by Micha=C5=82 Mir=
os=C5=82aw
> > and a family of eq, gt, ge, lt and le wrappers to allow this optimizati=
on.
>
> lt, and le
>
> > The following patches apply new functions where appropriate.
>
> What I missed in the above message is the rough statistics like some of t=
hem
> are used more often, some less, and some, perhaps, just added for the sak=
e of
> symmetry (the latter is what would be important to see if there are APIs =
which
> have no users at all).

These are my grep numbers. Some lines are declarations and comments, so min=
us
6 or 8 for each number, but all new functions have actual users.

$ git grep weight_eq|wc -l
35
$ git grep weight_gt|wc -l
20
$ git grep weight_ge|wc -l
25
$ git grep weight_lt|wc -l
14
$ git grep weight_le|wc -l
18
