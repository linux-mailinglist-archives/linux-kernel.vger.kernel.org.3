Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01AC59730D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiHQPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiHQPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:31:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25D9926E;
        Wed, 17 Aug 2022 08:31:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f65so12236815pgc.12;
        Wed, 17 Aug 2022 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=oKzPScXM6OjwBLoPDXjdugzEKQj4ZD8Vn9KIxJ4y7IA=;
        b=hbka5dkjg8rkSbSyeI54ZJETf23SZG8GuxIvflGwBLK34hMlbpEFApPkKI5Kw9yFHr
         3aV/P+uEEQroh+34+EuBbsum7n29zfob0bcC6av6RBGa6RQC/I+xW+7Qq580cL3PDQd/
         Fp8fcSNDyteKSrtby3Ca6qpAsGUaue+DeUcm/Cu1qsPUtBQq50DixqLmh7nS6pRgnwLC
         fqKJqVGB9bH315ps2R3/BPObv+hQSYt2FEWCSvvi+NUSg5m/XI6nVsz139GNQ6BEMIVK
         w3iOoiYxCgRy5BHgTKT+JT0CMBHCMSbEdzjuMoLUGMA9bdobdlrEMM1rpLd2TQHK3B+V
         tBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=oKzPScXM6OjwBLoPDXjdugzEKQj4ZD8Vn9KIxJ4y7IA=;
        b=nqv8tQySMTVpADVQeVABn5aJtmDI28cLs2dVvIc04BT4f1EtD/z9zINaSqEPsVBN4r
         0l+XGrwaEl8sekqdK0yUTJhbEs/UExnykVusQ/xhIj0OaYAjU9uDJQB051j33zd3Jouk
         +o/MjZaZgMFPA2Dka3r45OBpO+iZ8gy1kpKltwxFOtYmXn0YZKA+4XY8OSB7m7jln33L
         eFhUcD6yNgfHtkCzBPqA4996s/CbE2OIGmail1Rmw5Av6EJmpcohgN3oYSeoPCW3JyJk
         GEDdBX1E+xZrUhHw4qQVvMWRibfmcOxlDQXtR7f05XtWKHS04iRrULM+pJipoWuKsjxF
         ltbg==
X-Gm-Message-State: ACgBeo0UZfQkeophIEai5O+dqk1p7P6CP3l7KuutIrSMANKmD/V8FA61
        enIPEO9xXfXJqJ57pMEtrSI=
X-Google-Smtp-Source: AA6agR41iXoCj3uxN9u9K6zpVYayiQ48GBRaWNbVS2Out6kHHqGz3aytlODtJiPVzYW2cpn6ykmAew==
X-Received: by 2002:a63:684a:0:b0:421:904f:d38c with SMTP id d71-20020a63684a000000b00421904fd38cmr21894799pgc.238.1660750273269;
        Wed, 17 Aug 2022 08:31:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b0017128185043sm41094plb.191.2022.08.17.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 08:31:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 Aug 2022 08:31:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Use dev_err_probe() to filter
 -EPROBE_DEFER error messages
Message-ID: <20220817153110.GA1333586@roeck-us.net>
References: <3adf1cea6e32e54c0f71f4604b4e98d992beaa71.1660741419.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adf1cea6e32e54c0f71f4604b4e98d992beaa71.1660741419.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:04:00PM +0200, Christophe JAILLET wrote:
> devm_regulator_register() can return -EPROBE_DEFER, so better use
> dev_err_probe() instead of dev_err(), it is less verbose in such a case.
> 
> It is also more informative, which can't hurt.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 5541d26e8623..e000674d50df 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3016,11 +3016,10 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  
>  		rdev = devm_regulator_register(dev, &info->reg_desc[i],
>  					       &config);
> -		if (IS_ERR(rdev)) {
> -			dev_err(dev, "Failed to register %s regulator\n",
> -				info->reg_desc[i].name);
> -			return PTR_ERR(rdev);
> -		}
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(dev, PTR_ERR(rdev),
> +					     "Failed to register %s regulator\n",
> +					     info->reg_desc[i].name);
>  	}
>  
>  	return 0;
