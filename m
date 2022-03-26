Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EDB4E83FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiCZUAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiCZUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:00:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BB47044
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:58:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 17so14330317lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Xq0aLjK8mlWyJ0CXnoW648bxQRycwPWS0yoFwkrlVOo=;
        b=dFLDy7O2LZUcd7uoEP7FY3qmy3tSFS+MBFI1YigIfXCjrAowsTXSKLadzM4QtBSBXT
         z7SwY4RXCNcKvubpwS0SlVWOxK4BadrgxNayuVoBbUyF+lprdZAKjQVo2khFs8fMrZ2t
         MlXNsy5nBVSJXUdrlhXUDhKpxa+AoSGNzooEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Xq0aLjK8mlWyJ0CXnoW648bxQRycwPWS0yoFwkrlVOo=;
        b=zU+kYAXo8s7xaq40g0ZjeIunafIIyr81x0Az0iBcHaZgE7TXc/IUatZOGQa5GWBJTZ
         4KjwOwuEaS+Ms/VipZX7k2LYN7cKfPYFZXKXqB2NhIIWth0g/4pkEpixeCrx7GfSr7zm
         tAVqUfgDT9gos5vISZuwbr9oGaqH0oOZT6MkaXs+htLscow1hoA9qWrm7IO2R7VXrKRF
         CCfGag7fjEGtEDUuSqm6hDOnkXxuDroxWCl8461vcNWXXICsDLUIHp1fT01FmyVH3S2+
         JwIgy2iO40y6eGrMlfLmTHk84KqsJ68qQWv3ArAN0pCStG3kertC++w4aqOkVR9GOq+B
         XKZQ==
X-Gm-Message-State: AOAM531QbkCSfn2e98LEP5NGZZvkZCAwarHXtRDrRYBSNzophaANAy5u
        83ChmKPTKlUZnDsdn8xBVAWdYBo904hIj24C78Y=
X-Google-Smtp-Source: ABdhPJw0koveMwEET94IvYMGxdtSrVJo7YOvLRb+YoPiFJf+G2kfUD6MQ5xphq4HtslHmms+uQe/Qg==
X-Received: by 2002:a05:651c:104b:b0:249:b46c:c32b with SMTP id x11-20020a05651c104b00b00249b46cc32bmr9433800ljm.227.1648324735467;
        Sat, 26 Mar 2022 12:58:55 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004433b80c1d3sm1148476lfi.182.2022.03.26.12.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:58:54 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id e16so18576248lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:58:53 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr13374071lfu.542.1648324733085; Sat, 26
 Mar 2022 12:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <Yj19RH3qpzQsIV/O@shikoro>
In-Reply-To: <Yj19RH3qpzQsIV/O@shikoro>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:58:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoeUc15-8Wu8U=4FnwhgmyU3C13R107oigbmJRpi_sZA@mail.gmail.com>
Message-ID: <CAHk-=wgoeUc15-8Wu8U=4FnwhgmyU3C13R107oigbmJRpi_sZA@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for v5.18
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Terry Bowman <terry.bowman@amd.com>
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

On Fri, Mar 25, 2022 at 1:28 AM Wolfram Sang <wsa@kernel.org> wrote:
>
> I2C has for 5.18: tracepoints when Linux acts as an I2C client, added
> support for AMD PSP, whole subsytsem now uses generic_handle_irq_safe(),
> piix4 driver gained MMIO access enabling so far missed controllers with
> AMD chipsets, plus a bulk of device driver updates, refactorization, and
> fixes.

It feels odd/wrong to use the piix4 driver for the AMD MMIO case on SB800.

Would it not have made more sense to just make that a separate driver?

It feels like now the piix4 driver has a lot of "if SB800" for the
probing code, and then a lot of "if (mmio)" at runtime.

I've pulled this, but just wanted to mention this "that looks a bit
odd". How much code is actually _shared_ in the SB800 case?

I'm not insisting on splitting this up - maybe it all makes sense. I'm
just questioning it.

             Linus
