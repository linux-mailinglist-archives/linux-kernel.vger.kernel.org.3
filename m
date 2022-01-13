Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70D48D690
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiAMLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234108AbiAMLRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642072619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UpAWbhnLfAdP79dbzVZpoZs8Fpe6S1lBLtmGCHhouzE=;
        b=IRImLvuf5HdAEcB3O+OeDMR9HCgDMsSMtBl3Gx+cfZPIUNzUoOgGrla9hvB66Wl6iaEdDW
        SyWONLgCpcjxdJRX2hbKRPw7q+m/ZhQSR8y9tdwcn6hObQuo0tyYFJzWTE8xafuyZFHF6X
        ayswlnyLir+RMrQV22hl0pM7Bq7Dz9w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-zM-DA962MZKdVwUmtkxIiw-1; Thu, 13 Jan 2022 06:16:58 -0500
X-MC-Unique: zM-DA962MZKdVwUmtkxIiw-1
Received: by mail-wm1-f71.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso3427111wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 03:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UpAWbhnLfAdP79dbzVZpoZs8Fpe6S1lBLtmGCHhouzE=;
        b=zOoRCxDlDqF6dDhv5FNFNGgQaRtK/EjKW3ddPNh7epq92QDIM3VzNvtdIqcXL58QEu
         R2AKZzwD2Onh8D7Nmv4JmJkYtwdR/zPdz6X5vnppBwE7lPM0XyBCkv4BKmwOkyByNHO8
         pvwk0WK4QdIaJ0Ok4ZIOfcYgt9WSveRFhLqDuJ+xDduKL1KEO0uqZazlmLx/vqFLxouF
         5BNeGIBG+nEWTZ2LuqV/k1Hw8zCSgXbQQ9bdr6s2fC5VMqp5tHPCTGk7yyVuikKqge51
         mJrKwWev5sR27rJ9ROVg97y65BAqgUakrwC6BTqYJ3ammanlUuHYW7JLHFKt2XdPPR/L
         w7xQ==
X-Gm-Message-State: AOAM533OcWK5rt8HJ6F1REhdY8Mo4T1TDsg54l0YHsbVMBgO0FmTCnG/
        KiB2aCd+aitg5Hp2g3cn01BYMulCWphxpcJHvHT7ZciflrBOZbLdBSZyly9zM0IQs11ppxobm+h
        pALUREAZntSl7cAQ6s/Nqu+vQ
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr10843938wmk.188.1642072617025;
        Thu, 13 Jan 2022 03:16:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXXc6uRTealtYoDUNEciqOBGqdlLMcnCGsukcSFKe7p7D6S2unF5seIMFKN4PP4ZG1NvMiGQ==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr10843913wmk.188.1642072616790;
        Thu, 13 Jan 2022 03:16:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k31sm1313976wms.15.2022.01.13.03.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 03:16:56 -0800 (PST)
Message-ID: <735d2b47-227f-f09d-ddd6-28bc82a066a5@redhat.com>
Date:   Thu, 13 Jan 2022 12:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drivers/firmware: Add missing platform_device_put() in
 sysfb_create_simplefb
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211231080431.15385-1-linmq006@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211231080431.15385-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miaoqian,

On 12/31/21 09:04, Miaoqian Lin wrote:
> Add the missing platform_device_put() before return from
> sysfb_create_simplefb() in the error handling case.
> 
> Fixes: 8633ef8 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Thanks for the patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

>  drivers/firmware/sysfb_simplefb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
> index b86761904949..303a491e520d 100644
> --- a/drivers/firmware/sysfb_simplefb.c
> +++ b/drivers/firmware/sysfb_simplefb.c
> @@ -113,12 +113,16 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
>  	sysfb_apply_efi_quirks(pd);
>  
>  	ret = platform_device_add_resources(pd, &res, 1);
> -	if (ret)
> +	if (ret) {
> +		platform_device_put(pd);
>  		return ret;
> +	}
>  
>  	ret = platform_device_add_data(pd, mode, sizeof(*mode));
> -	if (ret)
> +	if (ret) {
> +		platform_device_put(pd);
>  		return ret;
> +	}
>

To avoid duplicating the error code logic twice, you could also do:

	if (ret)
		goto pdev_put;
  
>  	return platform_device_add(pd);

and then after this return statement:

pdev_put:
	platform_device_put(pd);
	return ret;

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

