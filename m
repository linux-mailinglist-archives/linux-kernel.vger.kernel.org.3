Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809FA54AD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbiFNJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiFNJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:28:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC927CEF;
        Tue, 14 Jun 2022 02:27:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eo8so2513533edb.0;
        Tue, 14 Jun 2022 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOAq4VksaaTkAqP72HdVciTjPEeSkHTzi3HjDdbvvMI=;
        b=Mlda03Yxqw6tVWsedmiUjVE7dwb5T7VQngiXsB6ZzjaTerumIr2afuXxJEnmmFSDJr
         Tl+Dc/Up415HB/hGXLr8OkFjRbCu8UxoRSEs1BA4M0pO3OVa3ev8x3dZh6D+HnuPcuWY
         nHjDsv60J/IbZ04L2vaZGeN1r0C1ZEizLKuZS7J4V9ccAtdQBlelkre+albAPpj67XAL
         f9dB1T+2mIZkYzj0EMLDpzS8mfLEP5UVyaHzpeFeqyXCy88U6w16MhhePsS+AsGlswyP
         +VEsDsSZigH3JDfWJ9uSW7EfnPurDWvhaQiu3aCKSCk4iJqK64yNE12Cx7fPnIGMrsZU
         /Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOAq4VksaaTkAqP72HdVciTjPEeSkHTzi3HjDdbvvMI=;
        b=SDIV7ieksBZDwJ4Aw6H0Yvr9MQwHUmDOlkoeOqvhE7rkfiRGTdL/EAQ1cUeDC0/ZSk
         87/Xji53bftDp4CyVjW0NwsSpa9Ngm6WCC40/9mtd3GyKD+I1/2PQ2KB8FzBeQY96g+l
         DGBZhn7wAV3Jz4VkrrcxedWZLwtc+ClijBDdcVG3Ge0KQFoyC52jEuuh9xDIqxqWDl6P
         tDzhc/k2EysNpYrZLAVz4E9Kc4t4WwyUXkYTO4ujZyeUsGZz/RJfTfTPcCz4T8laoqBI
         Icg4aDl7T273LyUfbvHYqpE8vxUOkzvald4kILbeDfHHck9azdeURfKcpuRsP0CHKMbu
         svQQ==
X-Gm-Message-State: AOAM531m+53L6a6TCRvs/tsv/sXNcoo9KWMQHxOi+SsfbjDVhLOqmW6D
        EVgtb9cfvQE+lcoyKluhbwO+WhnjeJe9RwbIAdE=
X-Google-Smtp-Source: AGRyM1vdg1FP29O+B8YHnb8sIyfJscVMzEmdoHlCmMY8djXAVhSI/XJmtiI17UcLO/cYVxBxiqT41qFcVJyV9m7TZRU=
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id
 j18-20020a05640211d200b0042de68aeae0mr4670452edw.111.1655198878304; Tue, 14
 Jun 2022 02:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com>
 <20220603180618.4b643391@jic23-huawei> <CAPUE2usmrREACn+bjRfMyNvF1aeozJq+tHCQY6XT7KMXvp94Bg@mail.gmail.com>
In-Reply-To: <CAPUE2usmrREACn+bjRfMyNvF1aeozJq+tHCQY6XT7KMXvp94Bg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 11:27:21 +0200
Message-ID: <CAHp75VdLMCBhhM4P_asTf7r+OhBHmgJVCg7MADkOYRTf1JvRaA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx_common: Allow IIO core to take
 care of firmware node
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
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

On Mon, Jun 13, 2022 at 11:31 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> The reason we have the code ACPI_COMPANION_SET and dev.of_node set (by
> commit 74a53a959028e ("iio:proximity:sx_common: Fix device property
> parsing on DT systems") from Stephen is we are getting device propery
> in ->get_default_reg(), which is called in sx_common_init_device(),
> before devm_iio_device_register().
>
> We have the same code path in other driver, like adc/stm32-adc.c,
> where indio_dev->dev.of_node is set manually to be able to set the
> resolution based on device tree properties.

Ah, thanks for this insight! I will rework the patch accordingly (yes,
there is something to clean up even in this case).

> On Fri, Jun 3, 2022 at 9:57 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 30 May 2022 20:43:26 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > IIO core correctly will take care of firmware node if it's not set in
> > > the driver. Drop ACPI and OF specifics from the driver and allow IIO
> > > core to handle this.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Looks fine to me.  As such I'll apply it now, but Gwendal, you've
> > been active with this driver recently so if you have time to sanity check
> > that would be great.  Once I've caught up with new stuff I plan to check
> > where we are with your various series on this driver.

-- 
With Best Regards,
Andy Shevchenko
