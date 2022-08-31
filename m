Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B05A7F71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiHaOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiHaOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:00:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C186E887
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:00:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so18498868edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6P2lNRWGpZ/wwTsS6VCxsNms7FDaVc457DP8/wjf4sI=;
        b=52a+2IX0YGfnqz28f3UmFbBleYRk6kTKTLXnAGyUYgRMmVD1G3B2whwY8hGfSNj9tZ
         4S96eLI7xh/bOk7Q2Sf3XdlDb4MhpYUPI04ZuvDxLZrWrCRDtQbWkc1cXvZ3aL1juPcM
         6aBk499GW2+fpjSMJU4+uTjmx+9k9Le7RjgiPe3d4AeIGbZHzyyrTesZx4c1ZFgXML9F
         yFYXWyJYY5+m3bRUFY5fW9ZHTmOoNiLRjoX3H3UaNfrFfxWYxsMf/4Qi/rCO5zYxVvXq
         bFVzKPPxTNSQudB4bZBISfM4VLwMTTZ5AWFl321KoAsNhJADDmNTG15hFH3U63eab4/l
         JR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6P2lNRWGpZ/wwTsS6VCxsNms7FDaVc457DP8/wjf4sI=;
        b=rhTdJIq0aLHtikAhcPExF8/kBm2KjSdlIfy79VYooKr9Z8akeVnR6g/mdTuZYg42wj
         VpFNbYtCR7MkFgpF3iU10Qve6l8hAsJ7noCm8XfkcPR7ZUr8N6p00tR/UCioZDSbhZcB
         4V2nSzEpLJE7nYF/JCsAEDUKWGYHxGq0unSaFGacHK+VPOHggXgEBsB7UE4WqWtEi5Px
         U8KuKjNjA20HxQpEQ0dLpPQwnAwHvy+hyAgMGJDqdJIdNNE1vUW3p5xgKFm2s8Mylo2I
         f2CkXNDW9FC23lOg7cXf3KLNBM19P55vNWsp7NptDjPoEIusKxI26wdZbcfZFYcyfgWv
         JiNg==
X-Gm-Message-State: ACgBeo3yGDs+IkJAf/PpRi7Yxn9+Wf2onqupduwcxT+E8yUAYMvych9r
        RDdMoCtVV3D6MBNuZ8RacBuJ+y8xqG3I6vofMPHcnaK8HiU=
X-Google-Smtp-Source: AA6agR6v2xfdp44q10zwuyuTtHUsTsSrbGtgUSYRAGCpH2+GAlWVbFFmwXd5cRLVHL5VvMA4Ov7vkQJOB7EHM3Bd32o=
X-Received: by 2002:a05:6402:51c6:b0:43d:dd3a:196e with SMTP id
 r6-20020a05640251c600b0043ddd3a196emr24908383edd.213.1661954437747; Wed, 31
 Aug 2022 07:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660839809.git.william.gray@linaro.org> <CAMRc=Md5Et-T++mZVw+jXnOWQS23o5hUOATYqs6b+pR1zr57Yw@mail.gmail.com>
 <Yw9n+m26FhEyxbNs@ishi>
In-Reply-To: <Yw9n+m26FhEyxbNs@ishi>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 16:00:27 +0200
Message-ID: <CAMRc=MeDZz9uK6o4dzL8YqvquepCeM6ZeL+2K0PLZYp50x-Wgg@mail.gmail.com>
Subject: Re: [PATCH 0/6] isa: Ensure number of irq matches number of base
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 3:54 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> On Wed, Aug 31, 2022 at 02:35:51PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Aug 19, 2022 at 1:11 AM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> > >
> > > Several ISA drivers support IRQ and call devm_request_irq() in their
> > > device probe callbacks. These drivers typically provide an "irq" array
> > > module parameter, which matches with the respective "base" array module
> > > parameter, to specify what IRQ lines are used for each device. To reduce
> > > code repetition, a module_isa_driver_with_irq helper macro is introduced
> > > providing a check ensuring that the number of "irq" passed to the module
> > > matches with the respective number of "base". The relevant ISA drivers
> > > are updated accordingly to utilize the new module_isa_driver_with_irq
> > > macro.
> > >
> > > William Breathitt Gray (6):
> > >   isa: Introduce the module_isa_driver_with_irq helper macro
> > >   counter: 104-quad-8: Ensure number of irq matches number of base
> > >   gpio: 104-dio-48e: Ensure number of irq matches number of base
> > >   gpio: 104-idi-48: Ensure number of irq matches number of base
> > >   gpio: 104-idio-16: Ensure number of irq matches number of base
> > >   gpio: ws16c48: Ensure number of irq matches number of base
> > >
> > >  drivers/counter/104-quad-8.c    |  5 ++--
> > >  drivers/gpio/gpio-104-dio-48e.c |  5 ++--
> > >  drivers/gpio/gpio-104-idi-48.c  |  5 ++--
> > >  drivers/gpio/gpio-104-idio-16.c |  5 ++--
> > >  drivers/gpio/gpio-ws16c48.c     |  5 ++--
> > >  include/linux/isa.h             | 52 ++++++++++++++++++++++++++-------
> > >  6 files changed, 57 insertions(+), 20 deletions(-)
> > >
> > >
> > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > > --
> > > 2.37.2
> > >
> >
> > Looks good to me, do you send your PRs directly to Linus? Do you want
> > me to take this through the GPIO tree?
> >
> > Bart
>
> Hi Bart,
>
> Would you take this through the GPIO tree? I'm planning on submitting
> some more patches later for these GPIO drivers so it will be convenient
> to keep all these changes within the same tree.
>
> Thanks,
>
> William Breathitt Gray

Sure, just leave your Acks on the first two patches.

Bart
