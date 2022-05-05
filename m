Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5898951B796
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiEEFuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbiEEFuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:50:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803F7344CC;
        Wed,  4 May 2022 22:46:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh6so6721410ejb.0;
        Wed, 04 May 2022 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=AAqxEn14F2urq7gRW6XIInZJqYKSj6uaZRKkj7ztyxc=;
        b=iVInBQQc78CUYacNlpsH9Ud7kB6dqn23jW7w+jMJscvFFkOHvZBF54dzHIWhvU3llN
         qW0uY0HHzTq1H9e10V+kPJH7f9nsk5NsPgVxzBhUXMTmiHdbSLSfbQiD6VysHFoae+Dh
         JFilEyLYF9y7tE5HunM7u10h/4uBoOSZYLbV5OsBHJWx8zA7ewQVvD7mRBRKh0EeAf5s
         fDfVGfhSWyajKH0AaR0S1TvwlCtCCjXTck9Cumtnlv7g4rsUW/ExegF650iQ+7M8EkaJ
         W9OofsnjDhmPo7P59xG8naTefJsMm8WeFaoU4y0mIE28JQ+Zg9heoq3GCh7vep4TvCgU
         IIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AAqxEn14F2urq7gRW6XIInZJqYKSj6uaZRKkj7ztyxc=;
        b=P6q1lg5UcmotkFwFo1YaVUTMo8yYw+I+Uo26sIUcR7iLWwSXK6sIt9k3C6VKuwvvYk
         8FEJ7PQTZeYVNwtxjsuSC2Gc//yLVxAUCEsarrJOM8KqKHd25/FyQwQ9WNblqmVlzGaZ
         1HHTBYbELsdEbopev1LMiOrq+eJ1QtfaovqHwejjcXrcnI7+3jeDPgpQMtAFD7pRd3TF
         g8gFc8kC+EH1ulSDsoNI1cvpeCP7rkAZAD0npb1s1yMeWL0nGqEFi/KX/4VpJwWLXF1O
         JxD90tYcAwEw8/TJ1owv+XlKnQ8VD9dnCIM/zefoZ5AzpXwpuF537GdfkVx89Egh1I2x
         WdLA==
X-Gm-Message-State: AOAM530GyxpK4FIH2jv2hA3+4MHY+kMfwA6D1pLVzrEeYPcOpbp63CJ+
        lv2pLJkSEQSgdKGlnQeShjE=
X-Google-Smtp-Source: ABdhPJxmEoOm7L1U4kbR4F1xUSjzh+Guzq53ory3XJUYqqgkU5cBr7/B9HTGtNiGANSfQ2qgdwaB1Q==
X-Received: by 2002:a17:907:7f09:b0:6f4:9f76:d10a with SMTP id qf9-20020a1709077f0900b006f49f76d10amr9971400ejc.248.1651729595926;
        Wed, 04 May 2022 22:46:35 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id eb7-20020a170907280700b006f3ef214e4esm326062ejc.180.2022.05.04.22.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 22:46:35 -0700 (PDT)
Message-ID: <318c0814-7f0b-9798-6998-5039094b010d@gmail.com>
Date:   Thu, 5 May 2022 07:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V2] nvmem: add driver handling U-Boot environment
 variables
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220503165658.13932-1-zajec5@gmail.com>
 <79c7891a-9a68-a111-094d-be9804071a9e@pengutronix.de>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <79c7891a-9a68-a111-094d-be9804071a9e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.05.2022 11:23, Ahmad Fatoum wrote:
> Hello Rafał,
> 
> On 03.05.22 18:56, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot stores its setup as environment variables. It's a list of
>> key-value pairs stored on flash device with a custom header.
>>
>> This commit adds an NVMEM driver that:
>> 1. Provides NVMEM access to environment vars binary data
>> 2. Extracts variables as NVMEM cells
>>
>> It can be used for:
>> 1. Accessing env variables from user-space
> 
> Is this already possible? The only interface I know of is the /nvmem
> file in sysfs, but that one is not per cell, but per device.

Maybe that wasn't precise enough, I should probably write:
1. Parsing binary data from user-space

In future I'd like to extend U-Boot's "printenv" tool to support reading
env variables blob using Linux's sysfs as documented in the
Documentation/ABI/stable/sysfs-bus-nvmem


>> +	label = of_get_property(np->parent, "label", NULL);
>> +	if (!label)
>> +		label = np->parent->name;
>> +
>> +	priv->mtd = get_mtd_device_nm(label);
>> +	if (IS_ERR(priv->mtd)) {
>> +		dev_err(dev, "Failed to find \"%s\" MTD device: %ld\n", label, PTR_ERR(priv->mtd));
>> +		return PTR_ERR(priv->mtd);
>> +	}
> 
> I am trying to make sense of this using the binding, but I can't.
> Do you have an example device tree fragment?

This comes from unreleased yet board I'm working on.

It stores U-Boot env variables in the middle of U-Boot binary.

partitions {
	compatible = "fixed-partitions";
	#address-cells = <1>;
	#size-cells = <1>;

	partition@0 {
		label = "loader";
		reg = <0x0 0x100000>;

		partition@40000 {
			compatible = "u-boot,env";
			label = "u-boot-env";
			reg = <0x40000 0x4000>;
		};
	};

	partition@100000 {
		label = "image";
		reg = <0x100000 0x1fe00000>;
	};
};
