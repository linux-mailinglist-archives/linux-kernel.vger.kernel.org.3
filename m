Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A65815EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiGZPFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiGZPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:05:10 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E263BA;
        Tue, 26 Jul 2022 08:05:10 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10d845dcf92so18863957fac.12;
        Tue, 26 Jul 2022 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fAlxGdxp/dvoWgj3QK/dYW1nCDi27HsdXLnCmUB1tnc=;
        b=h8lUqXYkxNMQbtkXIei1PI6+xwQor4tvNJk62rUZKdUIlLY2S8CUJWZXwIptO+lgjJ
         T4Q3XTnlQWJuMaihKw5Y7dYVD2zINu9KKQua+jA8N/fA5aLUAgP+TdRBz0OxIM3TlkhL
         nBhxED6Km22lbpOblPfCj92I+KnMBmtEvVuxdhUy1PObWuqPFqwkgNTBGwka+/vL2h/T
         VXW2B1vqJqDtj8gtP9NV4sgykGk/9XWHNSHy9BXdFvA5zqGltlwV7bPsAaXFYWSNgnOD
         aXTVg/dFaJ0oBbC1bi8MDGAU3z2ObFHsJyiYgNhQgsM1n2in6JRJqaSH+syyzzNHG7sl
         3W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fAlxGdxp/dvoWgj3QK/dYW1nCDi27HsdXLnCmUB1tnc=;
        b=psAyVNpfVWd74VVb8yo60m7jlRl/BK2l63aJtFqLpYCnTpRQnXiEV2L5dJvBw0h9ij
         PL2qFj6YOTglTvGv6if23MX+FIb1gA6Bi5rUR1qGYOE8/SOvM5E6rAMgxt5BrPBWnaDS
         Dk8S+PtXlcWQEZA9lTZHFBwO6+G/hbivDC2SlnIefgOXsPbr6KDBgT0fYzIWtjV0EEYm
         8bNPhlHi9SM0jK9CiePiGxLsm9RAF8MrfjO4JDJn+tumNWa1ob6aRkOkxUUwZtl9eOt/
         hCXZvCbJ+f/amlGgVGJGjccBVrSie9Md2UVdcjC11GhOdreDXHKI1lS8Tj0fwJWFtR/F
         2JPA==
X-Gm-Message-State: AJIora8zEIh/242C2JRBUFf5G3yrRYop7rF5k0U5V265vgzEG57lzzGn
        4vwAG6Sef+fUUfvroTgGvLljj6/n4RU4+A==
X-Google-Smtp-Source: AGRyM1uQpR0qQSkcAHd4iRJB5ANkMnWa9xPMJaanb6DW2uSV+P+dF4BqKPwp2/c77jqaHObRE+NnZA==
X-Received: by 2002:a05:6870:e245:b0:de:9321:9ea3 with SMTP id d5-20020a056870e24500b000de93219ea3mr8672741oac.79.1658847909280;
        Tue, 26 Jul 2022 08:05:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6-20020a4aac46000000b0043571d9c098sm6099515oon.43.2022.07.26.08.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:05:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <833d605d-0605-9439-6544-885e6f5f75b0@roeck-us.net>
Date:   Tue, 26 Jul 2022 08:05:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] hwmon: (occ) Replace open-coded variant of %*phN
 specifier
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>
References: <20220726143110.4809-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220726143110.4809-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 07:31, Andy Shevchenko wrote:
> printf()-like functions in the kernel have extensions, such as
> %*phN to dump small pieces of memory as hex bytes.
> 
> Replace custom approach with the direct use of %*phN.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

> ---
>   drivers/hwmon/occ/common.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 157b73a3da29..45407b12db4b 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -729,18 +729,14 @@ static ssize_t occ_show_extended(struct device *dev,
>   			rc = sysfs_emit(buf, "%u",
>   					get_unaligned_be32(&extn->sensor_id));
>   		} else {
> -			rc = sysfs_emit(buf, "%02x%02x%02x%02x\n",
> -					extn->name[0], extn->name[1],
> -					extn->name[2], extn->name[3]);
> +			rc = sysfs_emit(buf, "%4phN\n", extn->name);
>   		}
>   		break;
>   	case 1:
>   		rc = sysfs_emit(buf, "%02x\n", extn->flags);
>   		break;
>   	case 2:
> -		rc = sysfs_emit(buf, "%02x%02x%02x%02x%02x%02x\n",
> -				extn->data[0], extn->data[1], extn->data[2],
> -				extn->data[3], extn->data[4], extn->data[5]);
> +		rc = sysfs_emit(buf, "%6phN\n", extn->data);
>   		break;
>   	default:
>   		return -EINVAL;

