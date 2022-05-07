Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239FA51E621
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384765AbiEGJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiEGJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:37:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B0A18A;
        Sat,  7 May 2022 02:33:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l15so6263465ilh.3;
        Sat, 07 May 2022 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SrYbBEfoeVu0FjrD/aIgVtwTtJV4hidOToCcfNr3HI=;
        b=fbXm53CCfYL5Y8l+W5j16c2wuzus2sXUuMmoL5pIhIKQu5Im8ZqRd6WtYOwvPlfxoQ
         OSjbPXxmvzx0XGd5oY7VlWdNPNGHfzAPmbm1MyE5CUdspadYrovwtdpqxBGTp3KOH1uk
         /CD//SV4lQxHcHrRZzlTUDnZT/Q+jxe01csy4iaPWup/91vD2N9pwWk2qlD9VgE6cB48
         51EDBd+ZbIuTxfIWi2l8rwPX5ytVW1xes1QAhKoRC1GqReH4DssoHyTmIohfj8+RV8gk
         I+E/3S9686NGoJRGWMZYnFbhA1ayqTSA1vS+9fOFqg5/nONmMjXaOBXiq/RCNDyE9QmE
         Oy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SrYbBEfoeVu0FjrD/aIgVtwTtJV4hidOToCcfNr3HI=;
        b=MWkHoG1DajybX3txJj0uuju2zw6s6arHeOE5dELe9XniLnQyfbbp2KsAn2kiirrb7r
         2Wd7PQTDnsWWBB8cL/6LkiAqfNn/X3WmbRfMm/mCYEdjjBFti9BmSTCKFrKR2lmtVM42
         ueNnfFKEG58vGvZ/DYfX31jvtWBrBc+BNLon12XCbRtm/Fnp+nTqADb6Smp+OqgbPx/b
         j3AsAOw6hxs41aJ1LeCummjYyN4PH/4v7Br/1uzZzWoMYDQhLMB82kyrpJwbYlyplzOY
         0P55bqwcxbkBfxmLX8D1+gyvazJhy2Iyb1ucLyC4b3YQQG5n+gdMLPvSlkhFeYvEAQHf
         FN5g==
X-Gm-Message-State: AOAM531tmiqIOKQfye5XTWQwVyCd3Zny/a6/qZ0FI9mfNp1LVr9SI/kT
        9wzxli3F62aArnBOUt0nPihdPt/Ts7xkIKuo29fmRRHQzj4=
X-Google-Smtp-Source: ABdhPJwCgTjhha7NWh/KCMOEiT+7zGJSfgHGbHnf+KUgcwhH9l+hDFFvJptBR11RKTg2eGtm0oplVJPPAZ0n7SKmfVc=
X-Received: by 2002:a05:6e02:1c82:b0:2cf:1836:2579 with SMTP id
 w2-20020a056e021c8200b002cf18362579mr3013212ill.237.1651916014082; Sat, 07
 May 2022 02:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-8-ojeda@kernel.org>
 <202205070214.AC7C566@keescook>
In-Reply-To: <202205070214.AC7C566@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 May 2022 11:33:22 +0200
Message-ID: <CANiq72kHUmxyKEuWydnMrhHRS-zZ878z6KJ96VEfBE9vByfZXA@mail.gmail.com>
Subject: Re: [PATCH v6 07/23] rust: import upstream `alloc` crate
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Sat, May 7, 2022 at 11:23 AM Kees Cook <keescook@chromium.org> wrote:
>
> $ find . -type f -name '*.rs' | xargs sha256sum | \
>         (cd ~/src/rust/library/alloc/src && \
>          sha256sum -c -)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Even if I suggested it in the message, I did not expect somebody to
actually go and double-check it that soon! Thanks a lot, Kees!

Cheers,
Miguel
