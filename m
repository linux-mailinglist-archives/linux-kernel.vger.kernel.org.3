Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891174A8603
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbiBCOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiBCOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:18:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD75C061714;
        Thu,  3 Feb 2022 06:18:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p15so9310021ejc.7;
        Thu, 03 Feb 2022 06:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dhJnZ8FiFenFf/QVcZDF5PExKtMBcbR901XeUZhtQpE=;
        b=FSyeyUghSHrnm3Ukzc9OuvivZXPnQfVk2Lfi1hhAJ5wwsk2d5DBMSvSz6Uho7/7c+/
         9SfCDCqkFqXXx2BW6DSA1Kaeh91bKeVXSnqGl5VywPWALVB3XsD6wBEiAlx1TiRgDkgD
         NoY0LZ8YT/QLoArkyMPRSH0I9mWEvgCgFInoWEssiWzRsR9+L8qsNEfrlJYRUIT2UjEo
         4OgR73RRfI4m8cvmQwWAIBmSKj5s1IrwPWBPm77lCGUks/l4ixqh8TLd69OI2NUpFJou
         3z6KVhmzsP1hd6RO9sM+WABpCJd2TW6hojc2UlWD5Fjidm9FZ6MXllqrT2H3D+6//cZA
         Igdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dhJnZ8FiFenFf/QVcZDF5PExKtMBcbR901XeUZhtQpE=;
        b=FJWWnXMVm1QnYRnt8ek/A2siPCz/nQm9Ol434qOvJn/u57R7U0bTI/nCEu4YAd7ZmM
         oFl1QVRksuaV+YQVbxuF3skmqUfMa6WPoJjjBEBU3/O4GZBggcees+wuOvO7beH/WJTu
         XC40FXBrI/mGAGbfyetrPNJYdXXAEKDdNVrhRiLazMvtZJ6ToeiVJEZyHlnZrO5TjCjP
         Y9QTUOlZhU8S6q9Rf7ql+EyX+cAyFaUDzamWhGF3E6FZQKcCIH2ngnuwW0lRmH8CaWDU
         oR8WvMcdCv1fC31aK76b+QjE9B4/P/HhkwRIpbrCTyqFlhnUIy0+9YtNsgDA1vKlFZgZ
         mwtQ==
X-Gm-Message-State: AOAM531NVh7srDlcnB52c+qKlPCkKn7HcgDEmg75Dz0GvXC7hRRvfiXM
        rx2jjCUT9312XbMoxZuuaeBAB2P1c5PQOqEtwpsX5OTnHmQhcw==
X-Google-Smtp-Source: ABdhPJwuIUg9TosbjJM4Qn4asT3/1NvGEHIVjromCf+JHFUQmLOIEe2LKK64aHHmj3b6N93AX17tBNoTR5JAjEAsAXo=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr30033151ejc.132.1643897911125;
 Thu, 03 Feb 2022 06:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20220203133736.246397-1-j.neuschaefer@gmx.net> <20220203133736.246397-2-j.neuschaefer@gmx.net>
In-Reply-To: <20220203133736.246397-2-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Feb 2022 16:16:56 +0200
Message-ID: <CAHp75VfrygdyjgQJ7iRnGL-CELCQ+6D30r5aWwitCTUJvGVf_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: nuvoton: npcm7xx: Use %zd printk format
 for ARRAY_SIZE()
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        kernel test robot <lkp@intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 3:37 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> When compile-testing on 64-bit architectures, GCC complains about the
> mismatch of types between the %d format specifier and value returned by
> ARRAY_LENGTH(). Use %zd, which is correct everywhere.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 3b588e43ee5c7 ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO dri=
ver")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> -       dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups)=
);
> +       dev_dbg(npcm->dev, "group size: %zd\n", ARRAY_SIZE(npcm7xx_groups=
));

Dunno how it's slipped away, but the proper specifier is %zu. I guess
that's what I also mentioned in reply to LKP's report.

--=20
With Best Regards,
Andy Shevchenko
