Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8A4896FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiAJLHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiAJLHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:07:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D28C061748;
        Mon, 10 Jan 2022 03:07:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q25so43391102edb.2;
        Mon, 10 Jan 2022 03:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=he/R3Z0mxeByAmq12pzMewiN4Rzgf12JiYvzrsrEGrA=;
        b=hS2shLvL+GHJaqJ0aanryf6/X8+QltBMpM9pKVb8wdYXa6jMlRy1F9iQx9G+9N14xx
         j5xCMC7fFSnvGiwyIS6dtf4OdNUun8wDlOvadcUKWkG6fhKeFthdUNPFSUXACeKzpIJC
         CGqhb+DRx2379mgb6EefwIHefVwC1KhYypCauq7rxxxKUaLk/nAqcGEeesIupK+B4zXT
         S5KlGTqSvSzS8EWCARGEWbE1yuGN/t0MllZUs485ClS6U92hfmEbEjSIRvSeissXd7Ri
         pknhuXSO2r/TlJY6tBEtwq9VEeuqm01fFo4JbucCci2HJjaX49HlY2En2ze0WRYz8dt5
         +U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=he/R3Z0mxeByAmq12pzMewiN4Rzgf12JiYvzrsrEGrA=;
        b=PFiKcETsknDieggpVeUhWgrZqrSuKdPED5HA7e2a08G3lnzsbnQFrHNuEkdGz36GOi
         iStR+7Jkvdozv0dGvKdq3uNfqSocT0MmSKP2bQvVbIdJWdYcO1ByU61EjddTSr/+XVMF
         S7N+xJFC8xMmQtFbf8wDMZ7KR6JcHMGMEPHwKUY9RskOlSq238N7rd0ocj/3yLZYeAd/
         8P7+20aSZ5Xc1bnfiDXNxFEL8G1pfh46TwkDbT9ydTJIXDGclhZiK9rlg1/I+4bQMWmn
         yqmJqHGDBundw5KJFIwcIuM6vPHfDaJqNrbKJ0F+bRV6O6L/xK+8fpcXVKW3gkGmcn6W
         lmfw==
X-Gm-Message-State: AOAM531EAGrw/aAUZIICkyGjix356wq9n/fiT5Es1qlyz9KSYp2z0MVn
        OCCdnWBDIr0YUJjGL8jQw9/vJ90PyEK5bH9HWbc=
X-Google-Smtp-Source: ABdhPJwXdkbSUcWuHHd7MLqZaW6aVwLYP9a5QUocFvToL9VRPU2AMhJpYaJn7xWGlM1YSGkcNy6izCsZ8shqlYkuJl8=
X-Received: by 2002:a05:6402:34cb:: with SMTP id w11mr52430edc.158.1641812855397;
 Mon, 10 Jan 2022 03:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jan 2022 13:05:47 +0200
Message-ID: <CAHp75VcF2Xg4dz7Ea1L653wRqAgSJZvbwua1oWzw-Lsqttxvng@mail.gmail.com>
Subject: Re: [PATCH v2] iio: stm: don't always auto-enable I2C and SPI
 interface drivers
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 9:30 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
>
> This patch makes I2C and SPI interface drivers for STMicroelectronics
> sensor chips individually selectable via Kconfig.
>
> The default is kept unchanged - I2C and SPI interface drivers are still
> selected by default if the corresponding bus support is available.
>
> However, the patch makes it is possible to explicitly disable drivers

it possible

> that are not needed for particular target.

a particular

...

>  config IIO_ST_LSM9DS0_I2C

> +       tristate "STMicroelectronics LSM9DS0 IMU I2C interface"
> +       depends on I2C && IIO_ST_LSM9DS0

> +       default I2C && IIO_ST_LSM9DS0

Have you tested this for the case
I2C=y
IIO_ST_LSM9DS0=m

So, what is the result?

-- 
With Best Regards,
Andy Shevchenko
