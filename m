Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1285B49506C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354855AbiATOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356214AbiATOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642689572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZO9CxpXnVO0unS4PfDkiiWErEf+1QW6VcHAAffKfBTg=;
        b=DDRp3YXkeBVrS0bAMMXNYfbjW6s2w8iLh0FjRf/eOXSdmOR+bv5+n1SCy84B1vGscnHdHF
        WCnvSrRQLadiZ+J4fZjPDfQXIeNWc+pnyAPlv2i3Q7GDeJpbo4jjaTPhccEgXSLHMSwgoT
        QsEWTnU+sGpZOc+UP457PRCJdXYyTpw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-52VL2mJHPcy_F7SdQvHEOw-1; Thu, 20 Jan 2022 09:39:31 -0500
X-MC-Unique: 52VL2mJHPcy_F7SdQvHEOw-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso6040681edt.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZO9CxpXnVO0unS4PfDkiiWErEf+1QW6VcHAAffKfBTg=;
        b=HhtV8wAq3XcXIWhk1Z36KIsgIJs8qxMQEm4N6g9z5xbJdLyywl1XEUhJ5SGe0QBKIX
         AfrR8y+4PH8qWVkNGRu3uyAKi1FSZWXBbuvpYPJdjiJIq5a12AuJUcCKAs2kS9HeP3YO
         tUwvI9nMXHxFlvXgEyRKybg4M/GNbVxJsXh3Lr+UunouKqYyKC7RgRbDU9Va8OQiVvUW
         AYYDUMQc4h2MbBreLzwF6HyYmRo37aOnfgq05ftQW5E3dHEtHzKZmHrWn7kPO/KhzN2q
         xV+aRVdBATUM8rha2dyMNa9obMsDlonmH9+VHLUJ8jyeDz7KKqxoyBEDD7qHq5Hhn+Oa
         XtcQ==
X-Gm-Message-State: AOAM533uRx4lbAV8kHpHh6nNwCobvv8KVhj5h5tWL9xv7A1uiJeL/fLI
        1SV5zyuX9/LFq+WdPYqpmWnU7dfayi9bIrFiCvRCxpcVVFX8HoDDSHDM8u6xF03gOEcdJiyLrPy
        owbBUTgpDl54IHOr5C53/pubJ
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr16848581ejc.2.1642689570133;
        Thu, 20 Jan 2022 06:39:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC8EiUO8zmKN0IM1R4oP/7CsqAviHdzhjNraDig7Z05SORbdwzW3MgHf7pVUwqUy+23nb9fQ==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr16848563ejc.2.1642689569933;
        Thu, 20 Jan 2022 06:39:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id gr7sm1108869ejb.2.2022.01.20.06.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:39:29 -0800 (PST)
Message-ID: <d77c27ac-6721-1d3e-2d79-4e4dfae7cabe@redhat.com>
Date:   Thu, 20 Jan 2022 15:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 1/9] spi: Make spi_alloc_device and spi_add_device
 public again
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
 <20220120134326.5295-2-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-2-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/22 14:43, Stefan Binding wrote:
> This functions were previously made private since they
> were not used. However, these functions will be needed
> again.
> 
> Partial revert of commit da21fde0fdb3
> ("spi: Make several public functions private to spi.c")
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/spi/spi.c       |  6 ++++--
>  include/linux/spi/spi.h | 12 ++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 4599b121d744..1eb84101c4ad 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -532,7 +532,7 @@ static DEFINE_MUTEX(board_lock);
>   *
>   * Return: a pointer to the new device, or NULL.
>   */
> -static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
> +struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>  {
>  	struct spi_device	*spi;
>  
> @@ -557,6 +557,7 @@ static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>  	device_initialize(&spi->dev);
>  	return spi;
>  }
> +EXPORT_SYMBOL_GPL(spi_alloc_device);
>  
>  static void spi_dev_set_name(struct spi_device *spi)
>  {
> @@ -652,7 +653,7 @@ static int __spi_add_device(struct spi_device *spi)
>   *
>   * Return: 0 on success; negative errno on failure
>   */
> -static int spi_add_device(struct spi_device *spi)
> +int spi_add_device(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> @@ -673,6 +674,7 @@ static int spi_add_device(struct spi_device *spi)
>  	mutex_unlock(&ctlr->add_lock);
>  	return status;
>  }
> +EXPORT_SYMBOL_GPL(spi_add_device);
>  
>  static int spi_add_device_locked(struct spi_device *spi)
>  {
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 7ab3fed7b804..0346a3ff27fd 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1452,7 +1452,19 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
>   * use spi_new_device() to describe each device.  You can also call
>   * spi_unregister_device() to start making that device vanish, but
>   * normally that would be handled by spi_unregister_controller().
> + *
> + * You can also use spi_alloc_device() and spi_add_device() to use a two
> + * stage registration sequence for each spi_device. This gives the caller
> + * some more control over the spi_device structure before it is registered,
> + * but requires that caller to initialize fields that would otherwise
> + * be defined using the board info.
>   */
> +extern struct spi_device *
> +spi_alloc_device(struct spi_controller *ctlr);
> +
> +extern int
> +spi_add_device(struct spi_device *spi);
> +
>  extern struct spi_device *
>  spi_new_device(struct spi_controller *, struct spi_board_info *);
>  
> 

