Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF255AE9D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiIFNgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiIFNfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:35:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1940875FD2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:33:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fg1so1181478ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YG81fsrgVvtbiqNYNBZnqjl/kHiLEsWdD0wbROrMHQI=;
        b=CM2gzKkGrZAirkis7zZWySHvo3koLz+Flptuhq4k+FAbtvqnjCVv8lFcFCyLc0EnU5
         gUv5rzrNgm3Ofu4x2a0ATbiZ/KaHh7xnWWMrKnRQb9SAkns6X0kRhKarftovu5cGYKZk
         /8KT61ZTXg4XzZTUy0iff3or9U2KP84m2hh1lDqgnmKjf18geSSoF/MU4lVMsNx/Mgc/
         m14jTtEK9FRMPrvNJ98E8sCC998TkQQ+iD2Y/LpaVQ6EELbjK1n+kY/3oIojdR5NwfjO
         ecPVAAUdkKW2wGzbck1q+GsQCnPC483nqohQztM8nt/eUWbT5EdZwhPWrSmU9evTDc/c
         P9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YG81fsrgVvtbiqNYNBZnqjl/kHiLEsWdD0wbROrMHQI=;
        b=NKE2Pv/iUQJDnbOQcvTZPtoiptjHBCi3ttyK+S1LAsWqtXz0fzyMrl7gfjWozYQJ78
         kwcaewWQPt7I7JQwdOaKxHu4a1lmTU1XVuhcAYIvtrhNHp68XnSb4b/KaHvxPXNEhDyO
         jN+6Cd/3stZv5iDSYBFaOb/VXDR/gdwNKPEtk/veq8U6H1KAVNOWgE3UotvleaGzWKbO
         FKZ/donmYWgKY+ygEJDVrehVKZfS2qjnN5xjK1RkfCDvRy+3bUnRwjH4XlWSj+49LEe7
         5HJf3lutmIhdok0eszr08qL43DNv/mmGMHAP3Xs0bvSKc0fy5vx30X0ut/xZ1iMYzBEk
         mGSQ==
X-Gm-Message-State: ACgBeo3s2lR3LT3O6ixRt0itlgPls3K90LtEOWCOXHOXmm52rG1uE3QE
        gVteiL/F6dlH8TjmCK15MBDqLVPM3LM6d27xlFj7vA==
X-Google-Smtp-Source: AA6agR7PEn/0mTIlPjGhwc5a6em6dF4E52w+glg7yEh5IWQZV4Gj384gvHyGZlFTJ4HCWrWMw6A5C+h+IgO4qr2XvFQ=
X-Received: by 2002:a17:907:a420:b0:765:70a4:c101 with SMTP id
 sg32-20020a170907a42000b0076570a4c101mr9117964ejc.526.1662471226679; Tue, 06
 Sep 2022 06:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk> <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
 <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com> <YxdI/TLBrzJP3RKi@smile.fi.intel.com>
In-Reply-To: <YxdI/TLBrzJP3RKi@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Sep 2022 15:33:34 +0200
Message-ID: <CACRpkdaQ+0wbreyCEaoBnjKT0rtgPEnotZQw_Eh=y4xktwrwHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534
 and PI4IOE5V6534Q
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Martyn Welch <martyn.welch@collabora.co.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 3:20 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Tue, Sep 06, 2022 at 03:08:00PM +0200, Linus Walleij wrote:
> > On Tue, Sep 6, 2022 at 2:19 PM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Sep 06, 2022 at 09:28:16AM +0100, Martyn Welch wrote:
> > > > From: Martyn Welch <martyn.welch@collabora.com>
> > > >
> > > > The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> > > > Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> > > > Inc.
> > >
> > > ...
> > >
> > > > +    oneOf:
> > > > +      - items:
> > > > +        - const: diodes,pi4ioe5v6534q
> > > > +        - const: nxp,pcal6534
> > >
> > > ^^^
> > >
> > > > +      - items:
> > > > +        - enum:
> > >
> > > > +          - nxp,pcal6534
> > >
> > > ^^^
> > >
> > > Not sure why is this dup?
> >
> > No that is how DT compatibles work. One version of the component,
> > bought from NXP will look like this:
> >
> > compatible = "nxp,pcal6534";
> >
> > Another version bought from diodes will look like this:
> >
> > compatible = "diodes,pi4ioe5v6534q", "nxp,pcal6534";
> >
> > Then the drivers are probed matching from left to right,
> > with the "most compatible" matching first.
> >
> > This also answers your question on the implementation.
>
> Then I don't understand why the const list above is only for new chips
> and not for the old one where the same can be applied.

That's YAML. It's because the const list is the most compact way
to express two precise items following after each other, and the enum
list is an implicit list of single-item const:s, as you cannot enum
tuples.

> Mysterious ways of DT...

It's not DT, it's YAML that is mysterious. DT itself is a pretty
straight-forward
grammar, while YAML is a meta-grammar describing the DT grammar
(ML stands for Meta Language).

All meta languages are mysterious.

Yours,
Linus Walleij
