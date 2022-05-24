Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E835329C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiEXL4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiEXL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:56:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF110FE;
        Tue, 24 May 2022 04:56:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id q2so3249683ils.0;
        Tue, 24 May 2022 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s623joAvO3I1Y9L2nlzNVOrnSxU41vctt1MgQl9k/Tw=;
        b=THJ5JC0ab5X8dbma1QqJxqhYdU+gLa+DUUYC3aN6h2RNF3eibTE3jZOCOAhVvgD4pg
         a5fJfSbmLKuf1qspU2vTsvzhhRj0rljqn0ZztTjDZLov508goL5YyJpOz5CVvrwTJ3e7
         R4OzWwshJ90xqGuSFGjqCnEtDsKnWwk0G9kkTeeCZih2B0nxSOaQR1Sd8iYR4k5Zfofb
         C70XP+ASrsbHWR/7YzCmxl57ftYzJ+GktCRG8aQPWWT514qIUitfqIc+f+4WCUspX6nH
         XRQAFSnzQYAqhfXWzdAxGuv4oQbNTswvBSBGyBTgm6wsQaBeS2fYCdvrZdqjxWuFEmGv
         q4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s623joAvO3I1Y9L2nlzNVOrnSxU41vctt1MgQl9k/Tw=;
        b=FBXtAcfJNh8K3neooChQUXQDqsbASXqraMvQyRVN6LX61F9jz3EX/8g5EjoKmQLH3j
         f9WnFrZ75v0CdvB1d4LhLC5/JxnOUp2mH6AkK/l4FOo3YYnXSMpOE9n/hFlM/gYfeHYt
         s+RAUS1nq6JUpvS+pkWqhN63Tk/2S5FdeOuKpm55NUC5IG1wOBL98vFUfoRtg56EfloT
         qdttuZwgbhNBCWKg5izIHlQkV86GwMHN1BPCqdc/whio8voB866+yu2OFP2xMAeTi2O4
         3SB0IEw6s9fLmrTFUIUxkzUEYlbij3y8b1L1yOeGC9JoplKdlgVxJIpA8tfhheuROuwH
         S1LQ==
X-Gm-Message-State: AOAM532KiOCeOqTTUoAyzbMI6gmgj/5qXcg2dv+k934vzrY+bpfheWR2
        dUdqPHWs6UcFl+T2oVQLwONNK2rautixg1M2LDE=
X-Google-Smtp-Source: ABdhPJxY0fnNn+R942HDyIrQWoTArBHncI0MuDToWWNAMuWa9r9pFisa9HveCYRrvRbh8M/lqcPFzyjXjmtTMbYjmEI=
X-Received: by 2002:a05:6e02:188f:b0:2d1:58f:41a6 with SMTP id
 o15-20020a056e02188f00b002d1058f41a6mr13594132ilu.86.1653393363575; Tue, 24
 May 2022 04:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220330094126.30252-1-alistair@alistair23.me>
 <20220330094126.30252-2-alistair@alistair23.me> <45acc349-8fea-f755-065c-c561949c45af@roeck-us.net>
 <CAKmqyKOqjperoku_uOy4sCa6LmCUtfB7SCvhLEKxLtcwDkzRyA@mail.gmail.com> <YmEQ1/Gs15gUxYdh@google.com>
In-Reply-To: <YmEQ1/Gs15gUxYdh@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 24 May 2022 21:55:37 +1000
Message-ID: <CAKmqyKPqUuwguio07Jr99DV-3paEkmU-qJp6tERxPoU79BCAgw@mail.gmail.com>
Subject: Re: [PATCH v20 1/4] mfd: silergy,sy7636a: Add config option
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-hwmon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 6:07 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 20 Apr 2022, Alistair Francis wrote:
>
> > On Thu, Mar 31, 2022 at 6:02 AM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > >
> > > On 3/30/22 02:41, Alistair Francis wrote:
> > > > Add a specific MFD_SY7636A config option.
> > > >
> > > > As part of this change we can use MFD_SY7636A as a dependency for a=
ll
> > > > SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C=
 as
> > > > it no longer needs to be selectable.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > >
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Any chance of getting this in for 5.18? It would be nice to have the
> > configs all sorted before the release
>
> Can't do anything without Mark's Ack.

Can this be included in 5.19? I can re-send the series if required

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
