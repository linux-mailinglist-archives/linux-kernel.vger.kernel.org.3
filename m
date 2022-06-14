Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B753654AD23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355197AbiFNJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355009AbiFNJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:20:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C543EFB;
        Tue, 14 Jun 2022 02:20:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id me5so15987031ejb.2;
        Tue, 14 Jun 2022 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3+sUBnVwO0qXGbKWo8BCJX4H449NsANimZebun/fCg=;
        b=W97lADb2n/hoZttTeIOlnMYAkm9WoXFeUjSL4fbVaqp9/03cG46j9a5a7+qkZdqnLY
         LqigoZacQepZLSq8xPn1yGLj5+5issdemph9AMY3JorgT/3iDvpUoxj1V3Y1ZxiOhPEj
         6DuLolnCSbW8cTnpLpxnodotVB6cTPuDB2tbTHjkFURQieYOC3ffZZkHh5whegzn3tKB
         wKNYcWVUDfmIMp0W9uQMFh3CUhAgx+hWrVI1ew/CFc6uO+cg+RLnVDBK1meYBkbRf/07
         0Yt936sWyAq12inUZsfGsTc2zlbBikWIgR5Rb60mVww2Vx9RfyhGTm6IWYpv4+ZCCHyN
         8O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3+sUBnVwO0qXGbKWo8BCJX4H449NsANimZebun/fCg=;
        b=Q6KkJSnyO+FJIjeMMrnCIkRsRCZIGy6Bj/aVwo/yTdC+nodI7fkoiHxboRaTVcacx4
         FM38s1lLDJfQd4gc2/TiWUMh6qXJuYC7SxlidmAmRgtAbEkxRitv0DHs5W0RNUv/+2ic
         MUA3NjKp5dBkm7R08stO4N/u10xhYE71yZqfXS7kl2iWVWqDpiymvQgbryxacWKaYepF
         5lesFmJht3/mabscMlvohKoozw2IkEXpeV27cTzEZqqgVFlfVGBVmDKB4AbvgzXJWVWG
         PllbecTXO652BjRTcrB5yPosclhJI95xc2FnU6cy0c/sjXbwdajk7tESZgO27HQZsnho
         eyKw==
X-Gm-Message-State: AOAM532/OlV1syEyBHDWnxCspfKCpKTvbGtHuImXvgYcFc576i5k00/S
        1k65Eg1Mb01tdwx3EIT7V4OCWoovXBHtKQpsHRo=
X-Google-Smtp-Source: AGRyM1vTq/HKieNAD7SqyS0BWRxRT588ep7HL27SG7Rcyjq7pBN/oR0IU2NYMP9bAd0GqjBBlkD9loZctdaJS0okOKI=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr3331352ejc.132.1655198439090; Tue, 14
 Jun 2022 02:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220613191706.31239-1-jagathjog1996@gmail.com> <20220613191706.31239-3-jagathjog1996@gmail.com>
In-Reply-To: <20220613191706.31239-3-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 11:20:02 +0200
Message-ID: <CAHp75VdJ7z+GnEGEe2obd8Df5mJtNGQASf1c7WWXJVQ1Db8U4A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: accel: bma400: Add support for single and
 double tap events
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

On Mon, Jun 13, 2022 at 9:17 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Add support for single and double tap events based on the tap threshold
> value and minimum quiet time value between the taps. The INT1 pin is used
> to interrupt and event is pushed to userspace.

the event

...

>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/sysfs.h>

s is before t

...

>         bool step_event_en;
>         bool activity_event_en;
>         unsigned int generic_event_en;
> +       unsigned int tap_event_en;

Should it be boolean? Or i.o.w. why does it need to be an unsigned int?

...

> +       data->step_event_en = 0;
> +       data->activity_event_en = 0;

These are booleans.

-- 
With Best Regards,
Andy Shevchenko
