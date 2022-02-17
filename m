Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D84BA42C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiBQPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:21:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbiBQPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:21:06 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582C2B0B1F;
        Thu, 17 Feb 2022 07:20:50 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id f19so8840133qvb.6;
        Thu, 17 Feb 2022 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=TI2smanOEAYT6fFDA4KrImbVgLMdEfrg2gnIoR3JBRk=;
        b=aMyQaIyk5ux/FZNLJsplph8869hwBnK1++VrLh9mfWm2gl0HEVkfNaD2u7b1FL/RFZ
         BUdtDOG620vPVFNulZk1NRhIpKmvM3whrs9UUUyG2mTyp/Q82CifBhVg1QWkM0/gK/d4
         zdpVgD4tA0tgFFca799zRufNE9FU3KAzad41+pfYvT6O9kmFoo2xkon+jtM5NvkoAjee
         LHJMQOS/CMKGNs/XvXJWkEdogSqYmj8hp86STCr1r+I8fn3AlhHEzIjHBHHPdk8THbBz
         +R2WWf0V6kvrGOri85ITw16jMjrBOrK9DhUocwxnexk/xblmEy4gcpVsXqz4ewQI/R0F
         tWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=TI2smanOEAYT6fFDA4KrImbVgLMdEfrg2gnIoR3JBRk=;
        b=eJKWjGQUmTJZJD5UoY6OirwQmvAksHEqS0RMABF60RtenY6hnpYXqwrboyaeC+6Er1
         DsfqCLtQvd0Rg06E5LLS7aI1KzRAqyt9OK4UUo6sGLXr2pOOyfU6Mt2BuKiT4emUOFNl
         MN2yei+eNOQgss4ekO1dYFO21DWjhzGyIDtOeN3io6hJ5otEDGpmKTP0/yLkgKc0W1gF
         J6Er4j5nOz/2UxWYsPfoCZrFCz/E4qjEskenzjYRcztkmz846Bwrxu9dqFkj5ne/gvBc
         uoniwGxGTWJ2KnN/TB5TgxiNd7y633rdpk+x3cAMm7jf3U37b2GlC7IEPPYIQZL4QUoa
         tcEQ==
X-Gm-Message-State: AOAM530MvIkAIBSQQXC2UcPvWvjuY22tma7gLZQPFok6YCAYzusST2Ar
        irWzec1UX3DFNZph42TOpkI/QNlHwED5+Q==
X-Google-Smtp-Source: ABdhPJx/Z10ciW/Wo0fbtuiaLR7Gv++pHUbanbOr8+bsTeZlmrboNXApv4NGSy3EGsJM9aKjrIQkAw==
X-Received: by 2002:a05:6214:2581:b0:42c:945e:4c17 with SMTP id fq1-20020a056214258100b0042c945e4c17mr2373696qvb.25.1645111249671;
        Thu, 17 Feb 2022 07:20:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16sm24213691qty.47.2022.02.17.07.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:20:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
Date:   Thu, 17 Feb 2022 07:20:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
References: <cover.1645108566.git.sylv@sylv.io>
 <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/3] hwmon (xdpe12284): Add support for xdpe11280
In-Reply-To: <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 06:41, Marcello Sylvester Bauer wrote:
> Add support for another family of Infineon Multi-phase controllers.
> The xdpe11280 uses linear instead of vid data format for VOUT.
> Add the required logic to detect VOUT_MODE during identification,
> and set the format accordingly.
> 
This talks about the chip, but ...

> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   Documentation/hwmon/xdpe12284.rst | 10 +++++++---
>   drivers/hwmon/pmbus/xdpe12284.c   | 17 ++++++++++++++++-
>   2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/xdpe12284.rst b/Documentation/hwmon/xdpe12284.rst
> index 67d1f87808e5..e9a5a19b0c3d 100644
> --- a/Documentation/hwmon/xdpe12284.rst
> +++ b/Documentation/hwmon/xdpe12284.rst
> @@ -5,6 +5,10 @@ Kernel driver xdpe122
>   
>   Supported chips:
>   
> +  * Infineon XDPE11280
> +
> +    Prefix: 'xdpe11280'
> +
>     * Infineon XDPE12254
>   
>       Prefix: 'xdpe12254'
> @@ -20,9 +24,9 @@ Authors:
>   Description
>   -----------
>   
> -This driver implements support for Infineon Multi-phase XDPE122 family
> -dual loop voltage regulators.
> -The family includes XDPE12284 and XDPE12254 devices.
> +This driver implements support for Infineon Multi-phase XDPE112 and XDPE122
> +family dual loop voltage regulators.
> +These families include XDPE11280, XDPE12284 and XDPE12254 devices.
>   The devices from this family complaint with:

Hmm, s/complaint/compliant/.

Anyway, is it still correct that the XDPE11280 is compliant with the
Intel specifications ? The datasheet isn't public, so I can not check myself
what the chip actually supports.

>   
>   - Intel VR13 and VR13HC rev 1.3, IMVP8 rev 1.2 and IMPVP9 rev 1.3 DC-DC
> diff --git a/drivers/hwmon/pmbus/xdpe12284.c b/drivers/hwmon/pmbus/xdpe12284.c
> index b07da06a40c9..ec947c697670 100644
> --- a/drivers/hwmon/pmbus/xdpe12284.c
> +++ b/drivers/hwmon/pmbus/xdpe12284.c
> @@ -27,6 +27,9 @@ static int xdpe122_read_word_data(struct i2c_client *client, int page,
>   	s32 mantissa;
>   	int ret;
>   
> +	if (info->format[PSC_VOLTAGE_OUT] == linear)
> +		return -ENODATA;
> +
>   	switch (reg) {
>   	case PMBUS_VOUT_OV_FAULT_LIMIT:
>   	case PMBUS_VOUT_UV_FAULT_LIMIT:
> @@ -75,9 +78,19 @@ static int xdpe122_read_word_data(struct i2c_client *client, int page,
>   static int xdpe122_identify(struct i2c_client *client,
>   			    struct pmbus_driver_info *info)
>   {
> -	u8 vout_params;
> +	u8 vout_mode, vout_params;
>   	int i, ret;
>   
> +	ret = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	vout_mode = ret >> 5;
> +	if (vout_mode == 0) {
> +		info->format[PSC_VOLTAGE_OUT] = linear;
> +		return 0;
> +	}

.... the code above is not chip dependent but this code checks the
mode register on page 0. At the very least this is confusing.

What the driver should do instead is to check the chip type during
probe and make the necessary changes there, ie set the output format
for xdpe11280 to linear and drop the pointers to the .identify
and .read_word_data.

Guenter

> +
>   	for (i = 0; i < XDPE122_PAGE_NUM; i++) {
>   		/* Read the register with VOUT scaling value.*/
>   		ret = pmbus_read_byte_data(client, i, PMBUS_VOUT_MODE);
> @@ -140,6 +153,7 @@ static int xdpe122_probe(struct i2c_client *client)
>   }
>   
>   static const struct i2c_device_id xdpe122_id[] = {
> +	{"xdpe11280", 0},
>   	{"xdpe12254", 0},
>   	{"xdpe12284", 0},
>   	{}
> @@ -148,6 +162,7 @@ static const struct i2c_device_id xdpe122_id[] = {
>   MODULE_DEVICE_TABLE(i2c, xdpe122_id);
>   
>   static const struct of_device_id __maybe_unused xdpe122_of_match[] = {
> +	{.compatible = "infineon,xdpe11280"},
>   	{.compatible = "infineon,xdpe12254"},
>   	{.compatible = "infineon,xdpe12284"},
>   	{}

