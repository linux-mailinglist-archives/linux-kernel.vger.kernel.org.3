Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A24550A4B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiFSLex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiFSLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:34:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974611A2B;
        Sun, 19 Jun 2022 04:34:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so16189728ejg.13;
        Sun, 19 Jun 2022 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utuT6cM/eVUrce22kFa8LNAWsGwMTCB+s3XUZ2ZFqjM=;
        b=mXgpt+1B6pqO42lHUT4jA1tBiM52Ug3Jpsxo+tK8ynedBHMa0VbC/QlOY/k4MQWMIL
         sZ09fZTms2b0ER5ORbUV+AX0NpK9/vcWO6oxJlfxH6/poht8DdvaFuHJGhHEaQtJsE1P
         OcwbY/e+e2vNcoQeajDAVuJh4IYmXG2JL0WOvgETVXPqR7IcYrGQzerGpV/X0B9bhIw+
         iMuN8X4ElDnEYoEBQUr5TUkYPfadYvNEmbfNJL/1SzKuJSSRoLDx2bl3NNAk6ghs/cRs
         7HoejQdHbldmsGCRLJrfObwS8N7DKAUIfrzn1imoD3QRQbik5i3O0P4KqtqbfhZvYM5j
         d/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utuT6cM/eVUrce22kFa8LNAWsGwMTCB+s3XUZ2ZFqjM=;
        b=QZ0GGwh21avu0JOI3p725dk20yUNXQqF3Pa8F8YeVTcQPfxHLL3w9tdW4wSwMGrMCn
         EcWrWsDHn/KaLN7T9tXbkMwhzX6VdIP5NQnbSyq502Tx6cWqcP7MFd2sfTdvE7E580ff
         hEPslnXJIw5GV8Qe29l5QfKMqqnnievSN4kNzUJKGW8C9IO0PMgroCLKnZ+RPjwIK7QU
         r+vxjgL1D4kLOsXdHlw6DCdXC5vu5Wa423lvTWd2oBfXja+ZhJ6L362mV45RouJEOSbH
         IHnBKLHfZVOB8DXrn9TGYlmjDBMzvwK+t/25zyYAkmcCth9TcMKuOoa+PeAB7Y7LNii7
         eJZw==
X-Gm-Message-State: AJIora+iqQspd3763niDHp5gbpXzZFYlPJum66k6DmMS8P3oDyEhZfCc
        ElnNSUCwaN3J0kWAf/RSTPV9p+MFCz1eYFS1exs=
X-Google-Smtp-Source: AGRyM1tCsOw9ij3ODqUgP7h7NTNnUNkfZS+idLN4MZUsf44yfptBhZ7vjHap3gjfMwCJ8VWkccJjC7/adSSxTpLE/88=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr16875033ejh.497.1655638489111; Sun, 19
 Jun 2022 04:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220618165747.55709-1-samuel@sholland.org> <20220618165747.55709-4-samuel@sholland.org>
In-Reply-To: <20220618165747.55709-4-samuel@sholland.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:34:12 +0200
Message-ID: <CAHp75VfM3L-bKOLoXTz67JCWq8UX6d-LvuYDxXMtTBznGOTgSA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] Input: pinephone-keyboard - Support the proxied
 I2C bus
To:     Samuel Holland <samuel@sholland.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Colin Ian King <colin.king@intel.com>,
        David Gow <davidgow@google.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "fengping.yu" <fengping.yu@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
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

On Sat, Jun 18, 2022 at 7:12 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The PinePhone keyboard case contains a battery managed by an integrated
> power bank IC. The power bank IC communicates over I2C, and the keyboard
> MCU firmware provides an interface to read and write its registers.
> Let's use this interface to implement a SMBus adapter, so we can reuse
> the driver for the power bank IC.

...

> +       /* Read back the command status until it passes or fails. */
> +       do {
> +               usleep_range(300, 500);
> +               ret = i2c_smbus_read_byte_data(client, PPKB_SYS_COMMAND);
> +       } while (ret == buf[2]);
> +       if (ret < 0)
> +               return ret;
> +       /* Commands return 0x00 on success and 0xff on failure. */
> +       if (ret)
> +               return -EIO;

Something to use from iopoll.h ?


-- 
With Best Regards,
Andy Shevchenko
