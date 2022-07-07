Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA97569F75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiGGKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiGGKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:19:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA0113E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:19:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n4so12303713ejz.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbTM/nQcxZJ6BgR09aHGQ/QMYCWLXE45+KSnJNIU0dY=;
        b=vmMs0IRIkxK/RTIkpvHZ3Jh92559SFP+37T/C6vcMRhlarT9BUlv/SasH5H4D1qrYg
         ggSwKX2BzjBqJYkRyCXCSxYctonGyV7bdftuhnmOxGn5kC+OE611aQcITA9Rp1SgPH4W
         3ZuJZ9z2K/IVRNlQ+7Ca2lTPPWkSWyxZBiMQhd9XS4iqWv1AQDvAebsMLE0vda8yvmyt
         sP2Zstg6T6et1RUKNOVVCg+PyRGpAI/3CE3oFelXR3pmhLNgoqGQFv8SVFoV4JVz92jn
         6XddmbYv7msOWQmue7TM+VRQxHzU2X6Pt30CVTlCX6DO9GnrjuNeVbsiTIEjMAEli75P
         s1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbTM/nQcxZJ6BgR09aHGQ/QMYCWLXE45+KSnJNIU0dY=;
        b=hwX1X9zLfmbXGG4XzFl//k93Pu8T/0a3cHUQVTlKCuWTvzzDynPsXLApa07iltowI+
         T7nRdYtrOK9eF5PF6RJ5ikOxgO8uSVEJQF/c69DknMxtH0DQg3GEgVyem8xD4fwdKUg7
         UT/M/L5inq47wwoMOhc30tEn/qan/sydD77VsoNLDW/3vu6qvwyPXkTat2gDdgQvExui
         smeFdCv34/+luSbWNsvM1DFy7vS80AtaGuLZGZvC+F8278wyhqzXH51esR25mRt5NtYG
         8IB7OpZy3ak64zYja5xCZ1SEi8Wia2RKWQFCxO9UPMFu06cZioYSSFwYVJkc1RtoKA3K
         IerQ==
X-Gm-Message-State: AJIora/V7Pu1zohG8qln08kuEE7Bw7ZfgkKZx9ozQXS+C9wgY4lM5lnS
        MsIYG3bOETlx8e9flqW+12yJ/BJ4i8SZP/dSMG6Z2KEvHSQ=
X-Google-Smtp-Source: AGRyM1uyDxONACwUuTs6eFi5pFfWPYFxEXM593ZufX32OxEulj+Eeix2cte4tMMdSVy9+m9q4DPS15M4cIKGaWo+N1Q=
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id
 sc37-20020a1709078a2500b00726c9f22f5emr43343549ejc.286.1657189165528; Thu, 07
 Jul 2022 03:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220706084507.2259415-1-warthog618@gmail.com>
 <20220706085025.GA2259579@sol> <20220707090006.GB57165@sol>
In-Reply-To: <20220707090006.GB57165@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Jul 2022 12:19:15 +0200
Message-ID: <CAMRc=Mcqvp4oN_tHXS1cb0AnEOU=Znd4bmSwO4ZZ1GszRfXhSA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: fix null pointer dereference in linereq_free()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 11:00 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Wed, Jul 06, 2022 at 04:50:25PM +0800, Kent Gibson wrote:
> > On Wed, Jul 06, 2022 at 04:45:07PM +0800, Kent Gibson wrote:
> > > This patch fixes a kernel NULL pointer dereference that is reported by
> > > gpio kselftests.
> > >
> >
> > Should be:
> >
> > Fix a kernel NULL pointer dereference reported by gpio kselftests.
> >
> > Sorry - I rushed this one a bit.
> >
>
> And I might not've been totally clear, but this bug is present in
> v5.19-rc1 onwards (when HTE was added), up to and including rc5.
>
> Would be good to get it fixed before v5.19 goes out the door.
>
> Cheers,
> Kent.

Yep, figured that out. Applied and fixed the commit message, thanks!

Bart
