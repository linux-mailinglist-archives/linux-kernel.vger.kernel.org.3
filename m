Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478A654F658
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381933AbiFQLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381774AbiFQLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:07:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626B2FFE2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:07:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u12so8093195eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEwaem/xAtfULgaR3mIiQRybksdoP4gsjfxUSl3M7Wg=;
        b=IRA3BGiTIVjH8IMjsPrY2AaWkXWzLbXVe3yTtmFYtKgF42jKNMXXn1TkJwxJOmK6mi
         ql0r/Q/gFkBMxAeRmRDqF0sSl17OK6fLQ44mpQ5acpuXVp2zVQgs5aWUAxlrRiF76yf4
         0U9yJ0sJKYFs+O97pzF0ofgOSq9xCM6RwyRCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEwaem/xAtfULgaR3mIiQRybksdoP4gsjfxUSl3M7Wg=;
        b=LqaF4e4L31icRoY5pMFvPqRyG9fTyR7chPnZHQuBIhCRS2/dfSXDXfbsFiow7I9KcP
         jwxBJTUKhPkwH4mz5fXrAiCX7lipakFLqWtY7bWmsPQt9nUtrBkRZ6tCQ6GSB6nFuWqS
         bedhb7SATGdwZn5SMIqWCDiB2x7NWAlblVmZ0LfdOFSYuPRClIrq5NSqztR8RFlukct9
         aTYfy4gGgebeGMQ8f7QZ1xnbC0pMd1oSpesPK/bUigFy86BJdekcwEmKNkadyL4YPxDd
         h20eIXT4/p3UIwfgJbxe9dsyEARinJJor723g9VaMb7qvT8cKylOnJPT/7jgpICx1Ta5
         6v8g==
X-Gm-Message-State: AJIora8qzFb7U+SOEkhw9gcpr5OVHGraqAgfA84vO+bLX2YAIUcBOEqt
        cR11DGocX6e4eT7mzUjOkJS6paZ/0uo5Mw==
X-Google-Smtp-Source: AGRyM1sNsMGKRPI1TYMhzBkZ4ToM/6GTPDEmO8dYQ52LDJWKAuYTRn1ZxQWwo5Bcd1QRdVoCvH4W7g==
X-Received: by 2002:a17:906:7a08:b0:712:12f6:243a with SMTP id d8-20020a1709067a0800b0071212f6243amr8838938ejo.619.1655464068597;
        Fri, 17 Jun 2022 04:07:48 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906265b00b006fe89cafc42sm2047418ejc.172.2022.06.17.04.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 04:07:47 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so2233149wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:07:46 -0700 (PDT)
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id
 z21-20020a05600c221500b0039c55a09531mr9687808wml.29.1655464066586; Fri, 17
 Jun 2022 04:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220617100632.1447811-1-fshao@chromium.org> <YqxauLOp2sWOU/uc@sirena.org.uk>
In-Reply-To: <YqxauLOp2sWOU/uc@sirena.org.uk>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 17 Jun 2022 19:07:09 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhVSMfebqv9Kr-bkHdF9HcDMQVU-sTUzRch1d6bZO54Ug@mail.gmail.com>
Message-ID: <CAC=S1nhVSMfebqv9Kr-bkHdF9HcDMQVU-sTUzRch1d6bZO54Ug@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO request
To:     Mark Brown <broonie@kernel.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>, alsa-devel@alsa-project.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 6:43 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jun 17, 2022 at 06:06:33PM +0800, Fei Shao wrote:
> > The lockdep mechanism reveals an unbalanced unlocking on MT8186:
> >
> >   [    2.993966] WARNING: bad unlock balance detected!
> >   [    2.993971] 5.15.46-421fef3b44d7-lockdep #16 Not tainted
> >   [    2.993978] -------------------------------------
> >   [    2.993983] kworker/u16:1/10 is trying to release lock (gpio_request_mutex) at:
> >   [    2.993994] [<ffffffdcd9adebf8>] mt8186_afe_gpio_request+0xf8/0x210
> >   [    2.994012] but there are no more locks to release!
> >   [    2.994017]
> >   [    2.994017] other info that might help us debug this:
>
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Agreed, I'll resend the patch. Thank you for the feedback.

Regards,
Fei
