Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E72511383
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359426AbiD0Ihu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiD0Iht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:37:49 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132E6644E3;
        Wed, 27 Apr 2022 01:34:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ke5so605016qvb.5;
        Wed, 27 Apr 2022 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mts8+CXZqKYubrygYyfb7XAxGiHuoGj/BQDg0sBg5ck=;
        b=OEX1iqG5lS2jmxcFVAzAelcABrA0I4peMSmRW2z2OBvH+oCukYbw5WA7jWS1NODyxU
         dKZGQiFy8LQSexpzD0Hgn42J1xF5DEW1ragAF+9UIGLgc7Xj9yAQVau55vfsLM/b/eX7
         VeYrDKtzCH2mJrSWAeOcJaV4g5J8fG+3D5i30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mts8+CXZqKYubrygYyfb7XAxGiHuoGj/BQDg0sBg5ck=;
        b=QmaGJpJlAs0zqT37lpgKp8SLk87Ax9FDAGrxrtKCbWTnkAHEqPbp0Wx4yBcBc4BvuO
         31j+XgCmKd3uN/jmICd1tNu8jSRZKE7dJW09urhl9/82H2/OKRgJPXe9kh+fCjsKr7fS
         urDFo/VhKLDHQMPU0+8BUy7AOr0WO9w9kxk8yEbSc6PJs1AEV2r2MqsYGt2aIQXVx39Y
         yxI/P26hprmL2kB162ZXEFQjLT6fD/ibSa7gCQHYuwf6XMfFj2g58Hk6hn8ag2bCtemU
         BU8EZMxrYdUa/WIrS/4GXQfTA3cV+WU10NpKBZNiUUwcznvIP+JSb5LBQTuWV3mjd18n
         iLAQ==
X-Gm-Message-State: AOAM53028d28dDeNIad1YkEPZoV2O5gpYQMDz802rkjcZleC6ahYWGcE
        M/gzb6JDADk7JiYAbyd/JwSzClP/PY7vPGULhxU=
X-Google-Smtp-Source: ABdhPJyidkYZn3pks7qlaDMc3LwEDY1SYiqlg58dC9/l3UNI6GnmoBiDPuyd2UEkY/eAHDPGkC/Q10O6MS/Vv02VDYk=
X-Received: by 2002:a05:6214:624:b0:441:84f3:24e3 with SMTP id
 a4-20020a056214062400b0044184f324e3mr19162202qvx.27.1651048477102; Wed, 27
 Apr 2022 01:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220426154956.27205-1-eajames@linux.ibm.com> <20220426154956.27205-3-eajames@linux.ibm.com>
In-Reply-To: <20220426154956.27205-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 27 Apr 2022 08:34:25 +0000
Message-ID: <CACPK8XdzznuHFZ_sj3zt4CKcsi02Af4COqa0-JP7=w6Mw_EjVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon (occ): Retry for checksum failure
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jeremy Kerr <jk@ozlabs.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 15:50, Eddie James <eajames@linux.ibm.com> wrote:
>
> Due to the OCC communication design with a shared SRAM area,
> checkum errors are expected due to corrupted buffer from OCC
> communications with other system components. Therefore, retry
> the command twice in the event of a checksum failure.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/occ/p9_sbe.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 49b13cc01073..e6ccef2af659 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -14,6 +14,8 @@
>
>  #include "common.h"
>
> +#define OCC_CHECKSUM_RETRIES   3
> +
>  struct p9_sbe_occ {
>         struct occ occ;
>         bool sbe_error;
> @@ -83,17 +85,22 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>         struct occ_response *resp = &occ->resp;
>         struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>         size_t resp_len = sizeof(*resp);
> +       int i;
>         int rc;
>
> -       rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> -       if (rc < 0) {
> +       for (i = 0; i < OCC_CHECKSUM_RETRIES; ++i) {
> +               rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> +               if (rc >= 0)
> +                       break;
>                 if (resp_len) {
>                         if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
>                                 sysfs_notify(&occ->bus_dev->kobj, NULL,
>                                              bin_attr_ffdc.attr.name);
> -               }
>
> -               return rc;
> +                       return rc;
> +               }
> +               if (rc != -EBADE)
> +                       return rc;

Future you might appreciate a comment above the EBADE check clarifying
why that error is being special cased.

>         }
>
>         switch (resp->return_status) {
> --
> 2.27.0
>
