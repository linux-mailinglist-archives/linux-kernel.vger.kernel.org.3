Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CBC48D2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiAMHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:35:21 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36375 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiAMHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:35:16 -0500
Received: by mail-ed1-f50.google.com with SMTP id 30so19848751edv.3;
        Wed, 12 Jan 2022 23:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iT2CzIt65b5aQP4IY5x71Tt5MRhCCRGWDAz7IDhaeSw=;
        b=ak9ezYfrrsVU0QiK5fYYohj4UBFZ+TSsJoivxQ9XpQaOCZ0Qd1ilrJhbgEYoTZ+c0w
         l5o9xJQ9E4zQdKsfhm7cHJEQA/F+c0PiryZbk+0cEr2hXF6RcWxnDErlYXGegmavARyW
         geH+OpfiktB4VgJm+cMv2ZWzyfF4H8p/Hbwl+HUamam82FFEhuNekZiVs2SNoo+yT20q
         ZB/1OzRw3XaQZ1AmTX/yBB9lEAeOFzF81T04CCjc0k+zPEMnIJjF91LFjQKM/PRVZGEC
         TtRQtYSBFnRK4K7NZHvExKqVoD6C/r+KA8I7aECfrhyx1ONDy3vt6cv2IeqoRQcn4+P8
         HvpA==
X-Gm-Message-State: AOAM532jcuTgmJanoAYSgnPV0FWE1/t+WRqMsZRXr/YqJvAkFcMCf7P5
        1Uee5dGe/sFPXXNmy3A8bDKGIFHVk6M=
X-Google-Smtp-Source: ABdhPJx2MKY3+9K6csvRZ1fHkO88yJ0N6Lt0iMAJR2WRI+W3VDKW9ahAivYF16JIzGiBfxGc84eyKw==
X-Received: by 2002:a05:6402:348b:: with SMTP id v11mr3103980edc.276.1642059315722;
        Wed, 12 Jan 2022 23:35:15 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j5sm584551ejo.171.2022.01.12.23.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 23:35:15 -0800 (PST)
Message-ID: <58ebc58b-f8fc-06a7-b152-1709894da8e3@kernel.org>
Date:   Thu, 13 Jan 2022 08:35:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] tty/serial: Check for null pointer after calling
 devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107144852.4081390-1-jiasheng@iscas.ac.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220107144852.4081390-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 01. 22, 15:48, Jiasheng Jiang wrote:
> As the possible failure of the devres_alloc(), the devm_ioremap()
> may return NULL pointer.
> And the 'port->membase' will be used in mlb_usio_startup() without the
> check.
> Therefore, in order to avoid the dereference of the NULL pointer, it
> should be better to add the check to guarantee the success of the probe.
> 
> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v1 -> v2
> 
> * Change 1. Refine the commit message to be more clear.
> ---
>   drivers/tty/serial/milbeaut_usio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
> index 8f2cab7f66ad..1ecbf6d0dc79 100644
> --- a/drivers/tty/serial/milbeaut_usio.c
> +++ b/drivers/tty/serial/milbeaut_usio.c
> @@ -523,6 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
>   	}
>   	port->membase = devm_ioremap(&pdev->dev, res->start,
>   				resource_size(res));
> +	if (!port->membase) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}

Hi,

what about using devm_ioremap_resource() and have only one if there?

thanks,
-- 
js
suse labs
