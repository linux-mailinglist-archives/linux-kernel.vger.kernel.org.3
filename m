Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2285A610F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiH3Ksl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiH3Ksf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:48:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9269ADCFD8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:48:34 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i77so8859568ioa.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D+Zr5m06Dz7pd1eCr8Zp9JUK+jm0toq4g0HWVGImRYA=;
        b=abgFhPl46C8ei+7f36OH7DAnCzAMmjSmJbnkvTvPumKxM3f1C6WzRbefKGvkLMtYsA
         NxpwF8HNjVwrUZ6K95DrwmzLJHXoauPusJCJ4avSH0MRD+rplq5ciQoaVkW+htEFWz4W
         sYCigAomDmWEBjn4ZQLux3KreIkC02bze3h9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D+Zr5m06Dz7pd1eCr8Zp9JUK+jm0toq4g0HWVGImRYA=;
        b=T2PmgJp2mHgcM+2THcg9zo4ikDpAXOqPQa/5Fe/EGr0R8Rz+MT7zNHeIV2sIbUaqrw
         AGYwxCfmkJTQ8p9kkRd2gbXQqKF4FbH6M+vur3CPo8H7sn3ALz6LfVF6QRlCcwBKs8TU
         juxuikyeB1CSzQ3+dJiYW9AmryY42M4ciEirIYf7IHAMTHRqqjifEIHsugitD/XfyAFY
         lQcNCxvDicYkXYej/H0pudmfh09Oyc67xftg46Hq/cmHh67NZ3nHD2RCrSJQpTS8AqT+
         Mx1iCLdl1ZVo9fbo62h5BEckdpnbd+x74dFe/gYl8wmJgdM1+p0IM6Yf7aTxU/pLAM5j
         DfeA==
X-Gm-Message-State: ACgBeo3NSm/ico/78tmxZMsabiaDp+D7kRVQz88uSAfGl/bUstEevbp+
        Gbf8kkXlMcitohhiiNLX2yp7Hp30u7o9VyloTdJAbQ==
X-Google-Smtp-Source: AA6agR6iliUyUmz+S8kqdlyWYTe+420xcq+qusgU+R+5fk0mgQgTG3lhPxjIa7eRDTILKtYwB+ryOdEjtuc+NxjSFFc=
X-Received: by 2002:a05:6602:15ce:b0:688:e4fd:bbfc with SMTP id
 f14-20020a05660215ce00b00688e4fdbbfcmr10180294iow.121.1661856513754; Tue, 30
 Aug 2022 03:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220729165954.991-1-ignat@cloudflare.com> <Yv9dvvy0rK/1T0sU@gondor.apana.org.au>
 <CALrw=nEh7LX3DSCa3FTu8BYr4QWx+W2h3Jei9Qo67+XXH-Vegw@mail.gmail.com> <Yw3Rneo6Ik1QEfbG@gondor.apana.org.au>
In-Reply-To: <Yw3Rneo6Ik1QEfbG@gondor.apana.org.au>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 30 Aug 2022 11:48:23 +0100
Message-ID: <CALrw=nGJgMACrFVy+FVVCDb4H3wNUN2E-GLZaXzLsm3ReOUeVg@mail.gmail.com>
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

On Tue, Aug 30, 2022 at 10:00 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Aug 29, 2022 at 11:48:23AM +0100, Ignat Korchagin wrote:
> >
> > I can only elaborate here as I didn't encounter any real-world
> > use-cases, but may assume some limited crypto hardware device, which
> > may somehow "encourage" doing public key operations in software and
> > providing only "private-key" operations due to its limited resources.
>
> In general if a hardware is missing a piece of the functinoality
> required by the API then it should implement a software fallback.
>
> The only time such a NULL helper would make sense if an algorithm
> had no public key.

I vaguely remember some initial research in quantum-resistant
signatures, which used HMAC for "signing" thus don't have any public
keys. But it is way beyond my expertise to comment on the practicality
and availability of such schemes.

I'm more concerned here about a buggy "third-party" RSA driver, which
may not implement the callback and which gets prioritised by the
framework, thus giving the ability to trigger a NULL-ptr dereference
from userspace via keyctl(2). I think the Crypto API framework should
be a bit more robust to handle such a case, but I also understand that
there are a lot of "if"s in this scenario and we can say it is up to
crypto driver not to be buggy. Therefore, consider my opinion as not
strong and I can post a v2, which does not provide a default stub for
set_pub_key, if you prefer.

Ignat
