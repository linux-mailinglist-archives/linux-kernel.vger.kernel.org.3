Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3D58B509
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiHFK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:27:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E161D48;
        Sat,  6 Aug 2022 03:27:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ff27so899701qtb.11;
        Sat, 06 Aug 2022 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ojb/oCXcMsye9R9CinrRz1U1Kdh/Eo0FGrLI1wf3hRo=;
        b=SV9w6rFrbzPtMv1R31cJ+GUPMfFRCHJfmfKJfTTLpDBrrc9VyEQzzVRPflpihdbzEj
         uuByrltYXixKsW3PTMi6EMVcyb7lHjvWCeQtGvrASfgy+v+AHOFOZ4AyaH5Zbn1WgrdV
         K60/iSExTU6QqGdoGHSzjL5ZKQnFDbDM6UhWYqOz4AK5PHPJTZ7IXX9SwUxMctPnUjdw
         qaXQ0H4ilY38hPwoJS6Kbgl1d33Dfkv20OgFtpj8GzAqj+cxWggyrR3d30CO9chzrcfC
         OTeWai6Hwm0IrlUEl+4vsrZgdzrF0sRVFAZud4easlHzbz1+JXiwgRTS6DjGxf5AXWZs
         LPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ojb/oCXcMsye9R9CinrRz1U1Kdh/Eo0FGrLI1wf3hRo=;
        b=14rf70KfUUlyCL7OYWhsI/vWxEDPZZAfgeb93kEs7Db1sGCkF5a6O2su2XBNZ7GXEC
         Ne1CUg+XzVROqzN8OMWrNnooMTfAbO5Rf1qzCgd39X1EDDeh/BDkve8O90w9FyqKenqa
         BTH5y8GZ0GOsBko0mA9xHQY8zKUxgGQhQ1fmz4YUKEyI2uEIaXLinMo0q9aeuyYrdUsa
         jpcTE4H+oZUISKc8zJgzijV/UFbtOrrU5hLB9SR9A6luLMouLc4tvcFuNMq/ykcq8OnW
         ejSOJ0VDOYQ2QASj8L3lbMkJvgaeq9TgHvcAww0zMTKI+oPpTLCAP0+NQ0wKkmBQIzLB
         70Dw==
X-Gm-Message-State: ACgBeo0IF0tIrODXCsKLzuWKe5CZ95XDwQLUVw0tX+mEr5mGWggqSBVL
        ji2ZyeHBoEmP1sPMESqtVwDqkHCKLSLvcjPemXY=
X-Google-Smtp-Source: AA6agR4vEs3/3l/nfiwRbEmkE4Jpc/Nx5vNokQLkPB8Gtj1j6m0KOpDZ/VI2B5cAjbZwWY2Z43LTsKF4dTXKQ6Ohpu4=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr9170257qta.429.1659781661197; Sat, 06
 Aug 2022 03:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-2-luke@ljones.dev>
 <CAHp75Ve-oo=pGkpD10kbOVtrYtzQLscFq9HO0-Y5a6M_fpXDNw@mail.gmail.com> <N7V6GR.XFSPFYLCEU9X2@ljones.dev>
In-Reply-To: <N7V6GR.XFSPFYLCEU9X2@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 12:27:04 +0200
Message-ID: <CAHp75VfGSpYsX_bAebtU3TbjzAK7fmYioJB88X8p3NG5BDA2+g@mail.gmail.com>
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

On Sat, Aug 6, 2022 at 12:16 PM Luke Jones <luke@ljones.dev> wrote:
> On Sat, Aug 6 2022 at 11:44:33 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:

...

> >>   #include <linux/leds.h>
> >>  +#include <linux/led-class-multicolor.h>
> >
> > Not sure about the ordering ('-' vs. 's') in locale C.
>
> I used hid-playstation.c as a reference and followed that ordering.

Try something like this:

  LC_ALL=c sort

for these two lines and see if the ordering is the same.

...

> >>  +       if (err) {
> >>  +               pr_err("Unable to set TUF RGB data?\n");
> >
> > Why not dev_err() ?
>
> I didn't know about it? Is there an example or doc on its use?

Thousands of examples in the kernel source tree. The point is if you
have a device (instance) available, use it for messaging.

> >>  +               return err;
> >>  +       }
> >>  +       return 0;
> >
> > return err;
>
> Something like this then?
>
> if (err) {
>         pr_err("Unable to set TUF RGB data?\n");
> }
> return err;
>
> If so, done.

No parentheses. Have you run checkpatch.pl?

Something like

  if (err)
    dev_err(...);

  return err;

> >>  +}

-- 
With Best Regards,
Andy Shevchenko
