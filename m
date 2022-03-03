Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C74CC86A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiCCVxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiCCVxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:53:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AE53B63
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:52:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i11so8348115eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYiLJYYPJSjUhcXRGu1IuMA7OVQstg8mWS33iyknnRU=;
        b=Zc/WF7ywL7MhnMKbU00JCToNkD/++ZgWE+Y89kS14vE0kJ93fDvXJU5KZ4j0/9sqRK
         u9AjOEVVqB293uk/CyLW01XQKf8FgYoh55sm0DdlmYgEg1i9BkiLpKzZDXMyBcFxiTKe
         r1vJZPhN00yxmarO4mEaCG8FJaDbFVV0xnbKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYiLJYYPJSjUhcXRGu1IuMA7OVQstg8mWS33iyknnRU=;
        b=c/NEYykuoksU3pjsDIlHq6HIoqXg1hyni0unhHmD3XI++heWaov2UvjVOXsWwt2Z6m
         RApcpyQVjGjz/3NKdWhWeH4Ge/oUL7jqtM55qX0ty7gFs2aTtGzN10PDhD8A8rQT9IQu
         usG+mE6bmrPOYH/J6NP7FjWR2ItaZ00xiDwpCAkkDLpF1hp/eyOM9ulfHx9Ahsq/9q9+
         P55o3H+okbmLrwiHQ/OjLvY16rZcUzGwNbItk2HO620pDlyVAi4Jm8ueS8tm6jHC6vAr
         j6wS2Fv8zkJk31+hQn0cBnyb5KAhSX+JCqAat41QvgLSfMBHlUQopUwXVEjmHixEZ9/y
         8X1w==
X-Gm-Message-State: AOAM530ojjWrX/KSVjvKBP3BVnLTGuYeeZb9J9gUJxueo5yNJhCThKUz
        +cRjP5MSxsvJnehM9KeAiMuRHK4sMFYi2duU
X-Google-Smtp-Source: ABdhPJx949ynv3HiJ+nDvTacdFCtsqEz72joDgFmTpq884Kyygsi3XMLbaqs+IOTlUYTIhyhn1O1iQ==
X-Received: by 2002:a05:6402:f2a:b0:415:a3b3:2019 with SMTP id i42-20020a0564020f2a00b00415a3b32019mr11363638eda.177.1646344342731;
        Thu, 03 Mar 2022 13:52:22 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm1328830edy.37.2022.03.03.13.52.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:52:21 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id d3so9854218wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:52:21 -0800 (PST)
X-Received: by 2002:a5d:64ed:0:b0:1f0:6672:f10c with SMTP id
 g13-20020a5d64ed000000b001f06672f10cmr1142174wri.679.1646344341238; Thu, 03
 Mar 2022 13:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com>
In-Reply-To: <20220303015151.1711860-1-pgwipeout@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Mar 2022 13:52:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W6O5TtOHdVCbOyu221HrQWB8CnvcKA-5G49UF6TJaaHQ@mail.gmail.com>
Message-ID: <CAD=FV=W6O5TtOHdVCbOyu221HrQWB8CnvcKA-5G49UF6TJaaHQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 2, 2022 at 5:52 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> supports. This leads to a situation during card initialization where the
> ciu clock is set lower than the clock driver can support. The
> dw-mmc-rockchip driver spews errors when this happens.
> For normal operation this only happens a few times during boot, but when
> cd-broken is enabled (in cases such as the SoQuartz module) this fires
> multiple times each poll cycle.
>
> Fix this by testing the minimum frequency the clock driver can support
> that is within the mmc specification, then divide that by the internal
> clock divider. Set the f_min frequency to this value, or if it fails,
> set f_min to the downstream driver's default.
>
> Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")

I don't spend tons of time either Rockchip or dw-mmc these days, but
your email tickled a memory in my mind and I swore that I remember
this whole 400 kHz minimum thing, though I never dug into it myself.
It actually looks like the 400 kHz minimum disappeared sometime in
2016! See commit 6a8883d614c7 ("ARM: dts: rockchip: replace to
"max-frequency" instead of "clock-freq-min-max"") which only accounted
for the high end, not the low end?

I'm pretty sure I've tested on veyron since then, though and I didn't
see any errors, but perhaps this is because I was never using
cd-broken and the 400 kHz always worked?

-Doug
