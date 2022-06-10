Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74815546D05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbiFJTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350461AbiFJTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D88E6DF7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654888206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUW6JDLfmxj9lFzCpBnq7MGkjudHtjpg7FJPkpReq6I=;
        b=YzrHk8ANKkdwsfW5kABDc/uNzjxIHs1qJaadf139pUKck6MDMvkROu40yaWcUUHIN4esE4
        b9aVc34LsvNFD75yjVUuFkdgqJlKhe/WKoC+KpMqzctg7GgGE1QR7iCHnIifatPhv47Tbk
        moKxd4mrowV398XbqbkbfYqD7b7T7FA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-zncx7-M-MC2-MME9Jz9ZmQ-1; Fri, 10 Jun 2022 15:10:05 -0400
X-MC-Unique: zncx7-M-MC2-MME9Jz9ZmQ-1
Received: by mail-ed1-f71.google.com with SMTP id g7-20020a056402424700b0042dee9d11d0so80085edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qUW6JDLfmxj9lFzCpBnq7MGkjudHtjpg7FJPkpReq6I=;
        b=QM3uS+AlaX8XVmdDpoha/I+XRUEpzV3KKDfeJjbqNMpqu13gQxwWzEeU4LMlUM0xDI
         j6YXbVQV9bK9miiQ8AYu4/G73TUw5MT9dngoooozUF5iBrdo9KsY/H6R4PQT3EJGDeHD
         bDffalHsydetm7F+C5hsiE4inFeK0CCF6XXWaFX7fHkXVDHlL5MqDEOfm9rXT2P0U3ZE
         teQr5PlPJsAx+jfmfaFI3zwwyC43tH6W6EVHWz3WR7A8sRG5QjpWYiK5BBAatOj0YI3j
         5ZJBuVk6dvLBx4eaM4SqfqEwdajz6QvOd2JCqtZ0CjcEd6Tg/dsV9I+qmOC8oib8nKrU
         vqaA==
X-Gm-Message-State: AOAM532FEh+h+BnPAw9zSZPnbPGajUp3Zg9TuPlDC/vZyhkg5eRuXoRo
        DnGgkOU5WM3ipzDi7gPKv02wULN9XReHFmKYoFnU7kSUd2BJDRyrsZvvzm8TKFZPkrStnReWCLZ
        PDmOm7CSgArGbIRSqaPuN6wCG
X-Received: by 2002:a05:6402:4246:b0:42f:3a4b:cc71 with SMTP id g6-20020a056402424600b0042f3a4bcc71mr43556562edb.107.1654888203759;
        Fri, 10 Jun 2022 12:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnQNxWVZrJvoD/0PvZcdsGvidN1hpNu/R4NfW2TAvvSoYJyzY0SE26ysyPLnRN+SSoVDGpzg==
X-Received: by 2002:a05:6402:4246:b0:42f:3a4b:cc71 with SMTP id g6-20020a056402424600b0042f3a4bcc71mr43556545edb.107.1654888203542;
        Fri, 10 Jun 2022 12:10:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id t2-20020a05640203c200b0042617ba63c2sm5084edw.76.2022.06.10.12.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 12:10:03 -0700 (PDT)
Message-ID: <d5680f64-d5e7-3e42-0340-0f540ea12e50@redhat.com>
Date:   Fri, 10 Jun 2022 21:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: system76_acpi: use dev_get_drvdata
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653989063-20180-1-git-send-email-baihaowen@meizu.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1653989063-20180-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/22 11:24, Haowen Bai wrote:
> Eliminate direct accesses to the driver_data field.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/system76_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
> index 7299ad08c838..958df41ad509 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -339,7 +339,7 @@ static ssize_t kb_led_color_show(
>  	struct led_classdev *led;
>  	struct system76_data *data;
>  
> -	led = (struct led_classdev *)dev->driver_data;
> +	led = dev_get_drvdata(dev);
>  	data = container_of(led, struct system76_data, kb_led);
>  	return sysfs_emit(buf, "%06X\n", data->kb_color);
>  }
> @@ -356,7 +356,7 @@ static ssize_t kb_led_color_store(
>  	unsigned int val;
>  	int ret;
>  
> -	led = (struct led_classdev *)dev->driver_data;
> +	led = dev_get_drvdata(dev);
>  	data = container_of(led, struct system76_data, kb_led);
>  	ret = kstrtouint(buf, 16, &val);
>  	if (ret)

