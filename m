Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1C5AA749
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiIBFfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiIBFft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:35:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA647B86;
        Thu,  1 Sep 2022 22:35:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r6so731506qtx.6;
        Thu, 01 Sep 2022 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CjdSnX8tKDWhdJtdqaneyF+qDLboAux9fkOeHQPAim8=;
        b=TlcQlare3b/VilolwjEXzA6BdpmoQkz/xdaauz/exhPyFGr6lkRGvTCygYknIv+vAj
         XJvFfnhlxEp6PtoLzl8yG51c3s1m6mC7c8juPVL3zkBhdNqFxbXnXZaiOMhlsLD0pLoX
         R4/+SR11V9ydjoLqIrYx5fylgPlv8Pizf8nnhgGdqiSX6p+a5sncIqO/BdCEAstda1n5
         YIASWyzrnaoF0L7S2vJlsONM+VrH7iWGpbuVxBh98rahNbmrDgoxJAVDyDPQVmluWFil
         XarB8oM3mcu76xMForVvySFcfLisYRuyQwpXoqVZooGxGicqU273tSN3GzcT8BhaP35Y
         Ai/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CjdSnX8tKDWhdJtdqaneyF+qDLboAux9fkOeHQPAim8=;
        b=8NQxIIbPs0SPOcyb3Nl5NHdcGJIvyZvZTukeKlHL0yiAHtIUZfS8mcSRb6h4sgTyEJ
         tmBM859RNEf4FYHUDLZBmE9mKM4j6Rjm8fCtyvYvAMj19Cw1PnyBmUB2NbAgIBYiylqB
         iNMTdV6m854JvfKT/xsaTDH/9daBs3Z+7LDpYr1hbO8q1IchJOSRiVbONtqfnYm0oSYV
         Fd2L0NAAE9CSClUXptIm0o9e0gjiWiCGsq8HmMaOJLSg+FxryRHnEIkUy31K7iN8Da4O
         JNy0u+K7f0y96ply2+WLrx6uiGO1lRZ9MEbH/9dN9uL5gS/og3TaRVZX8whOot09z/Cw
         x63g==
X-Gm-Message-State: ACgBeo1ZRjVxHKs4kjhe6oUz4kFDHlUqeActAnmbr7tNqmJK/rOFtZs1
        rrj+mCWkcFBkRJbzsmSb/yavwUkak4cQ+ebvrPOBRQRQjOQ=
X-Google-Smtp-Source: AA6agR7yIMcv9vUmOX6g2X8yfXaDp4ZpkgrkSgBnCp/9iMBfw7CFygF2IXMmPkAqS253JisPwYuDdo88eihKZ87SYpA=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr27146665qtx.481.1662096947294; Thu, 01
 Sep 2022 22:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220824114927.79231-1-mmkurbanov@sberdevices.ru>
 <CAHp75VeQX_8niAu4uORW1YEfjxhLJFWsnm_JccECfAOAzAh32A@mail.gmail.com> <20220901224345.fy6xvbpdn4axtlks@Rockosov-MBP>
In-Reply-To: <20220901224345.fy6xvbpdn4axtlks@Rockosov-MBP>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 08:35:12 +0300
Message-ID: <CAHp75VeFT4coDG-fpZ2sErBxnhOpgU98Ctf+vcGcgLRTO6YMuQ@mail.gmail.com>
Subject: Re: [PATCH v1] leds: trigger: pattern: notify userpace if pattern finished
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
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

On Fri, Sep 2, 2022 at 1:43 AM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

...

> > > +static void pattern_trig_remove_pattern_ended(struct led_classdev *led_cdev)
> > > +{
> > > +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> > > +
> > > +       sysfs_put(data->pattern_ended);
> > > +       device_remove_file(led_cdev->dev, &dev_attr_pattern_ended);
> > > +}
> >
> > I'm wondering if you can always have a file and instead provide a
> > value there, so user space may use epoll() mechanism on that. It will
> > simplify your code here.
>
> Could you please explain what you mean? In the current implementation
> userspace can use epoll() already.

On the suddenly disappeared file?

-- 
With Best Regards,
Andy Shevchenko
