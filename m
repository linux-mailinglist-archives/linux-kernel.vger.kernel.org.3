Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6F4A478A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378215AbiAaMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbiAaMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:50:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A6C061714;
        Mon, 31 Jan 2022 04:50:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h21so25199746wrb.8;
        Mon, 31 Jan 2022 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IB70YYX8AebCvRAflv6xUAjSyKnP57ih2ZQmgTxAT3w=;
        b=ZB8N8WxfYYqdMZ04Q3AuVTJPntv5MSSus8rlMBN7+6DgTmU9DPbul2yWob6B5SLQK/
         s7xVhgLq3XI2eLDZKtRp2TmmAugxDtF/pLbnvcmLqpTFAsTkuwhKnSIgARsfL0WW0XXP
         qO5x6fjVxfzMto3J/LYdYBPyMzvTe+ILSaMwib83I14qAFl82iO/HWn7h5BBut+PTFq2
         8XKN0UDVOXtrCol50eGRVbqutsu59KtofBqkxncWEPRE2wvTQcQBJO52fGPG2mFb4kcU
         IJCL83A+h8PEfUPBTQU7XpyJqkUY3ygX2djiHgt1uTFZ3cyrQ2x6cavvs0ll9iOqxLx2
         867Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IB70YYX8AebCvRAflv6xUAjSyKnP57ih2ZQmgTxAT3w=;
        b=YTp24KYbOqDTuUeN83u70TURnuyRDgRnA/5Laaue4cEcz8+84YcOofLyCn0C1Kr+7H
         4T+HZ54dpxUbcxHmbyZQSAhGNZgary47cO1fPLVYKvoR0MC0MK2fz+cyzYYWMi4oarnL
         pX3Z/9Qce6uIqW1Ryr/2EB/GaVROh3GrBTot688JYZ5ZrcU2xt76KqRyXloJvSU/ykL9
         SevRjMDrNu7Vc6WOJ0rOGnrwTvHQI5+3mUKD4qnvmhX+tz2BLygzK+mi7cCIY9h2+/wT
         jDeRlnI2PbNYSS8NfP1QaX7nrfHQBDOX6+y2/1305StmZEM4YjU73nm3x2XqXrtYT1rJ
         czEw==
X-Gm-Message-State: AOAM532vJnmPRSStttktoAYhy/4xs5QCtAWkaAGeQ6kKWuuhaKcabpzh
        M6z1EY5m9VqXYhlRhHVi4kY=
X-Google-Smtp-Source: ABdhPJwRfOYYbvnzmbXXO6N7nO9dz5jdzWYkYKTY368TEfGVnA9dSe6ELcS3A9kLumu5GfphY7cU+w==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr17150527wry.242.1643633409194;
        Mon, 31 Jan 2022 04:50:09 -0800 (PST)
Received: from [10.18.0.8] ([194.126.177.11])
        by smtp.gmail.com with ESMTPSA id i19sm9982606wmq.45.2022.01.31.04.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 04:50:08 -0800 (PST)
Message-ID: <321ac205-51f7-88e1-abda-6f601b585ce2@gmail.com>
Date:   Mon, 31 Jan 2022 13:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] surface: surface3-wmi: Simplify resource management
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <8b1a6d05036d5d9527241b2345482b369331ce5c.1643531799.git.christophe.jaillet@wanadoo.fr>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <8b1a6d05036d5d9527241b2345482b369331ce5c.1643531799.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/22 09:36, Christophe JAILLET wrote:
> 's3_wmi.input' is a managed resource, so there should be no need to free it
> explicitly.
> 
> Moreover, 's3_wmi' is a global variable. 's3_wmi.input' should be NULL
> when this error handling path is executed, because it has not been
> assigned yet.
> 
> All this is puzzling. So simplify it and remove a few lines of code to have
> it be more straightforward.
> 
> Fixes: 3dda3b3798f9 ("platform/x86: Add custom surface3 platform device for controlling LID")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Right, that input_free_device(s3_wmi.input) seems wrong. Patch looks
good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
> Compile tested only
> ---
>   drivers/platform/surface/surface3-wmi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
> index 09ac9cfc40d8..b9a4b2d81f4b 100644
> --- a/drivers/platform/surface/surface3-wmi.c
> +++ b/drivers/platform/surface/surface3-wmi.c
> @@ -190,14 +190,11 @@ static int s3_wmi_create_and_register_input(struct platform_device *pdev)
>   
>   	error = input_register_device(input);
>   	if (error)
> -		goto out_err;
> +		return error;
>   
>   	s3_wmi.input = input;
>   
>   	return 0;
> - out_err:
> -	input_free_device(s3_wmi.input);
> -	return error;
>   }
>   
>   static int __init s3_wmi_probe(struct platform_device *pdev)
