Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10B500022
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiDMUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiDMUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:46:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C382253A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:44:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so6363781ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9t746E0a3Zsh93FlmUmusMHEf6L1/F6+kRTi3ZPWd3U=;
        b=NpPyUcrQ7ZOjuUtydpO0p2toOxFON7X+5zw1Y63SEiUiNqQ4gztOMnnPJOXGMzYTSC
         5rYy7JDvRCd8Y15GeAIxAzAfXIgI7S33JA/ZAmDD9vgR0zHszTSDxGCrQWWaXRl9v8ue
         GqUiGQHi4etpqlM/9j3h0Rn+mq48g3srPc1X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9t746E0a3Zsh93FlmUmusMHEf6L1/F6+kRTi3ZPWd3U=;
        b=hvRAKp8qnFad1i5SNnHIfac0wojQkS379q0wwbi7A2NU3excA9z20uic+F0mG0OLQI
         WZn2ZVuA5nFtnoTPrE6XDeapS7nSRzBzaAmrIyoe9Wu+FWu39X7FqZxrLUbT2pubRRFw
         sIE4Nn11khL9S6Pl1iw6QSyxQSS//iV0RUGpYsBGmbEK0vLs8UU6PJKm5c9b7N/9jnzK
         iYe9q3WX53kFaul6X4moc/XnfYDp5PG2ezsItKijsZWHWYK9YLtxhyc7VL5VivHdAo5H
         lG/SLF2AGSHJPCQxxuCah+KgwxIJlLiMdsywmR2XH85Xq3/yWgNrshcLB0vwTnpxHaeP
         x1RA==
X-Gm-Message-State: AOAM531yfxBVGqylJECZZNK+ZguBXp2D//LNnpPRjL/pppkCn6ytw9Gf
        Fq0QVDU/9gtA6AFC+mv8aeMhqNH3EUeZwg==
X-Google-Smtp-Source: ABdhPJzSq3INZ5SB+eb+RZjK3NovoCCIazQRYKhQNGPCXc6XvOUBHklqdJ9Ksu0IkaxgJO3rAyoJkw==
X-Received: by 2002:a17:906:c092:b0:6cd:f3a1:a11e with SMTP id f18-20020a170906c09200b006cdf3a1a11emr39447053ejz.185.1649882667796;
        Wed, 13 Apr 2022 13:44:27 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm318438eje.183.2022.04.13.13.44.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:44:25 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k22so4313379wrd.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:44:25 -0700 (PDT)
X-Received: by 2002:adf:c14d:0:b0:207:a28f:f5dd with SMTP id
 w13-20020adfc14d000000b00207a28ff5ddmr420309wre.679.1649882664627; Wed, 13
 Apr 2022 13:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220413033334.1514008-1-swboyd@chromium.org> <20220413033334.1514008-2-swboyd@chromium.org>
In-Reply-To: <20220413033334.1514008-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Apr 2022 13:44:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ux8AmWpsphRL2waUSrp_Vioykn5WTui4UpzsGLr4fdcA@mail.gmail.com>
Message-ID: <CAD=FV=Ux8AmWpsphRL2waUSrp_Vioykn5WTui4UpzsGLr4fdcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: cros-ec-keyb: Only register keyboard if
 rows/columns exist
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 8:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the device is a detachable, we may still probe this device because
> there are some button switches, e.g. volume buttons and power buttons,
> registered by this driver. Let's allow the device node to be missing row
> and column device properties to indicate that the keyboard matrix
> shouldn't be registered. This removes an input device on Trogdor devices
> such as Wormdingler that don't have a matrix keyboard, but still have
> power and volume buttons. That helps userspace understand there isn't
> a keyboard present when the detachable keyboard is disconnected.
>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> I tried to use mkbp info to query the number of rows and columns, but my
> EC firmware doesn't have commit 8505881ed0b9 ("mkbp: Separate MKBP_INFO
> host command from the keyboard driver") so it always returns 8 and 13
> for the rows and columns. Sigh. With updated firmware we could query it,
> or we could rely on DT like we do already.
>
> Originally I was setting the properties to 0, but
> matrix_keypad_parse_properties() spits out an error message in that case
> and so it seems better to delete the properties and check for their
> existence instead. Another alternative would be to change the compatible
> to be "google,cros-ec-keyb-switches" or something that indicates there
> are only switches and no matrix keyboard.
>
>  drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I do wonder if there will be any unintentional side effects here.
Specifically, even though there is truly no keyboard here, I wonder if
anything in the system is relying on the EC to simulate keypresses
even on tablets where the keyboard isn't actually there...

OK, I guess not. While I think it _used_ to be the case that you could
simulate keyboard inputs from the EC console even for devices w/out a
keyboard, it doesn't seem to be the case anymore. I just tried it and
nothing made it through to the AP.

Seems reasonable to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
