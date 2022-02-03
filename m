Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCF4A8027
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbiBCINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:13:47 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:39475 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbiBCINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:13:43 -0500
Received: by mail-vk1-f169.google.com with SMTP id n14so1201385vkk.6;
        Thu, 03 Feb 2022 00:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9uBxzW1iQTkHJWmlNd6eDgXf7Vcz0FCfwe1uYSA3ng=;
        b=gNDTGZRU1+tLRkopVxR7UmWRP41JCnixcbuTxuTHbQm6qyzK2bTlRvFzPFZd4iziQK
         q2UnSdEeN7PNoCnSFiQZwpjT9y1dtHM+ZijQCYPBj86Iz8Nf7wXDG2Z41O0u5XV80Je1
         Pjy0MSYNfP2+uU+CUiM6iOgKCCsZefEWj87YUpeslhFus2oHHuacGzrLLhuZkLZr2V6E
         NUdJfPOP9kkFCx4Ky+swgENGEweL5dvCDKxVaMn6DoHxakJwusd2vOHmg89mzSAOzrOY
         6bNae3yVjskCRNFgECT0olzaXXLCWPHM4GCC9MhYwKN187pRSMAvH1mUoBxJKyTeA7uQ
         yHtA==
X-Gm-Message-State: AOAM531ZJ8/byTIvx+BKz9ENB55vcH6ymTmY1s5V+07DxOK7bSyLM4y1
        N1WpXZIvpkH599y/6OjOHUd7GAQ2bPfXmw==
X-Google-Smtp-Source: ABdhPJznwH3Egm/ej3cjnkX/xVze9JlrbhrTnX2EY3hkqZ8vvDuuyokMG+wRj2qaSLcmCyYspO0/Ug==
X-Received: by 2002:a05:6122:220d:: with SMTP id bb13mr14009897vkb.33.1643876022722;
        Thu, 03 Feb 2022 00:13:42 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id j37sm6817703vka.45.2022.02.03.00.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 00:13:42 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a24so3718165uat.10;
        Thu, 03 Feb 2022 00:13:42 -0800 (PST)
X-Received: by 2002:a9f:2c0a:: with SMTP id r10mr13728057uaj.89.1643876022094;
 Thu, 03 Feb 2022 00:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20220202225327.1544295-1-keescook@chromium.org>
In-Reply-To: <20220202225327.1544295-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 09:13:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRrD+2zKoHxAaQdDuiK5JFDanbv0SJ91OdWfx+eyekPQ@mail.gmail.com>
Message-ID: <CAMuHMdVRrD+2zKoHxAaQdDuiK5JFDanbv0SJ91OdWfx+eyekPQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: cmpxchg: Dereference matching size
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, Feb 2, 2022 at 11:53 PM Kees Cook <keescook@chromium.org> wrote:
> Similar to the recent arm64 fix[1], avoid overly wide casts in the cmpxchg
> implementation. Avoid this warning under -Warray-bounds with GCC 11:
>
> net/sched/cls_tcindex.c: In function 'tcindex_set_parms':
> ./arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct tcf_result[1]' [-Warray-bounds]
>    64 |                 __asm__ __volatile__
>       |                 ^~~~~~~
> net/sched/cls_tcindex.c:338:27: note: while referencing 'cr'
>   338 |         struct tcf_result cr = {};
>       |                           ^~
>
> No binary output differences are seen from this change.
>
> [1] commit 3364c6ce23c6 ("arm64: atomics: lse: Dereference matching size")
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do you want me to queue this in the m68k for-v5.18 branch, or do
you want to take it yourself, together with commit a8712a32665f9b1a
("Makefile: Enable -Warray-bounds") in linux-next that triggers this?
In case of the latter:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Please let me know. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
