Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1452FA85
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiEUJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiEUJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:52:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0AADFF67;
        Sat, 21 May 2022 02:52:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d198so5876820iof.12;
        Sat, 21 May 2022 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgU6CVcBQStjcDR5gk2dFy7rEHS5OgkX1HJgnqEvLw4=;
        b=OiM5dSKoVRtHFckOGNUBmUfGQYcX+ecD9ipw8M8AS5csnbpWH32uLwtiwQ5hVwyHvx
         IXAXwm0FLv8yQMy78Z9KQP1t9L8hg9KCEcFQ03HQqWFTtYvy/NQWY9Eopwga0Lneqpje
         MTZTZKTpQW1eUtDAZ/V04SNZKFIUZ/wyPuD+vklv/a72S+41O+iD9i1rgiHoQHhWaSXt
         XzLgATlHRwU1liDoo+vw5sC8C9YIa/rMHzfOYIS2Q69Pgfo665nC0hbioBh7Xq4ltYsd
         G3enkBJb1ElKXAi9fLqDNjcb/WPpJRvhnf3GGKWCVDz0x2GRhQXs25q4TnvHb8DLK9SY
         QGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgU6CVcBQStjcDR5gk2dFy7rEHS5OgkX1HJgnqEvLw4=;
        b=beLGFEJLOMSwk5MejloaXs2WzITbxUZjE4+w3N/d/XieNIcxXUHLQr1n8umCo7DvC3
         eElkDaKDPvwyJUMNvqv+WS/FiIHUuO654SqZY05alA45HJaf+oqWw6WgZkj8Z5SNm8X2
         jlZ4PhDiXw8v2Cg0uifyNwQQog7AFuRCZjPSynCVPQIhZT44s2hncZuE3i7UOa7fi46O
         +JQljLA8/W8oYhhe0d84S9pm/ma9xnARrZSYiez0SeCogPjWI1SFZuS8a6OsnCVt1M07
         xLLXccZ8iRB7acNK1FL//lInhpXhn3na5suJiZU0YUGmMz+LQSYvwo1CsfzncOSudVss
         66mg==
X-Gm-Message-State: AOAM531QE6sPZrfZn642JIaL0HCB1381c41F3DyL9EULDhmyVjEIqdEc
        FoFSmf4ZNq5kGCKtp6wUlh41fiUCowhQrmIYEQI=
X-Google-Smtp-Source: ABdhPJw2I3LiVPq9ZApoyJMwbFaJnOwaKOIo4UqmVWX6E5YU3HM68MY2KtVhBgJPSi2J0ZE+/mU127hS/nAp5g+gsCo=
X-Received: by 2002:a05:6638:130a:b0:32b:b608:1676 with SMTP id
 r10-20020a056638130a00b0032bb6081676mr7729318jad.108.1653126749775; Sat, 21
 May 2022 02:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-7-linux.amoon@gmail.com>
 <79b727f8-0631-5a96-fbc6-6e5d637bab7d@linaro.org> <CANAwSgSY=4zOLjw22GN+a7cc5j=myWWkD7gEQ4_3sgEaTS74Rw@mail.gmail.com>
 <018b97c2-efab-699d-653d-c220a98f5ec3@linaro.org>
In-Reply-To: <018b97c2-efab-699d-653d-c220a98f5ec3@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 21 May 2022 15:22:13 +0530
Message-ID: <CANAwSgQe9uveBMgrt3VNUTmFodW3P0Pxhc28KfB8MyEogOtOjQ@mail.gmail.com>
Subject: Re: [PATCHv2 6/6] thermal: exynos: Add runtime power management for tmu
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

Hi Krzysztof,

On Wed, 18 May 2022 at 12:49, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/05/2022 20:45, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Sun, 15 May 2022 at 15:18, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/05/2022 08:41, Anand Moon wrote:
> >>> Add runtime power management for exynos thermal driver.
> >>
> >> First of all - why? Second, I do not see it being added. Where are the
> >> runtime callbacks?
> >>
> >
> > To control runtime control PMU, did I miss something?
>
> Controlling runtime PM by itself is not a goal. What does it change if
> it is enabled?
>
It means we could have efficient power management for this driver.
as per my understanding, it controls runtime sleep and improves power efficiency

> > I looked into imx thermal driver # drivers/thermal/imx_thermal.c
> > to enable run-time power management for exynos driver.
>
> So you have runtime PM enabled and then what happens? Where is the power
> saving? Since you did not implement the callbacks, all this should be
> explained in commit msg.
>
Ok, As per the original code, it just registers the SIMPLE_DEV_PM_OPS
with .pm = &exynos_tmu_pm
So I have made sure that suspend resume feature works correctly
 with these changes on SBC Odroid U3 and XU4.

I will try to look into setting RUNTIME_PM_OPS
or use UNIVERSAL_DEV_PM_OPS instead of SIMPLE_DEV_PM_OPS
any thought on this?

>
> Best regards,
> Krzysztof

Thanks and Regards

-Anand
