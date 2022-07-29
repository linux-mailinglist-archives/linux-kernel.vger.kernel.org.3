Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E755585512
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiG2SnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2SnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:43:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E9D7F513;
        Fri, 29 Jul 2022 11:43:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 17so5413036pfy.0;
        Fri, 29 Jul 2022 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQFD2i1BZHa8RQc9srU5ruiCzgLfvoBguWZDczSGOzs=;
        b=FT+d9UG753ZyRu0j4oAchSv4x646bB4zVQG7yVdtn0q7kEqblMO6z8ZHUxL6L5jzfR
         KMdbiUN9vRjsgUwSnKikTfuPu5Yx3Rm6dhi0KYaAIeSf8+PDVeizc2UMKnQklU76QXCZ
         727Ptkzn6yl/f1WiFKOs1eLEhW6vlasv7IozRSKXxuUQaIwWjlyq17Jxq0yZfFXg2ViJ
         Q5g05dkqPwsmVyNXXtKZ0KDAE6OpknBwn8nLrt3XCT9xuv39azVnmDVHzyUqTxHks1/x
         QUe1oG1ce2UEyuOvY+S5EVYXAIRe5aANhbo8hkfjfa7eDZSet4z6dJyFPhCAcmTWyraP
         N5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQFD2i1BZHa8RQc9srU5ruiCzgLfvoBguWZDczSGOzs=;
        b=TXVeXur0md1pmk2ls4fL1iWDHO6v59yz+KgUOXREqBqrPWz10Z8GeOfRz+QE6nWkwp
         EdMyVyw0+CacQqmgy9qBq5Qbyfbci7yZPKkJixCsCsQiCOA7ZDUsHz6a0c7jiQBrLb5e
         ith45RCgZeWCeZ/hRmg9znL3A0PQkVlGb9yQziSAR6Ht/x03/moLM71HBPgdysfvVg7Y
         4/izWPzGU3sGCTpuE64kjhDruybKvjszjki3cdgXymrWpRpKXZlan5Wp1CsCz/rRtgld
         njKpJXnN6dbUjsElXUrx37HR8lSs5eZlQAj402/NgUUPc6Z+CvttOkEdEM95qv4/PfrY
         juaQ==
X-Gm-Message-State: AJIora86nTydF5reXzMtWYzwEWd2fZdVuRRmnte+/maHO1zSigqAcqvF
        sHo6I2wyiLzUplNPwV3lW48=
X-Google-Smtp-Source: AGRyM1tPbWiaF1aBaOYnw/D0vVSSHle6RKSgjAko+8nilhrH6zosXoye0p2R5slSx1Prcdr/hpZ+bQ==
X-Received: by 2002:a63:85c6:0:b0:412:a94c:16d0 with SMTP id u189-20020a6385c6000000b00412a94c16d0mr4034436pgd.253.1659120187739;
        Fri, 29 Jul 2022 11:43:07 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1d28:9877:e2d1:3368])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00000400b0052896629f66sm3202634pfk.208.2022.07.29.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 11:43:06 -0700 (PDT)
Date:   Fri, 29 Jul 2022 11:43:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c - convert to use dev_groups
Message-ID: <YuQqN1+4wow5TlUZ@google.com>
References: <20220729135816.2306989-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729135816.2306989-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jul 29, 2022 at 03:58:16PM +0200, Greg Kroah-Hartman wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner.  Take advantage of
> that by converting this driver to use this by moving the sysfs
> attributes into a group and assigning the dev_groups pointer to it.

I obviously like this patch as the less boilerplate code the better, but
I am not sure what race are you talking about in the commit message?
Could you please elaborate?

Thanks!

> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "jingle.wu" <jingle.wu@emc.com.tw>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index e1758d5ffe42..d4eb59b55bf1 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1311,12 +1311,6 @@ static int elan_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = devm_device_add_groups(dev, elan_sysfs_groups);
> -	if (error) {
> -		dev_err(dev, "failed to create sysfs attributes: %d\n", error);
> -		return error;
> -	}
> -
>  	error = input_register_device(data->input);
>  	if (error) {
>  		dev_err(dev, "failed to register input device: %d\n", error);
> @@ -1442,6 +1436,7 @@ static struct i2c_driver elan_driver = {
>  		.acpi_match_table = ACPI_PTR(elan_acpi_id),
>  		.of_match_table = of_match_ptr(elan_of_match),
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.dev_groups = elan_sysfs_groups,
>  	},
>  	.probe		= elan_probe,
>  	.id_table	= elan_id,
> -- 
> 2.37.1
> 

-- 
Dmitry
