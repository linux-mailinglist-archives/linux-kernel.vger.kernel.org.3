Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB74BFE48
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiBVQQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBVQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:16:23 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7818C1662FA;
        Tue, 22 Feb 2022 08:15:55 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d84so80824qke.8;
        Tue, 22 Feb 2022 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UWtT6xKER+DvpZW0lXvn6f8vSNtev/dB5lCJohKQPOM=;
        b=oZ6Ryqexq35v/xGN4BjFPj8OOgCtUt+SyumS9l/DMnx9LQQaqSZHyk1+FcBkauTiDK
         0wysqc8avBJ4sEqIwqAiDww6LO7vTNcbLF5GdHvuTi7/HxSdLJ/DBhb6D3c/9NzbA08E
         QZyu9u7Y0zpxeHMAaxo5GxgtW5nChthUVEo4HOhCqM1oHJZCLU7FNPoWvDvr7tvsN3Wg
         UdpdH9YqbGciDNp/oqalTQxrLE+2vWHwI7E75xNShRM0cnFteGm6aCt8ipYhW//biggt
         rnutVcTGID6QUXZx814vHaVuLmSshzj5biRr8JpOltJMul1JEPhsnPOaHwEguJYACzRS
         g73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UWtT6xKER+DvpZW0lXvn6f8vSNtev/dB5lCJohKQPOM=;
        b=LlvdYtaFCdWmV/NmpkQTL8inUJIHEOiWOC3QiNnb6qQixon0k5YXxyWLbjnC5KoBDt
         8KOWED0WEZQZGXvjRAQaj8GSmmKEK0PH4Kd7HctC/w4ZfSogiK8ChZJ3P3FrJY/eACJj
         6eJQCt2GBrnDqOSLnsDd5nBcbkVStyN28KXSicDak8KtdWokB9C3KyfqqLUPWAtBAphD
         3w33agr+tAWMcFVlgI2wfieR+qrkPF1hdqrQraR/idFju7HvfOQp+mWIeB7L5M39AQt7
         n4qXx+TEjNu33vLvIq/qrZJcP4c9Mpw+vzKTXISIPd6D0nyn7kiPtatX64/xmn3sORC1
         f4dQ==
X-Gm-Message-State: AOAM532Zeo2+GsIZ48hrIiJQDMvfdtW29AdIQRVEstNpl52I8ldmDY7b
        8OOC8DfElVwdBaeJg+UTvKk=
X-Google-Smtp-Source: ABdhPJzk4uPD+ivitZf+tYykOXeYxxrqm1d6eByI01S4V/Azt9iqOTqTWGAtvKac/nCJI+xixVoRNA==
X-Received: by 2002:a37:a5c6:0:b0:46c:e3c1:7216 with SMTP id o189-20020a37a5c6000000b0046ce3c17216mr15814898qke.721.1645546554583;
        Tue, 22 Feb 2022 08:15:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g8sm25292qki.47.2022.02.22.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:15:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Feb 2022 08:15:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vikash Chandola <vikash.chandola@linux.intel.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, iwona.winiarska@intel.com
Subject: Re: [PATCH v2] hwmon: (pmbus) Clear pmbus fault/warning bits after
 read
Message-ID: <20220222161552.GA243421@roeck-us.net>
References: <20220222131253.2426834-1-vikash.chandola@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222131253.2426834-1-vikash.chandola@linux.intel.com>
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

On Tue, Feb 22, 2022 at 01:12:53PM +0000, Vikash Chandola wrote:
> Almost all fault/warning bits in pmbus status registers remain set even
> after fault/warning condition are removed. As per pmbus specification
> these faults must be cleared by user.
> Modify hwmon behavior to clear fault/warning bit after fetching data if
> fault/warning bit was set. This allows to get fresh data in next read.
> 
> Signed-off-by: Vikash Chandola <vikash.chandola@linux.intel.com>

Applied.

Thanks,
Guenter

> ---
> changes since v1:
> v1 patch was clearing all the faults. That would have lead faults not
> getting reported to user at all. This change clears only current fault
> and that too after reporting it at least once. This way all the faults
> will be reported to user space at least once.
> 
> Behaviour has been verified with following PSU
> FRU Device Description : IS162F22 (ID 84)
> Product Manufacturer   : SOLUM CO., LTD.
> Product Name           : IS162F22
> Product Part Number    : G36234-015
> Product Version        : 10A
> 
>  drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..ac2fbee1ba9c 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -911,6 +911,11 @@ static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
>  		pmbus_update_sensor_data(client, s2);
>  
>  	regval = status & mask;
> +	if (regval) {
> +		ret = pmbus_write_byte_data(client, page, reg, regval);
> +		if (ret)
> +			goto unlock;
> +	}
>  	if (s1 && s2) {
>  		s64 v1, v2;
>  
