Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EC59FEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiHXP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiHXP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:59:55 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66927B3D;
        Wed, 24 Aug 2022 08:59:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m2so5611637qvq.11;
        Wed, 24 Aug 2022 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7hORbcq/+/qG8SwkVlzbfMOWmi0HkT2VLP96xu1KWXs=;
        b=ZV/kBVEPZRaG0fH4TYyc75cjY5NOpj9CpPG15QgBOMjpAs8RDetkPOMrBDyd3rL7wA
         +jKILlJ8KhrEBkYo5Q4vQ/HWTyN+lm4wOGxBwhlvXY5z8/CeeCWbII5IHquvQsZAhBkv
         O2CYI3gkcYHsypMF690g+zDwEyyPYUqSJ7iWyyg1TRY/9260TJuh6fvU7zxhfIjIvBlw
         5oRUu6Q/aYKPDILqgcidfUVUx3nKY3d7aViT/0cy3V7zbTk4cUXD/AOZTz+kD1XctOyl
         mDLmdoPBCvCUDb1sqyceA5qVfRmz/1VeWGywagHqeY2eTO0WJHeJKO8WBcsgNbnp2nYa
         0mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7hORbcq/+/qG8SwkVlzbfMOWmi0HkT2VLP96xu1KWXs=;
        b=fwfOL9UTyMn7pGyCf6rvjibhnQKL9MxET8b/b0xj3J6JZhoHbY+Zqdom87t9SOFYFk
         XJ+mR1QT1MI1IJtkKnRLrLQ9uZyjR9o+XqfgEPKSBTznwzkLh55bCODJjscPFfRL7dSQ
         B/yrY2ZONyRephUn1o5tqytAIhyZvX6Ee0syoF3KHYyEzg2N87ZLUARFznHZuLDlZNZ5
         bGwuoWRDl51Wcq06y2KTP+VwDVF3HcecXdgscf2F/GCCb1YEsyCdwA2PZxtpa+vAhhpP
         mlWAqAdkj56TGFQYDHTq7qdgUp9HArNUtZmMPkkZMNCIwkLEUTcfv+RHnamX5S/grhVn
         AgHA==
X-Gm-Message-State: ACgBeo2sD5x2ep7K64vAgVx6HBP/wZqfV19ZYMZJjHDybBugK/LtM9L+
        UH70eciBUk4ld5KPGkgZMAFybUcaDVQSWx+IRzM=
X-Google-Smtp-Source: AA6agR6IH/YQUvcAvIaOUOZc6i6jJnkeQHEC2lXPQYr5m1uMOxJpXvI2FPgxjplaxtJAK3k4brOP372jhbwcCfOHiS0=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr24691932qvq.64.1661356793655; Wed, 24
 Aug 2022 08:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220824140347.1842-1-henning.schild@siemens.com> <20220824140347.1842-2-henning.schild@siemens.com>
In-Reply-To: <20220824140347.1842-2-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 18:59:17 +0300
Message-ID: <CAHp75Vf6agD-G1Ey1UgUvWnub4Q8-ysx3OMV14dR3ed5FRX=Vw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
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

On Wed, Aug 24, 2022 at 5:04 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
>
> For the GPIO subsystem the only difference is that the direction bit is
> reversed and that there is only one data bit per pin. On the SuperIO
> level the logical device is another one.
>
> On a chip level we do not have a manufacturer ID to check and also no
> revision.

...

> +#define gpio_dir_invert(type)  ((type) == nct6116d)
> +#define gpio_data_single(type) ((type) == nct6116d)

What you are trying to do here is to put GPIO maintainers / heavy
contributors on a minefield (basically moving your job to their
shoulders). Please, provide a proper namespace and not gpio_ one. I'm
talking in my "GPIO heavy contributor" hat on.

With that fixed I can survive w/o pr_fmt() being in this patch. If you
are going to address this, you may add my tag in a new version.

-- 
With Best Regards,
Andy Shevchenko
