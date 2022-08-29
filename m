Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5995A4783
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiH2Ksp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiH2Ksi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:48:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8595AA06
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:48:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i77so6192727ioa.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6eEhRyK8tN1mfI2AWsGzTZ1EUrn0gEvL2xA2WQ+MKj0=;
        b=i1WalOLcijhyVYUdO8039B4A6ay+Zlf40F54H7uq4GpTD5HdY7G8Bwfh7cf75YCfP2
         zWx2gXj1Fso4mvLE3U1MBEMkqLkbTz97hIn5T9pEIeA02u4N6mJ8mUW3lqJUdXu6r6i+
         Tyt5pqILw1IEX/msz5o7/wsPZvqj9BpiIjjG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6eEhRyK8tN1mfI2AWsGzTZ1EUrn0gEvL2xA2WQ+MKj0=;
        b=YMBZ2FUsDDxw+rJBaU5Uri3IsH6oWfd54FFnkEt4ty5wxzJ2TfxNMfMuJn1oQY7tpq
         wC+NOTY3Ci6MAvFIyrH4dbiHEDzxORzvaYARfR9TR4S9Pk0aQB5j33jcX0UR0kVmU6g0
         oIaxHmWSjO04ZvgLzVXlG7zV1XaIoBjaZUVMtUTakNEcs+xTMeRvpcJf5pWOlTFYRjbk
         5Ux3ksI6TP80LXqRHCaaciP2S9HpAS0nfiuzDhekJCYwDfweCR3OjYh+2LJXjxKS7U2x
         p3w7ZCc03YNRGzug1ETC44yxt1nk/gkbN359GN0nb3+KO0CaEJETMnYzKTFrDnBhc/mF
         8MNg==
X-Gm-Message-State: ACgBeo2yHTSXBWJVe/w/ss5LNLn/FRvEP8zVMSxEfZH0aiT3vhD3IItz
        YNboXzVx+77Kpi83TlsELohJu2u/WjJ3EbK+otCvfg==
X-Google-Smtp-Source: AA6agR4REKnRoTZDrAnY0rribqVHuCqe5bvTvVYBr3N5m+fmepZ+EGusZxIoSzIdJoax9PbGfq9c2KBrxkiPll/Bh2s=
X-Received: by 2002:a05:6638:1686:b0:346:a3a5:638d with SMTP id
 f6-20020a056638168600b00346a3a5638dmr9844031jat.0.1661770113770; Mon, 29 Aug
 2022 03:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220729165954.991-1-ignat@cloudflare.com> <Yv9dvvy0rK/1T0sU@gondor.apana.org.au>
In-Reply-To: <Yv9dvvy0rK/1T0sU@gondor.apana.org.au>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 29 Aug 2022 11:48:23 +0100
Message-ID: <CALrw=nEh7LX3DSCa3FTu8BYr4QWx+W2h3Jei9Qo67+XXH-Vegw@mail.gmail.com>
Subject: Re: [PATCH] crypto: akcipher - default implementations for setting
 private/public keys
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:54 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jul 29, 2022 at 05:59:54PM +0100, Ignat Korchagin wrote:
> >
> > @@ -132,6 +138,10 @@ int crypto_register_akcipher(struct akcipher_alg *alg)
> >               alg->encrypt = akcipher_default_op;
> >       if (!alg->decrypt)
> >               alg->decrypt = akcipher_default_op;
> > +     if (!alg->set_priv_key)
> > +             alg->set_priv_key = akcipher_default_set_key;
> > +     if (!alg->set_pub_key)
> > +             alg->set_pub_key = akcipher_default_set_key;
>
> Under what circumstances could we have an algorithm without a
> set_pub_key function?

I can only elaborate here as I didn't encounter any real-world
use-cases, but may assume some limited crypto hardware device, which
may somehow "encourage" doing public key operations in software and
providing only "private-key" operations due to its limited resources.

Ignat

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
