Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85894F4FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839018AbiDFA5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353651AbiDENHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6CBE167FB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649160547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTHcEPqS4WZU3twPg6xFE08lBamScSNylvPFU0OFzg4=;
        b=B22yoDcAQRw1Vts9MS32ITUwy6/UdIQ7uF0jPjzo2fFQaRHzVqGAn71l4WMdwI/YPiS89+
        VvY3SfUBiwMAyAjYMm6S9kxg4PAoSF9c6EwSkPoSPbjowUITMpZVVChSxOzPRFTcT2QVh4
        YSPIN3GXs0jObkOHHKj5boFHVd/tEDA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-e07P-Z4CN0KVFs4JtRw1Yg-1; Tue, 05 Apr 2022 08:09:06 -0400
X-MC-Unique: e07P-Z4CN0KVFs4JtRw1Yg-1
Received: by mail-qv1-f70.google.com with SMTP id kc2-20020a056214410200b00443e6240ba1so2626076qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wTHcEPqS4WZU3twPg6xFE08lBamScSNylvPFU0OFzg4=;
        b=Kn75rhpukTIRxXSo8wNc6TrjHhfsHB7Gi8Hgx1pWtkaz/BTrpyckhh+VFQAUwAgyoX
         l236x1Zzn/V6HopQ5upC15iaxwlGKPnyEBf3+qAxGKUCAajnnEFwAeoEzM8OkH5w7wd5
         j+pPe+GYcXiRZt4DP2sc5Y8eTUpDNlnJTh5g9Zcgwdklvr76PULhNsX+4CX763kRRgqA
         kbrRqtDNP6VU3HbHObXf2EXRQnHBaBGmZDEQu5jAap9W9M2uoqbAtqS0Cx2CM+K8eOUQ
         1NVv4Bk7ZzJAS+sRQoh82tC5bhvMYqvh9W2RzvtrvJaGganV7V4xsP7WE1j2BpfVhRiC
         ZxGA==
X-Gm-Message-State: AOAM533JiTGLQf1yQ3dgUAu0+NsNJWKvAx1e/3Q0+Fyyczo2pgnhzN4b
        h3rQmrolYHGhPhOQojr1b0mP6hqbxwkLajjV1FhFDH4MdVx2t5Lil/3/VgeGg6HSa7GCGlXzBs8
        J7ewkMkSR+s5iZGxtXCeu9F7U
X-Received: by 2002:ac8:4e8b:0:b0:2e2:129b:35f1 with SMTP id 11-20020ac84e8b000000b002e2129b35f1mr2557099qtp.387.1649160546383;
        Tue, 05 Apr 2022 05:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX7HhPj5mEGcuqhZHuJX+RbnyZLGTfgVtl7WdedWYWbPlNoy2uZL3YMCqfNCIwWRAhYtFenA==
X-Received: by 2002:ac8:4e8b:0:b0:2e2:129b:35f1 with SMTP id 11-20020ac84e8b000000b002e2129b35f1mr2557071qtp.387.1649160546126;
        Tue, 05 Apr 2022 05:09:06 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a059400b002e1d59e68f3sm10850768qtb.48.2022.04.05.05.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 05:09:05 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] hwmon: intel-m10-bmc-hwmon: use
 devm_hwmon_sanitize_name()
To:     Michael Walle <michael@walle.cc>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>
References: <20220405092452.4033674-1-michael@walle.cc>
 <20220405092452.4033674-3-michael@walle.cc>
From:   Tom Rix <trix@redhat.com>
Message-ID: <155156e6-e258-78dd-441a-7faad4afde3c@redhat.com>
Date:   Tue, 5 Apr 2022 05:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220405092452.4033674-3-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/22 2:24 AM, Michael Walle wrote:
> Instead of open-coding the bad characters replacement in the hwmon name,
> use the new devm_hwmon_sanitize_name().
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> ---
>   drivers/hwmon/intel-m10-bmc-hwmon.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index 7a08e4c44a4b..6e82f7200d1c 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -515,7 +515,6 @@ static int m10bmc_hwmon_probe(struct platform_device *pdev)
>   	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
>   	struct device *hwmon_dev, *dev = &pdev->dev;
>   	struct m10bmc_hwmon *hw;
> -	int i;
>   
>   	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
>   	if (!hw)
> @@ -528,13 +527,9 @@ static int m10bmc_hwmon_probe(struct platform_device *pdev)
>   	hw->chip.info = hw->bdata->hinfo;
>   	hw->chip.ops = &m10bmc_hwmon_ops;
>   
> -	hw->hw_name = devm_kstrdup(dev, id->name, GFP_KERNEL);
> -	if (!hw->hw_name)
> -		return -ENOMEM;
> -
> -	for (i = 0; hw->hw_name[i]; i++)
> -		if (hwmon_is_bad_char(hw->hw_name[i]))
> -			hw->hw_name[i] = '_';
> +	hw->hw_name = devm_hwmon_sanitize_name(dev, id->name);
> +	if (IS_ERR(hw->hw_name))
> +		return PTR_ERR(hw->hw_name);
Reviewed-by: Tom Rix <trix@redhat.com>
>   
>   	hwmon_dev = devm_hwmon_device_register_with_info(dev, hw->hw_name,
>   							 hw, &hw->chip, NULL);

