Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACF44AF66B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiBIQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiBIQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:19:31 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952DC050CC5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:19:24 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id d27so1463613vkn.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bnya6VmSL6leRIRse/uCEksReFzWugbjTC+ac8YkiUs=;
        b=6U3OmFhKPy0DV7IA0CXx6dmQrv7Pdg1eAfqTXYPZD3matBPQdxcSAB9/XNMDRxviEM
         vWUR+ErcY8/pAKZPgEbqbXp5VzmswIhsn5z1911BJjtGyUPOxWNuwh6e/Nb0XzCocmbV
         F/aPZyf1nKWxuc3RtNnYeaPVRt/qSj+aEfZVWTFlgNe6zNfXKPB365vepcpTlRzC7ts4
         J+Bh6zkFjDYxaOwhBbkazu2c0YwXk97Ks8UrYVy6Rk7BhmlttWqyPMP0lavBaAxxMcbY
         AjYEO8rPT5K1u5/Ue5AEWydqLORXfJjM1XOY/CvCSmZesRO4ewh8782DUg4ng863BIvw
         dI5w==
X-Gm-Message-State: AOAM530Nj1oaHlsWdM+CeqIJIJ8aPeEhaX13OsTWPkRpuNiQw5sgDbU6
        EWaBTyxq5FavvMVD3sybm0/NMcuDsHgspA==
X-Google-Smtp-Source: ABdhPJyQk0Kpuiu4XFzYmOCTq+75cpoNxTJyKWBIyydQO1QGLelWpXaWwqcC8UQ8Vz+lOxWC99iSFg==
X-Received: by 2002:a1f:2ac3:: with SMTP id q186mr247809vkq.33.1644423563248;
        Wed, 09 Feb 2022 08:19:23 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id d202sm3389710vkd.38.2022.02.09.08.19.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:19:22 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id t184so3136169vst.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:19:22 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr910748vse.38.1644423562636;
 Wed, 09 Feb 2022 08:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20220209094158.21941-1-sj@kernel.org> <20220209094158.21941-2-sj@kernel.org>
 <715a8b2e-1048-c098-8b89-bcf3c13cbd75@google.com>
In-Reply-To: <715a8b2e-1048-c098-8b89-bcf3c13cbd75@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 17:19:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
Message-ID: <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
Subject: Re: [PATCH for-mm 1/2] mm/internal: Implement no-op
 mlock_page_drain() for !CONFIG_MMU
To:     Hugh Dickins <hughd@google.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Wed, Feb 9, 2022 at 4:38 PM Hugh Dickins <hughd@google.com> wrote:
> The thing is, SeongJae's patch makes me wonder, why did it not need a
> !CONFIG_MMU definition for need_mlock_page_drain() too?  That's because
> mm/swap.c's call to it is under an #ifdef CONFIG_SMP, and I imagine that
> CONFIG_MMU=n usually goes along with (but does not necessarily imply?)
> CONFIG_SMP=n.  It'll be safer to add a need_mlock_page_drain() stub too.

RISC-V K210 is SMP without MMU.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
