Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0494BC8FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiBSOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:51:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiBSOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:51:53 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F23DE5;
        Sat, 19 Feb 2022 06:51:34 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id f19so20762813qvb.6;
        Sat, 19 Feb 2022 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=43Ht17inyq32gylsASA6Me5+CCvPJb1J1VwzteoIMe8=;
        b=fIUcgdM9Q3fPvVvDIarQng2hKC3kAZRG+0vwHznWUzPSzAUtnEj/FArvUvD2Y3vdRj
         IwgWUzfvAmpiZNkz3O9wq7JqnziJckVTNcqoS1UPH4bFm0GgO0OIy239o1zwPjFxZTdh
         eiN8y/Xm1XZdMxWTDmmIn7I7Rjy0O0UFDuYgjZYf7+jNFIrhLlzzbgtWaZTB0SERxx31
         H5s9ctvwY1Tr8U5Xec8LAPKnYRE5YsOhXpuEyeo39Uh3aop6d1h3UvviNWABGwtR7dLv
         c2bd1ihdZDo/M8hqxrFFJEIUvD9olXSm3rgE1OawZkKyiNx/13PWoia9aTu7f6265/wl
         FAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=43Ht17inyq32gylsASA6Me5+CCvPJb1J1VwzteoIMe8=;
        b=nDxOoNf4RzIH3vxUA1cRKHIi/bvFWTm4OPYEq5uaHTsktQT3t1GPR+EeQ7uQ6XO+1Z
         KY7BaKvrugOwMSxW2xHbqa27iBRqTQ1ZmM/iLonuED7G8yHIYvFmpAylN+jO/6g3C9EE
         04QnSlTuftUHXrsakR/rOlExh3bIVh60hyDVrfvthJZljzI/4np8lwVSZO6bOvKBmk8y
         THyT9LMHEni6vC6ghw4JiVJNKMqVy1AT7EayrXVv12wp/LcFZSOf33iuz0gjaQwZnNbp
         ld8Gf88IDkiz9vJSNSdu0Ack2ETK6bsdrS6D6NNhKYplgY9FNFPrtd9h2KFp6juNnwd6
         9g0w==
X-Gm-Message-State: AOAM5313dQZnV42VtgMley8O+mOlzWYFTB9s+jHViUxQuKJso+bFUYiV
        xcrn2Jn/sU21oyOZaJ9sKkJ0i1wUfJdLnw==
X-Google-Smtp-Source: ABdhPJwcoYwi4wbOm61x5x2U5FgqH8Ds8d2uHShzAayZ83eizvem9SSa00s6UPW9NMk/I2R+w07bVA==
X-Received: by 2002:ac8:570d:0:b0:2dd:97c8:e413 with SMTP id 13-20020ac8570d000000b002dd97c8e413mr7811725qtw.3.1645282293746;
        Sat, 19 Feb 2022 06:51:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k20sm26748095qtx.64.2022.02.19.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:51:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:51:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] hwmon: (dell-smm) Improve temperature sensors
 detection
Message-ID: <20220219145132.GA1033025@roeck-us.net>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-5-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215191113.16640-5-W_Armin@gmx.de>
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

On Tue, Feb 15, 2022 at 08:11:10PM +0100, Armin Wolf wrote:
> On the Dell Inspiron 3505, three temperature sensors are
> available through the SMM interface. However since they
> do not have an associated type, they are not detected.
> Probe for those sensors in case no type was detected.
> _i8k_get_temp() is used instead of i8k_get_temp()
> since it is sometimes faster and the result is
> easier to check (no -ENODATA) since we do not
> care about the actual temp value.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index a102034a1d38..b7016971bb2e 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -655,6 +655,11 @@ static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor_types
>  	case hwmon_temp:
>  		switch (attr) {
>  		case hwmon_temp_input:
> +			/* _i8k_get_temp() is fine since we do not care about the actual value */
> +			if (data->temp_type[channel] >= 0 || _i8k_get_temp(channel) >= 0)
> +				return 0444;
> +
> +			break;
>  		case hwmon_temp_label:
>  			if (data->temp_type[channel] >= 0)
>  				return 0444;
