Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE258B50B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiHFK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:28:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD17613D7B;
        Sat,  6 Aug 2022 03:28:26 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a2so3497220qkk.2;
        Sat, 06 Aug 2022 03:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QMTcefpNaXq/ZeFIs0rURWC/eH5FulURuyF9pjeQIKg=;
        b=kx3fQWqCCzxht1ZQEWMZw6KT8jK3aN+7imhz+wkAU1ufYm39mo8PbvVff4cuYmqyN2
         ljJ5Ll6/+wM5aBjPml+X61OOQBxumKeWliDdzQhnBk0YBlE4tQIWJ4L5OgLSEqv7b/vj
         W4TpOGSHDYzRueAZI1dZtODFDqSs9NYwGbKeH2vGuQjffmNU7Nu8yqNeAsM+XkZOD2px
         31eTK87fGhOCwSAE+tJ8viqtIGzAS48ydY2PihiwTFCZa88gU/19B8/HsqQTBx+vB5yN
         bZXgIDceh1s/DbrMzR8/LNeHgBmX76FBYRNaGcx5qwXfwID8P6sNjO8a2xyKBSvoftFa
         pKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QMTcefpNaXq/ZeFIs0rURWC/eH5FulURuyF9pjeQIKg=;
        b=GUhYbluI3u6Y47z3IUsVcKzb1noqJ1Mvq7JadZNcCEVKmNkuTNTW0LD1IRn6ns49Ut
         PjJDfXKohaj3mGPMWw8XeOEcmXJN1ri9izr3dKR+W+6brAAd8pJA7EhRgTBmoE0A6O8l
         +qganPBraWA5b+/kNDs/KsoUxxy+GbbvXgkt4Ww7+ffsmNWvxdX+8YpP2akxiWqHwYFY
         tohOu00WIHSpKFRmwGYojdrZJgqW7u9oQL7uusaP5uwhKcRWNyJHq0b/5H7G0pKKL8gZ
         ZpWyWChKPxwtmwKRybhPlhrCbf2Y/TPxdfrnww7QhiagPQ8ENXcU2EcZmt1qbsO0cBrq
         LNOQ==
X-Gm-Message-State: ACgBeo2r1ye86t9gxQoiEbtk4gS7eAe/xABIywAyrlHklpLP+js2lxXq
        O8rr8JBLnRQ9ROSELVzoPgLExisjg2axIFVKMkQ=
X-Google-Smtp-Source: AA6agR4Vo+KLnsEFQ2f5AtjEGGpM0ivIbO4OzSxPRY6LZS6Vrg+qaW7a5WIcasBoQG/CZhVC1u4sgwffrC/YSM/cQNI=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr7902043qkb.320.1659781705909; Sat, 06
 Aug 2022 03:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-2-luke@ljones.dev>
 <CAHp75Ve-oo=pGkpD10kbOVtrYtzQLscFq9HO0-Y5a6M_fpXDNw@mail.gmail.com>
 <N7V6GR.XFSPFYLCEU9X2@ljones.dev> <CAHp75VfGSpYsX_bAebtU3TbjzAK7fmYioJB88X8p3NG5BDA2+g@mail.gmail.com>
In-Reply-To: <CAHp75VfGSpYsX_bAebtU3TbjzAK7fmYioJB88X8p3NG5BDA2+g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 12:27:48 +0200
Message-ID: <CAHp75VenmsaB+iwqSUgr0YsFKjY-CgSiVpp7OgxK8Vqai=gL+g@mail.gmail.com>
Subject: Re: [PATCH 1/5] asus-wmi: Add basic support for TUF laptop keyboard RGB
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 6, 2022 at 12:27 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 6, 2022 at 12:16 PM Luke Jones <luke@ljones.dev> wrote:
> > On Sat, Aug 6 2022 at 11:44:33 +0200, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:

...

> > >>   #include <linux/leds.h>
> > >>  +#include <linux/led-class-multicolor.h>
> > >
> > > Not sure about the ordering ('-' vs. 's') in locale C.
> >
> > I used hid-playstation.c as a reference and followed that ordering.
>
> Try something like this:
>
>   LC_ALL=c sort

Should be, of course,

  LC_ALL=C sort

> for these two lines and see if the ordering is the same.

-- 
With Best Regards,
Andy Shevchenko
