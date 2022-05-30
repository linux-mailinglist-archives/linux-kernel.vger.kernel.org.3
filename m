Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D61537845
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiE3I5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiE3I51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:57:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EFB2019A;
        Mon, 30 May 2022 01:57:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so19506710ejk.5;
        Mon, 30 May 2022 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TD1gul0/mySriBMlbavF8TDIj7HBySCjFvjhT5CkpAI=;
        b=E4NeLIXUzy/oYrWhje+yckD5m3Cvg9Nutcnye2lGtVE9fDESiEvsbjMVwEoAkiWm63
         X9/JI0qcEdwlkQE49PF8gVLKtHAFlcxhXgYmQ2RUH8axqc+IdbxaphuzPOAfdUd6sj+W
         CgzqWuuhjkjrrqxplc3f2zznaLwnr5no7wLIBByQpy4x1lRaILtH4WmpPUmNxRzd2oSM
         rjfRICjLZiOSJFvJPvH4hPe7xdWta+3tcEdvHXan0wXHV40QHv/48O6imEYHNM73+P8n
         ca9jEuxcDMY086umYZDarQrxOSs3qjd50TGNQ5xGrmzMoKhZqRk8IpxlCfKDci1uez1V
         6tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD1gul0/mySriBMlbavF8TDIj7HBySCjFvjhT5CkpAI=;
        b=b9tKsKDxg8VS3avdoZjej+/24on/PPV/bWJ6mkAOXWFeh9VrDXUHMX5B3uoyp9/b6+
         fQ3XFsRxs/CrjHOJtUdy5evjQOMcDbkA8UnZjVGYV2FroGbNSbWpGtbouirbQb3iDkGJ
         GsqpHWgLJZ0mN2NlbCSfbKankA7aohQ82TydgIgHHGWdGR8bT8sfyu2I0yi5sHB7ROfs
         Na9A6Q82SP1tdR/fNayT5LksAdk5kYXbnRnH+yHKpFYeqt3kcObI0kMMsGYqnJlOzZnf
         EfTMuzpEq/AigNJpUVf/tsDZb5WCwzwAPZgOAhh/c5W3P6xqHw9u7mFhHZaPBLJBOj4Q
         skcw==
X-Gm-Message-State: AOAM533Uny47/VWc9nrUEqwSz9WcwZO8NodaLGMcjT+1UQkHMYav3B4I
        vVLO/B9QBdoZvQE1PM25Ztsc7xl7z9Pp6huUTt0=
X-Google-Smtp-Source: ABdhPJwQx+9GGbBOUTraP1TZInSQTT/do9kz9ihJyqmWvUimq77+tfG07h1tioYrxE3aesFHRGXJd1jbjh6Yh42Lofw=
X-Received: by 2002:a17:907:a088:b0:6f4:f661:f77a with SMTP id
 hu8-20020a170907a08800b006f4f661f77amr48081294ejc.77.1653901045047; Mon, 30
 May 2022 01:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220529040153.4878-1-jagathjog1996@gmail.com> <20220529040153.4878-3-jagathjog1996@gmail.com>
In-Reply-To: <20220529040153.4878-3-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 May 2022 10:56:48 +0200
Message-ID: <CAHp75Vf0v_zgV4QymQMDiAYJ7-48iY0BdE9ACBgr2kV52yy3mA@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: accel: bma400: Add support for single and double
 tap events
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Sun, May 29, 2022 at 6:02 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Add support for single and double tap events based on the tap threshold
> value and minimum quite time value between the taps. INT1 pin is used to

quiet (see below as well)

The INT1

> interrupt and event is pushed to userspace.

an event

...

> +#define BMA400_TAP_QUITE_MSK        GENMASK(3, 2)

QUIET ?

...

> +       /*
> +        * No need to change ODR when tap event is enabled because
> +        * tap interrupt is operating with the data rate of 200Hz.
> +        * See datasheet page 124.

When referring to the datasheet, please be more specific, i.e. table /
chart / section number and name, No page needed as it may  be changed
from version to version, also date of the document or revision would
be nice to add.

> +        */

-- 
With Best Regards,
Andy Shevchenko
