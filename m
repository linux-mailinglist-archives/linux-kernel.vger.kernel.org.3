Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75F5331F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiEXTwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiEXTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:52:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204FA63BC2;
        Tue, 24 May 2022 12:52:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s3so24377615edr.9;
        Tue, 24 May 2022 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWO0Oz6FSzVSjg0n1qsEvU7TZkBiPIk+EdOl96gTcAs=;
        b=Htr+XH5PLNGhIQwErqbd9XRsT1oKRhWMlJBAiBBKoCJV34QfZsNXKMlu0eW/8LNRYk
         +3rg/s7fkXY/TdPjvKugQdn9hr/0G67aVsRZdBlu8RpagD4pnHkx0aqrM2J6i0DhqWFN
         Ju7+YJHJGgg0SuUGQQIgS/fsb49Rys0XRg8SFrJb/YX6XuA72lFMVN3dhePRkNVbiPrw
         rFSOpABQQ8sF0SnoAGoEYn29DbJnUDzhlKfJsgl9PgE9BDVPa7f9U7W/eFzGYQAiBd4h
         qSa+/RNGrT05vcjwc3asQ7pT3obImfmqWwQzL1QGUr3dwh1SeOpVRBxLhhA7Yp1gl9Mr
         RWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWO0Oz6FSzVSjg0n1qsEvU7TZkBiPIk+EdOl96gTcAs=;
        b=gSWmUgIGBqny3ZHgSevHqcIlwpEJn9n9IKy159kxZxXdYhglItVBYuWi/2+TnisC8H
         v2rw2VP2AhDFaGVfyZgdFv8R8lG8dyNLDsjRglZoNHw1SR1Hpe3lKeV9kXjMItpQ7uan
         lvGmy/DTiVACWDvc5NGQIqAow/qt8eIoEMTCigMtUSaBhTU5cCaIh0Ouc6oKr5iZAc8c
         008h5T6QyBrXIC3+DjssEhSD0LXcgnWk1+0VcLXu3LYbqe3yBrXGPb+n5njFzJ0tgdhj
         /rq7M3guW6SRbIBd2w8kpSEA9MmORTFwQYN36wTZrIUtIY1+rNV6lC8WiD7X8TfHSsQk
         CZtA==
X-Gm-Message-State: AOAM530/HRpOAMETnncXQUwqR9c4fm5Y76k2bqvhDekmXrcFWMASnHVD
        KvwQr7WSHF9/w6+kf6nHHHa8R/nyqW2KTjiOb/4=
X-Google-Smtp-Source: ABdhPJy97bG4vV3JeVnww0FCmSfau1qF0Iljx0lbd9yvGC7C48OGFP80su630DLKX71E0LeRD9HP+ONscpejuQ73ytg=
X-Received: by 2002:a05:6402:1d48:b0:42b:6e02:5ece with SMTP id
 dz8-20020a0564021d4800b0042b6e025ecemr11121787edb.178.1653421958614; Tue, 24
 May 2022 12:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru> <20220524181150.9240-6-ddrokosov@sberdevices.ru>
In-Reply-To: <20220524181150.9240-6-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 May 2022 21:52:02 +0200
Message-ID: <CAHp75VeF-ApaW1LKsg6HeQiYZ6aDubN093DU0hSBKcjR5qH+Yw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio:humidity:hts221: rearrange iio trigger get and register
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, May 24, 2022 at 8:14 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> IIO trigger interface function iio_trigger_get() should be called after
> iio_trigger_register() (or its devm analogue) strictly, because of
> iio_trigger_get() acquires module refcnt based on the trigger->owner
> pointer, which is initialized inside iio_trigger_register() to
> THIS_MODULE.
> If this call order is wrong, the next iio_trigger_put() (from sysfs
> callback or "delete module" path) will dereference "default" module
> refcnt, which is incorrect behaviour.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo device")
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/humidity/hts221_buffer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index f29692b9d2db..66b32413cf5e 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -135,9 +135,12 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
>
>         iio_trigger_set_drvdata(hw->trig, iio_dev);
>         hw->trig->ops = &hts221_trigger_ops;
> +
> +       err = devm_iio_trigger_register(hw->dev, hw->trig);
> +
>         iio_dev->trig = iio_trigger_get(hw->trig);
>
> -       return devm_iio_trigger_register(hw->dev, hw->trig);
> +       return err;
>  }
>
>  static int hts221_buffer_preenable(struct iio_dev *iio_dev)
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
