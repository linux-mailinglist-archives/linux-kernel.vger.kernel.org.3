Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421AC489D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiAJQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbiAJQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:29:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A7C06173F;
        Mon, 10 Jan 2022 08:29:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m4so14278537edb.10;
        Mon, 10 Jan 2022 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tb2UIfWjrHZNv93aEu9rRuoPC63dB0IOjiFEuqXiHHs=;
        b=YP+mwUSIyxtVNPh+ciU4S/WCAbXK/HhJUvPwvlKSflyMPB4tHCq97iawOHhC6pbuP6
         WaQdHHYJN/uksFJZ7eqSqMeTPoIVy1tz63153EscV/aKw+sFO/lJA8sp2Ye+FrzMuYxE
         c+VOEPMjuIWSV2+k7rHygm8iINBc0p/KRaCMX/r1b+n/Vd6MkJgH2Z8SNOUAz1nHj7G9
         4B0IkNV3YUOBgm2dr2yPluTAgauCmQd0J3A7A9fxs5WLA8Hk58L6XyunJ5TLmZnhlf5z
         d6gIb8m1tOpHyPaiVPTkSNXaVRgxFeMWOj/lEgHkvnkkd7IodoFU2Pcj8QlPEvCLKHNf
         ivYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tb2UIfWjrHZNv93aEu9rRuoPC63dB0IOjiFEuqXiHHs=;
        b=G7se0q/gRveRXF60SlxNSHz7+wvHcfj0xApmapPyqFwVlfMib7UIpoQTunWakNMVDb
         TPZ3tMvWz/SCYGnJAl/iDEOc2kLzxIqMctiZFzPDKAwhsgJE4V4ZB9SDCOLnhCFPoWDX
         kk8GLOVVkGZC92NpFd51afAiBrWiOk30xZ6bHXBTHSqyfzVZQy5Bu15LxJ8jdMlhhJMV
         kxw+No6nFvKMVtl1lxRCf8p3PssN+GUqPrvcsb3xWgQfXdym7Ldn7bQ+tDh2KWk4qdrw
         eVpZe+roPXrfDiOiT06jakKFi8OEPvNVu1wE8ol64wCm/4KXKblGehomZAQN4dwYW4x8
         a1kw==
X-Gm-Message-State: AOAM533DtrJER38h4hP0DaKvBbT6GjdQwMTw14O2jGaDwQJAmSDX6rmA
        14U1CmtsnzaUxKHcPUaaJhHiize9EflXdbOFLZU=
X-Google-Smtp-Source: ABdhPJy2HJD38OHa/NU4I45gvByn7J2E8iqhT1RF1Wdjsys5HacppqFQGZAZlwUn1KMRt+/9HVp+ZBcIzaDyTEqvu9U=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr409353eds.77.1641832145876;
 Mon, 10 Jan 2022 08:29:05 -0800 (PST)
MIME-Version: 1.0
References: <YSy/PFrem+a7npBy@gmail.com> <CAOMZO5D0m1xCfgFifKz1H+oYQSfxsfuZp4U39rPMACmzv1fvjQ@mail.gmail.com>
In-Reply-To: <CAOMZO5D0m1xCfgFifKz1H+oYQSfxsfuZp4U39rPMACmzv1fvjQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 10 Jan 2022 13:28:54 -0300
Message-ID: <CAOMZO5BkFf1HYbe86nGjnx=w6Lj16fP2u=t233aBv85LAokdmA@mail.gmail.com>
Subject: Re: HRNG in CAAM isn't working properly on IMX6 SoloX
To:     Fredrik Yhlen <fredrik.yhlen@endian.se>,
        Horia Geanta Neag <horia.geanta@nxp.com>
Cc:     Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horia,

On Mon, Aug 30, 2021 at 8:49 AM Fabio Estevam <festevam@gmail.com> wrote:

> We also observe this issue.
>
> Heiko on Cc tried increasing the RTSDCTL_ENT_DLY_MIN value
> and this seems to help:
>
> diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
> index af61f3a2c0d4..53c9fa04a24c 100644
> --- a/drivers/crypto/caam/regs.h
> +++ b/drivers/crypto/caam/regs.h
> @@ -513,7 +513,7 @@ struct rng4tst {
>   };
>  #define RTSDCTL_ENT_DLY_SHIFT 16
>  #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
> -#define RTSDCTL_ENT_DLY_MIN 3200
> +#define RTSDCTL_ENT_DLY_MIN 4800
>  #define RTSDCTL_ENT_DLY_MAX 12800
>   u32 rtsdctl; /* seed control register */
>   union {

Even with the change above we get the following errors on a
imx6sx-based board running 5.10.y:

[    0.918126] caam 2100000.crypto: registering rng-caam
[   22.598192] caam_jr 2101000.jr: 2000025b: CCB: desc idx 2: RNG:
Hardware error
[   22.598260] caam_jr 2101000.jr: 20003c5b: CCB: desc idx 60: RNG:
Hardware error
[   22.598324] caam_jr 2101000.jr: 20003c5b: CCB: desc idx 60: RNG:
Hardware error
[   22.598368] caam_jr 2101000.jr: 20003c5b: CCB: desc idx 60: RNG:
Hardware error

What is the proper way to fix this issue?

Thanks,

Fabio Estevam
