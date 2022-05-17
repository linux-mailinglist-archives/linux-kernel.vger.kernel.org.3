Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34A15297C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiEQDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiEQDRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:17:08 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755C2EA02;
        Mon, 16 May 2022 20:17:07 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so22667941fac.9;
        Mon, 16 May 2022 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tbMBXgyeDNJ8XSgJOtBDgLoNW60+5QspBWo0Od9KL+g=;
        b=h5xlq7zOdfcDnoc9qfumZtnEVtKQKZtUdD8KdqXz/YF49Eo4d8DSmnuzLWv3lYadgH
         a6Ug3JOtnb7vl1XvQkkZN8XzibPM07YDeHJxZfEZmtjE7X1brdyBWBxDSXJEkaLmLh0g
         lbNUd80GkGj1vajfLikopVLWdNtmNg1Orka0pgeAiSabksyyy4tUm/lB8dkBA7HbClta
         aAqsdiWkfrRk0AO/SRINB1TznwfbmjLkzoPN4h5SbiBg8s5Tgo4c4X0IQiOi5TqQmsHj
         efB16iv/NAlDLnmaoJoWitE9Gvh/nTZFNtDqN2qJyOxvNre1iDYTpju3gJhnUE/7iYm1
         3KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tbMBXgyeDNJ8XSgJOtBDgLoNW60+5QspBWo0Od9KL+g=;
        b=FxFe7ho+p/u3Km95r2auiY2infZZ0pYYTkFb0KV4oJcNlB9OY6KVBJVhqNPBXSLvlp
         nxQeYaaNoiToWe+JcBAKJelxqxE40JvVwDgi2D8gOBvQalKMZIr8MifrnAmbhSWuOZZJ
         Onaj7qbP/fiSaA+yCSGblUzOHDSzmuaIopV+ap1+mDz8S9tQ4om+xRj9RRv3Y6YrHREl
         oBZb0jLDtA0SnBONXcwH27gEH80CvYOtsWZOBu+fjwphlJg3N2yZgCQjAKtIsxS81Hb0
         q9bxf5J5ipdsaAqRv+LRNQuEerJoTgIQdh/hB/BDVBhcnlI/3/NRfVVouC0W9JYXGVJu
         kOfQ==
X-Gm-Message-State: AOAM533vLhNhwuzFXpjFC7Z2g/8w8rwhgfHWlVwN7ZVxRU8pE12MUXzc
        sDIMRUdOr5/1QTtm6dba9QidXWTmHOEw4A==
X-Google-Smtp-Source: ABdhPJwsWLQ21cpKDGpwu4dNMNiWcULWXcPvkKesR6Jw7SOGHRw+RZ5KdeJs2ixgqSMbC8dljtTYKg==
X-Received: by 2002:a05:6870:a9a4:b0:e6:4451:f4b0 with SMTP id ep36-20020a056870a9a400b000e64451f4b0mr16969238oab.252.1652757426558;
        Mon, 16 May 2022 20:17:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9-20020a05683030a900b0060603221248sm4591475ots.24.2022.05.16.20.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:17:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <33aedaf3-3b57-daa4-0928-d9dcaea98788@roeck-us.net>
Date:   Mon, 16 May 2022 20:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hwmon: Directly use ida_alloc()/free()
Content-Language: en-US
To:     keliu <liuke94@huawei.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517024022.1980274-1-liuke94@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220517024022.1980274-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 19:40, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>   drivers/hwmon/hwmon.c  |  6 +++---
>   drivers/hwmon/ibmaem.c | 10 +++++-----

One patch per file, please.

Guenter

>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 22de7a9e7ba7..2e2cd79d89eb 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -764,7 +764,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>   			 "hwmon: '%s' is not a valid name attribute, please fix\n",
>   			 name);
>   
> -	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&hwmon_ida, GFP_KERNEL);
>   	if (id < 0)
>   		return ERR_PTR(id);
>   
> @@ -856,7 +856,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>   free_hwmon:
>   	hwmon_dev_release(hdev);
>   ida_remove:
> -	ida_simple_remove(&hwmon_ida, id);
> +	ida_free(&hwmon_ida, id);
>   	return ERR_PTR(err);
>   }
>   
> @@ -968,7 +968,7 @@ void hwmon_device_unregister(struct device *dev)
>   
>   	if (likely(sscanf(dev_name(dev), HWMON_ID_FORMAT, &id) == 1)) {
>   		device_unregister(dev);
> -		ida_simple_remove(&hwmon_ida, id);
> +		ida_free(&hwmon_ida, id);
>   	} else
>   		dev_dbg(dev->parent,
>   			"hwmon_device_unregister() failed: bad class ID!\n");
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index de6baf6ca3d1..5c4cf742f5ae 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -482,7 +482,7 @@ static void aem_delete(struct aem_data *data)
>   	ipmi_destroy_user(data->ipmi.user);
>   	platform_set_drvdata(data->pdev, NULL);
>   	platform_device_unregister(data->pdev);
> -	ida_simple_remove(&aem_ida, data->id);
> +	ida_free(&aem_ida, data->id);
>   	kfree(data);
>   }
>   
> @@ -539,7 +539,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
>   		data->power_period[i] = AEM_DEFAULT_POWER_INTERVAL;
>   
>   	/* Create sub-device for this fw instance */
> -	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
> +	data->id = ida_alloc(&aem_ida, GFP_KERNEL);
>   	if (data->id < 0)
>   		goto id_err;
>   
> @@ -600,7 +600,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
>   	platform_set_drvdata(data->pdev, NULL);
>   	platform_device_unregister(data->pdev);
>   dev_err:
> -	ida_simple_remove(&aem_ida, data->id);
> +	ida_free(&aem_ida, data->id);
>   id_err:
>   	kfree(data);
>   
> @@ -679,7 +679,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
>   		data->power_period[i] = AEM_DEFAULT_POWER_INTERVAL;
>   
>   	/* Create sub-device for this fw instance */
> -	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
> +	data->id = ida_alloc(&aem_ida, GFP_KERNEL);
>   	if (data->id < 0)
>   		goto id_err;
>   
> @@ -740,7 +740,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
>   	platform_set_drvdata(data->pdev, NULL);
>   	platform_device_unregister(data->pdev);
>   dev_err:
> -	ida_simple_remove(&aem_ida, data->id);
> +	ida_free(&aem_ida, data->id);
>   id_err:
>   	kfree(data);
>   

