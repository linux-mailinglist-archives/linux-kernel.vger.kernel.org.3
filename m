Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17D56BA00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiGHMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiGHMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C5B057238
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657284427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dE7am2qZLWCC7z65J2aM6/B2V9+Pl8ooChSgECZZn1k=;
        b=AosZpzKWR+iqHiXmQFkUnGRJ82eZzEyRwlmTSkdWReFeVHQ2DJQ7a9EBY1ripC5WnOvYhb
        5C4gH/R3aa0JSJ2ow3glzv/PXy0Xc+gNcBxM7wNnJ1yx0Sf3CUVtCXAXg0/YUrjoVU6TOt
        /JX4+1Md9d1751/Ih2g9gsx89St8D2o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-inQJhO0FPyieZiuvM-V42w-1; Fri, 08 Jul 2022 08:47:03 -0400
X-MC-Unique: inQJhO0FPyieZiuvM-V42w-1
Received: by mail-ed1-f72.google.com with SMTP id s1-20020a056402520100b00439658fad14so16373083edd.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 05:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dE7am2qZLWCC7z65J2aM6/B2V9+Pl8ooChSgECZZn1k=;
        b=snH9xZqh/KsiY/EeYPP8Gu2SDuKzhfHEa25gNnbwLHrvPBSNmOuWH1PzHIWeX/lUmP
         hfEkQTt8eO9sQV05HddQ2DeT9mmyxWx4e881D1QbxUwDfF7jjJox+RhyefMSuzSsekEs
         M/iIJkXpZS+e5yk8kE2xbx+lBYC8Aq/faTR+iVJ+31oYVPNLKGKY0UvhHu6vM125EYg+
         zDfK3VXapLr2g9ql5NDNhyLcv9GNzfR2gssUdHMNz7VWwBPudPa/dZfx2c5EoeVDY51P
         cG+tecAQ6vpM7ysIKF22xTYnFmXE2P1IbhYE52ZD8I4x2M8xoSPPlEK1+HkPx6mQw6pU
         fJ0g==
X-Gm-Message-State: AJIora82JtiDOQmbjmsJQ687AJMEnZ3QGcDc4OYjmk/ca9Br1FeAIj8D
        2Av5uJbYgokJexNnYn7VIjCmuhxKg2m7epY6U8KAi/lbFn6RKkpq9Cwr6cUSna7StpiZkZLk1nm
        yAdi2kn2I0a9cH8oTNDue7rn5uarNH7sTxnL1wmM3
X-Received: by 2002:a05:6402:3551:b0:43a:a5c0:2fbc with SMTP id f17-20020a056402355100b0043aa5c02fbcmr4533859edd.288.1657284422067;
        Fri, 08 Jul 2022 05:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0baia0qjnBRPMWggkVJVUHjsBDBJIk0iKohafPMy/4sJgj8fQu1EU9tbAdY4QzjAnUHsY+KoFz7Su7AFx8yk=
X-Received: by 2002:a05:6402:3551:b0:43a:a5c0:2fbc with SMTP id
 f17-20020a056402355100b0043aa5c02fbcmr4533846edd.288.1657284421915; Fri, 08
 Jul 2022 05:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220620131618.952133-1-vdronov@redhat.com> <20220627195144.976741-1-vdronov@redhat.com>
 <YsfappxjOaj99WEV@gondor.apana.org.au>
In-Reply-To: <YsfappxjOaj99WEV@gondor.apana.org.au>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Fri, 8 Jul 2022 14:46:51 +0200
Message-ID: <CAMusb+Q=Y8CSAnHDF3W56s=SvqNKYV=EYQ9+J=Me35mCA8ZYig@mail.gmail.com>
Subject: Re: [PATCH v3] crypto: fips - make proc files report fips module name
 and version
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Simo Sorce <simo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Herbert,

On Fri, Jul 8, 2022 at 10:27 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Jun 27, 2022 at 09:51:44PM +0200, Vladis Dronov wrote:
> >
> > diff --git a/crypto/fips.c b/crypto/fips.c
> > index 7b1d8caee669..d820f83cb878 100644
> > --- a/crypto/fips.c
> > +++ b/crypto/fips.c
> > @@ -30,13 +30,37 @@ static int fips_enable(char *str)
> >
> >  __setup("fips=", fips_enable);
> >
> > +#define FIPS_MODULE_NAME CONFIG_CRYPTO_FIPS_NAME
> > +#ifdef CONFIG_CRYPTO_FIPS_CUSTOM_VERSION
> > +#define FIPS_MODULE_VERSION CONFIG_CRYPTO_FIPS_VERSION
> > +#else
> > +#define FIPS_MODULE_VERSION UTS_RELEASE
> > +#endif
> > +
> > +static char fips_name[] = FIPS_MODULE_NAME;
> > +static char fips_version[] = FIPS_MODULE_VERSION;
>
> This doesn't compile for me because you need to include
> generated/utsrelease.h.

Dang, it does not build now indeed. I'm not sure how my previous
build succeeded so I've assumed utsrelease.h is included in fips.c
via some other .h file.

I've posted v4 to this same thread below, it just adds the "#include
<generated/utsrelease.h>" line.

I'm sorry for the noise.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

