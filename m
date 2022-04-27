Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C95117C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiD0L4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiD0L4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:56:49 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC212085;
        Wed, 27 Apr 2022 04:53:38 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d39f741ba0so1616542fac.13;
        Wed, 27 Apr 2022 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDcZaNu3s46BCfyK8AGIWunVVLL0K103UCBfoUiQuSg=;
        b=PICN4L/bpRW0Ywnxp6EKdRxBPCzwU7brnkiRpdkxe9lXWNaE4lTzPUkUshVAWLTe/N
         oNxKJ15ESYMJ1IWAQj7eAPSMVvhEvW+ZsVAuaZmliL1pg9Jnx9eacqGVfOzvPrUSGWnZ
         UWLb0os8sSiInNnyHiHdtt7bXjtVue/jhqp9gJqzj+wVDBNcExTnCjmpS2i1gW3+DoE5
         nXM6WltKKK1Km8+3wWS1x0YzzPWfDV4y6WWt7BGN2jCv0tjPfkciRgRc1U8l4P3HbEKv
         8auJ3vFVfpc2iLwnPF1l6lZ4znNqDqASmphwBOE9hCmVPRMTMb8uea5nYIYN9Yx0FBae
         pDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lDcZaNu3s46BCfyK8AGIWunVVLL0K103UCBfoUiQuSg=;
        b=VqB/jkNci1VKAx3/t+5zy2hz0kn8J8qj8GKzLgze/BHu8UU98L1ZBQPA99T3cJLFvv
         tBi05tbbClx1HgfRe86IadMt9rb9waj4H+FW7rFMy7IpkrCex6jFXq+ktbqmi0a5rRTI
         cHg2CmFku2O97ajf3HLZkFRamQiy4Ek60HJmAczS0hkNMKN4jlpYpHz+6ctwhIXPawg6
         2yOZSOWBf3LOIYE+QfvCF6cYW1DtRsZMr/Tbg+Rh/Tmt9bshxDtwsC0Gs4VXgMMkj8t5
         XH+XHo2oh0cyDgUmc1KPd0qTHrCxae+j7T/asEa4IRp+hg6GlkFNLlVbzeGCKDw8kONQ
         QWRQ==
X-Gm-Message-State: AOAM531JXfgyliSJ0bssAj0zMlWeCsVyMGyjQYkiBFKu6sBTSRX8BYJ6
        kkspg6hya6ejVQjvUAW73vE=
X-Google-Smtp-Source: ABdhPJxqdW1u4b+HYMVRCPgoviFhCC1pBVd4W3nXiChpfznNK9sGQAYLA/Qj8VRLsCahCdXVQ3ARfw==
X-Received: by 2002:a05:6870:6324:b0:e9:16de:4053 with SMTP id s36-20020a056870632400b000e916de4053mr8701723oao.164.1651060417408;
        Wed, 27 Apr 2022 04:53:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m22-20020a9d73d6000000b006028f49a6fcsm5779329otk.4.2022.04.27.04.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 04:53:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Apr 2022 04:53:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH] hwmon: (pmbus) delta-ahe50dc-fan: work around hardware
 quirk
Message-ID: <20220427115333.GA2686708@roeck-us.net>
References: <20220427035109.3819-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427035109.3819-1-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:51:09PM -0700, Zev Weiss wrote:
> CLEAR_FAULTS commands can apparently sometimes trigger catastrophic
> power output glitches on the ahe-50dc, so block them from being sent
> at all.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Cc: stable@vger.kernel.org

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/delta-ahe50dc-fan.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/delta-ahe50dc-fan.c b/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
> index 40dffd9c4cbf..f546f0c12497 100644
> --- a/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
> +++ b/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
> @@ -14,6 +14,21 @@
>  
>  #define AHE50DC_PMBUS_READ_TEMP4 0xd0
>  
> +static int ahe50dc_fan_write_byte(struct i2c_client *client, int page, u8 value)
> +{
> +	/*
> +	 * The CLEAR_FAULTS operation seems to sometimes (unpredictably, perhaps
> +	 * 5% of the time or so) trigger a problematic phenomenon in which the
> +	 * fan speeds surge momentarily and at least some (perhaps all?) of the
> +	 * system's power outputs experience a glitch.
> +	 *
> +	 * However, according to Delta it should be OK to simply not send any
> +	 * CLEAR_FAULTS commands (the device doesn't seem to be capable of
> +	 * reporting any faults anyway), so just blackhole them unconditionally.
> +	 */
> +	return value == PMBUS_CLEAR_FAULTS ? -EOPNOTSUPP : -ENODATA;
> +}
> +
>  static int ahe50dc_fan_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>  {
>  	/* temp1 in (virtual) page 1 is remapped to mfr-specific temp4 */
> @@ -68,6 +83,7 @@ static struct pmbus_driver_info ahe50dc_fan_info = {
>  		PMBUS_HAVE_VIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_FAN34 |
>  		PMBUS_HAVE_STATUS_FAN12 | PMBUS_HAVE_STATUS_FAN34 | PMBUS_PAGE_VIRTUAL,
>  	.func[1] = PMBUS_HAVE_TEMP | PMBUS_PAGE_VIRTUAL,
> +	.write_byte = ahe50dc_fan_write_byte,
>  	.read_word_data = ahe50dc_fan_read_word_data,
>  };
>  
