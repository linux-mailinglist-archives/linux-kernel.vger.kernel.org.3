Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA82507C51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358154AbiDSWDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDSWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:03:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7443BA60;
        Tue, 19 Apr 2022 15:00:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id a10so56060oif.9;
        Tue, 19 Apr 2022 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eBs7CZQL5YV7OnaTPtslbp1P80YDQjl3qZLiZzB1YUE=;
        b=gyx4Xa/FJorjPR7T0cDMuH4cSm9a+cnHXKf60tuvv8cj1sjXQhhz5v2LfVyH1GrqJJ
         TdHTKCFBNLOCt6DUPGakmdgTBYmu7z9C2yKMy3OQRC0YoxW6qtP5r1QOmAebTY+aoPM/
         khD+KDZjWdvLTpwZ8xkxfj7VtlJw7Ntc/HdtkujRcAelOfF9oPzatxvXiRQl95C1BDAE
         bOW/UYm+hB74RDAlpscpp3ORnOqh2KH2GddLgqc1Dp5/6Bg7qdxkPao1eQKDFgBOFKbC
         6ju8qFAsB4vyv8Nui1UeiFSSzTfYJmya9GTFExOCOpMa7coY9AHeys7xNqy/qJtgIzre
         hRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eBs7CZQL5YV7OnaTPtslbp1P80YDQjl3qZLiZzB1YUE=;
        b=LscLGedhUYom0eIb5YtHQ1TIH212+b9YcGEldodLkFWw9U2y4pYDf/lFCRAFsH6xdK
         qkEHCdBUBq1g7relvZ0muoFyqEhhDSJ4ESkoyh6wZ1RtxOm6ZxkZilR3/q7fw1iBLTrb
         uAMY/qKl8a/e8vr5Xyx167Lwkg/xduRKhfGWHyzId6fE7gBhpHZscmosAvanphCs2VHZ
         qVphFADXdjhO9MNrCuX884CaT9FXDrCjUnvzDlqDRaDOSrHPFaADF1dCbDl7nt/Foi1G
         MbIAZ4QvnH807aaWah1irMY97m9IpgJXg4f4WvcTnhsEL7ooRUBCdOZkLRE0MTE6SzTH
         b9Eg==
X-Gm-Message-State: AOAM531CH7D09GYzO0A2QiDPIM5c2ecUlDwbgosORCuw6o5WatalhqIR
        lG0+89XtIqPewyaJUCK0js/h08KR5CY=
X-Google-Smtp-Source: ABdhPJxq9tmxUcraw8eslHwRmDcCm6nCvUAZeydUZ0WbOezbkeF71BmUDCyZbidmIJ5rQKwJBCARkA==
X-Received: by 2002:aca:1117:0:b0:322:4189:8959 with SMTP id 23-20020aca1117000000b0032241898959mr316168oir.254.1650405622469;
        Tue, 19 Apr 2022 15:00:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m65-20020acabc44000000b002ed13d0fe6fsm5512450oif.23.2022.04.19.15.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 15:00:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <734e748b-941c-5ae1-5140-22cc845bdfc1@roeck-us.net>
Date:   Tue, 19 Apr 2022 15:00:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmod: (pmbus) disable PEC if not enabled
Content-Language: en-US
To:     Adam Wujek <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419205228.303952-1-dev_public@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220419205228.303952-1-dev_public@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 13:53, Adam Wujek wrote:
> Explicitly disable PEC when the client does not support it.
> Without the explicit disable, when the device with the PEC support is removed
> later when a device without PEC support is inserted into the same address,
> the driver uses the old value of client->flags which contains the I2C_CLIENT_PEC
> flag. As a consequence the PEC is used when it should not.
> 

How can that happen ? I would assume the I2C device gets deleted and re-created
in that case, which should clear the PEC flag.

Guenter

> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 82c3754e21e3..f8ca36759b0a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2014,6 +2014,8 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
>   	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>   		client->flags |= I2C_CLIENT_PEC;
> +	else
> +		client->flags &= ~I2C_CLIENT_PEC;
> 
>   	pmbus_clear_faults(client);
> 
> --
> 2.17.1
> 
> 

