Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A645047D72D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbhLVSv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbhLVSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:51:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D243C061574;
        Wed, 22 Dec 2021 10:51:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so12253824edb.5;
        Wed, 22 Dec 2021 10:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYTh2CwssS/3FtePDunwZjTT7AQdZfmbx8r4C9A/7rk=;
        b=NkCq+PT+dxAtqEM4hO3GIGerh5pEAHRJ/tvQvHEAIqTVPFb1VzvT5vbB/p603Mc3TX
         Ma5ejfdhhqTPhqiK+LanVD9cR6xKmKUWkgKx68Qr33HeuZeEgsDo5oJ0xhAuWKjD82XY
         uPK9MpnzYeaiZfev1navurWuAW/b2be/zz1EFNhb/l6N7BHAY1r+mdJcK0z4piVR3Swz
         Qc4KJqFuNZBxbocb0TcAIRAJgfMadSLBGB63cJfqxoTo6t2J6tdEOdbL7NIx5kKq9uyd
         rGIU+f4MRcwGnDTl9W5JY7YUL8TJFgLbQZgUHQ5gxobtloyQqPkEj4zCxsIyp0ynaYoU
         EVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYTh2CwssS/3FtePDunwZjTT7AQdZfmbx8r4C9A/7rk=;
        b=BEN3X0XVKFRXQpVUtoa1+1PYYUNEqhbxCPW171Hg2QjntrRZjHTcYmx8KrcXGZ8Pbr
         kPQCxcU9ln3h6xNJI4+tcjdagZ10Xxw61WfTxJ+cRn/YEbaFcNTNQxViDDkADEbu6eSJ
         M0bgkeG+fG42l/jQ6DEH3ucNBRhH2Q9GyIeZjwvYtngnt+2qutlqPNPpfTCm9pWZMg3R
         DiTqjUmrRUThvp+Tfm5o5zhGldAFrF6fhROdz+yY7oscEKn4GWEU3fQ3JyGYTq6w/yTK
         QKcdwfLzgxG0aihjWjp3iI21RwA+IGtz7+0KsODjgIktuv2YZWwPM53J4Mo3l484I7yy
         cpOw==
X-Gm-Message-State: AOAM532y2bNI5UaZzBuEwnkdxpXAJhKJs4izTrq72hg9uwyyZ7kVvSvk
        5F4NXSiHeMeyPRMF+yVZrm8uWayiHxYzYQBHVNQ=
X-Google-Smtp-Source: ABdhPJyCRsdCg1paGM0b6KJFzrwBvF+whD52FtJVNqLzVlcBfwUrtUieqKtiF4oFQWciu1uukzbB/kN0jiZfv0E3pl4=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr2183968ejc.497.1640199084990;
 Wed, 22 Dec 2021 10:51:24 -0800 (PST)
MIME-Version: 1.0
References: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 20:49:26 +0200
Message-ID: <CAHp75VcU8B8fydh874p6HpgGXXRYvNGdphH=i17JHB3DYJ1JZQ@mail.gmail.com>
Subject: Re: [PATCH] drivers:iio:dac make expression evaluation 64-bit
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mihail Chindris <mihail.chindris@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:59 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Two 32-bit values are being evaluated using 32-bit arithmetic and then
> passed to s64 type. It is wrong. Expression should be evaluated using
> 64-bit arithmetic and then passed.

...

>         dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
>                                                         65536);

Shouldn't the above be fixed as well? Has anybody tried to compile on
32-bit arch this?

> -       dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536, span, &rem);
> +       dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536L, span, &rem);
>         tmp = (s64)rem * 1000000;
>         dac->ch_data[ch].offset_dec = div_s64(tmp, span);
>  }

-- 
With Best Regards,
Andy Shevchenko
