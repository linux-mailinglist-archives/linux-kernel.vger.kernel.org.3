Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4238468876
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhLEACk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbhLDX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:59:27 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A0C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 15:56:01 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so8519004oto.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 15:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zY3i7ftL+qU7EaeCEo0Da0c8vVJG5AN/hKQi41H+yLI=;
        b=hXY+SVGQvC0dITFV/8cw66YveTL2VrAPWypCzem5wLj0zfH0E8//nkk0PU9MlEuimD
         8GJR/HNR80LvvLGcBjuQtk9mGAL+RtIsU24DzgSNKw/CGq/6tIQQ2kVGxDURajHvLdwJ
         xUGOkiJOTh5nc4PFGiaTqbZodn2nnLUqEAXoV387GuNy8z9H88bl/anUL9OZ+i61/VgN
         wrWgmcBkiHuQpbaFDJ2yYWTsYMSt0NaCe2WKez4U3aIVPTRCoMMb9A59BLNcSYBGT5qD
         9YTPNYXfPElaKANjF9CszCxad0tRKRhcaE4Dev27/x+XspjJ/k748foEPQZJZzW6OSaw
         Atzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zY3i7ftL+qU7EaeCEo0Da0c8vVJG5AN/hKQi41H+yLI=;
        b=kOiZ2biCGbbJyzdgvnEf9TBZrSQSDEyfr6e21JtWiw+ZMhLZf520b+XXonCI4uM2Et
         wt10qa8Ad7JNBejw1oQTmG5xNwPdetYy4JOmbRDvD7n7zJfDaUt6Kg0JLhg0CLdeX88y
         nbJmA7jZh6WMlWSImNXX3b9VX5ECOT7W4oyjP33sIIMfo+Fw26uD/lJafcYdrURK47BM
         129yAd2sYf6vEd34srpJyZq+kEQMUMGssCLuhUMU1V0acFEPKXNoscW8ZUptFJOR2Wug
         CNGM74wC0Ffs3/VU3bAFrQPQrM0N2KRblCocoZFBMsrIkFc4TNIaSkbOWP1VzAbKcSgt
         +2RA==
X-Gm-Message-State: AOAM533+Gz2HzzkPRUKvIXvL9Dgy3bs6JcZBHKS39/I5+Q8tN78U9i+c
        uZvThc1zxmPncOphUKzJfrxzmk5XHTf73BLvO2nFYA==
X-Google-Smtp-Source: ABdhPJz2vvD7CFG8AqSlV1zqwUTjhaC64nFB3oOay4IJHNTFWeP7piR/EKMbqPy9/EM8NpCWA32hXh9F6VlWbbXvFlI=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr23737125otg.179.1638662160588;
 Sat, 04 Dec 2021 15:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20211129153330.37719-1-nbd@nbd.name> <20211129153330.37719-13-nbd@nbd.name>
 <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com>
 <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name> <c721ac4a-8b80-2241-3380-6b55e953d754@phrozen.org>
In-Reply-To: <c721ac4a-8b80-2241-3380-6b55e953d754@phrozen.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Dec 2021 00:55:49 +0100
Message-ID: <CACRpkdbOC_CgB_jsVKq7z+mhyK0jo4dvXtjYOuaVeJcCJXufBg@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO controller
To:     John Crispin <john@phrozen.org>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 8:02 PM John Crispin <john@phrozen.org> wrote:

> Hi Linus,
> I sent an email to you 16.06.21 explaining all of this and you replied,
> telling me that this approach is the most reasonable one to take.
>         John

Sadly I don't remember that, too long ago!

Anyways let's just go ahead with this.

Yours,
Linus Walleij
