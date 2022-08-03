Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8796258911A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiHCRRA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Aug 2022 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHCRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:16:57 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A214BD2B;
        Wed,  3 Aug 2022 10:16:55 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id g5so5001224ybg.11;
        Wed, 03 Aug 2022 10:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=tVkrucCiudsyx1mFT3vVq9clQOmXAUbsmn7GW6+D/E8=;
        b=bEJv1k7kPO0WQDT9fXfWlvmgVZBwS3DkEkfsX7vfku5WNEnv/iT6D+Mz7iC+rOHnTs
         hFzmH6QRrpxFix48MHBa+fXs8ogPQ+EMdUL/ppWQg4nsgLtd7vxhj23ht3gii0DlHUPf
         bmDtmtLlHL4rq+RZRlawe0jqVwmzBfaS3xX39+0iAPDnWzXCASN1RhfWrXx+ku39+g/6
         kYYwxCUaOUK5ZfuRriozlIMGUmV9JCYalZ9CojETyO262x/0nCD+TxV7Df6EBBRFPWu6
         5UHHf6z7WRo1EHSsyzCAF6uttrv876AFRf3oi+s2lPCjIDVB41VQJo72npy+3M8QPUjs
         pZrg==
X-Gm-Message-State: ACgBeo0w34PaZ8deHrRheR8r8WW1PGLM9jQhyHMSpWg/vNUX/VyxXoH9
        UP9FMYsHodih1gCeRZ3y266tc0wwEL43BVY7Fpw=
X-Google-Smtp-Source: AA6agR5y94g6lfVwhfJAawaPYNXyfBaF56BbGZ3vYo034kvqYtQMhuAUgng63ePd6TM3yBwDiFfY7X1HdtZ8qnjkVM4=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr20498350ybm.482.1659547014946; Wed, 03
 Aug 2022 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220731141352.7caa1a69@endymion.delvare> <CAJZ5v0idi1+Rzgqgr0H3_d_SB6B41hoZ0TJ2h8j8iK9FQPNGbw@mail.gmail.com>
 <31d5794f-de7d-373b-641e-e2fa62987138@linaro.org>
In-Reply-To: <31d5794f-de7d-373b-641e-e2fa62987138@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 19:16:44 +0200
Message-ID: <CAJZ5v0jwadU_Sip-7GJiGG68Vo1KqOSfFB5Hpxqa+_P38AK1oQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: Drop obsolete dependency on COMPILE_TEST
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Talel Shenhar <talel@amazon.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 7:08 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 03/08/2022 19:05, Rafael J. Wysocki wrote:
> > On Sun, Jul 31, 2022 at 2:13 PM Jean Delvare <jdelvare@suse.de> wrote:
> >>
> >> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> >> is possible to test-build any driver which depends on OF on any
> >> architecture by explicitly selecting OF. Therefore depending on
> >> COMPILE_TEST as an alternative is no longer needed.
> >>
> >> It is actually better to always build such drivers with OF enabled,
> >> so that the test builds are closer to how each driver will actually be
> >> built on its intended target. Building them without OF may not test
> >> much as the compiler will optimize out potentially large parts of the
> >> code. In the worst case, this could even pop false positive warnings.
> >> Dropping COMPILE_TEST here improves the quality of our testing and
> >> avoids wasting time on non-existent issues.
> >>
> >> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> >> Cc: Talel Shenhar <talel@amazon.com>
> >> Cc: Neil Armstrong <narmstrong@baylibre.com>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Daniel, I can pick up this one if that's OK.  Any concerns?
>
> No concerns, I'm fine with it

OK, applied, thanks!

> >> ---
> >>   drivers/thermal/Kconfig |    4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> --- linux-5.18.orig/drivers/thermal/Kconfig     2022-05-22 21:52:31.000000000 +0200
> >> +++ linux-5.18/drivers/thermal/Kconfig  2022-07-31 13:51:55.009394318 +0200
> >> @@ -221,7 +221,7 @@ config THERMAL_EMULATION
> >>
> >>   config THERMAL_MMIO
> >>          tristate "Generic Thermal MMIO driver"
> >> -       depends on OF || COMPILE_TEST
> >> +       depends on OF
> >>          depends on HAS_IOMEM
> >>          help
> >>            This option enables the generic thermal MMIO driver that will use
> >> @@ -496,7 +496,7 @@ config SPRD_THERMAL
> >>
> >>   config KHADAS_MCU_FAN_THERMAL
> >>          tristate "Khadas MCU controller FAN cooling support"
> >> -       depends on OF || COMPILE_TEST
> >> +       depends on OF
> >>          depends on MFD_KHADAS_MCU
> >>          select MFD_CORE
> >>          select REGMAP
> >>
> >> --
> >> Jean Delvare
> >> SUSE L3 Support
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
