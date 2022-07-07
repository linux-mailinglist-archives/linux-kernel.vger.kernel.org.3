Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E473E569FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiGGK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiGGK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:29:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF153D37;
        Thu,  7 Jul 2022 03:29:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x184so5099848pfx.2;
        Thu, 07 Jul 2022 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xkSpYLA2hqfsxahuAfQtyWp9WK9S+AEkS7nnUigkbP4=;
        b=Uy5v44vF9ZsC6U9vhuFog2+tIzl/k7lGP1idZ1pJFp3qODEFlxzooW77oadSFlrjw0
         6aDNqySOr//5AIurRFLZi2V2Zbycp/HmFjwOs/xYcnRdgdhlPy6QLGEHIcjEY1KCyBwP
         G3PsuIlZOt4D3WKq9Z7EwGDinu6OdVS1oxzbyhKfhy22wC2ZtbInbu171AfNg9u00Ngw
         vagMIiliIX0AKs8Zd9dTbpkOOIVmRKa0qu5LLsqTPW9Mmj7f5qOhFV0KL6HXoLsWOwB4
         R7R7RNiNU+J99Xs/BOLbJuV2MhWluVjq8byyqJ05Zk5of2D1PRWSlJYojCAQwZ1VMKAc
         7VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkSpYLA2hqfsxahuAfQtyWp9WK9S+AEkS7nnUigkbP4=;
        b=7apW+kwLML1bis1UYH6wY8+TAv15wTBV0sP4n1iPdUovWu6hwZumOs6rJ/Q/lXXhjE
         FZASq60h7tu5RQZZmGWrH7dBGuck7DoKAupSKyZutAFs4HBItTSPaQYXicTasHN32Qa7
         WTMs8hPjjgEJ5ENV1YhGzuFXQrM3QacuoDK+fhO56h/Lm+HvUSziFerHuH4bN7WS0cgH
         t+7MClAHbBwqVdnDNoWdPfsIsjfIztp/7lMRT5SjYC5tjUIzON1pe/J9fgTGklr4+AxO
         uJ5bjLqmik1uVkoQ+7ZwnEabm/QRKHuwD+BG8oh1JR7tLFR9dZlU3MXN/clbPewJQGXL
         wykQ==
X-Gm-Message-State: AJIora9SolYOdAfFs2N+gIbntToMTYmyL25hs9QM4hj/qqjl0LrzOYf/
        bljsW1bTCkoAr4gXufcOIsc=
X-Google-Smtp-Source: AGRyM1vEWHbbgcYl0W0A1GHrpbNU7Fdbax7IR4Xy1VLt1k/b2LAsjPQRIy1XjDKHSuXn1eApEqYC7Q==
X-Received: by 2002:a63:1724:0:b0:412:7bee:fdba with SMTP id x36-20020a631724000000b004127beefdbamr10476410pgl.340.1657189763823;
        Thu, 07 Jul 2022 03:29:23 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b0016c1948ef7esm452394plg.296.2022.07.07.03.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:29:23 -0700 (PDT)
Date:   Thu, 7 Jul 2022 18:29:18 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix null pointer dereference in
 linereq_free()
Message-ID: <20220707102918.GA60169@sol>
References: <20220706084507.2259415-1-warthog618@gmail.com>
 <20220706085025.GA2259579@sol>
 <20220707090006.GB57165@sol>
 <CAMRc=Mcqvp4oN_tHXS1cb0AnEOU=Znd4bmSwO4ZZ1GszRfXhSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcqvp4oN_tHXS1cb0AnEOU=Znd4bmSwO4ZZ1GszRfXhSA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 12:19:15PM +0200, Bartosz Golaszewski wrote:
> On Thu, Jul 7, 2022 at 11:00 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Jul 06, 2022 at 04:50:25PM +0800, Kent Gibson wrote:
> > > On Wed, Jul 06, 2022 at 04:45:07PM +0800, Kent Gibson wrote:
> > > > This patch fixes a kernel NULL pointer dereference that is reported by
> > > > gpio kselftests.
> > > >
> > >
> > > Should be:
> > >
> > > Fix a kernel NULL pointer dereference reported by gpio kselftests.
> > >
> > > Sorry - I rushed this one a bit.
> > >
> >
> > And I might not've been totally clear, but this bug is present in
> > v5.19-rc1 onwards (when HTE was added), up to and including rc5.
> >
> > Would be good to get it fixed before v5.19 goes out the door.
> >
> > Cheers,
> > Kent.
> 
> Yep, figured that out. Applied and fixed the commit message, thanks!
> 

Good to hear.  I never got around to reviewing that final HTE patch
and, while it did end up pretty close to what I expected, there are a
few things that I would've done slightly differently that I'd like to
tidy up.
And also have the HTE specific code compiled out unless CONFIG_HTE is
selected, as that is very likely to be the case for most builds.
But that can wait for v5.20.

Cheers,
Kent.

