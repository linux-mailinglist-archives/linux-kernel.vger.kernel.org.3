Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0C53C035
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiFBVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiFBVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:05:08 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8335260;
        Thu,  2 Jun 2022 14:05:05 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e656032735so8391688fac.0;
        Thu, 02 Jun 2022 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sqyZgyr1cUz1zJEyUP874Hc1Tcr8DUqd/+IQAxibrto=;
        b=PMTF/QBCKPMpsCUK6MBl77i8p8kX7DxTBEP5nDImU090bZy6Ubx0Jirgo9wiflRspl
         gXtvpFih/XIOMuTOjL4rtuT/JEcjjnWV+aPfN+Y8Te4sou7mgkttECV+yJN95slmL5+T
         TLscbrn4K0JlXGw5xVPwGFd55NyJ+uWvncZvxOeNt5nOYd35vPsYwCjf+ih9jnJheKGj
         neiPM8Sea19DFFCUaZyMzFnO91IakKjbVTz8lnhAPAAEpCWDHI8wyNeB5+k+RX4nBS2Y
         HN8b0SyuZb9KQQu+fP7Y+q5uIs2AWq0ytgCaPSKaSlIoCXZ6o0IuSeRPNY66TaSzKnaG
         9KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sqyZgyr1cUz1zJEyUP874Hc1Tcr8DUqd/+IQAxibrto=;
        b=1UCHsgTCN/s0Xg8KM+PLk5UYDt+bUN+Hj0c5M1nNeJ7CQjrQWfA35foUA8YvxlQdHy
         RW61oC4fF09EoCBGyTF/2g0C+NG89WJa0SeqAvavDUG26ynivekT29uwLTlmHccaE0Af
         wDyitOKK7Vg9ivsLjSlkt20AQb8/j9lHiVFIT3r7ex0dabHAw6TWuTy+UemT6xAcfnKP
         FrH71YlLmPOKgr2Alr+rcFAH/h7iWN+qy4U08MidywA3GMVn4Ylwr5LsTq/Pw/lCUFeC
         IUrIG/6DUkAECvSUw1sXEDzxSHAJZ5+kXW7XJNoqoDCgNROnHNTYkVzIjjwN1fyqy0n+
         Pb6w==
X-Gm-Message-State: AOAM533OiMboJMPFMn5v9n1E9/GHfBXOhg8cLR7H5pZe4Kl0Zg5su14a
        z1/pFu3THTVPGKxslIkKRW0=
X-Google-Smtp-Source: ABdhPJxFZnPA5BV9McR0eVYUYdoskxQTrQMOgJaY5gzDRX0bXqckjrxxccYNRZNVsWCT+33ALWkwJQ==
X-Received: by 2002:a05:6870:e245:b0:de:9321:9ea3 with SMTP id d5-20020a056870e24500b000de93219ea3mr3925392oac.79.1654203905261;
        Thu, 02 Jun 2022 14:05:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10-20020a056808118a00b00325cda1ffa2sm2868194oil.33.2022.06.02.14.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 14:05:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <00111f40-b741-7dd6-834a-c5645e075d23@roeck-us.net>
Date:   Thu, 2 Jun 2022 14:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] hwmon: (k10temp): Load the driver on models A0h-AFh
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Babu Moger <babu.moger@amd.com>,
        "open list:K10TEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Gabriel Craciunescu <nix.or.die@googlemail.com>,
        yazen.ghannam@amd.com, x86@kernel.org
References: <20220601172121.18612-1-mario.limonciello@amd.com>
 <20220601172121.18612-2-mario.limonciello@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220601172121.18612-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 10:21, Mario Limonciello wrote:
> commit 8bb050cd5cf4 ("hwmon: (k10temp) Support up to 12 CCDs on AMD
> Family of processors") added the CCD offsets for models A0h-AFh but
> didn't add the PCI device ID for the device.
> 
> Add the missing ID so the driver works on these models.
> 
> Fixes: 8bb050cd5cf4 ("hwmon: (k10temp) Support up to 12 CCDs on AMD Family of processors")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I can not apply this patch without the context patch (which I wasn't
copied on), so I assume the idea is to push this through the x86
tree. This is ok with me.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/k10temp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 4e239bd75b1d..80a489f89aa2 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -493,6 +493,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
>   };

