Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB952B5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiERJUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiERJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA414A272
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:20:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so2797210wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eBrgiBGzrk60kAZSEVCexv1pWJW5TTEZ8MUjnMwLi/I=;
        b=bKCZxRM1GoQTtqmmmW5HOA0FKMOGvKrMx1cl1ODcLG19yE2nCh9+52uWp5JEeiUWWT
         2yNY2n6uNTiOKmM/R87OZFim/s1zQgcicxY8uILlNGsvr2dtMxiV23UqCIOTL7sIh0qF
         pkY1FHbSxwLaPZRBeC5eKzoLHMDkHbETzTE9n6jZcz32Y2p4o1lHbljlyPCDMNYHgE+l
         6V1kkUxJfqmqCSYSS5lXO6fjWiIbZqHVb0LYZurFDtChM14eTJdDJVBuDLFupp3ocNRc
         5xO40GRRBQOLSkH6zjsCE7Nqo1y8/PzivfcxGMJgfnCsczobb4a+pKR6J/XC3tCd0C00
         CKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eBrgiBGzrk60kAZSEVCexv1pWJW5TTEZ8MUjnMwLi/I=;
        b=0fowZHyeFJBjMLBDrlEzuBp28qq6ynqQYJcQGEmcpoPBn8oeX1OtRoV8tRHBqzdB/e
         06sz3f4fS0pbq7lGq1qYKYk4JOv9N7V/G66zsgytOWPLtmlP2ykKHckgWmmU5CRG+Xh8
         olIHs+7gGeqDKsYXi/pqfD8jx/6xNtyFCxFPSgw+m+MAW/b8lZVHNCt5cJc9XQYz3h/V
         VLaxlaEeWrsXMTjxv/QLoB2FESNAE6ZnJrueZhIbkchLLfek2UzxYAU3iah7lHgpCMDW
         enTXA97N/m+xb/rGFXlRJ4ElVvdtiUzVvSAluucTqNI0y+jvQLMzsJ+TBbUnAWSZjIYh
         OXyQ==
X-Gm-Message-State: AOAM533pHdaeYZHt4KnXbEt8vVCDKBmXmFXhgkNcePZTG3g2+VBwG9fx
        7BZ/ITsNwpV9KPhMD4mUXturip/uZFDMAmXBcqJBJU14IggbEA==
X-Google-Smtp-Source: ABdhPJyNgdytB47LUliXc+x/PU5W1Vst1F3N/U9fluyBnS+APsQi7/YRSS6Psb+Lcx8jhj0DGPUy4mF0djw+vfks62s=
X-Received: by 2002:a05:600c:35c1:b0:394:8621:a1d5 with SMTP id
 r1-20020a05600c35c100b003948621a1d5mr35267641wmq.196.1652865638784; Wed, 18
 May 2022 02:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220511214132.2281431-1-heiko@sntech.de> <20220518002529.GA1928329-robh@kernel.org>
 <CAAeLtUBLpDHeJHfPtaUb_OLZb_6cUQa1Z_F+06pkdJMSHtWrfQ@mail.gmail.com>
 <1893094.PYKUYFuaPT@diego> <CAAhSdy1sG8uzg0W2Ufi=EYFB58+JZobUa9D+rcHeb4upJoMzng@mail.gmail.com>
In-Reply-To: <CAAhSdy1sG8uzg0W2Ufi=EYFB58+JZobUa9D+rcHeb4upJoMzng@mail.gmail.com>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 18 May 2022 11:20:27 +0200
Message-ID: <CAAeLtUBYF5qG3TkVCwz-DjaM4xGrwm9GyEPSBYJo04g70cNO4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
To:     Anup Patel <anup@brainfault.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>, krzk+dt@kernel.org,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 11:10, Anup Patel <anup@brainfault.org> wrote:
> > > > > +    description:
> > > > > +      Blocksize in bytes for the Zicbom cache operations. The bl=
ock
> > > > > +      size is a property of the core itself and does not necessa=
rily
> > > > > +      match other software defined cache sizes.
> > > >
> > > > What about hardware defined cache sizes? I'm scratching my head as =
to
> > > > what a 'software defined cache size' is.
> >
> > I agree that this should be worded better. The intent was to tell that =
this
> > is different from say the l1-cache-block-size.
> >
> > I.e. these values can be the same but don't need to be. But I guess I g=
ot
> > too much lead on by a kernel implementation detail (L1_CACHE_BYTES cons=
tant)
>
> Better to just call it as "the cache block-size expected by Zicbom cache
> operations" without getting details of relation with L1 cache block size.

I would make this an even stronger statement and assert that Anup's
recommended rewording (and staying away from L1 block/line sizes in
terminology) is required to accurately reflect the design of the
RISC-V CMOs.

The Zicbom operation size is in fact decoupled from the
l1-cache-block-size (as that would be the cache line size =E2=80=94 and
therefore the size of fetches/replacements to the cache) as the
deliberations within the CMO group showed.   This is only the granule
that Zicbom instructions operate on (and there might be additional
mechanisms at work in the background that ensure that this is safe for
any given underlying cache implementation).

Cheers,
Philipp.
