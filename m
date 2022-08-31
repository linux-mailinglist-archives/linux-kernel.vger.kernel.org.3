Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE85A80D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiHaPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHaPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:03:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA38D41BB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:03:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c59so12560031edf.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Wvt6ITeF/X4JRSxdtK92jcKPth5+KtUlEAYbOxr/jds=;
        b=PddbYj3qG05D1/L5GWquq87ECVO4EbUwFENnYFzNQL2UqGwNkl9svThio3fJoS1Xj2
         mmCGnKGnMsMVQSIqJmeBWiLM/VxF5Zuftj4L8bV4+SXaMbCBlffHpWUMtqyu+kY+/v/Q
         M9xWIbikP2nLLWQHu267ekz+EL+G1ArpvB8fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wvt6ITeF/X4JRSxdtK92jcKPth5+KtUlEAYbOxr/jds=;
        b=uJBcUoOyKeFExGjRqJHKKGJboqUwY2lqvwPyshjgPqG9yLvYXxn9ead0LSn/YvE68S
         Kb9zkFqQByW0bGnGktgLjQRwUKlEspKinGd7uwSf7WahvNmo0snkfnjN8Xegm3yCp+/s
         ERI3UWThm4T9xlOCvvs62BfTcKNViDHiupJdYdzp85NHTRrg8bAwG5kmuyLwU/aT3Q03
         fe6hEO4G8YXohthB+WCjBUAvXMbyd/1038NOOJnCZNjFdck2vp4NkdH3PiCfSNo0yIop
         DVhJsa53pRvwbl8jb0/F6WG4fnFjqdpDVMHfM2iZUlc0HpRTPs3vg2h3xNoA79aYEP0C
         qg0Q==
X-Gm-Message-State: ACgBeo10VO5YTcN8HIyGkxYOW4bV4Arn52bxJTLP0LJbdw1T6K+0vBhW
        4b1H5+KY3PUE/dpS0jOr6ZyNhkIAhUizXW0ZAe8=
X-Google-Smtp-Source: AA6agR7KxzmodC0K0yEpqRN5H5heTXBEYT3v0YQq0sbEUE1xkvQ0RSS2v08N3HG6fjuD5CEQbJ+Djg==
X-Received: by 2002:aa7:cdcc:0:b0:447:bac0:4c20 with SMTP id h12-20020aa7cdcc000000b00447bac04c20mr24135306edw.183.1661958204375;
        Wed, 31 Aug 2022 08:03:24 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id jt2-20020a170906ca0200b0072f0a9a8e6dsm7230493ejb.194.2022.08.31.08.03.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 08:03:23 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id u18so5991096wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:03:23 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr12130960wrr.583.1661958202933; Wed, 31
 Aug 2022 08:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220720162314.1.Ieef5bc3848df40b71605b70bb571d6429e8978de@changeid>
In-Reply-To: <20220720162314.1.Ieef5bc3848df40b71605b70bb571d6429e8978de@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Aug 2022 08:03:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WC0QUaZsHQHhc+TAV2JXT64rnxDh9OvskpVrZAXzfz=Q@mail.gmail.com>
Message-ID: <CAD=FV=WC0QUaZsHQHhc+TAV2JXT64rnxDh9OvskpVrZAXzfz=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Fix typo in kerneldoc comment (appers=>appears)
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

On Wed, Jul 20, 2022 at 4:23 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Ever since I got the spell-check working in my editor this one has
> been bugging me. Fix it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index e6645d6e9b59..07a383dff548 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -53,7 +53,7 @@ struct panel_delay {
>          * before the HPD signal is reliable. Ideally this is 0 but some panels,
>          * board designs, or bad pulldown configs can cause a glitch here.
>          *
> -        * NOTE: on some old panel data this number appers to be much too big.
> +        * NOTE: on some old panel data this number appears to be much too big.
>          * Presumably some old panels simply didn't have HPD hooked up and put
>          * the hpd_absent here because this field predates the
>          * hpd_absent. While that works, it's non-ideal.

Maybe you'd be willing to give me an "Ack" for this stupid little
patch so I can land it? ;-)

-Doug
