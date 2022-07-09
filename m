Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229D56C505
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiGIAJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGIAJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:09:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD717A50F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:09:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so182433eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Kre5cz4l5Tf0VTuUpoElE2gdZV8MsECS9JN4JXo2R0=;
        b=AWRq3jVXftz43iikcTXj5ErIBHPO5xGsl61/iSsZIJgeaDyYrxrJ+CqcvHKgmtLnNi
         DoW3+TTA3MSV8dJIUvWq30swSalzhV6PCcy5pjFV/0nX/tFxotW7Jl8/pmlJMYBONup3
         Hyzv4uyk819g0FkPUZKKmRV/1qePIFc4RsIHIVxV5lJXPgdL5Hh1gKSpy2v/xy6cETJ+
         1OxYO3cxNck6zBKvKAlkxpZzOc4ehfk1xHKXQjmkySFk2AClxze0j4x4Vy3o2Qka7947
         0Q9ur+SoQsaTA2jrpl8EJpTJgTY6D5e5mlGCwySnL3x/TfcZ2QX+AkRC+sW52K1oQB4E
         GV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Kre5cz4l5Tf0VTuUpoElE2gdZV8MsECS9JN4JXo2R0=;
        b=zVsoonQXjL5YifghUZhKvydacrd9UH6hdpvF3Uqooc2hpyNOjyx7bFAr06sip2mTQJ
         fD9jBVBVfjltwD0HpGLuggGaYIM+XHcxvRHUjGfCRI1u3IL8OTzGUd8XWB8jptMKZJcm
         zgxib8ZZT6sOYoHfCbzrwS1gXbOwgc6Vv0+JM82w1YtfI79cJcWWcjK6Efk5fAqx4DUe
         w1dGLi1PbR52GyAkDzyaVBsDOfMTjA56NBaDv5ogJB5xuYNva4apeLyBQOoGa8yn5VYk
         smYH92ESY21zyQMcqDj/PKpnpnPEu343w/5EC+EJWnZl5FEA3Hcw4GW8y5O2j8OckPdL
         WyYQ==
X-Gm-Message-State: AJIora+7ZMGTU9N629B7qUl/HYN9C8noFALBJHkk3ZLo4EcbmZ/M+Im1
        C3M0cH2TPG0RIE2JKvZTerlt08Anh/2w3PQbFnKQqg==
X-Google-Smtp-Source: AGRyM1t0nY+KGPSZvS28pWTlJJjpkvrJngzngq9dm5rNV1Y6hdJx8eIZiDUw3C4gkDHMadOpmMGuXwSg+LEhnasix/c=
X-Received: by 2002:a17:906:8a45:b0:72b:31d4:d537 with SMTP id
 gx5-20020a1709068a4500b0072b31d4d537mr2312274ejc.170.1657325375105; Fri, 08
 Jul 2022 17:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220708232653.556488-1-justinstitt@google.com> <CAKwvOdnhzwg0OswLc+RwgX0=Z4beF6EEO09w8Ezdhg-YyXQeJg@mail.gmail.com>
In-Reply-To: <CAKwvOdnhzwg0OswLc+RwgX0=Z4beF6EEO09w8Ezdhg-YyXQeJg@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 8 Jul 2022 17:09:24 -0700
Message-ID: <CAFhGd8rCXR=Vq918tN0KDgzohuDhR=YAYvbXmG6rqKsXU-BnkQ@mail.gmail.com>
Subject: Re: [PATCH] amd-xgbe: fix clang -Wformat warnings
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 4:48 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Jul 8, 2022 at 4:27 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > When building with Clang we encounter the following warning:
> > | drivers/net/ethernet/amd/xgbe/xgbe-dcb.c:234:42: error: format specifies
> > | type 'unsigned char' but the argument has type '__u16' (aka 'unsigned
> > | short') [-Werror,-Wformat] pfc->pfc_cap, pfc->pfc_en, pfc->mbc,
> > | pfc->delay);
> >
> > pfc->pfc_cap , pfc->pfc_cn, pfc->mbc are all of type `u8` while pfc->delay is
> > of type `u16`. The correct format specifiers `%hh[u|x]` were used for
> > the first three but not for pfc->delay, which is causing the warning
> > above.
> >
> > Variadic functions (printf-like) undergo default argument promotion.
> > Documentation/core-api/printk-formats.rst specifically recommends using
> > the promoted-to-type's format flag. In this case `%d` (or `%x` to
> > maintain hex representation) should be used since both u8's and u16's
> > are fully representable by an int.
> >
> > Moreover, C11 6.3.1.1 states:
> > (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf) `If an int
> > can represent all values of the original type ..., the value is
> > converted to an int; otherwise, it is converted to an unsigned int.
> > These are called the integer promotions.`
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thanks for the patch, this fixes an instance of -Wformat I observe for
> x86_64 allmodconfig.  I thought you had already fixed this file up?
> https://lore.kernel.org/llvm/20220607191119.20686-1-jstitt007@gmail.com/
> which was merged. I'm guessing that was from a defconfig, while this
> was from an allmodconfig?
> Seems like there's a bunch of config ifdef'ery around the definition
> of netif_dbg.

Definitely different across configs but ALSO files are
ever-so-slightly different:
amd/xgbe/xgbe-drv.c      _v.s_      amd/xgbe/xgbe-dcb.c

>
> Either way, thanks for the patches and
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> > For clarification, the first three parameters given to netif_dbg did NOT
> > cause a -Wformat warning. I changed them simply to follow what the
> > standard and documentation recommend.
> >
> >  drivers/net/ethernet/amd/xgbe/xgbe-dcb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c b/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
> > index 895d35639129..c68ace804e37 100644
> > --- a/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
> > +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
> > @@ -230,7 +230,7 @@ static int xgbe_dcb_ieee_setpfc(struct net_device *netdev,
> >         struct xgbe_prv_data *pdata = netdev_priv(netdev);
> >
> >         netif_dbg(pdata, drv, netdev,
> > -                 "cap=%hhu, en=%#hhx, mbc=%hhu, delay=%hhu\n",
> > +                 "cap=%d, en=%#x, mbc=%d, delay=%d\n",
> >                   pfc->pfc_cap, pfc->pfc_en, pfc->mbc, pfc->delay);
> >
> >         /* Check PFC for supported number of traffic classes */
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
