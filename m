Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2955476CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhLPJCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLPJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:02:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2AC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:02:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so85043153edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIbH4SBUTuR0l4tTL7AOxNkBOgGIn/iy+LZnKcqvvgA=;
        b=o8+RashkwgCrlNotfXLtqTsFevD8f50yVDdW+L4a62MZUsf/U1UGMDnJF8P2YoRyha
         GEsAMaruSO85MGPl4XWKn15AooxtYn3QF4lLMPSziwQSmSgjMXDBouRA8fM/qli0LMbZ
         xV3AvI3IZXH1ssWssl6jbadMCEN3IpF6o38TscsPT66kWBDxo/y8lblOPMw9109TyYUQ
         T95h4i+AAnASqpU3j2emLTbXsLWEKxUMuAxfn19SdAT3SK0xceneHAeT3cSe6b5Ry6VU
         SGrPEa8oCv6+FNiJVy7tn4fYFCzg/Aol32zEajFd0FZWfe6FpWTOSGSujXP1J63JPKke
         ORuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIbH4SBUTuR0l4tTL7AOxNkBOgGIn/iy+LZnKcqvvgA=;
        b=lhAPVdPJ/Jn2acr8OInzObG0/2qp96q0k5GbdP8Q7hxIWuYQG+40XXW4MSMoJR8MU6
         9oo5FZ69fukBL20F16zHq0UU59DwgwgvnWKyCIzWZQolDRnNmSMMiVqskMqFifYBeOxX
         C+RCTNjfP8dWT0q24SqkKDn16fngD9O/uVpIBtwDFeztvP500Z5ThRL5uy9NL6HDOU4I
         GrXBp7hefyN/LHoOnmxB4n4GDHts3TozwTRoBfrNJl4ttlFq19yDYwG6+SicdE6JmEeq
         Av+VzoZKdDlf6lJAPgVifyjRbnFLSiWxdvWEv2jyBPzj8Cp8C58sHpFynXXX/mU/Rg2p
         uVyA==
X-Gm-Message-State: AOAM531wWMgTu12OBUADMof7vjsXLzeJhdn+eFt+nLFYTfMdJe+fSJCe
        RV82VFWg7Q89E1WMQ4Ei0GF0tvfUx1NcQ+saZICtwg==
X-Google-Smtp-Source: ABdhPJySShxGp6YbFcUrtOlrqvy9G7/3hwoav4HzaV1/xvWq/Hhe1DphVlmvTcYd4WCYYxbQtiCJBZEzhnGMkyZPWCE=
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr14700005ejc.101.1639645349406;
 Thu, 16 Dec 2021 01:02:29 -0800 (PST)
MIME-Version: 1.0
References: <adc9d6a4-5cab-d8c1-a7bc-d9edc673e4b9@axentia.se>
In-Reply-To: <adc9d6a4-5cab-d8c1-a7bc-d9edc673e4b9@axentia.se>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 16 Dec 2021 10:02:18 +0100
Message-ID: <CAMRc=MeukM8-1P6t9LBgjs9VEQ8JhqNyUVAiZ1yaALsPSxSUTQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: allow line names from device props to
 override driver names
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexander Dahl <ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:00 PM Peter Rosin <peda@axentia.se> wrote:
>
> Some GPIO providers set names for GPIO lines that match the names of
> the pins on the SoC, or variations on that theme. These names are
> generic more often that not, such as pioC12 in the at91 case. These
> generic names block the possibility to set more useful GPIO line
> names with device properties (i.e. gpio-line-names).
>
> Allow overriding a generic name given by the GPIO driver if there is
> a name given to the GPIO line using device properties, but leave the
> generic name alone if no better name is available.
>
> However, there is a risk. If user space is depending on the above
> mentioned fixed GPIO names, AND there are device properties that
> previously did not reach the surface, the name change might cause
> regressions. But hopefully this stays below the radar...
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---

Applied, thanks!

Bart
