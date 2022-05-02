Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155951754C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386305AbiEBRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357301AbiEBRGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:06:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926725EA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:03:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so17293732edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u6ctPDMxVgGjtnFGMUjLT8WYXeEvvG7PHjNe0QwddI=;
        b=U+6pAjMkfydxMfXGeTmt3HKbxbXevcplbal5L1ckkQu9nHhDDr4SDRGgBekVn87CJd
         YrmGEanXaLZSZ82VJResvpoYyRkLUcrMX7ZgkOFM7hnObCOd86KUkbaj6zmv9dig+Cl6
         pXz5+eXdWfU0Vqp7yPjv4dFgsa7Lo+L0IpdMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u6ctPDMxVgGjtnFGMUjLT8WYXeEvvG7PHjNe0QwddI=;
        b=X7E1nvoI6giUgDmrhFUzNjCsPJzEpVJHY/3FzBWlxmdiIdVZV2+UJCV9T1ZGdieyaf
         trZ3+T8mIV/wnQjOm+OWmoaaj1Q7UVIWVq6ePJeW0v2I8YZ+gmizehk1MSJVhF0GbrMg
         OcqzoKLBL/kV45zytNmLgkC6NRSJKSPYKF6Lmv5ty1eS313+KGlNr245OvS9/hqNy8bF
         36yvF8i4hLT6JMujNbRtiA6W3tVbfnMobQDuzsarpuP0ACyvL9asc9Oq5AghvDv5kZ1g
         R6mIye70lwFv++g1zxuSJub5Ak2v34yLmZe0o/fQUO9KiRbRTHXuOTB0Z6UNB7ith+aG
         Setg==
X-Gm-Message-State: AOAM531u1UD6sIkUI401l4WHN2eNIjfSVpQNz2RiV/aCQhR1eyOmh8pP
        9TKgoxnfsLF78R1xp4Ec6lnmXfGM5ht4i9hn
X-Google-Smtp-Source: ABdhPJx27BFvrnTzAfOrhJHaLFA6B1F/Usvgj+q5/e58ASh1G9/HJPr5LBeD6x4ELT8Y+CiBgKxtbQ==
X-Received: by 2002:a05:6402:5107:b0:427:ded9:9234 with SMTP id m7-20020a056402510700b00427ded99234mr646768edd.275.1651510988667;
        Mon, 02 May 2022 10:03:08 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id cy19-20020a0564021c9300b0042617ba6386sm6761042edb.16.2022.05.02.10.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:03:07 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id k2so20323333wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:03:06 -0700 (PDT)
X-Received: by 2002:a5d:6d09:0:b0:20c:53a9:cc30 with SMTP id
 e9-20020a5d6d09000000b0020c53a9cc30mr9166713wrq.513.1651510986299; Mon, 02
 May 2022 10:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-3-swboyd@chromium.org>
In-Reply-To: <20220429233112.2851665-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 10:02:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAbfe9BC5QPDezz3FSEwHRFdQeZpARJYT4b9V1rNp_nA@mail.gmail.com>
Message-ID: <CAD=FV=WAbfe9BC5QPDezz3FSEwHRFdQeZpARJYT4b9V1rNp_nA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: cros-ec-keyb - skip keyboard registration
 for switches compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
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

On Fri, Apr 29, 2022 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> In commit 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if
> rows/columns exist") we skipped registration of the keyboard if the
> row/columns property didn't exist, but that has a slight problem for
> existing DTBs. The DTBs have the rows/columns properties, so removing
> the properties to indicate only switches exist makes this keyboard
> driver fail to probe, resulting in broken power and volume buttons. Ease
> the migration of existing DTBs by skipping keyboard registration if the
> google,cros-ec-keyb-switches compatible exists.
>
> The end result is that new DTBs can either choose to remove the matrix
> keymap properties or leave them in place and add this new compatible
> indicating the matrix keyboard properties should be ignored. Existing
> DTBs will continue to work, but they will keep registering the keyboard
> that does nothing. To fix that problem we can add this extra compatible
> to existing DTBs and the keyboard will stop being registered. Finally,
> if google,cros-ec-keyb is missing then this driver won't even attempt to
> register the matrix keyboard.
>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Fixes: 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if rows/columns exist")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index eef909e52e23..1bbe2987bf52 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -536,6 +536,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
>         u32 *physmap;
>         u32 key_pos;
>         unsigned int row, col, scancode, n_physmap;
> +       bool register_keyboard;
> +
> +       /* Skip matrix registration if no keyboard */
> +       register_keyboard = device_get_match_data(dev);
> +       if (!register_keyboard)
> +               return 0;
>
>         /*
>          * No rows and columns? There isn't a matrix but maybe there are

As per my comments in patch #1, I wonder if it makes sense to delete
the "No rows and columns?" logic and settle on the compatible as the
one true way to specify this.

-Doug
