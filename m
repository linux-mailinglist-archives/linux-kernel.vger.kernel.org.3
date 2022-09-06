Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C545AE54B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiIFKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbiIFKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:23:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51826744D;
        Tue,  6 Sep 2022 03:23:56 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id w18so7753536qki.8;
        Tue, 06 Sep 2022 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=H5pwFuAZZMIj2I5RRhlxNYuTG6MvUnIlXueGXDyqSJg=;
        b=Xip/MmcIt3saImEZ4NETjHwC4FBksGOTicSfSgqhDka/sY6L5i0Dy1vOUvd34Vfns4
         WqsXA1fVyf40gnY77/DLzA5/WCO7tXOcclA3KPmYcgyzPytsLzBCnSTmSJeLJk2lMRvh
         SMmYxN4AngNhbq3pafZJru7v4i1Gaxe5RmuU+nFA4X61mQOsVXrjWG1t2E/AAf/mS+PL
         OEXF0baHxjj5qwDMg0AMoGnm6rZdNhZN9qUuBdij4BEPYfZGWjSRR5cOVrirViTBNtyp
         02QLmXnpmP9gGrvaDVjvyHivGD0DsJfFTH6SxLcJGPIjwDUXIM3z94izMZVK11g6mlQY
         bOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=H5pwFuAZZMIj2I5RRhlxNYuTG6MvUnIlXueGXDyqSJg=;
        b=E+5I3pcGn0kv613XdPQqR5IRaY29K/QXom+VIOX7AGrDORDwx14R7tXgTAcu+mkuMR
         5j0zLlQr/xKA1sO5M7/TcKAMpA2L061OkWLs/0WFdCRzX3uxqojNhZ/E2yypST62IDLv
         fWcwH0XhmLVVNsZ9V/Fd5zhSNVoUqAYCtjBU+TnMOZZSS3BQsPbQRbWbLZxikXLnhy+T
         jmYtfIDaTudxOOoS5RMAwtKttvXq0bx9ND7+GyeAhx2+hEyTpRRYml5lAiRPT6kLDJ7s
         jw0NqgwsGrnPsKCzfCC5rrEqIhV3iXqZQLb4IRUY4d6NzOwMzoTnUB5KkjyWpeN+cEvQ
         AS4w==
X-Gm-Message-State: ACgBeo0+FC8cnE2WCVI5dwTXhBZOddhMlI1nWBnT3P5ww9TLAEFiTfdT
        aYDcCZKNd+7proSnAS5276nTPhVflfJsgdgaOoDgelhzRII=
X-Google-Smtp-Source: AA6agR5Ae5z3esG3Zofnkg6MjIMHHcJ04AbLL4B5WLdGfXAk7PpYzu2605HJduqrw5am+5/Zz2jQ+6IMB1abx15M9/g=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr35278732qkf.320.1662459835399; Tue, 06
 Sep 2022 03:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <61da82560512fbbda5f4124a1c907375da822b15.1662454215.git.cmo@melexis.com>
In-Reply-To: <61da82560512fbbda5f4124a1c907375da822b15.1662454215.git.cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 13:23:19 +0300
Message-ID: <CAHp75VeUN3apcuauOSy6+jEP94vinuT8vdR7=B6yRC5mx2B2Dw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: temperature: mlx90632 Change return value of
 sensor measurement channel
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Sep 6, 2022 at 12:05 PM <cmo@melexis.com> wrote:
>
> From: Crt Mori <cmo@melexis.com>
>
> The current EINVAL value is more applicable to embedded library, where

an embedded
  ...or...
libraries

> user can actually put the fixed value to the sensor. In case of the
> driver if the value of the channel is invalid it is better in inform
> userspace that Channel was out of range as that implies more to internal
> driver error than invalid input. It also makes for easier debugging of
> where the error comes from during the development.

As I said earlier I'm in favour of this change to at least make good
use of this error code since it is confirmed to help debugging.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 6b33284eb0b6..aee065a38772 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -436,7 +436,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
>                 *channel_old = 1;
>                 break;
>         default:
> -               return -EINVAL;
> +               return -ECHRNG;
>         }
>
>         return 0;
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
