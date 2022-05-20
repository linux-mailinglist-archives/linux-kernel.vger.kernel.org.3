Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04B52ED5C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349908AbiETNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiETNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:41:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0DB633BA;
        Fri, 20 May 2022 06:41:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so2667149ejc.6;
        Fri, 20 May 2022 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6/QsRAqORLUi5yt6UyiQbo9u0dbWL0L7kaCffhGcMk=;
        b=ClYLW0l1BIhR2/RZRemlp3vY3UOL6kkSeYyHENRrBieKfcIBVhRyUsfYJIOaTtCBLu
         SOXZeahMnq0PKqNY2//UfhcXS3eOFbEhYT3d6ov3UXi+DLW0rrGmYn8mDKKf3ihADJUq
         ZoUoMg7yuRUNl7orqh6ketvjG81XNynPDZzc4uDt8ZGRrT3CySDSXsiE8lc3eGt6N86I
         QbWMFoxKzhUKlDCnfXEwPPEw7CD5gce5oSG5Vse+ttqY2y9zHEU2z5EO8pTKg6oUHksK
         lDtyKACZwJu3wq0P9J9VWc20QVmKR0mKGDDvl51wKirpjs6W5atFU7Zn2f6OFMxrU+Yz
         9yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6/QsRAqORLUi5yt6UyiQbo9u0dbWL0L7kaCffhGcMk=;
        b=tuF5PrLUmO8x7+oDEF/jgofYuVxxsFx66PYCrMJl8/TaBNer2bMPuwkfr94TE1XvRS
         9Q54+qruBEBHlIYZA7fEr5zq19VXmMkHmUWwBqyIyJjiNTDYhrfVyOpmnWCnkz4Tkby7
         8yeGrnMiPWayhxhtdEuduy6BX2/5QwpKsk+kYGDcPSprky+4ueUSaHqY2CS3UFW5KrRZ
         grbOdSg9zaZDgRKL0p3zmlpTGsarUWSbotDmfzgXgsDgSF0qpkjAzlisf8330rjikiJQ
         gwF5FibiiE0nkRORG2kbLAXhrBYuscHDAODIfSib6jM0/QDFog+57fMoj/S7CMf+w36a
         WmPQ==
X-Gm-Message-State: AOAM532X4aBVqrLKM8gNSh5R5XhvQNXjKa98NK/zTJEC3cf+QMg8qFwG
        GUnZpSrEKFX0AMtYR3Kc/SWYjZIteA5IIxRR8kk=
X-Google-Smtp-Source: ABdhPJzN+WMvM3kDw1WvLqjTNWo5kMMiC76PzB9Y2thrPEAfHpjnCrR8aMmyr3Y4oeVHD/70d6BebJS4tRJ+Gs8ngC8=
X-Received: by 2002:a17:907:3e8c:b0:6f4:4fdb:6f24 with SMTP id
 hs12-20020a1709073e8c00b006f44fdb6f24mr9002543ejc.44.1653054112931; Fri, 20
 May 2022 06:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220520025624.3803776-1-zheyuma97@gmail.com> <CAMRc=MfeEjJ0bGaDgkYOxYA1pi+8376zis=V1Hyvy5K3AKCAxA@mail.gmail.com>
In-Reply-To: <CAMRc=MfeEjJ0bGaDgkYOxYA1pi+8376zis=V1Hyvy5K3AKCAxA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 May 2022 15:41:16 +0200
Message-ID: <CAHp75Vd0jS6vv5C-NDtyLLPHHR15r2mL1=-qdPDdbTo47dxmFw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: ml-ioh: Convert to use managed functions pcim*
 and devm_*
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Fri, May 20, 2022 at 1:33 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Fri, May 20, 2022 at 4:56 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> >  When removing the module, we will get the following flaw:
> >
> > [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> > [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> > ...
> > [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
> > [   14.221075]  pci_device_remove+0x92/0x240
> >
> > Fix this by using managed functions, this makes the error handling more
> > simpler.
> >
> > Fixes: e971ac9a564a ("gpio: ml-ioh: use resource management for irqs")


> Looks so much better now, gotta love devres. :)
>
> If Andy takes it through his tree:
>
> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Otherwise let me know, I can pick it up myself too.

It's too late in the cycle, I don't believe I have time to pick this
up. Go ahead to proceed it!


-- 
With Best Regards,
Andy Shevchenko
