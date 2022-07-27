Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002F583166
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiG0SDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbiG0SDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:03:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7113BA25D;
        Wed, 27 Jul 2022 10:07:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j22so32689190ejs.2;
        Wed, 27 Jul 2022 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVg/eCwNEIrx6GRerxc0709vpghlaEmW51aLjLi1e8M=;
        b=aBwCoXN2wnVKVkPRdakVvqRt9OJEGqlZECFjMrYlKVN8Pi/Euh2FJp6eeRrhnN7vvh
         D5hs+lkE4mTCoGOw8jmWQ+hCAQBlinwauJBP8ikzrBKABHI4C8Q6dLNHtwrBuJjiC2XF
         OSa8Qu3DuOUzIZnlMrZt72xitoP4TR85WXqQ5BJAvuvyrxr5NVTLJw6at+lmAVgk8sb9
         8ROjypMMo1taArfugWKRNiiSzCJWn+EVwylRRNKOIalts9Y4W7u3XiRaAwWlZrVmb0fi
         s9/rxXh2m3R7L7/zOrlbSbB9a4atHCn04qXjEnVNYzK1gfZf0S53BQ49QeJ+i7kKAOw/
         l3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVg/eCwNEIrx6GRerxc0709vpghlaEmW51aLjLi1e8M=;
        b=egwn2WbS+3QJlW2jKrIptMtPZncjj6CIgX+W08mQZsrW9zjvpt3fPgfCEn81+UCcHy
         ixdPw5yVvNWiw1AXV8gH2DoNN21fwcfE4chk1qBCS6rdB1VSxA4rny2sFPQ0IRnNOsMr
         hR7Uigy+/lyJjpDZg97kypWcxmwFJ6G9hOLuTwFrBtFSuF0WMi7cniH/bTtkKvvIJLJL
         Gi1Bt2MrzC/LVCHk8jz9mc8vsoK5hSjlAdsgBAAl5FfMsN9tGwkfW3NoSsmpSeqv7cXL
         EeRqmKyYEdGyUkvddeo9t6DVbWwNklMig5I1lgv//huXeDF2cAXr298KvZk1sR3RlWa1
         dvbQ==
X-Gm-Message-State: AJIora80n2ZNKgjbM7Ft9L1q0xTPeC6DvD5tOFB/p31C/Oj1F6inRJbN
        7YEoEKyc0zmNWd2QqHZvU20fCgJeaCvY0a03DLwtPQ4YYrk=
X-Google-Smtp-Source: AGRyM1s6sTGx30blMAuTLfPmqIwH+qYP4Utw4B1oiVWxPTYrpZnNjkN4aoiQk75FuLt6fBQ2VZ2OX1sIEskVL6+JgPk=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr17542758ejc.242.1658941620460; Wed, 27
 Jul 2022 10:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220727164133.973930-1-potin.lai.pt@gmail.com> <20220727164133.973930-2-potin.lai.pt@gmail.com>
In-Reply-To: <20220727164133.973930-2-potin.lai.pt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 19:06:23 +0200
Message-ID: <CAHp75Vcar4Ufg1UpS6kGcieBCAwVh_KiUgiMEDJugb1YqO_FHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: humidity: hdc100x: switch to probe_new callback
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jul 27, 2022 at 6:43 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Switch to probe_new callback due to probe is deprecated soon.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 9e0fce917ce4c..0d514818635cb 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -351,8 +351,7 @@ static const struct iio_info hdc100x_info = {
>         .attrs = &hdc100x_attribute_group,
>  };
>
> -static int hdc100x_probe(struct i2c_client *client,
> -                        const struct i2c_device_id *id)
> +static int hdc100x_probe(struct i2c_client *client)
>  {
>         struct iio_dev *indio_dev;
>         struct hdc100x_data *data;
> @@ -422,7 +421,7 @@ static struct i2c_driver hdc100x_driver = {
>                 .name   = "hdc100x",
>                 .of_match_table = hdc100x_dt_ids,
>         },
> -       .probe = hdc100x_probe,
> +       .probe_new = hdc100x_probe,
>         .id_table = hdc100x_id,
>  };
>  module_i2c_driver(hdc100x_driver);
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
