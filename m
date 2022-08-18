Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4F599121
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiHRXXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiHRXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:22:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0FD806F;
        Thu, 18 Aug 2022 16:22:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w14so2728180plp.9;
        Thu, 18 Aug 2022 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=qgaRqWLOG14ObT5+4RJNUQhFO09m1LTxuFNhc0IL+bM=;
        b=VUT0pwuy46Q9xCioqvoI0NWA88EeZHqUd2kLg0q6nox5muUm0/69D1hdBVztMUrGjV
         8+cbHrRu1hyaiMu1alRzmjPjYNJlcet9k4Qa/0rHXTRFVjy4pypNhQvx8SQj0MbPaosP
         kwxJ7+Haub6Ehg3ILlsoO9hyLNipfx1w78DAzM2LfUuEySDzu1b76xmhvpSfJ/KFXeEL
         +cSjgIYHEa9xlEOry+AtVSz8EURKAga16ydnYEzB9Gva1D54XPTOM/6yoJGPOvg/Y7P0
         X4uOnWU/FB2V/P7sgPiyvkFBhPAcDJe2nqKa3fFRE5mTp71g1Ku3h+yT9+9+vcBjijIZ
         x1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=qgaRqWLOG14ObT5+4RJNUQhFO09m1LTxuFNhc0IL+bM=;
        b=V0RC2Ns2Lm6HqLoSDM4+XM58HAto6W3eaplMj7JSYFksQ3syGMJI+49njnmM1elP4z
         lwjbkYEx9DzAi5w84CdgJlk78x6jwKuhILrC9KVT4i7byfMLoBGUU+9XOl8z6HkrOsbs
         b/iC2z5aDEhgSeYx5GTFr902mxj4gNtJpC1yHy8R4ezRUwDMBaqtXlrhrZfeJaql4zGn
         pp41peBEY4ucB1Kksh/UoJpWyi1A70gywdyd/bzb93jZhmwUvSRMEqIAP0eMezgKbGqv
         79XtB9TWyRSJWK9+w+KAAOLLXAiv9oj3cI44y+wq27hk74U8H3Sm1CWMNbZmd4qtC9TY
         lQBg==
X-Gm-Message-State: ACgBeo0DuNkdhLzNTKVwcccCLf1A3K8yaFBHKf3nmsc229g4yQkvbv8v
        4GGrRmp6mOCooH7RuIwbRfY=
X-Google-Smtp-Source: AA6agR67exVvt2va9wiPPA2ugh9vLj0F9W5th6QlgWtJOJneOMBoXNr49iNNPEwcZdTsNfaK5SzkYg==
X-Received: by 2002:a17:902:e945:b0:16b:f802:1660 with SMTP id b5-20020a170902e94500b0016bf8021660mr4848640pll.7.1660864978571;
        Thu, 18 Aug 2022 16:22:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00172a8e628e7sm1899194pli.190.2022.08.18.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:22:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 16:22:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (iio_hwmon) Make use of device properties
Message-ID: <20220818232256.GA3505808@roeck-us.net>
References: <20220730125024.87764-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730125024.87764-1-andriy.shevchenko@linux.intel.com>
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

On Sat, Jul 30, 2022 at 03:50:24PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Add mod_devicetable.h include.
> 
What does that have to do with this patch ?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwmon/iio_hwmon.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 580a7d125b88..3aa40893fc09 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -6,11 +6,13 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
> +
>  #include <linux/hwmon.h>
> -#include <linux/of.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/types.h>
> @@ -149,8 +151,8 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  	st->attr_group.attrs = st->attrs;
>  	st->groups[0] = &st->attr_group;
>  
> -	if (dev->of_node) {
> -		sname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
> +	if (dev_fwnode(dev)) {
> +		sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
>  		if (!sname)
>  			return -ENOMEM;
>  		strreplace(sname, '-', '_');
