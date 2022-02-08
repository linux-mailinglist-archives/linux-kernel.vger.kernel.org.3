Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD64ADA3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376404AbiBHNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiBHNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:43:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2338FC03FED9;
        Tue,  8 Feb 2022 05:43:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cn6so14804122edb.5;
        Tue, 08 Feb 2022 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4NlyDvQ+OmTWhioc5XIe48Pbf0SWwcG+0BmyfZwVFE=;
        b=InKvcODql4soQETTIoVQwvWCSdhsI4olMXqvYkj6+7nx78OgY4P9Ppbcpbe0Bl5K8C
         pCG8Np9utrrmDQ6BuEoF/qGZtWAFhyl1UvLVi++W2jBkSMCPsSc+mQPIID67reJ7L34p
         F/2ZDRJ642N1nstNdozNlDA5HRXPh9HKLNqBkpL9GYOa89jd7E7HOmivcqEv7Wo/cAgJ
         ZZ3fXK8NNkRSoeUHZnfYWXFbl5XOe/tSFfYjnJ/pgS5VFaskYns0huL9KF/MVQPe5YTn
         TMMzgHKtHH0k++cYe2OeoHVChbWquicgEBYdCEhBEDz2oGZTVZxE1WN/J21bLJbixpAo
         wZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4NlyDvQ+OmTWhioc5XIe48Pbf0SWwcG+0BmyfZwVFE=;
        b=KuWfb9tZffRlUtlE/yrgtElVv6eQ3/r8hnV6i6i9sdWQgsgCO+2Bm3eLHqKlX/MmE5
         N/qwZl7YNzJn9XYfI0KodivkNh+ZCQzy9GQBtYB1Y+HwNRJrxAb14gx7pVkUMBgluyuF
         eXZpF0vCXeCkUjDLyYkw/WBqkx9Z6cdkxix6lUgCgdRCaVGLiHH5TMPKuRAYPdvq5fbA
         +WfKWYFCl6bSkTGJwH2eDWze4tpoY48g94lFYI6ZduDIsx20Vks+Nuzm9JCay/lX955K
         zynuhxXtb4OgKZEELVeJjSsviP7sUdHMrNP17aZs8lN/Qv9Gq7L8c5OcfvhU2rPnB0NV
         dRGg==
X-Gm-Message-State: AOAM532TIbRd7bvp+6PKHbmNJ1c8UebtSokrTuAysXcBt+xUltn11cLQ
        wBFMoH+p+XGazYODYRVgfVUQXRSHfuvge6GaaZc=
X-Google-Smtp-Source: ABdhPJzL1h8uMoMI1YO9mj+zqENB5rXbyS/y1GH2Oy4Usn3dJT9bRKgSvTIO9Olpk7hrj1E2o6AP93f79oomlsyf6Jc=
X-Received: by 2002:aa7:c413:: with SMTP id j19mr3693113edq.200.1644327778649;
 Tue, 08 Feb 2022 05:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20220208020441.3081162-1-liambeguin@gmail.com> <20220208020441.3081162-4-liambeguin@gmail.com>
In-Reply-To: <20220208020441.3081162-4-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Feb 2022 15:42:22 +0200
Message-ID: <CAHp75Vd7OfLyfziraV4AHWrnTSCPPN9gzGNxaFa+V6uNe8-YUA@mail.gmail.com>
Subject: Re: [PATCH v14 03/11] iio: afe: rescale: add offset support
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
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

On Tue, Feb 8, 2022 at 4:04 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> This is a preparatory change required for the addition of temperature
> sensing front ends.

...

> +               if (iio_channel_has_info(rescale->source->channel,
> +                                        IIO_CHAN_INFO_OFFSET)) {
> +                       ret = iio_read_channel_offset(rescale->source,
> +                                                     &schan_off, NULL);

> +                       if (ret != IIO_VAL_INT)
> +                               return ret < 0 ? ret : -EOPNOTSUPP;

Wonder if this actually should be

   if (ret < 0)
       return ret;
   if (ret != ...)
       return -EOP...;

> +               }

-- 
With Best Regards,
Andy Shevchenko
