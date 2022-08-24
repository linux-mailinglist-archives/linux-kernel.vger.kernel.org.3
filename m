Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C859F5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiHXJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiHXJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:01:20 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281347435C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:01:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r6so3170996qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HhxCZvae4Tf9kz9NcsjXMEcY8sfHg3Ouyy3SX130F2Y=;
        b=NljGLElc99FfmYIVG0KKvVV2zUnquTWsHwvb1zZGVomY/peegybQGRT/Tqtu9Y1yrD
         GDknq/k9ni53Ny4kmKdmKkwr8km9PXVmfJhPTCrD4Kjl9RWOZDkx/lhfvct5S2e6ra4l
         P+RMO+QPGtfpUDhtoaE8V3tL1dvax3jBu0nWcElCUP2ck/ZL9uqiiXedLWv5rT1dTtnf
         GzZ/YUfG56KhcqCwIxF4L3dgwfIdLwF2e8EM4i+5osbvFqS7TBOaixINkBtxuK3Ci7xk
         93xA74g5+UfPT/8SjsQrZcmOpxwfuU+DUyzeX2W4XWs7taqKEd8cPqHa9jfRqlmpmf9x
         i2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HhxCZvae4Tf9kz9NcsjXMEcY8sfHg3Ouyy3SX130F2Y=;
        b=clEC5hwpFapWVQSKHwyePpQDtwd8IievEXHYqqK6QQLCM3I6Y67LbPUsrOxyioplTr
         f643oj//iTHxn6Vb7bWNQkNKH3pscMmqFFgyNbhVPqFgTxec5tOox6W9g1q7o9SJ21qz
         QZrXG/harQNKHf5vdmfLKABif/2sx0YkfgPoFdXBEiew+Y6n2n7AN4esmcChCzgktHSz
         6WKxPMk/XWx8LsjlIZu5qwyrLKrAQllvOnE7t5QfZFTV2ICcwpqNHlFH0w/C/OioDvCT
         8piD9UUcYILC/rP58hq0hXHYMpOpCk0kYFPCvV+laOHsKuXagttmwPlg46HOr4fLYqoW
         AIRg==
X-Gm-Message-State: ACgBeo0LTaBF+sjfPW73RK+JkQmX0XA4BsaTvd9GRak4lV3msN3bb8fl
        Q1ENF3Jm9vQGWOHuXWVGQqgHnQ/nZCHbLVPORlc=
X-Google-Smtp-Source: AA6agR7LZmjCNCLMXXWlp2k23GexHuVg/Vd+1zc8jeLzHuHcI8ZFAnYSBm6IicpyHUKA93sCXq9O5J9AxItSMB1Pgxs=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr21568523qtx.61.1661331677075; Wed, 24
 Aug 2022 02:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com>
In-Reply-To: <20220824012624.2826445-1-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 12:00:41 +0300
Message-ID: <CAHp75VddCDWo3pkX9oJUUYqndmZbKm5eB_3HU7ytsjjwFnsnRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] lib: optimize find_bit() functions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 4:39 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> v1: https://lore.kernel.org/all/20220728161208.865420-2-yury.norov@gmail.com/T/
>
> Yury Norov (3):
>   lib/find_bit: introduce FIND_FIRST_BIT() macro
>   lib/find_bit: create find_first_zero_bit_le()
>   lib/find_bit: optimize find_next_bit() functions
>
>  MAINTAINERS          |   2 +
>  include/linux/find.h |  46 +++++++++++++------
>  lib/Makefile         |   1 +
>  lib/find_bit.c       | 104 ++++++++++++-------------------------------
>  lib/find_bit.h       |  45 +++++++++++++++++++
>  lib/find_bit_be.c    |  42 +++++++++++++++++
>  6 files changed, 152 insertions(+), 88 deletions(-)
>  create mode 100644 lib/find_bit.h
>  create mode 100644 lib/find_bit_be.c
>
> --
> 2.34.1

Seems like the cover letter is generated by Git, but it has 0/4 in the
Subject while the rest of the series is n/3. What happened on your
side with the numbering of the patches?


--
With Best Regards,
Andy Shevchenko
