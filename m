Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC04D3DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiCJAPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiCJAPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:15:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BCD2BEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:14:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m12so4889957edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YOi63Y4UP1PxQIOJspMhCwWLw9KtU08nAJtSydjZYc=;
        b=ndLnV1n/Cj/VOOqVdnS1BUd+irOj0yq6+IhyDGRmeUD7EdPsTQEL0tSrZjhbJDKx5v
         HKwiDEpH4dZd1KSzFoOc1+usH/ySFbHje/5+3KfuIxLocRKXPGtD287yO40DXZCx/hJh
         TtDAT0zyBfLi10li350C7mskcVtQIQ6KYd1Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YOi63Y4UP1PxQIOJspMhCwWLw9KtU08nAJtSydjZYc=;
        b=Ka2WgB9a0L2GuORDvfainlxfEHc64FZ2+skaPwMgO6J17ggf3PqBnmHJ1zm7HxLEGQ
         zSAIlQbJbc5P7lJHqdvtgz8Tl1MrzAywR0pD69KP2sWUZKycwqSaXUF+ayK9s/rEDBM5
         LWAJ7gd5yZKSs9bwhatn6gK2y7sMIco+9fM6K10fgBbilWM9IhE5yxJvIF6ag6OlF6Q8
         08F7kbQAU+8BOnKCeYdK9XzdcjDIDMFRMNUgSiH96KgtSaqLMICJn3x3cW6k4i22bGbr
         16GJjPeKPAwdZGFrtPhgBXssVJe7q9j+bDiFzO0GCZh7Nu079MIAtcvlirCjrTly8glC
         lAwQ==
X-Gm-Message-State: AOAM531b5+6JuZbB9QbIPSIV9gZPmV3LFulsbITgZdeuDfbD5kNVsxew
        XB3s7tGW5hUArZ+ZkTJiogu3gCZWg8uyG69v
X-Google-Smtp-Source: ABdhPJzoQvIbuDhyBr0ytMGfchno5rZuIzAomLL/g3cGbo9HgxCbDsFPcXpt+8lbwucRymBaNcm8nA==
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id x1-20020aa7cd81000000b00410d64eaa31mr1876602edv.167.1646871271874;
        Wed, 09 Mar 2022 16:14:31 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906829500b006cef3dcd067sm1262058ejx.174.2022.03.09.16.14.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 16:14:31 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id i66so2277179wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:14:30 -0800 (PST)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr9408784wmc.29.1646871270537; Wed, 09
 Mar 2022 16:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20220309033018.17936-1-rdunlap@infradead.org>
In-Reply-To: <20220309033018.17936-1-rdunlap@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Mar 2022 16:14:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=ViPnSnoSYHSJFvyzkJ+Q+w7JuZFWS7u5BQxN6KHquGyw@mail.gmail.com>
Message-ID: <CAD=FV=ViPnSnoSYHSJFvyzkJ+Q+w7JuZFWS7u5BQxN6KHquGyw@mail.gmail.com>
Subject: Re: [PATCH v2] kgdboc: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        He Zhe <zhe.he@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 8, 2022 at 7:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) environment strings.
> So return 1 from kgdboc_option_setup().
>
> Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc7
>   kgdboc=kbd kgdbts=", will be passed to user space.
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc7
>      kgdboc=kbd
>      kgdbts=
>
> Fixes: 1bd54d851f50 ("kgdboc: Passing ekgdboc to command line causes panic")
> Fixes: f2d937f3bf00 ("consoles: polling support, kgdboc")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-serial@vger.kernel.org
> ---
> v2- correct Fixes: tag(s) (thanks Doug)
>   - drop Cc: Laura Abbott <labbott@redhat.com> (bouncing)
>   - add a reference to init/main.c::obsolete_checksetup()
>
>  drivers/tty/serial/kgdboc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
