Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2849FC69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349185AbiA1PFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiA1PFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:05:03 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986BC061714;
        Fri, 28 Jan 2022 07:05:03 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q186so12784890oih.8;
        Fri, 28 Jan 2022 07:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cRkzWM8NeL3N7R1U1Fg4vj5Gf+jJ9eTY6cn4OX+5KNM=;
        b=Lfbq+cGJpYtNeAE7/5LpPV891KqhMKy9UNpnstWTTz0OPv4tbncwlxhJL4PyIcfQfq
         OQj8cfH1o9vIv230l11/kwi97CMFlDsNY7qG4B1uJux91qYzu0YlPaBJhcn8L7lM7/2I
         JIIBcQp2WguZv9+cyFlAReZ/LaE67tYeTiASPAnyBZrMrJg55UPaHFvAIlnprrdTepkj
         97QmywP6VzdY/tLJrOCPArtU2wiIu+nQEBvZn73jpAFjR4vucAljxZ5Fw7iQmqmtHs/L
         RZvmkFnkRJRaiuE9vyPTNCJneHkaN//+PwtDLkaklwTOwsNPMdPtZEFivjQyYQhku9ec
         XoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cRkzWM8NeL3N7R1U1Fg4vj5Gf+jJ9eTY6cn4OX+5KNM=;
        b=NK3keoUvIKcnNdPKmu7JaXnu5y8Xf/BybrnYjZ8zO1IXMe15ovmrdz8B6k9IkL8+IP
         0LHCtrTB6g6xwiONuC/JhT21SF8+fSsmmz7w64BRHEv3k1FZxKj6iW1476XlqIzSC4Cu
         7JGZdCtdbG2KHtI0wgI3UZ8wdlerFxcUtymIQs+WeiyULn14r1OVRNktJnvPN4JVj960
         0OLzPYHWdiUdFbuzagfR1Ks2bnD1pRT2AB5zORbg4t/nUGjrZGj1THL7mtv5bXz4YWFc
         QDCCsj5059F8dyFZSk61dpkYgBXEIA7r1YCNu1OO+02fFMs5aMb8n9Py1rnZOBE5N9HY
         kndA==
X-Gm-Message-State: AOAM533DllU/9O3YS7wLMCuoh9U9KB5aVMO9u9az9wyeXz49AtdL62LC
        xouVQ24z/EPq51FkEeWImfDbl91WkR90SA==
X-Google-Smtp-Source: ABdhPJxvO6lQWFvZ4fUaUQrzfe80kveQHpcR2480QCQIoyU/sxHMzpiRnJugWQQviUdNekrVx5v7zg==
X-Received: by 2002:a54:4e94:: with SMTP id c20mr5604662oiy.132.1643382302903;
        Fri, 28 Jan 2022 07:05:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j3sm6798811oig.37.2022.01.28.07.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:05:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6c0335ca-eb16-b4de-1f2c-8bdc82219b57@roeck-us.net>
Date:   Fri, 28 Jan 2022 07:05:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hwmon: Remove checks for validity of dev
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220128125913.1291533-1-usama.anjum@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220128125913.1291533-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 04:59, Muhammad Usama Anjum wrote:
> dev is being dereferenced in device_property_present() which means that
> it is valid. Don't check its validity again and simplify the code.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/hwmon/hwmon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index e36ea82da1474..aec32abd0a89f 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -822,7 +822,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>   	hwdev->name = name;
>   	hdev->class = &hwmon_class;
>   	hdev->parent = dev;
> -	hdev->of_node = dev ? dev->of_node : NULL;
> +	hdev->of_node = dev->of_node;
>   	hwdev->chip = chip;
>   	dev_set_drvdata(hdev, drvdata);
>   	dev_set_name(hdev, HWMON_ID_FORMAT, id);
> @@ -834,7 +834,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>   
>   	INIT_LIST_HEAD(&hwdev->tzdata);
>   
> -	if (dev && dev->of_node && chip && chip->ops->read &&
> +	if (dev->of_node && chip && chip->ops->read &&
>   	    chip->info[0]->type == hwmon_chip &&
>   	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
>   		err = hwmon_thermal_register_sensors(hdev);

Wrong fix, sorry. While I would love to make dev mandatory, the function
is called with dev == NULL from at least one place, and the check is (still)
needed. Even if/when it is removed we would have to add an early check
and return -EINVAL if it is NULL.

Guenter
