Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7947D47D244
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbhLVMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbhLVMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:42:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89221C061757;
        Wed, 22 Dec 2021 04:42:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id bm14so8187115edb.5;
        Wed, 22 Dec 2021 04:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PHB2DbyuqWjb8kOPRMCAabVl++BybmOaXAT1jQnLdE=;
        b=A3aSKk0zsqKWt+N5dbDvZnR4TsIGtDoP9kAPs5+0kxYIEBmxB6Vb/Yx6Kj3y+jETgw
         quiZ6gPo4KKWywQ13342Mc1UOABJvfvMy4hpHwZ5A/MOZF1HOgvsle0lS6fl5aBBp4P9
         xtzENL4wML613CCYM7STBCQ0tzXknUbL+THotmvNnPTe5ZE7nlHR8UgBp2EnArNwpTGH
         4qpXzwiz9ejiflfBFWSXCtR0ouvspEnaAn3c1T6k/gXGrBDxUdg2OFmcSaiOVO9OxTgD
         JZs26eFkCWL/8NncABavxU5CeWI9FK1uJAEzDrur7Vbq9D8kJTedLY4aZqFcjRG+1X8y
         iiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PHB2DbyuqWjb8kOPRMCAabVl++BybmOaXAT1jQnLdE=;
        b=E8+f42v+bOH+BXxkzT4xCQq+5QmFedj1Jq1F424s7hBLkYCTR0JcIvaYQxnuM1higN
         U8ncnVmEtfRcphUK19M1RLGAzh7zK+OROaDKIAZP8aMxfzG+YWOzklIrIgxE+1jYzuGo
         n9VuoG+dGV2zA4SQhtLxQofESh9N6qn6lfMWkzgqfwzQrM+K1Srculgy6vZeSAdMPFmR
         RP/dQ2RLHAPU1eZP26EWioB7p9qQOorztxUHUmiKMRQDTW1oihsu+8zzi2aY7kagvrl+
         ZDo2wMrdafvn2Ol1hKLRuHRpb/kvmmWy7p/KmXl+wlafLgnGsYVAarSCN+AKAVREAsLf
         M2cw==
X-Gm-Message-State: AOAM533msJtbJHDKsaI9iXhEtj+0MZ4pyyzD42V+TlH7DsHAeJxJTOh4
        +Kp2bh5sV5JQAOpxhNSoJBg5XzhNLKiwZMe7Uqk=
X-Google-Smtp-Source: ABdhPJwhAUvQ/IAad0o9VyMvINqUtW7Yn7BvDa5bqAfmkvgWiK1Qh0+09stpi2FbCU9QA3buCd3YEhZkroARzxwUrYo=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr2360256ejc.132.1640176953787;
 Wed, 22 Dec 2021 04:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-14-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-14-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:40:35 +0200
Message-ID: <CAHp75VfC5-C1JuY4r_26tR7ds-f=S6BCPNde=TEBbWNW6hBrnQ@mail.gmail.com>
Subject: Re: [PATCH v11 13/15] iio: afe: rescale: add temperature transducers
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> A temperature transducer is a device that converts a thermal quantity
> into any other physical quantity. This patch add support for temperature

This patch add --> Add a

> to voltage (like the LTC2997) and temperature to current (like the
> AD590) linear transducers.
> In both cases these are assumed to be connected to a voltage ADC.

...

> +       rescale->numerator = MICRO;

Same comment, please double check we imply 10^-6 and not 10^6 here.

-- 
With Best Regards,
Andy Shevchenko
