Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD55F544C07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbiFIMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiFIMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:31:34 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573F22F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:31:32 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id c83so5133267qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WNNhQK6JE2Cn/3pAieE4V2HComQZrsks/B6n612PiU=;
        b=a7t5REScGn8rczrH3NdB4766wQQn+Q/c5cZ64rkGhv2kTUENpHnIpZX/w/81Ru177z
         YGuqU/ozILaqkcX3iqRN7Cd0ftYR6m0/ca30iiR7UO+/ThbBFR7ZBa1WlQM+t+42gK+z
         ODmUDQVZf1DS02u9p2tO+cHclXbkcB8xZC6cA/J4BfVXPeaZD1QNtBaZbAnf2jzrsTd/
         k4K0+IBh6MXiRc4H9CrMUzJWDokpzRcRp3Cc0d8Sbz3sSJ4DZ8X4yICq9tNPEHvh4TUK
         Lq+SyXdChfGTiyn+khKuaCtJhheO24s1ZuuCTailIZuVHO4OEZbtoBIIF+450uw+LQiu
         cpfg==
X-Gm-Message-State: AOAM533LltWdDDrSqwahXFabERSpi+RE06jDU6cZRRBhNvSbdxMxSDeA
        22wSe0AcJPRu9aebfZRoQP2ZYXXS6LHr6g==
X-Google-Smtp-Source: ABdhPJxMIlK5ymr5ifVZxKBZhSzm3C+zODRKVSU7XDehZp1zm7BILi/Jv13hB/MXeXVjfC0v73VgIA==
X-Received: by 2002:a37:a605:0:b0:6a6:7c24:5c80 with SMTP id p5-20020a37a605000000b006a67c245c80mr24895796qke.448.1654777891097;
        Thu, 09 Jun 2022 05:31:31 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id j19-20020a05620a289300b006a6ab259261sm13524759qkp.29.2022.06.09.05.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 05:31:30 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-30c2f288f13so239211757b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:31:30 -0700 (PDT)
X-Received: by 2002:a81:6157:0:b0:30c:7e4d:b28e with SMTP id
 v84-20020a816157000000b0030c7e4db28emr42497205ywb.502.1654777889942; Thu, 09
 Jun 2022 05:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220609121709.12939-1-Jason@zx2c4.com>
In-Reply-To: <20220609121709.12939-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 14:31:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXocvPDViVHjEfeWGxA+7SwOrD3pP7v8wFM80Us3xSU4Q@mail.gmail.com>
Message-ID: <CAMuHMdXocvPDViVHjEfeWGxA+7SwOrD3pP7v8wFM80Us3xSU4Q@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: select random number before taking raw lock
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
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

Hi Jason,

On Thu, Jun 9, 2022 at 2:17 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The RNG uses vanilla spinlocks, not raw spinlocks, so kfence should pick
> its random numbers before taking its raw spinlocks. This also has the
> nice effect of doing less work inside the lock. It should fix a splat
> that Geert saw with CONFIG_PROVE_RAW_LOCK_NESTING:
>
>      dump_backtrace.part.0+0x98/0xc0
>      show_stack+0x14/0x28
>      dump_stack_lvl+0xac/0xec
>      dump_stack+0x14/0x2c
>      __lock_acquire+0x388/0x10a0
>      lock_acquire+0x190/0x2c0
>      _raw_spin_lock_irqsave+0x6c/0x94
>      crng_make_state+0x148/0x1e4
>      _get_random_bytes.part.0+0x4c/0xe8
>      get_random_u32+0x4c/0x140
>      __kfence_alloc+0x460/0x5c4
>      kmem_cache_alloc_trace+0x194/0x1dc
>      __kthread_create_on_node+0x5c/0x1a8
>      kthread_create_on_node+0x58/0x7c
>      printk_start_kthread.part.0+0x34/0xa8
>      printk_activate_kthreads+0x4c/0x54
>      do_one_initcall+0xec/0x278
>      kernel_init_freeable+0x11c/0x214
>      kernel_init+0x24/0x124
>      ret_from_fork+0x10/0x20
>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thank you, the splat is gone.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
