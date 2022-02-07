Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985804AB64E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiBGIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbiBGIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:05:51 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE6C043184
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:05:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g8so1776510pfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NM//vzHJXC7wtiEIkUqyxs4RVdOqre3GtFkBni2nGNg=;
        b=CPAAqs2kh2QC3R8xpXymC9JpYNqnh64DBF1Oczs5drnfgjlEg7Jf/9EvkIQDaHixT0
         Yv/BAZcMDsmdSn8BPpCEIHbbZrfYTqZAt4accszm9vVphvX9rK/DQUWWKnnpvYajf3dJ
         F6iFHUeet7eo6lj7Z75iQRaz4Edds8fgTzfjwrU7KZkp4Y39H3RAWAHK/2+ae7ce1Lru
         LPmUvbHwLN8pv3qx6/gY9FF1CJhpvcMvVAaKoc9+mgdHQ8EFzlib9BrEgimYxzxY6riA
         GZw8jpquYGrcobBW14OphRRGUMaA4lOUrnfNaOtH7dFZRUu6czfKNEPMgblPNRAVAu+u
         k+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NM//vzHJXC7wtiEIkUqyxs4RVdOqre3GtFkBni2nGNg=;
        b=TINphuZXr0TcrB+Omaz1edCUs+b6GtJLD9p9UbYWaGeowL6At0yr5/xzrJmOP51Nce
         kAevBkt9vXOmDRS/2g45fKytMbpt/OeTKDBXGAu2c0MqChyXtQqZyZ/9j1fgB7D8cIib
         pJtv7Ndiel+WpOo4w8DKpJm8AD15emTcnT4txr3DMqmzQJl4z6pWx6lSFmPQUNBQfKY2
         v2HJ9gdRUYFNU7KRidJK4iueC1CivSWl7IGwCcEuk90CKHhefpUsd8zu6XAW/vxWigRh
         Mx2yNFvXnbyoj1Do/mg1Ejw+tAeuM8XYqGFAAf1FG8XDJgq/j7L4G6VXQ2yn+GXamfOK
         HWvA==
X-Gm-Message-State: AOAM531LnaDewI1GZS3ruf6wBWygZH5KvGVcL5yVGv+YCbkACT4lzmFb
        ve3iaHqYXK/RpfosHWwcY7bCJAoa3VFxtYjELk8=
X-Google-Smtp-Source: ABdhPJyr4F7x3v0nRm2LnGvfdUjEsSwLIM6AzecdGCMtE37ynvDeR5GSB5npooK6FQ/pSm4NqbbnCJj7CH/jBncOkMo=
X-Received: by 2002:a63:141f:: with SMTP id u31mr8677881pgl.614.1644221150056;
 Mon, 07 Feb 2022 00:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20220206174359.2986-1-jszhang@kernel.org>
In-Reply-To: <20220206174359.2986-1-jszhang@kernel.org>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 7 Feb 2022 10:05:14 +0200
Message-ID: <CAEn-LTrZwq1-6F8PWScGPp1TRk1eaB-7qOrvPjyLhK=OzDTQBQ@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
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

On Sun, Feb 6, 2022 at 7:53 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> After irq stack is supported, it's possible to use small THREAD_SIZE.
> In fact, I tested this patch on a Lichee RV board, looks good so far.

We went from 8K to 16K somewhere in mid-2020 on riscv64 because we
were seeing some random crashes in various distributions (Debian,
Fedora, OpenSUSE). Thus we matched what other popular arches do, i.e.
16K.

Thus I would be very careful going back to 8K.

david

>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/thread_info.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 67387a8bcb34..fdbf3890a1ab 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -12,11 +12,7 @@
>  #include <linux/const.h>
>
>  /* thread information allocation */
> -#ifdef CONFIG_64BIT
> -#define THREAD_SIZE_ORDER      (2)
> -#else
>  #define THREAD_SIZE_ORDER      (1)
> -#endif
>  #define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
>
>  #define IRQ_STACK_SIZE         THREAD_SIZE
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
