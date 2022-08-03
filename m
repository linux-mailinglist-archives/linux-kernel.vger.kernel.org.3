Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54395890F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiHCRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:05:51 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DC13F71;
        Wed,  3 Aug 2022 10:05:50 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-328303afa6eso26866077b3.10;
        Wed, 03 Aug 2022 10:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bhOSVGE3Tx9C5nqtrK/UZTcc+tPCeJhL9zQ8m19yaEk=;
        b=6QVk44y3BAsx+EcDBU2kGjZpH2bkHt3hk+dKRscjUSEV5IbCRy1AeZGNgWcOFCyYTf
         RYaIgX0IIbuoHIVf9InWaI4EITSC3HCPWQtSG/yf0uIbzS3/vcK7nLJXq7P0Od+1+q/N
         0wPpniKw9jEFNQz0OUFsHN1Isfhexbb2K08LbkxuiDGTOAdgz1kfkBI0hVicMCkXFpXn
         BaPaiDa2XNfT53tpZh6Bj+KUslaQlht3S+iN5GVosXzrXNJO9uVeJuKFdV90m70PAxjR
         DsKjVKTYZuidTgYlM3xhDwF27dlddNEWyyLyhX7MX8tU3Wgv0nw+kDSJywzIg/8R4rdf
         2ORA==
X-Gm-Message-State: ACgBeo1lH7opDV16Nw+wWYpXl7asJ5JZ9xX318HI7d96WjuoI9mIUa9b
        OF5BQB4PNUrWK/9VxYi4WcLlMtEGSk7FvykzOreCZMEh
X-Google-Smtp-Source: AA6agR5KqOEym6pHgkRKEMzkCpe0adUXnHNaV4qwJviHjOaYlT8gAkl9UrjhWwJB/unaWCjW05FAeWhxQFPqJO6IfTs=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr13221615ywd.149.1659546350173; Wed, 03
 Aug 2022 10:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220731141352.7caa1a69@endymion.delvare>
In-Reply-To: <20220731141352.7caa1a69@endymion.delvare>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 19:05:39 +0200
Message-ID: <CAJZ5v0idi1+Rzgqgr0H3_d_SB6B41hoZ0TJ2h8j8iK9FQPNGbw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Drop obsolete dependency on COMPILE_TEST
To:     Jean Delvare <jdelvare@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Talel Shenhar <talel@amazon.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 2:13 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Talel Shenhar <talel@amazon.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

Daniel, I can pick up this one if that's OK.  Any concerns?

> ---
>  drivers/thermal/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-5.18.orig/drivers/thermal/Kconfig     2022-05-22 21:52:31.000000000 +0200
> +++ linux-5.18/drivers/thermal/Kconfig  2022-07-31 13:51:55.009394318 +0200
> @@ -221,7 +221,7 @@ config THERMAL_EMULATION
>
>  config THERMAL_MMIO
>         tristate "Generic Thermal MMIO driver"
> -       depends on OF || COMPILE_TEST
> +       depends on OF
>         depends on HAS_IOMEM
>         help
>           This option enables the generic thermal MMIO driver that will use
> @@ -496,7 +496,7 @@ config SPRD_THERMAL
>
>  config KHADAS_MCU_FAN_THERMAL
>         tristate "Khadas MCU controller FAN cooling support"
> -       depends on OF || COMPILE_TEST
> +       depends on OF
>         depends on MFD_KHADAS_MCU
>         select MFD_CORE
>         select REGMAP
>
> --
> Jean Delvare
> SUSE L3 Support
