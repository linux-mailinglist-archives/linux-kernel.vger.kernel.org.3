Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445C5A31B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbiHZWGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiHZWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:06:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA6DF666;
        Fri, 26 Aug 2022 15:06:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y3so5563557ejc.1;
        Fri, 26 Aug 2022 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gxfAwMNo+XhGWxyftpO+6CnWOrfELB6W6KeuWQP0Tdk=;
        b=JSn7nXQZqRXtCtjtjPrKqmpIQSbKBQrbylO8/4lyVncWoASGdXTvkdkWUAKChPwQr8
         pNox49bzzudetwp6M8yEvHOWZRj+ePrSS6ejclBBF9bPOZGnw83YKLC80HF5wFTlDuXl
         RYZ4U/u4UQS+zml8Ft3eC/DIHPGR3lZUDDkI8A8K50IJGpSf9vmn3Kytks2vm1S4vwy7
         DJpCHERiBI7hxikEMYXkOYWG0gSa8AUpVfL9+FHIEZXQn9p6fhZsKFMXBTdnJdrEWMRH
         ZoQe9LT1P9Iy3Xi2yt15ImYNJBpsWiPbkJMhLy175wv67d5GizMSFTxf1nlOhD5EbvJ2
         dgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gxfAwMNo+XhGWxyftpO+6CnWOrfELB6W6KeuWQP0Tdk=;
        b=rcjoqbyIjVHwmtHcLkJRE+y1Cn2nAG5gSzt0T+aogbA5nbSKGhgniAtvmDbGtfUJZV
         CDHI9BTYPmDuthJ8/2HVqyKZoT8GH+H9eimK4JPMkFkKMzWjinI/22VnH4vEGJzq/B/K
         H4hyQ4YURcZEx+aaxmqFRBUvlFBg3IIGAuNRyQPJ7DmwQCMYYBlVo3iKu8Mw3wtBO/BN
         fFiBLjcjH/n6seu0cxDvBr6FoZE9je/2zUmNRN9MtDDBpdjYPOjesf0BOKd5VG+x79EX
         aiOKCWNpFUQ9ixRKwXiMz/F/FjeLe8KJlQ2czX5o7dQl6rzVoM93GK/w6BZQFdE0eMNT
         rZAw==
X-Gm-Message-State: ACgBeo0P7KF2u/Ff3ravea4LrQ6hhGR75ylE9WIZngR6z/AR0B9jSDNX
        zeFL8sk/BP822pGV2ERj4ePDOm8ICDkvMnpFFlg=
X-Google-Smtp-Source: AA6agR54OERaFQ227DRip+YatbGP5ryKZCn+s70oVq/MUOKUUzRrRT1aksE/nBH1mqzT4YDDbGuNE6VuKbJMwm7N7vM=
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id
 xf9-20020a17090731c900b00740ef932ffdmr2430901ejb.584.1661551596454; Fri, 26
 Aug 2022 15:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220825194604.15645-1-jagathjog1996@gmail.com>
 <20220825194604.15645-3-jagathjog1996@gmail.com> <CAHp75Vc5048aQL5cLy-OfBfnH6tz_7z24sFX2H1oGRz+JUyq9Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc5048aQL5cLy-OfBfnH6tz_7z24sFX2H1oGRz+JUyq9Q@mail.gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sat, 27 Aug 2022 03:36:23 +0530
Message-ID: <CAM+2Eu+a8LM+XBELAm9H51EWVwCDqcYaxfdj4_-Sk9TtJ0gLJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: bma400: Add support for single and
 double tap events
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Aug 26, 2022 at 1:53 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 10:46 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Add support for single and double tap events based on the tap threshold
> > value, minimum quiet time before and after the tap and minimum time
> > between the taps in the double tap. The INT1 pin is used to interrupt
> > and the event is pushed to userspace.
>
> ...
>
> > +static int tap_reset_timeout[] = {
> > +       300000,
> > +       400000,
> > +       500000,
> > +       600000
>
> + Comma and so on for the rest of the similar cases.

This is the terminator case so I have not added a comma in the last.
All three tap configurations have only 4 value options.

>
> > +};
>
> ...
>
> > +static int usec_to_tapreg_raw(int usec, const int *time_list)
> > +{
> > +       int index;
> > +
> > +       for (index = 0; index < 4; index++) {
>
> Magic. Shouldn't be defined?

All tap configuration value arrays are of size 4, I will define a
macro for that.

>
> Also you may add it to each data structure in question.

Do you mean storing these values in the device's private structure?

Tap configuration values are not stored in the device's private
structure because.
- I am directly accessing the device registers in _read_event_value()
and _write_event_value().
- These configuration values are not used in the other parts of
the driver.
- Two of these configurations have a default value so instead of
reading and storing these values in the device's private structure
during device init, I am directly accessing the device's register.

>
> > +               if (usec == time_list[index])
> > +                       return index;
> > +       }
> > +       return -EINVAL;
> > +}
>
> ...
>
> > +       int ret;
> > +       unsigned int mask, field_value;
>
> Reversed xmas tree order?
>
> > +        * Tap interrupts are operating with the data rate of 200Hz.
>
> a data

Sure, I will correct these in the next patch series.

Thank you
Jagath

>
> > +        * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
> > +        */
>
> --
> With Best Regards,
> Andy Shevchenko
