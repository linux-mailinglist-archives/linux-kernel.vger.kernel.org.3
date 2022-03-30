Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD8D4ECA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349223AbiC3RSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349218AbiC3RST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:18:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4670F46
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:16:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v35so37885789ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tm/M1QfNcXKJWdbzlJAPcD9QnDTFP9PBZoip9dKGLOU=;
        b=irzbuC1yxtPzJaM4QZzXOwtaJeLpJb3y5TgrFTuR9Hmy3I/J+Xy7c1XVzyLq8bBt8T
         zMVgEsrRKq6WvsTaOjAJ3lLqjscObzyz6/D9zTfknSvxIG/X2UtFYl9MZvpGQXKkFLlS
         9W5RT9fcmgacwj//r5OLUyfM63/S+lI+NOvD+mttNfp6zrri+kL+D1P4CEz+1hZl9gHy
         WDCWqsrBM5ciM7dv7o1vifMVA/tSMP2eL5UNQao5EWv/Md3fQVTWaW6qQFjAvgIzDuPP
         w6M40os/G8bRPiUDzT4eUNM1Bt7nWv/0opXkR8sjYNTYDIlSPHvfCssw0Bk0+cO+JCgI
         ovkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tm/M1QfNcXKJWdbzlJAPcD9QnDTFP9PBZoip9dKGLOU=;
        b=H9YrXMbXJ5pTEAJJqwpyiw3gc2XadGyzNPaJxCMapeMjslaI+YH0XoTfBBOiLlkIxo
         UZKHvlwCaNcGzrKdIM+UXl4DrGm35VxoqiVgllE6RUQQ/vpsVQLJjYHJw2HdJYFDE8MS
         n71ykSeMOoK/HYozqolhivZngAe/0PoA5y0C916r/kXArZSEfllQ0xhFkugqiYBohW+5
         kbXe/51mr+8lHPb2/mA1wPSq3am3ukkEe08+SDYl/B9uFYVPXoW7sRBduInxUg5DEKel
         y4sNOZtSJenvITB38Uww8y3pYy+nhP+sF9dNVeJN0yLU8ghC7gUEob+AzqRKV96JC5jl
         9iBA==
X-Gm-Message-State: AOAM5301NvxCGP16KttDPpm/Ugnegj/EMouTq/CkYuL3MLfxM5Jpp1sq
        5MJDRMkg30P0IrTPxHNfFUFU9qg2Qc8JSkS7cDeiRg==
X-Google-Smtp-Source: ABdhPJwD1xhq+b+6JWdeZZOadJTyi9N59W+i4HzUlWqQvahhAC85WlXhfGU7QdLJSNmt+8J53orFK9viunsXr6g0hLg=
X-Received: by 2002:a25:f45:0:b0:628:b4c9:7a9f with SMTP id
 66-20020a250f45000000b00628b4c97a9fmr623786ybp.55.1648660592162; Wed, 30 Mar
 2022 10:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220311011715.2440601-1-eric.dumazet@gmail.com>
 <87ee2jo2je.ffs@tglx> <CANn89i+aCnUQj+UkRQBQ+mkL3xeFCmSkgeCYx+hmMNmko+EZ4Q@mail.gmail.com>
 <87bkxnnzkj.ffs@tglx> <CANn89iKnyG=3MbKzYKsE92p8Qu0QHie_UmQUxJx9YmHGUhKrQA@mail.gmail.com>
In-Reply-To: <CANn89iKnyG=3MbKzYKsE92p8Qu0QHie_UmQUxJx9YmHGUhKrQA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Mar 2022 10:16:21 -0700
Message-ID: <CANn89iJnmeeBY_2f5NqLhrjymkH6sdmPOBb4i-hDb=qN4-YcCg@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: use smp_call_function_many() in arch_freq_prepare_all()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:05 AM Eric Dumazet <edumazet@google.com> wrote:
>

> Can you send an actual patch, with a changelog then ?
>
> I saw kind of a rant about my patch, which was fine IMO.

I forgot to say that avoiding IPI is very nice, of course.

Thanks !
