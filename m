Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4D51E8C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446754AbiEGRKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446725AbiEGRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:10:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B13981B
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:06:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso9394162pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=50cVO3qthcm3b2xqR68tMJMaU8j4FFGwSvmXlvEKRIg=;
        b=XA4BbRCNayh/ytgikpUzN4kvedWLzqcSDET1DkqFEpWb05dxGME4hQ87mzjH5F9G9/
         xslbNlR2pxxvG3czjh/ep8ePi4H01ka3my8EYhtL8rsMeuGFZYcJKaqiavLi+W+QUcd+
         qV8npTLSNTD52lb5uiF2OA+4PsVCQHMbM2YYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50cVO3qthcm3b2xqR68tMJMaU8j4FFGwSvmXlvEKRIg=;
        b=ot+hOn3Ub4nDnLedgLiPuqLlhqUdsCzn+F4Aw20ILIAeVz+ULS1ZVkqc+AQWXTF7v+
         4dvhSOie/sUbUN1drfUIdUcTNc0hnsjKtAn8JEXinfb7yaB+DWaPJU40xC7M8cG71ExB
         FZQiVZVZl3xCRWrGhc3ZwC4pkh8nZ9uZG7s92dq4QlTZtgKFrdec0zDiSVzgJhMHz0eX
         Sq3UHsGSvyOiVJUQu47Y5Vda3bYEWmOEeLQPck3toWQLp7wufFrgqL7Ncl33e9T4GwBP
         x/fW5KbofjmKrFmLyFdUFpkb0rXqmJzf6jjCH79dR0391mXkFqcCtX5b1UB687CruKVy
         EO9w==
X-Gm-Message-State: AOAM533YJJl5vlaOKqFB4YLgNveMX2rEx2UeoLDOJdCTu35eP1bc6IsS
        9WU6vA0PewzoRT4rIgJSoGj9zw==
X-Google-Smtp-Source: ABdhPJw266ytADuOoLTKDxHhoUYHP07t/aN0b1wVgzExgdUVx2SDfoNg+6V87xdhJW1dCGT7MbbOsA==
X-Received: by 2002:a17:902:ab55:b0:15c:ecb:81ad with SMTP id ij21-20020a170902ab5500b0015c0ecb81admr9071715plb.50.1651943183125;
        Sat, 07 May 2022 10:06:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r23-20020a632057000000b003c14af50615sm5431944pgm.45.2022.05.07.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 10:06:22 -0700 (PDT)
Date:   Sat, 7 May 2022 10:06:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v6 07/23] rust: import upstream `alloc` crate
Message-ID: <202205071005.E734A5D6@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-8-ojeda@kernel.org>
 <202205070214.AC7C566@keescook>
 <CANiq72kHUmxyKEuWydnMrhHRS-zZ878z6KJ96VEfBE9vByfZXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kHUmxyKEuWydnMrhHRS-zZ878z6KJ96VEfBE9vByfZXA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 11:33:22AM +0200, Miguel Ojeda wrote:
> On Sat, May 7, 2022 at 11:23 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > $ find . -type f -name '*.rs' | xargs sha256sum | \
> >         (cd ~/src/rust/library/alloc/src && \
> >          sha256sum -c -)
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Even if I suggested it in the message, I did not expect somebody to
> actually go and double-check it that soon! Thanks a lot, Kees!

How could I resist a code review that I could script? ;)

-- 
Kees Cook
