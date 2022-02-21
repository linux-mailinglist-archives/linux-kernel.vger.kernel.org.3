Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482FC4BE0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380170AbiBUQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:21:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380102AbiBUQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:21:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2F19C21;
        Mon, 21 Feb 2022 08:20:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i11so19633968lfu.3;
        Mon, 21 Feb 2022 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZK5pqUXTQrSjRGlSBGSEoZmitlEJTMxo2eco03KXojM=;
        b=PJtL49qYMOomlXMj1cD01SSeerWmAUfZPO+WWapkpCvfnQ3TrCLme9NPwdWl72ZYZI
         AI/gYRJLYp2IcUmtZyEJUQx1wGbCghYKRMfgM93VLC+p5xDa1Qdk/rubHvaqGeNEpTS7
         ZnF1nxpAXGjPZlL4qcmFNE6QIdCxfiZu7bWSnmM+EdRC8z76NnVmdj9zpQEFHoe4y23j
         xs0jjwiHGD0A+XpIZIe7j2EKwPBiTmZ3giejUEiVdjkDBe9KRJbTom88QT1cdRllmnLA
         ZNteJp8Sh9JkI9z0NLkUUsr9L4AYYhZXkq7Kdk588s8W/nsopb+yftzpr0JJmQR4WHPp
         GJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZK5pqUXTQrSjRGlSBGSEoZmitlEJTMxo2eco03KXojM=;
        b=JCZnsQMWZ12tABb2ZEzc1fiJ09MgwA5/AcYmtK1TCfG2X0vzqgYQVNg+7XtHzDGxMA
         NrS6/SrVsTadm63XfVAtjAnNXSqbDjm4mLDO0f1+QvDPvLLnTtrWlWlUBmFOq5Ekljoe
         Cc5Wd/ReQ197Jbv0/sCsbpifNvotdpXSWyfkudx6rqUe9gQDTd8LHbxJLj8iH/Bu1RQo
         /pgiwZ1dOxqV7jzPwge6sUzDNrnWElfOu/TkXf2N0L/AD4wy2U3h5Bnq4xJeq55uZpwS
         NNBLxAVbjldj4RWBQrtljMcmUBGd6n3Nyz2Exrilxc2JYMO36fzlEvzqPuzN2WNvFMpa
         QTfA==
X-Gm-Message-State: AOAM530M2O+QvIirLi6WRkVg4yrMb0i+jN1Sd06x/VS1NXIlVXUjo9It
        KNaoh620owKNZu5FbP++j0s=
X-Google-Smtp-Source: ABdhPJyGh/5okaydPq9KBAmqAT+TW4UZbPPDGeU4Dr/bQCn9YGJv0S0qSVZc7ihc0SSI+f705BDVwQ==
X-Received: by 2002:ac2:52a1:0:b0:443:b482:fd2b with SMTP id r1-20020ac252a1000000b00443b482fd2bmr11450023lfm.197.1645460441205;
        Mon, 21 Feb 2022 08:20:41 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id t14sm60804lfe.239.2022.02.21.08.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:20:39 -0800 (PST)
Message-ID: <437c7c3c-66d4-2665-c8fa-781979366bc3@gmail.com>
Date:   Mon, 21 Feb 2022 19:20:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
 <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.02.2022 19:16, Jon Hunter пишет:
> 
> On 21/02/2022 16:02, Guenter Roeck wrote:
> 
> ...
> 
>>> The platform I see this on does use device-tree and it does have a
>>> node for the ti,tmp451 device which uses the lm90 device. This
>>> platform uses the device-tree source
>>> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451
>>> node is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>>
>>
>> Interesting. It appears that the call to
>> devm_thermal_zone_of_sensor_register()
>> in the hwmon core nevertheless returns -ENODEV which is not handled
>> properly
>> in the hwmon core. I can see a number of reasons for this to happen:
>> - there is no devicetree node for the lm90 device
>> - there is no thermal-zones devicetree node
>> - there is no thermal zone entry in the thermal-zones node which matches
>>    the sensor
> 
> 
> So we definitely have the node for the lm90 device and a thermal-zones
> node, but I do not see a thermal-sensor node. Maybe this is what we are
> missing?

Could you please try this:

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 5915fedee69b..48f80bc99fe6 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -233,8 +233,12 @@ static int hwmon_thermal_add_sensor(struct device
*dev, int index)
 	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
 	 * so ignore that error but forward any other error.
 	 */
-	if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
-		return PTR_ERR(tzd);
+	if (IS_ERR(tzd)) {
+		if (PTR_ERR(tzd) != -ENODEV)
+			return PTR_ERR(tzd);
+
+		tzd = NULL;
+	}

 	err = devm_add_action(dev, hwmon_thermal_remove_sensor, &tdata->node);
 	if (err)
@@ -283,7 +287,7 @@ static void hwmon_thermal_notify(struct device *dev,
int index)
 	struct hwmon_thermal_data *tzdata;

 	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
-		if (tzdata->index == index) {
+		if (tzdata->index == index && tzdata->tzd) {
 			thermal_zone_device_update(tzdata->tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}

