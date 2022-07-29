Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B915854E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiG2SF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiG2SFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:05:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089866343;
        Fri, 29 Jul 2022 11:05:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o13so6787830edc.0;
        Fri, 29 Jul 2022 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iom84cdy4ZRx3/XZL1kBcDuZ4qoJIboGi9y5F5LZ0lQ=;
        b=NdoUncLDaYmnIUxtp5QVY9G2fPgach/XbR+dNwlKeuehWymokowysST4sRUyAw4WEh
         DjacYZHmKyjP2W9Iq/wNAaWMVQRiAVnrX+xFjQRCXlFwUFq6ndfrsa3YXxYWag4eJ/jJ
         whj7ZuEqLecvy/IViifSa70N7WpkRYfT112AaWtX3g2CkJB1kFfqwZSebYDxjxMDduOa
         3nNMz6OoIzOiLE+OXeH3IyPwvj6oLE9rlPrUej6Do3HhxmeqhFlPVEZdm88XZm+NaSFz
         5KKWPPqTrsB3TntrxpY/KgYdLYZbChPc9OVyipeEG19V7+0nNO1CI0HTKcfwGUe78PCw
         HyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iom84cdy4ZRx3/XZL1kBcDuZ4qoJIboGi9y5F5LZ0lQ=;
        b=66B2W1huxerKARLwfj1qFi6B03bAF82zVwRlI+oAYHLxg6PC7cOcSRPQP6zWOf4DB8
         nZTzWQ3WJ4tcmC+rSKsbmYKjnRiSN1tVgzpYDQM2qNsnUr7+wgHhoPEaiZwgXxkyisNP
         sJZFl6YA2O7Gu5/MjKSgKA1CA/TCk37O7o59770UsM1jEfD/HkEhAnRdLUq81V6KNE6I
         gi9gCQK1QON87CbIQw8A0a0k75Mv3XGRtxIusJgZ2GK9U5mFFGUp65D+h2wfSlDFafux
         A4ZSPl8YyDM3H6KPcWJ39+Xu/89Jlvv7r4RNFYUQVAEZWud6kLT3vMK20BWxElWWiaga
         g1hA==
X-Gm-Message-State: AJIora+m7ZiAfau7jC8wFawU2BHH1zB6LM+md+prwux6kTKFrjDoIIRF
        qtm1TCg+O8zJ56IPpF31G2sh4UZUQXK+wV9LkGg=
X-Google-Smtp-Source: AGRyM1v/Ky20zvFr+UmFkVa5hY4ozP18Br1JReADo3/hNo0NlgVy3drn5gOpUNAtEnMHQQMv4ZFCzSG/Bvf/nd8XwQM=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr4757299edb.380.1659117915324; Fri, 29
 Jul 2022 11:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220729172332.19118-1-ddrokosov@sberdevices.ru> <20220729172332.19118-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20220729172332.19118-4-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 20:04:36 +0200
Message-ID: <CAHp75VebuSHm38izDYYaSh0jXORqnjenEYmfXcHPOMsfvs1F=w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: common: scmi_sensors: use HZ macro from units.h
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 7:23 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> Remove duplicated definition of UHZ_PER_HZ, because it's available in
> the units.h.

Fine to me in principle (whatever name it gets after all)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 793d628db55f..c6d2cf5504cb 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -18,6 +18,7 @@
>  #include <linux/scmi_protocol.h>
>  #include <linux/time.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>
>  #define SCMI_IIO_NUM_OF_AXIS 3
>
> @@ -130,7 +131,6 @@ static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
>  static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
>  {
>         struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> -       const unsigned long UHZ_PER_HZ = 1000000UL;
>         u64 sec, mult, uHz, sf;
>         u32 sensor_config;
>         char buf[32];
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
