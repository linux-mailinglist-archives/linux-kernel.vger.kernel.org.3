Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46F5526877
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381667AbiEMR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380668AbiEMR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:27:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77022703EC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:27:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ks9so17570078ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf0rn8yLC7yAPUBUazTnzPwSa/C/YmybSq+uQGiI6lg=;
        b=hEx1V12/qwOL04uY2qlbamcUTkaJNL+QbeX8z8ioN0zwzxI3yvuyYZU9wKfrQZj0rP
         BD3iFFZQqBbFu0y9i/4PgH4y7TmRpccgEcWf9c35EPwQhAndt8h72QTY8lvv6FJF/3iI
         1t1xWtbl3fEaJaHwVj2kxyuQr0niC5M7SSqyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf0rn8yLC7yAPUBUazTnzPwSa/C/YmybSq+uQGiI6lg=;
        b=kztnRKOzjLbhXQL7CqSvXcAtCOZyAAPxJXQD9EDgcxJTKgF7XbOV2p7uKdfcgk0cEX
         zdNjqCdbUtKLQXsNWAM3kQbS2wEyB7+f/v2vTVhppufwK6oCT4C1bKgpQ4CTvYSGexWJ
         XWyVqbWQvsyP5RD1HNMqg+GMOVlC10OE8SZBImzoj9eE0ZM2cW2pNZ6zGLls2LVmuea1
         0E/GL/Kj0HjAVDvFsKgo36vcdx71Ebed1Thy/F067aoN2kcdNzWbgEOELquDejxl1VQR
         ++g+bMTArU2HHv74WWwN3qDR9H344/tkKpwJSCQE/f7AJLmKxXd2KfZyvZ79k6L3fCgK
         QbiA==
X-Gm-Message-State: AOAM531/vtdX6CGq8yvhJhaef5NIGAdW+YmD9KBX7mEFRSAUeYD/e07B
        WPqxVwXqDcF7FqDG99YTQRYdXgYYNydDQ8VxcIQ=
X-Google-Smtp-Source: ABdhPJy/3iF5GjGbC+FB3i8Hd2653mZCKipstFXjcWxJ1CxgHe63LBrdnUPpGFvPqXuHuiG3UA4KlQ==
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id do13-20020a170906c10d00b006f4a770846emr5191647ejc.497.1652462848846;
        Fri, 13 May 2022 10:27:28 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090664d400b006f3ef214de6sm964888ejn.76.2022.05.13.10.27.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:27:27 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id q23so12313727wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:27:27 -0700 (PDT)
X-Received: by 2002:adf:ec08:0:b0:20a:d39d:6ab6 with SMTP id
 x8-20020adfec08000000b0020ad39d6ab6mr4855652wrn.442.1652462846758; Fri, 13
 May 2022 10:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220513100825.701c0801de7f18168c4d838c@linux-foundation.org>
In-Reply-To: <20220513100825.701c0801de7f18168c4d838c@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 May 2022 10:27:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz2FG+OxdR9KCWO=pPoWezScYx+rLUjHdeL4y9oJJvCg@mail.gmail.com>
Message-ID: <CAHk-=wgz2FG+OxdR9KCWO=pPoWezScYx+rLUjHdeL4y9oJJvCg@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 5.18-rc7
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 13, 2022 at 10:08 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Please pull a bunch of hotfixes for 5.18-rc7.

W00t. Pulled.

One day your workflow will also keep patch dates intact.

That day is not today, but it was still really nice to just pull from you.

Thanks,
                Linus
