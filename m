Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14B489B30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiAJOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:21:53 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:44784 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiAJOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:21:52 -0500
Received: by mail-vk1-f175.google.com with SMTP id b77so8193165vka.11;
        Mon, 10 Jan 2022 06:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKBRWv0ZtQW0j4K4yY6WOWacYW+WViNADP4qa506v6E=;
        b=7UsacSWyVIdHt1TFcXaWZZled7iNSbz8JbVR4SEIpvvseilFt3dkA9x1/NoXNDvfTa
         KxPXoPmfImV1KmkNogx+56BDDNjAw28JIhk2y1Jz05LMXMoK83TmQ/3qrQHhO2Z4Q5I0
         Xz6BsF9JYQMQY0wSP98oDUqeaiyTlzFCXgshy04ORPxYCVUGOQlQZuU4uDMgGCubi2Vu
         w/D+PrrVg0fYRsx9qEvUTzfcSgx/7MZ7b2TYKiGQv9DZuUoC3bV9ueNKsLP+7wpC0Vyn
         pwNJE5v+eU0qfmhD1cZvJ2fIL7PAz6AXIi3IfUwxeB0ddUI8YtM8m4grVj5ts+Omc+hS
         JDOw==
X-Gm-Message-State: AOAM532Q0+ZPzfmMerWeOl1zqb9nMg7nrnCoz0srBEMVskumWpG+TeQL
        4CIaR/tQqKEc6IG1fSneEmyyf0jfC8uYCw==
X-Google-Smtp-Source: ABdhPJz2h1LsRjBdLs/6DYsdmW81rBdEI8Cwb5lms0AHxMdTFpg+d7I1STm3fHYpAZ2OM78T7L3lcg==
X-Received: by 2002:a05:6122:99e:: with SMTP id g30mr28279649vkd.23.1641824511255;
        Mon, 10 Jan 2022 06:21:51 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id x190sm3774404vkf.56.2022.01.10.06.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 06:21:51 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id n124so3582754vke.6;
        Mon, 10 Jan 2022 06:21:50 -0800 (PST)
X-Received: by 2002:a1f:5702:: with SMTP id l2mr470497vkb.33.1641824510503;
 Mon, 10 Jan 2022 06:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20220110084239.1597511-1-laurent@vivier.eu> <20220110084239.1597511-2-laurent@vivier.eu>
In-Reply-To: <20220110084239.1597511-2-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 15:21:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtEZ3WqFw0ihSAAcTP76TdR+jtqjkX+=UwOi+=04xOWQ@mail.gmail.com>
Message-ID: <CAMuHMdWtEZ3WqFw0ihSAAcTP76TdR+jtqjkX+=UwOi+=04xOWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] m68k: add asm/config.h
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Jan 10, 2022 at 9:42 AM Laurent Vivier <laurent@vivier.eu> wrote:
> To avoid 'warning: no previous prototype for' error, declare all
> the parse_bootinfo and config functions prototypes into asm/config.h
> and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/m68k/include/asm/config.h
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0

scripts/checkpatch.pl says this is the wrong one.

> +
> +/*
> + * This file contains prototypes provided by each m68k machine
> + * to parse bootinfo datastructure and to configure the machine

data structures

> + */
> +
> +#ifndef _M68K_CONFIG_H
> +#define _M68K_CONFIG_H
> +
> +extern int amiga_parse_bootinfo(const struct bi_record *);
> +extern int atari_parse_bootinfo(const struct bi_record *);
> +extern int mac_parse_bootinfo(const struct bi_record *);
> +extern int q40_parse_bootinfo(const struct bi_record *);
> +extern int bvme6000_parse_bootinfo(const struct bi_record *);
> +extern int mvme16x_parse_bootinfo(const struct bi_record *);
> +extern int mvme147_parse_bootinfo(const struct bi_record *);
> +extern int hp300_parse_bootinfo(const struct bi_record *);
> +extern int apollo_parse_bootinfo(const struct bi_record *);

Missing parameter names.

I can fix those while applying.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.18 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
