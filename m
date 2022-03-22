Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE46A4E47AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiCVUoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiCVUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:44:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE39C75604
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:42:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 5so13621410lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2U9MBMr+1/uM/VxRs4MdeE4RwpAAvsI7P/hOZkh3NDc=;
        b=fCNY/BolP7QFEI2E0i5Od5B6ze3g0v6AZHkuuWB94UFzHknCYmVASkXg7Wz6WggffZ
         BpK/5sPNmAEPzbEW1Cpwu/1yzLvFavPbUVek4kcWFUhsYkm1IKbXTuaX4Qzi0d6kluSP
         Jy1h/b/dTzXEPW2O2PiifN8B5S4BdpypKJPl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2U9MBMr+1/uM/VxRs4MdeE4RwpAAvsI7P/hOZkh3NDc=;
        b=mRfAC+2iMQ1biw4HKEnGeF4oyLiE8XhLBHmxPOdiLLqMxJeIVcRbi8HOMVm9Sr0J5n
         1PxnWQ4dyFc75s2DUUNVEaziIU5BylER3vqUTOJwNwF/5T2oefvbMFBd4pUo1uqytMli
         /DbWWyYPN2R018ZPA0w6rWjcyrZJqovpyyu9O9/4Jxuw1sk/EB9W80gww6CJ+zcJpqid
         C5AbShCytxAMY6ZxO8S9mCw97mj0Q7GZO4nK4hqrwXwVWr4a58jPBfClado3fF++t3iX
         Ny7Bh2Vky+yt4v6aM80OhMSj41j0Wzm8fqAjkG8TERTRng7Sa8mQhvyiwW27u3hEMaz0
         FxEA==
X-Gm-Message-State: AOAM531L+j09o9LTSH4rLoxXkiJz7AjckiYi6N2Y1H3Z/YIn+NkQx9GK
        eKAV3L4vYNffSeJkDf2/hVOIeN3Imy/KENzmXgw=
X-Google-Smtp-Source: ABdhPJwxu9Q7j/G6Tyfe53mtowtYb2VUawNi6dfd27bhjEIGnY9oc6Sc3sqzwxuK2H42IOY+3yt4Yw==
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id f20-20020a056512229400b004486c863c78mr18774243lfu.531.1647981762895;
        Tue, 22 Mar 2022 13:42:42 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e9e97000000b0024921bcf06bsm2562487ljk.57.2022.03.22.13.42.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 13:42:40 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id a26so13799021lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:42:40 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr19150741lfh.687.1647981759939; Tue, 22
 Mar 2022 13:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com>
In-Reply-To: <20220322191436.110963-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 13:42:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSRk_-Nh5gtDKZj_fKya1NKry1Y5jdejfKNPnB+Pr4cw@mail.gmail.com>
Message-ID: <CAHk-=wgSRk_-Nh5gtDKZj_fKya1NKry1Y5jdejfKNPnB+Pr4cw@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> @@ -1507,6 +1507,8 @@ static int write_pool(const char __user *ubuf, size_t count)
>                 }
>                 count -= len;
>                 ubuf += len;
> +               if (unlikely(crng_init == 0 && !will_credit))
> +                       crng_pre_init_inject(block, len, false);
>                 mix_pool_bytes(block, len);
>                 cond_resched();
>         }

Ugh. I hate that whole crng_pre_init_inject() dance.

We already mix the data into the input_pool with that 'mix_pool_bytes()' call.

So what I think the real fix is, is to just make urandom_read() use
the input_pool data directly for initializing the state.

IOW, why isn't the patch along the lines of just making
crng_make_state() take the data from the input pool instead, when
crng_ready() isn't set?

As a broken example patch, something like the appended (except that
doesn't build, because 'input_pool' is declared later)?

So take this purely as a conceptual patch, not a real patch.

(Yeah, I think this also means that code that currently does that

                crng_pre_init_inject(pool, sizeof(pool), true);
                mix_pool_bytes(pool, sizeof(pool));

should do those two operations in the reverse order, so that the input
pool is always updated before that crng_pre_init_inject() dance).

Maybe I'm missing something. But it seems kind of silly to use
base_crng AT ALL before crng_ready(). Why not use the pool we have
that *is* actually updated (that 'input_pool')?

                Linus

@@ -374,19 +374,14 @@ static void crng_make_state(u32
chacha_state[CHACHA_STATE_WORDS],
        /*
         * For the fast path, we check whether we're ready, unlocked first, and
         * then re-check once locked later. In the case where we're really not
-        * ready, we do fast key erasure with the base_crng directly, because
-        * this is what crng_pre_init_inject() mutates during early init.
+        * ready, we do fast key erasure with the input pool directly.
         */
        if (!crng_ready()) {
-               bool ready;
-
-               spin_lock_irqsave(&base_crng.lock, flags);
-               ready = crng_ready();
-               if (!ready)
-                       crng_fast_key_erasure(base_crng.key, chacha_state,
-                                             random_data, random_data_len);
-               spin_unlock_irqrestore(&base_crng.lock, flags);
-               if (!ready)
+               spin_lock_irqsave(&input_pool.lock, flags);
+               crng_fast_key_erasure(input_pool.key, chacha_state,
+                                     random_data, random_data_len);
+               spin_unlock_irqrestore(&input_pool.lock, flags);
+               if (!crng_ready())
                        return;
        }
