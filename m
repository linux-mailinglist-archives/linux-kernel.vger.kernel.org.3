Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE74B10B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbiBJOoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:44:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243099AbiBJOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:44:10 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC6C4F;
        Thu, 10 Feb 2022 06:44:11 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s185so6105496oie.3;
        Thu, 10 Feb 2022 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=XZ/XXrZj+racVLVnNMLvBbtBG9nrEv0nxXZlOiR9KOw=;
        b=n45EP27B+6zrfSmpHjUJIM0UV0BPcBRWM3a8N6aphJOjhcESJ5xRq6ba4QHgwpTszs
         4UkHdrjCbgPO4x8EVyrCFYbt/bOSjsuRAjAGZhCZHbZnDOoQR706cbwmAq85RRf5qzus
         YdOLAqgFPl0/S2kNZwMBqDwox7/tdOfNUdBgvs94tgcG6/683XJXThculQFAaA2Z+6kp
         se7CMTtqJpqIqjE0EhQ4RBxLTqOJPvmqdohlZjeQ8M9UowpDzOnTTXJ4U4MJv9HdFfMI
         aN9odpotJtXTBJyU4jvbSREe8dOhyKMPLxNRNnQ+N11OgpF/EUitOpoJ2Ac8rzrUwcoQ
         Xh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=XZ/XXrZj+racVLVnNMLvBbtBG9nrEv0nxXZlOiR9KOw=;
        b=Z6AXuyGVgu9vpRuSadshNNAL7xPKXz4BvDmVWy/vzkuLqCfQJ06HwiT5tKgBe4uUso
         VP6SV+/R4wmYpAt7mXVdmYFnElq74JU82O2nuVqA1CKoJFNno7UfZbcffe5iQflA+/AI
         OAZ/1T/JrjV2pYswWlfLEwRvrakY2z5mwrNyQP/J8jLCpnPQxv/SiYeJF9LpvlBjLNOt
         /FyPN6PavMamXkkAQdtMxxdRpmsyxmI9RS+kXmFNdjbCXwt9RvNBWzxzUWPvfkAwX9hG
         EXuPXbCq0Rqh/PQBRd1AZ+eEre/Zzcyf5adCNksvBYAGReOnyzZPunhb7W6erICebC5y
         atAQ==
X-Gm-Message-State: AOAM531+MuDVpgZR/raaURNflQGdnglq357gLsxLlwoogAkGSraNsS0W
        2rDyt+7fouxulzGfJO/uvAfiBcM+PmuoBw==
X-Google-Smtp-Source: ABdhPJyCA97FMS4pI4Mm7GH6VWM1hU3yLtdtUnKRcqooR/XJ2+SK4/QzR+a921eW5f7Q3DhDDN3J9A==
X-Received: by 2002:a05:6808:1248:: with SMTP id o8mr1088866oiv.205.1644504250407;
        Thu, 10 Feb 2022 06:44:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21sm7901044otj.71.2022.02.10.06.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:44:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
Date:   Thu, 10 Feb 2022 06:44:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Vikash Chandola <vikash.chandola@linux.intel.com>,
        iwona.winiarska@intel.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus) Clear pmbus fault/warning bits before read
In-Reply-To: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
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

On 2/10/22 04:41, Vikash Chandola wrote:
> pmbus fault and warning bits are not cleared by itself once fault/warning
> condition is not valid anymore. As per pmbus datasheet faults must be
> cleared by user.
> Modify hwmon behavior to clear latched status bytes if any bit in status
> register is high prior to returning fresh data to userspace. If
> fault/warning conditions are still applicable fault/warning bits will be
> set and we will get updated data in second read.
> 
> Hwmon behavior is changed here. Now sysfs reads will reflect latest
> values from pmbus slave, not latched values.
> In case a transient warning/fault has happened in the past, it will no
> longer be reported to userspace.
> 


NACK.

Reporting that information is exactly the point of the current code.
We _do_ want to report at least once that a problem occurred in the past,
and only clear the warning flag(s) afterwards.

Guenter

> Signed-off-by: Vikash Chandola <vikash.chandola@linux.intel.com>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..1cc82d644079 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -577,6 +577,15 @@ static int pmbus_get_status(struct i2c_client *client, int page, int reg)
>   		break;
>   	default:
>   		status = _pmbus_read_byte_data(client, page, reg);
> +		if (status > 0) {
> +			/*
> +			 * Status greater than 0 could mean that there was a fault/warning.
> +			 * Clear faults and do a second read to make sure we are not getting
> +			 * stale values.
> +			 */
> +			pmbus_clear_fault_page(client, page);
> +			status = _pmbus_read_byte_data(client, page, reg);
> +		}
>   		break;
>   	}
>   	if (status < 0)

