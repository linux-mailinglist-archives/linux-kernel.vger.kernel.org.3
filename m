Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCAE53991F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348266AbiEaVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbiEaVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:53:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E322B0D;
        Tue, 31 May 2022 14:53:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so9775855edf.5;
        Tue, 31 May 2022 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jKLy2+1wJ6FvjsseDYfkSRIwq6bSkGwUcxVnEaBaHo=;
        b=k9+rj8JVq7JLtvRHCT0gkLzsoLUqcwgI87tvWqPsUh3pgL8DstthzlcI6SWzSXXn9E
         NoyAF1rZaD7uQPf/fFidt8v6Q0tz1zQZHVpGhsTzAcoyzu2QCTBQuJCN6ghcHA7MHG/c
         NyBud0an2JLkmdzTZpxRg/SbQciP9LNFZ+5k0HcsB8L2/Oh02JKB0JFihba6zAqqKzLs
         xlTqiIZQi+G61Apnx2aPPc8u2hLXtRbbi5vJtxNd0flO9/LkA3AWxmjXx3Ehoptb2WuV
         N92wj3PeCZ7HaOagNsAi1c7e3ZdHhlqXTUhRrXQpNImp9pGf2/vIyGYaJQwLj72MoGek
         A3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jKLy2+1wJ6FvjsseDYfkSRIwq6bSkGwUcxVnEaBaHo=;
        b=bPPpBpn99Uz30R5IfSB7dzxFH5byBc2jTMsW/Fjbrh+axvQNgvfNuAu03njg0BDQjM
         4vlht8FqpcV21o02mhIOhD4xGLq85Gl4Mm7JeJMzn/HUitdQbRVBU6U/wC4Yuaeg4drC
         FyyGLZdE65zIMqKlQ+Nnrnd3vPgIWgsjjwrNMkPjcneTNOsHrHfoE0c/s6uRnYiCwjS1
         tIwGnmZJfMTlvL27YmsF/P52mKKA6yd33dg2WJ5XoZYPuogT0Q+ZiVXAqxU7NSZiJLzu
         Hq+5OikBMK29XYFIlo6M6g51PkJyKtnEoAllmPTzrd2H5dwF02AdUtr3imqOcWQw7GZS
         2lCA==
X-Gm-Message-State: AOAM533vYUgSmPIZZeBBS0B8CNFV9zymsgcTwV4tASn4WnYIvlOqn1kH
        4QpLr4aNcL+KswzaocC4XQt/NuC96UXI60NGIow=
X-Google-Smtp-Source: ABdhPJw7V2LqbZ6gntsjtVD/ZVuc1e6nKKIT+I2uXvIrAVuxJVfdZuF08H/Htj7WTo432yGeoXe+1LvBNyhatPFpxxE=
X-Received: by 2002:a05:6402:254a:b0:42b:6c9a:c06c with SMTP id
 l10-20020a056402254a00b0042b6c9ac06cmr47865254edb.199.1654034017881; Tue, 31
 May 2022 14:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220531211842.71998-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220531211842.71998-1-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 May 2022 23:53:27 +0200
Message-ID: <CAFBinCAXPGXmuChU9XrqbH4Di6L6rSihM3VSqfFzMrK0D4bLuw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] iio: adc: meson_saradc: Convert to use dev_err_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
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

Hi Andy,

overall this is looking great - thank you for this patch!

On Tue, May 31, 2022 at 11:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
[...]
> +       if (IS_ERR(priv->tsc_regmap))
> +               return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap), "failed to get amlogic,hhi-sysctrl regmap\n");
checkpatch complains:
  WARNING: line length of 115 exceeds 100 columns
  #44: FILE: drivers/iio/adc/meson_saradc.c:728:

Adding a line-break right before the error message will solve this problem


Best regards,
Martin
