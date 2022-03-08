Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65864D1CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbiCHQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiCHQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:05:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E6F473BF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:04:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id dr20so40211916ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPdkQphM15Eo5SdM94J/CTEkuLTXrgrE/iujWZfOFDM=;
        b=aEkBiyYVtzRXNJrAwcqq5Cwk5JilhiTWgJi0SCpBkYO4Fiat+SModSUH3HKB3MwIVt
         M4do+kkcYvc+Hi/On7MZ173vl9tapETKN5+r8i8Q1TTXLM8AxNSBVbDLs1z4eeGhOmfB
         wWL4ES7pxhENQhDd4uNDCD8b/YcftTftn6DYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPdkQphM15Eo5SdM94J/CTEkuLTXrgrE/iujWZfOFDM=;
        b=Oekz9Qek50R8vSzHZa8KgvTPzqQtfy9Fl72nv9QCERfDPhz1D1DHwNW9vyCZH7rFaD
         D1XW8qJHTgGaZxrR6T+1K7WvzAXwIHng7uavxYoQpTy1gcvxeK3YtO7FPVZgkqt1bqnf
         FSFIAPC1YpWYCRoutHY62Ul/TrN3741ON1qq3ZsM2b6BtAb4BfgLEgI3Z2KBkUEeYwm4
         9mowafPW/K2MNUjIeAjxwJXuzUkDTb0q0YJRvAc3+uKK3no234Q2KYFs9G2X1e+GlWkK
         YZDFYAWVwCgsdm7YCCEoyjnuddlnDh38GeQj59Dm8dlFid4RfcNlKPydalldzWNWvvAp
         RCUw==
X-Gm-Message-State: AOAM532NlGuxonxdHQtJz7cHeFCj0cp+ZNf5xGM8fdEjBMntndK7/Y03
        LBk4Aw7/QLcPtcWt/9FXLq4/QSrb5YdUPfag
X-Google-Smtp-Source: ABdhPJx0d3ZD4+ST9IWy40QXNG2bRrYvEcBSvGvlkHpP2gJwjR12+aSf6auNeQW0JyHhGnJ3hm8a6g==
X-Received: by 2002:a17:906:b50:b0:6d6:e503:131c with SMTP id v16-20020a1709060b5000b006d6e503131cmr13805069ejg.597.1646755477828;
        Tue, 08 Mar 2022 08:04:37 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm6062142ejc.161.2022.03.08.08.04.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:04:36 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id t11so29315335wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:04:36 -0800 (PST)
X-Received: by 2002:a5d:490f:0:b0:1f0:6791:a215 with SMTP id
 x15-20020a5d490f000000b001f06791a215mr13078257wrq.422.1646755475774; Tue, 08
 Mar 2022 08:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20220308033241.22099-1-rdunlap@infradead.org>
In-Reply-To: <20220308033241.22099-1-rdunlap@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Mar 2022 08:04:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
Message-ID: <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 7, 2022 at 7:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to indicate that the boot option
> has been handled. A return of 0 causes the boot option/value to be
> listed as an Unknown kernel parameter and added to init's (limited)
> environment strings. So return 1 from kgdboc_option_setup().

This took me about 20 minutes to trace through the code to confirm,
but it appears you're correct. It's pretty twisted that early_param()
and __setup(), both of which add things to the same list, work exactly
opposite here. :( Any chance I could convince you to:

1. Add a comment before the definition of __setup_param() explaining
that 0 means error and 1 means no error. There's a comment next to
early_param() that _implies_ that setup is the opposite(), but it'd be
nice to see documentation of __setup(). I know __setup() is supposed
to be "only for core code", but still seems like we could document it.

2. Add something to your commit message helping someone find the place
where the return value is checked. Basically just mention
obsolete_checksetup() to give people a hint.


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
> Fixes: 1cd25cbb2fed ("kgdboc: Fix warning with module build")

Are you certain about this "Fixes" line? That commit was just code
motion to move the code inside the #ifdef. It sure looks like it was
broken even before this.


> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/kgdboc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-517-rc7.orig/drivers/tty/serial/kgdboc.c
> +++ lnx-517-rc7/drivers/tty/serial/kgdboc.c
> @@ -403,16 +403,16 @@ static int kgdboc_option_setup(char *opt
>  {
>         if (!opt) {
>                 pr_err("config string not provided\n");
> -               return -EINVAL;
> +               return 1;

Shouldn't it return 0 in the error cases? If __setup() functions are
supposed to return "1" no matter what then what was the purpose of
having a return value in the first place?
