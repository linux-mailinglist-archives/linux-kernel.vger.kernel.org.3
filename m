Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C4488949
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiAIMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiAIMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:14:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57F8C06173F;
        Sun,  9 Jan 2022 04:14:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q25so33616238edb.2;
        Sun, 09 Jan 2022 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ODzzEtdzx+BLKoHw0Ew8QLVtY3SVHT6OOV7UeJFfcg=;
        b=P3MeS9UhL7JO3PCCFgx4ITcvl5JyUGA7PO0YbQ7bmjxlrRfTJ64yj6LpoC2/Essyqr
         QU7+K/cEWBEAn/5SGL5Zr6usiHGrFDpg6nBM02SvjHVeYsNf9tV3skpg8puOlNXcGtC0
         nA6JluQjJjyQhWC7Hd1P/J1UDGeyVvzy87cIuf1rfF72wV5oEvvTOGJSrB76P0uwbtEM
         U8/2vi8/nfv1nn9xXwJFK2pU2l0YtYLELAT0gXb+cUoI+4RJ3cwVAhcMIq8WWmnY4xNu
         UuPwgkCNzwZhGpx89yvBKAiFBXgHAcf1N+5y0SvoUmeT+5BfiWOx+B09waJ5HJC6B3e3
         8viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ODzzEtdzx+BLKoHw0Ew8QLVtY3SVHT6OOV7UeJFfcg=;
        b=X+TCKLNpzPJhPPTs5/6EkYE86IR9yovvmfbhC3NvFMhD7qGWtpyvHwCZNFAjMVJ7Re
         /fcq6SMjuljh6v9RdNW/DXhZzT6g9KkZHPVEDplDB5xmicNL9m4YtAZmDCM+uAQctuEp
         86XCWZ8DL49EJUji5HnwsoBe9vpgfA+w2BL6Wm1t93FtWu6imejLkiF7WQqlmaEYklMW
         riO/SLIHtkUEM5RFUZsjUI+DLXcJIn7ZIZv2XzE2Ft8T3WkE9qRWzXIwnUxhVKGwVYe8
         w6oRFmqQjBGxIGlP+wUwDeFoClsWY6+gwQiyf7SS3kUeWtYBsVD5xtT4S48hGzRXQ8Hg
         +pkA==
X-Gm-Message-State: AOAM530L+mwqsJejvxoF6rUlal607PdB/UHuTB53oWfx+n2mu1B4uCxu
        OHkFHUwhVKlwRrxtwUa5+a8BzuvXa1RNc/MTt8A=
X-Google-Smtp-Source: ABdhPJy+9tXir56/D7W5HXQcPbozaD3w093HKKc4pk0Hk+kyzQ50keWucatAcFNy1hsqx6nrEnhOCUZK5kGzq5VcZzA=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr56501013ejc.132.1641730482630;
 Sun, 09 Jan 2022 04:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
 <20220106062255.3208817-3-cosmin.tanislav@analog.com> <CAHp75Vcq76iaHHp2oXFsaE4d_+EGH87DxQRYu7Ys-adN_4mmUw@mail.gmail.com>
In-Reply-To: <CAHp75Vcq76iaHHp2oXFsaE4d_+EGH87DxQRYu7Ys-adN_4mmUw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 14:14:06 +0200
Message-ID: <CAHp75VeTNaMBZy-ZS68iKNq+GJNJgFSGxmcohr9-bGiN9KswSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: addac: ad74413r: correct comparator gpio getters
 mask usage
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 2:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 7, 2022 at 7:34 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:

> > +       bitmap_zero(bits, chip->ngpio);

> (At least this conditional can be replaced with __asign_bit() call,
> but I think refactoring the entire loop may reveal a better approach)

Switching to it makes bitmap_zero() redundant.

-- 
With Best Regards,
Andy Shevchenko
