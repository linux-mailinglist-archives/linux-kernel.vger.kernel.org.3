Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A0567703
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiGES6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiGES6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:58:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6C1FCCD;
        Tue,  5 Jul 2022 11:58:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l11so23434204ybu.13;
        Tue, 05 Jul 2022 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GgOTK8JPl4Gc9sCsTpBhVS+r5KJG/3rc61mViR4SCY=;
        b=MMBQyxSHX4Hxb968KOOM79u1NGS/FygOZnk3IwDlmFzwVxIbwPZglyX64WjKL/JEhj
         daWjYGrpyqd7lLZy5p4NtDi1Gi88uZgnV6+Sf2LlKZrg2KWjdkCmTdbiKbRwbwDzaYH5
         X8u9ObSIdrEHi6S6xzofO5tieOVASSn2W4NKHDEeAMvtB/ZFi9V0YDJpfh4lhhKF/l9O
         TXTEao1eoIk2f2ooQ2K2pTuFUkv7gIXq3itkJXZQljedzEtm3NAEa19ORi30FaV519PE
         KHBlKBQIdqJIgiiTz5HsQ3jf7PQeNaXMBZoYoCpwMwIgm2b5AKA/OYpgCHlu9UdZLz1D
         t+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GgOTK8JPl4Gc9sCsTpBhVS+r5KJG/3rc61mViR4SCY=;
        b=PjAS9oiRit9Gg5x2ot9hZxolln+eE6j0RYohhu3n2K63RVhdRAZQzK0mbb/V9vNXZ3
         rHh0mJ5ZPO1Tab2xUGM9Ix/xiEkby+XMQlWYWMTzzWB1ag2I9VnJ0t1cJ2z9F67NRn4E
         /u8rMtECRBuEVwVyCiqzuJ7VBOrJi5dBzobP0EOi6NItUXq0YO+oyadXNmUp7SUqytfq
         3DpHQdbmbBL6hfGjtrGR7ips0SwX2t2h9YlGKo/OQF/FNMY6bNmZnaNZ+lXW2zIW5mnt
         8FKwgdwV0UecZU1ambILLNde/m1leRSzQpO89A2d31YY7SGTm2VOaYsOz1x50lndKYya
         alEQ==
X-Gm-Message-State: AJIora9izqVCr3M3e3y0zweBS3ZxEC055IiMdtLiA/kVImW1bWETrd0x
        gnXeBpXr5QqoTpRQ1o3VZpW07XY+Rp2fAYk8sygPoAcFh8NOEA==
X-Google-Smtp-Source: AGRyM1saNf1h+jbNK1m6kDRF42l21TvpQhbjqH60l6MJL30jqp7pIkkOASH10savVSTakyud7xQIoGjX9zGoh9NFE40=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr39379530ybs.93.1657047492856; Tue, 05
 Jul 2022 11:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org>
In-Reply-To: <20220705163136.2278662-1-vincent.knecht@mailoo.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 20:57:36 +0200
Message-ID: <CAHp75VfwoSqLZVbsN3DduP=SEKvr=tSfmxF1MTnYma0zh-JsXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] leds: Fix/Add is31fl319{0,1,3} support
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
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

On Tue, Jul 5, 2022 at 6:32 PM Vincent Knecht <vincent.knecht@mailoo.org> wrote:
>
> v3:
> - pick up Rob's R-b for patches 1 and 2
> - reinstate bindings docs license and maintainer
>   changes with Nikolaus agreement
> - took Andy's comments on patch 4 into account

Thanks for the update. Nothing serious, but a few comments.

Also a question here. Do you have plans to convert it to use device properties?

> The is31fl3190, is31fl3191 and is31fl3193 chips (1 or 3 PWM channels)
> cannot be handled the same as is31fl3196 and is31fl3199,
> if only because the register map is different.
> Also:
> - the software shutdown bit is reversed
> - and additional field needs to be set to enable all channels
> - the led-max-microamp current values and setting are not the same
>
> Datasheets:
> https://lumissil.com/assets/pdf/core/IS31FL3190_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3191_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3193_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3196_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3199_DS.pdf
>
> This series:
>
> - converts dt-bindings to dtschema, adding all si-en compatibles
>   for convenience and consistency, and adding constraints on
>   supported values for eg. reg address and led-max-microamp
>
> - changes vars, structs and defines to not use 319X suffix
>   but 3190 for 319{0,1,3} and 3196 for 319{6,9}
>
> - adds fields in chipdef struct for chip-specific values
>
> - only in the last patch, adds is31fl319{0,1,3} specific values
>   so those chips can work.
>
> Tested on msm8916-alcatel-idol347, which probably has an
> si-en,sn3190 or si-en,sn3191 (only one white led indicator).

-- 
With Best Regards,
Andy Shevchenko
