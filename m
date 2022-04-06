Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5FE4F5C85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiDFLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiDFLbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:31:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC7569493
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:16:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g9so2768442ybf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HkJYbIHMqwQ6KzQhnlyh94SGyp2xoVLs+8NE9EwLMWg=;
        b=pdEzYhc3D/8vfTe+xdqkwb9W3OA/Nn+PUf/QQnIvGlmAtOLtscQNdTChoStLaXhp7w
         UGsnor+Lfy+KKJAjSprZoff8bCD1eJzNIIrQRFf2JV58NbWtPc8autMR22UrpsZtzjNQ
         KV5yhiEiLmLV6cl33VwIta9RFWffLigB+yC92XyfauYPSpV31pMdsceWG/Ra+dioaURH
         FPTNzss6/H8NxVDb/PlOg4Cb30+UOg1maqec3axzVXeL267MRChqwXDxsNHYsXxI2lfg
         zrsBihbByYHmTUwlv6kXBRCLKSj+MDxL9lNmHUD0wyDMmS0WnKv0A+jo9vIzaG9iuwvg
         +IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HkJYbIHMqwQ6KzQhnlyh94SGyp2xoVLs+8NE9EwLMWg=;
        b=hhrzwLGhkUMkAzuHQpKRHc9ekv3HN1skOpEcY25pF5bBqV2PPtD3HBfK/Y4cRgDi/0
         ZDiXItZEY7XihSkp/jN7u0CZmB20Vm+hBcSTlkaFtJ+xhMu+rV2iQt9veNiTlrXOmYHJ
         0PcmBXool/DcXonzTnsPPJe/EJ22ETDrFuieG3cwzwzpSvA3tB0jzIUcyqF+fO+HxnIf
         7VgIKhs3l1ibHIjxU1XRMNCn3NX6qnHfO7bGd4RwGPJAQ4eHNqQjXnR1awTC/niE0EUN
         hHUDW2Fqq/Ad5cnHEU9itjCVppiSydm2Fvch+MEMWabqi/Y918a7Sl5F1BFlpWnvmePG
         zJUw==
X-Gm-Message-State: AOAM530WSN+/EAnG38Sk917tiDJ1HnVS7OxpIDqHRXVZTFItkX6VIznz
        6ohfCzBOY9EyOAPdBza25NkZTicado4WsrVEZAvjGg==
X-Google-Smtp-Source: ABdhPJzMrCurQ3/dMDZuGfj7fAlAKqY4rSbL4z205qGDy3ZsS/DZmDyMXNksW5lk4Wmv7bQp7yblJKZ4p03bo7PF5HY=
X-Received: by 2002:a25:bfc9:0:b0:63d:a284:3616 with SMTP id
 q9-20020a25bfc9000000b0063da2843616mr5495810ybm.416.1649232986369; Wed, 06
 Apr 2022 01:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220326071159.56056-1-ebiggers@kernel.org> <CAOtvUMfpqxrdgmnzpkCW=EdUmquXYC6F=rwW+n8koJAt0Wg38g@mail.gmail.com>
 <YkuAaabISmyqcjoS@sol.localdomain>
In-Reply-To: <YkuAaabISmyqcjoS@sol.localdomain>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 6 Apr 2022 11:16:16 +0300
Message-ID: <CAOtvUMc3n0p8pcbrxTLYYWhpT=nQOQqEfXoB0DOJBoZUq7riPA@mail.gmail.com>
Subject: Re: [PATCH] crypto: testmgr - test in-place en/decryption with two sglists
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 2:34 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Mar 27, 2022 at 09:04:43AM +0300, Gilad Ben-Yossef wrote:
> > On Sat, Mar 26, 2022 at 10:13 AM Eric Biggers <ebiggers@kernel.org> wro=
te:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > As was established in the thread
> > > https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@be=
nyossef.com/T/#u,
> > > many crypto API users doing in-place en/decryption don't use the same
> > > scatterlist pointers for the source and destination, but rather use
> > > separate scatterlists that point to the same memory.  This case isn't
> > > tested by the self-tests, resulting in bugs.
> > >
> > > This is the natural usage of the crypto API in some cases, so requiri=
ng
> > > API users to avoid this usage is not reasonable.
> > >
> > > Therefore, update the self-tests to start testing this case.
> > >
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> >
> >
> > Thank you Eric.
> >
> > I have given this a lot of thought and here is what I predict will
> > happen thanks to this added test:
> > - We will not find a driver that this breaks, in the sense of
> > producing wrong results and triggering failure in this test.
> > - We probably will see drivers that when running this test when DMA
> > debug is compiled and enabled trigger the debug warning about double
> > DMA mapping of the same cache line.
> >
> > The reason is that these double mapping stemming from this test will
> > be from mapping the same buffer as source and destination.
> > As such, the situation that is the cause for the DMA debug warning, of
> > a mapping causing  cache flush invalidate, followed by DMA, followed
> > by another mapping causing cache flush/invalidate while the DMA is in
> > flight, will not happen. Instead we will have mapping ->
> > flush/invalidate -> another mapping -> flush/invalidate -> DMA ...
> >
> > Note, this is certainly not a claim we should not add this test! on
> > the contrary ...
> >
> > In fact, I would be tempted to claim that this means the real problem
> > is with an over zealous DMA debug logic. Unfortunately, I can think of
> > other scenarios where things are not so simple:
> >
> > For example, what happens if a crypto API user has a buffer, which it
> > divides into two parts, and then submit a crypto op on one part and
> > another crypto op on the 2nd part (say encrypt and hash, just as an
> > example). For the best of my knowledge, there is nothing forcing the
> > split between the two parts to fall on a cache line. This can cause a
> > double mapping of the same cache line - and this time the warning is
> > real, because we are not guaranteed a single DMA operation following
> > the two mappings. There is nothing much a crypto driver can do even -
> > the two operations don't have to be done by the same driver at all...
> >
> > I believe the scenario you are proposing to test is a benign example
> > of a larger issue. I also believe this is an example of Worse in
> > Better* and that the right solution is to dictate certain rules on the
> > callers of the crypto API. Whether these rules should or should not
> > include a limitation of not passing the same buffer via two different
> > scatter gather list to the same crypto op is debatable, but I think we
> > cannot run away from defining some rules.
> >
> > I would really love for others to voice an opinion on this. It seems a
> > rather narrow discussion so far between the two of us on what I feel
> > is  a broader issue.
>
> I don't have an answer, sorry.
>
> I personally don't actually have a lot of interest in the crypto accelera=
tor
> support in the crypto API, since in the domain I work in (storage encrypt=
ion)
> it's much more common for inline encryption hardware to be used instead, =
and
> that has its own support in the Linux block layer, separate from the cryp=
to API.
>
> If there are fundamental issues with how crypto accelerators are supporte=
d in
> the crypto API, then I think that the people who actually care about such
> hardware need to get together to create a plan for correctly supporting i=
t.
> Doing separate crypto operations on contiguous buffers is absolutely some=
thing
> that users can expect to work, so if that in fact cannot work, then I exp=
ect
> that this limitation will need to be very explicitly documented and check=
ed in
> the crypto API, and users will need to explicitly opt-in to being able to=
 use
> crypto accelerators rather than having them (sort of) be used by default.

Very well. Since the issue I've raised is right now an theoretical
issue, I'm going to leave it be for now.

FWIW, the ccree driver passes this extra test with no failures.

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
