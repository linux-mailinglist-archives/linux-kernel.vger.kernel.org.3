Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66B058B064
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbiHET0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiHET0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:26:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCDA1FE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:26:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m4so6680170ejr.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Q2Atz4bVyAaEAuIsyG/t1IjdMr6gjS4rHeEEvGYCK80=;
        b=SzqiKjJQVFvyrvD+UjbFI0Ijsovl6BCQd/CLmNRlJa3i2aK70f2+hXL2IHvjChohS4
         KGPfEGmAAe5+0KNQCp+rOTDHpFSvH/xGA8WDw7bdgEKzfpW+bFVHztcSYyHLEhcneKnA
         QD4dRFMtvRmUZ5s68j6JUBEhofP2VOPPTpJIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Q2Atz4bVyAaEAuIsyG/t1IjdMr6gjS4rHeEEvGYCK80=;
        b=yPrAYYICVhohiEpket3RPDf2Nv275eaQFOgrTjQNf0Zck0BhclGf3G6n0KB9WyAucN
         1Q3lH6Q4Amh8qpnxOlHxbvu07PD7dT5omvX3CDPFsJod9f9+kvUvAz76MgVYc90TDBYP
         nQ/BFa0AMHfRe2D/yg2oi2HXh2sHO0pEVszHAwbwMZciF14kYFp+N6oW0sDo9QsaKiRs
         dKrMA8vjQKb30XluaNBA21Id6ofkL/LfEkXZVsbdCvDbAF9rS0QnFtB+bPhsWPkZmusd
         k2LfPeCr7CWCFUUDAthaWoBRCIiXdUdFDpgJJuYpxo8xYFy8rooKjEgpiLF42EkLMug2
         ivkQ==
X-Gm-Message-State: ACgBeo3LQBV1JD7O9LFAq+3Qc5Z/flbqc2c3JpGheWe7rKA3PRH3XX9V
        aU0/VE6BDgf+xBeLTxS640y1GbKSei/jFPG5
X-Google-Smtp-Source: AA6agR4P1m3SSqsxR6Z6G7GnWOcIAc6Rkqv8UquhKqckemaAfPmRHi2/Wl+m9yzjozdFW6m1g175Cw==
X-Received: by 2002:a17:907:6d8f:b0:730:b108:5062 with SMTP id sb15-20020a1709076d8f00b00730b1085062mr6129022ejc.461.1659727607975;
        Fri, 05 Aug 2022 12:26:47 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090628d400b0073065747de1sm1893679ejd.51.2022.08.05.12.26.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 12:26:47 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id l22so4264085wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:26:47 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr5240692wrr.617.1659727606852; Fri, 05
 Aug 2022 12:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220805111836.1.Id5a4dc0a2c046236116693aa55672295513a0f2a@changeid>
In-Reply-To: <20220805111836.1.Id5a4dc0a2c046236116693aa55672295513a0f2a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Aug 2022 12:26:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9VWbvWqdEEY9=OnNSsAnQ+CgQPRifbAu2ixrgPQd54A@mail.gmail.com>
Message-ID: <CAD=FV=W9VWbvWqdEEY9=OnNSsAnQ+CgQPRifbAu2ixrgPQd54A@mail.gmail.com>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Drop reset delay in onboard_hub_power_off()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi,

On Fri, Aug 5, 2022 at 11:19 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> onboard_hub_power_off() currently has a delay after asserting the
> reset of the hub. There is already a delay in onboard_hub_power_on()
> before de-asserting the reset, which ensures that the reset is
> asserted for the required time, so the delay in _power_off() is not
> needed.
>
> Skip the reset GPIO check before calling gpiod_set_value_cansleep(),
> the function returns early when the GPIO descriptor is NULL.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/usb/misc/onboard_usb_hub.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

I was trying to figure out what this "reset" was defined to do and I
looked for the device tree bindings. They don't seem to exist. Was
that an oversight?

In any case, I'm not convinced that your patch is correct. Timing
diagrams often show a needed delay between adjusting a reset GPIO and
turning on/off the power. The timing diagrams can sometimes show a
required delay on both sides. I guess at the moment the only user of
this reset GPIO has a symmetric delay, but I can totally expect that
someone could come along and say that they needed 10 ms on one side
and 1 ms on the other side...
