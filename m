Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68E4A5E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiBAO0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239250AbiBAO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643725599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHeQ7ycHn7asMx6C36hsAZkE9E18SqcVluALQH8g4t4=;
        b=O7jtwIJKvH5jaYZxFhSyQXjUJ9RD9NMEmSHoT2OJkBBpfSGbHK1UOALFNoqrjvFfD9mFjM
        ShBeUzMTov4eIOxbLcvpeSFCPNI3dG2gk55hYBcqxeMvS/DRhlF6DxINuJrrXLxXthnGYt
        RFWNm2i9biuvZJ+kNh5yTLJP1rUziDc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-jqVuujJMN1ydf6yEXB-Ydg-1; Tue, 01 Feb 2022 09:26:37 -0500
X-MC-Unique: jqVuujJMN1ydf6yEXB-Ydg-1
Received: by mail-ed1-f72.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so8769474edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SHeQ7ycHn7asMx6C36hsAZkE9E18SqcVluALQH8g4t4=;
        b=RIvBmDuLsHVGlM675vi2m0MttSFLHHo8sa883i6WmsAT+/8xKX5q0/tVg8qLM0RfKG
         4TE5Yh4uH6oNw8y94yG/XJ2NOsf4jFwdqoq17vepbgtsBEGSOgIXQm/Y2STSTI+mOW/g
         9VDeJaFiwIfPZpbN8bO/l47wIZALFREnaYbLH1ir7YJWY3W6fzVCwuFJHmmmgmJDHX6d
         WnYMzmsahXS3TzOAodhJuYuHZAF6wi4maK0eCtBass33B+Aanlm0/lHmiEEkDEhmnTzN
         W96n3IJSsuXPtNIt4k3Z8GhOtQK9XTH7MqxUUG6RKmgL53ZC3AkDm2VYUXyxGAL8cVyH
         rKow==
X-Gm-Message-State: AOAM532CWydHMzWzrC4y9SV+E74wUQVbfP+a763KmNx+mZduiK1AsVbc
        AtKvKuM7TLti6T8/P7Xblr1cBDU7I4hfbN1hM4oO+EQz47EEbWbLiyE1VAoxlgY9NDsrPIwNnvU
        k7nQ+g8YFYPjLKLqUBzEKIgoD
X-Received: by 2002:a05:6402:1d56:: with SMTP id dz22mr26419242edb.82.1643725596792;
        Tue, 01 Feb 2022 06:26:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcIP8n58f/Us1Fbv32LxxCWhGs8UL07KOLBWbrU0ooPqALPEtbqtU6/lEbqy162NSaUULbng==
X-Received: by 2002:a05:6402:1d56:: with SMTP id dz22mr26419221edb.82.1643725596554;
        Tue, 01 Feb 2022 06:26:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id hh13sm14747228ejb.89.2022.02.01.06.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:26:36 -0800 (PST)
Message-ID: <c821953a-6572-d60d-6a00-fccd541268c5@redhat.com>
Date:   Tue, 1 Feb 2022 15:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 1/9] spi: Make spi_alloc_device and spi_add_device
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
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-2-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-2-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/22 18:24, Stefan Binding wrote:
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

