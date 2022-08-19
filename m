Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29751599939
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbiHSJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348306AbiHSJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:57:59 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A811F4C9B;
        Fri, 19 Aug 2022 02:57:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g16so2907633qkl.11;
        Fri, 19 Aug 2022 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=/WIizd4+ASdkLn8xaORlftblvX7iF24VmukZ5lVBNU8=;
        b=WBQ19U1DAzER9eiwrktnTik/2a3VJg3p0hPXXGFvEam0lUqNY7eD/DPZxcH4tnq3hs
         Kunc2r3YYnuK5MerOwDWN0gKBAFIak8Ry5LelPAGykEL9WcYIO+IJEIpFRn6Emr98geP
         DhXIXt/a3b9aqVP7/k3K11McCsl4noX7ErwTvu9wbAdthR4OkhScsX2AVz1SDeh+vI4y
         FzV4wE8pOJ4QK39BIDTOoUbgAqXbWKWNf8BiK2TYQtR+rfV0GUML9oScRLqAtANjxv4B
         9KkopgiiCNa/LH/tTbhjgOhl8BmxzI2OBawfSRzZ4D6AW9U+x7oNK59HuRwRJ5f+TEz7
         texQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=/WIizd4+ASdkLn8xaORlftblvX7iF24VmukZ5lVBNU8=;
        b=p9nT5/eSF9r6oP8cKgdq4CgJcPg9DM48mRNEnfiPmDuGdPP7vQe9Cd9dxvKoRQeKhq
         J8fYZhS0KzQl+i+Twr1iMYbAqi4aZgLaFRXxhBHZuOd0Mj/CjlZ4Eu8nJGKO4e7+J0sR
         5BqmPQAt2/abbgeILoLi/Y6gi6zBevizjWDexZJTb2wz/Xr8meplfIz31ROO4C1dliEw
         AvudU6fHpMU4/MsIsWsOIAaXbOxWYDEGw2DMnJMTuVyxAQoOlEyun74TFXu0r4+HOmyI
         OqR/8NgpO5BatfxdluyEzG7fi026OxOgOIv6nQphbXCHu1wnYfuU/MxAK4EWwP9ReM8P
         hDuw==
X-Gm-Message-State: ACgBeo2twVdL6fKj8bg8cQBKzANd6eRV5HTIaEdaMicVIOVEk/nhuWon
        0gRRbdoEEfQVNrDXo+HzIbBYWHo/buNMWQdQ5BE=
X-Google-Smtp-Source: AA6agR51w56fpbskuo54O8W+TZy9Y+3HiBfTHc0Ja/DTeXlR7tEwzfrsY7hfhFOAb40XYnFAHBE+f2rIqZmDJlgHeIo=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr4696051qkp.748.1660903038316; Fri, 19
 Aug 2022 02:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com> <20220818232040.GA3505561@roeck-us.net>
In-Reply-To: <20220818232040.GA3505561@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:56:42 +0300
Message-ID: <CAHp75Vf+-4U6OW4sf+mKsPt8WoRL_jN-sYtzOMzhhH8--+OU1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 2:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Sat, Aug 06, 2022 at 06:25:15PM +0300, Andy Shevchenko wrote:
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> >
> > Add mod_devicetable.h include.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> I had another look at this patch. A substantial part of the changes
> is because device properties don't support of_property_read_u32_index(),
> reworking the code to use device_property_read_u32_array() instead.
> Sorry, I don't like it, it results in a substantial number of unnecessary
> changes. Device properties should support the equivalent of
> of_property_read_u32_index() instead to simplify conversions.

Not all (device property) providers can have such API available. Are
you suggesting to
 a) alloc memory for entire array;
 b) cache one for a given index;
 c) free a memory;
 d) loop as many times as index op is called.

Sorry, this is way too far and non-optimal in comparison to the
substantial number of unnecessary changes (two or three small
refactorings?).

Another way is to provide a pwm-fan-acpi, which will be the copy of
the driver after this patch is applied. I don't think it's a very
bright idea either.

--=20
With Best Regards,
Andy Shevchenko
