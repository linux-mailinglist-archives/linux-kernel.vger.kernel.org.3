Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D3647AA73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhLTNiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLTNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:38:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A60C061574;
        Mon, 20 Dec 2021 05:38:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y22so38520683edq.2;
        Mon, 20 Dec 2021 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZ7XPuXV66Jqd4yktH2bq7HDzowfU96jgj/+7vaR+nY=;
        b=MJzyq/LGmPIRQy0STlRjvtQdLjx8CIioY/mfkFOVgZUXM5aBzD2HhbRUrL1ZfwVv//
         +4J3i6pssepGJXCAN06xHDMMWkFZidh9mJvvA41wiK+A3gRqvW88Zkj+lBU6YKeAoqz9
         VKGVza7f+myoT5f6PkC6GjPmYgE5WGhnljNLMeO97b9biLwhaIT7vA7l9kpjxfDIN0Lv
         ldFJ6eyYZPGOVW6uDqj8L+y8Pc/IVVPDad5CJLW+sLQBv3E38eHwRLYCb0nHDwJnfLSx
         rlVAGyv3Hk2pqE7X1v9b4pXaL7BekDmMs8dtv+qjrSx1k2bJ3TlQzwGPkeMrDXNZpziP
         2P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZ7XPuXV66Jqd4yktH2bq7HDzowfU96jgj/+7vaR+nY=;
        b=cUFDmIN405NJVYyWvNuWIN34barMOZO104HsOliHgu+ZkdhG7XansJ/Fdzq+X3QfzQ
         YFAIq4jfp+ytJY57RreztMdD2erdclyWAj+pz7rSIKm+4/OVIaO19n6n5ti1S5EVN5Z5
         B41tu0CzwzwCA1kaKiVI7y+raOB37OJqD7+D8lhSeHj0lhZIb8+rgmW+MzXT3cRe+h0I
         qUXZ7cMFTz5Q6O9PmnonVXgZnHeT5/4AaCEahmo0gX2eRSpCROwXO06SP2nM5tIcPsdK
         /cSDuzJ4sZjIKNLYpmeowd+PkCn3CXeQD2CSj14iDxCalXzEhznx1mTLyysUiVYKKXiP
         cMGA==
X-Gm-Message-State: AOAM531o5NC457GtHF8QQidMhI03yCBO9fwLYCvF8ahvJiQMF/DPS92L
        KLVeE/gxC581Y2R5puKQr1wWQm16+6RkfWSXllbuvwHerGMQrQ==
X-Google-Smtp-Source: ABdhPJxZ0uY0+ofRoFHD/DKg7ZL0Ib40Gi3sN8JCT6HUd5ATa98YKaZeKEkZSA5hIyM1duQSb9aNJxzJVxIRNSw/MG8=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr7499564ejc.132.1640007492838;
 Mon, 20 Dec 2021 05:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <CACRpkdaLt8O4ONZL0vY44gMbuSR_tT3Gkbh9f3sg7m23tUKO2g@mail.gmail.com>
In-Reply-To: <CACRpkdaLt8O4ONZL0vY44gMbuSR_tT3Gkbh9f3sg7m23tUKO2g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Dec 2021 15:36:13 +0200
Message-ID: <CAHp75VfC6mED_yGrHR4Gv3ykL-ckC89s3to5MtW+WSbUPLT0KA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpio: msc313: Add gpio support for ssd20xd
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:05 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Dec 13, 2021 at 10:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> > As suggested by Linus I have dropped the DTS commits that were
> > in the series to add a usage of this code to a target.
> > If possible can you take the first 4 commits for the GPIO driver
> > for me? The final DTS commit will go via our tree.
>
> Looks to me like patches 1-4 are good to go, but Bartosz
> must decide if he wants to merge this late in the development
> cycle.

JFYI, it will be rc8.

-- 
With Best Regards,
Andy Shevchenko
