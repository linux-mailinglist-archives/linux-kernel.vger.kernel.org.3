Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C854CA835
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiCBOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiCBOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44E5EC8F8F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646231500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jffqN0m1GTXZQWXvQAEMRQWppzF6htiIzraNQHv9l3A=;
        b=TsL9CYqYPKegncPPd63lFL2ceCbl4yUiOyS/Z9Y2noyS8znFsv3FLKrtnmrp/OBNHjrFu2
        mcm1iJGfaW2oHOvf0vuT37d5H200em4G0NzCIbWaHj7v1i7WunrKmsqIJ331eiLI4O5Qqj
        TGBbhVlqHzjDBdwVORa3D7bA7fKRQaE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-Ox5b2FSFPJeGoGBI0wx-9g-1; Wed, 02 Mar 2022 09:31:36 -0500
X-MC-Unique: Ox5b2FSFPJeGoGBI0wx-9g-1
Received: by mail-ed1-f71.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so1095511edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 06:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jffqN0m1GTXZQWXvQAEMRQWppzF6htiIzraNQHv9l3A=;
        b=FjQ2oPXRV8AmKMmyf8tUk8hNUUykdp9kWQaxUtYyPUgX/01EPQZJHj6c2qNdqRQ9m4
         Gm2VRFg5GVxMRvcIFlA68+UILSJ9kqawEtkSU3vi5eOGcw7TdHE9cKbS3mVw6EnQbUbv
         BXKFEaXGGEktx+kObvpSPDm4jFh/914xORBU2RL/2dm1pgDJx1HdHIgRNdKms/NruLHc
         7KHn/29VJ1Py9+3ANsJa1lN+1g9gQHdNapLQf7oM7EGNAXI3laioW/Lh4LKUSTEjrSKW
         O/GOdYXwTbp55KXzstbmqS/U+JgsSybt7TidxUpSdeIB7l2sOl3mT5tAhwxDsq3Jn++S
         LP7g==
X-Gm-Message-State: AOAM5312jvFlWNv76H3KpXgVv8xrc31NnCz5wcqD7ch0iHxC89FBaGGb
        upBqhh+1cXLsKsIYMEPagN+o7kGQaUf6RofW9w9tD+PzfVyHpdUlHrVO+bNC96alq8dDEyI2J4q
        zLac42ShjKNFSB0hPOf2mVmBW
X-Received: by 2002:aa7:d453:0:b0:410:d407:da20 with SMTP id q19-20020aa7d453000000b00410d407da20mr29770286edr.351.1646231495396;
        Wed, 02 Mar 2022 06:31:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaZs2pwoj8NQ1tJcS9kKa4Smgf4WJxw9Nh28O3Qs9xg1q9OsU5852ZY8EiOYJAbvbNOWtZKw==
X-Received: by 2002:aa7:d453:0:b0:410:d407:da20 with SMTP id q19-20020aa7d453000000b00410d407da20mr29770273edr.351.1646231495166;
        Wed, 02 Mar 2022 06:31:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id z17-20020a1709060bf100b006cf2730b5f2sm6383886ejg.30.2022.03.02.06.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:31:34 -0800 (PST)
Message-ID: <54dafc1d-bc72-8cb0-a539-4fdfc068cb5a@redhat.com>
Date:   Wed, 2 Mar 2022 15:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] platform: x86: huawei-wmi: check the return value of
 device_create_file()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225130448.27063-1-baijiaju1990@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225130448.27063-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/25/22 14:04, Jia-Ju Bai wrote:
> The function device_create_file() in huawei_wmi_battery_add() can fail,
> so its return value should be checked.
> 
> Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Please run check-patch.pl your patches before submitting them.


> ---
>  drivers/platform/x86/huawei-wmi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index a2d846c4a7ee..2ffd3840f3e8 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -470,10 +470,19 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
>  
>  static int huawei_wmi_battery_add(struct power_supply *battery)
>  {
> -	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
> -	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
> +	int err = 0; 

There needs to be an empty line here,
> +	err = device_create_file(&battery->dev, 
> +						&dev_attr_charge_control_start_threshold);

Why the weird continuation of the call on another line? Please make this a single line.

> +	if (err)
> +		return err;

Empty line here.

> +	err = device_create_file(&battery->dev, 
> +						&dev_attr_charge_control_end_threshold);

Please make this a single line.

> +	if (err) {
> +		device_remove_file(&battery->dev, 
> +						&dev_attr_charge_control_start_threshold);
> +	}

No need for {} here.

>  
> -	return 0;
> +	return err;
>  }
>  
>  static int huawei_wmi_battery_remove(struct power_supply *battery)

Regards,

Hans

