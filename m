Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719E74A5EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiBAOyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239557AbiBAOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643727270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFwpy9fOZO6ssV96jv+obSGnqOS+dofnT9+Jw0dBzFY=;
        b=MWBynpe/XU3JsqA1CQHOk4PwnNILOm6bRsqxfMnl/GW9nrU77qPETouFETJwFflaVQhuon
        1ln+4sbfvg/Efa1rubxTYaMJlnWuh098gJu25QsvVGS2RPrTWFrB7VzwqqZmTFj4PrhMwW
        vjMPtnNIyDa7h0KmWBIDxHowwMROtyw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-zkf9H0ZJPhiNZ6g4oRr5lQ-1; Tue, 01 Feb 2022 09:54:29 -0500
X-MC-Unique: zkf9H0ZJPhiNZ6g4oRr5lQ-1
Received: by mail-ej1-f71.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso6672064ejj.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XFwpy9fOZO6ssV96jv+obSGnqOS+dofnT9+Jw0dBzFY=;
        b=LqGZv7JV3ZgvDPM8vDjz2Jomnx3Wn+8JP43hhU0mZ3EibXdLzp6dBLC6MnETN36mnC
         pVvDdDgKR1F027zwD7Shosa5Xplq6zwbsvrznuhdGfX6EXjvEX7UpVv7xUwSP7XWX7WY
         UhIJvyBcatdWpshD/2S5zWqaCGZD/+XcSlZwNaDuBJtlEPBZZGuvb75HJ/efESkWq3rr
         Plo3bmyPiFCgdNTOIAWbw9gGP1xU0RTTUBXCqsNOzSGD6VX1Y8/PejlCs+7H5J4zqbQG
         1S7Pvq6ZecBpu9cB9BUpHhrltMju9sHyp1JknKQdnPfVbgd2HsE9ZLGmjhbZ4zjYcEGh
         Araw==
X-Gm-Message-State: AOAM530JKcJmPN/6+UV2ofR/Aze4QBhCe/CTgSXzbfQwGcKYnwmt+J2c
        ccGL8EOwTy5EcNp1XqyJZNavohILzf2qvFPGmkIiE8uYD4UAf54YW3kOAlBkCYrL2eg+mnJ8PUh
        m1sfacy1Hw4GSwnIHVBVyiTq3
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr21186656ejc.365.1643727267221;
        Tue, 01 Feb 2022 06:54:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEkNSH5vVbDhhRxtI2/WVmnkgqtbEUGR0iAiSf9moRNqfjGp9ibnT3pF8ifw/vhLJcbPc/cw==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr21186615ejc.365.1643727266772;
        Tue, 01 Feb 2022 06:54:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id a25sm4283157ejs.149.2022.02.01.06.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:54:26 -0800 (PST)
Message-ID: <f9b67b36-4b33-2557-0f0d-2819cc616cff@redhat.com>
Date:   Tue, 1 Feb 2022 15:54:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 1/9] spi: Make spi_alloc_device and spi_add_device
 public again
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-2-sbinding@opensource.cirrus.com>
 <c821953a-6572-d60d-6a00-fccd541268c5@redhat.com>
 <CAJZ5v0jGqUvZS113VewgsGm8cMJc2B=M5KyqmOHTPNy+R8KeEQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jGqUvZS113VewgsGm8cMJc2B=M5KyqmOHTPNy+R8KeEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/22 15:52, Rafael J. Wysocki wrote:
> On Tue, Feb 1, 2022 at 3:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/21/22 18:24, Stefan Binding wrote:
>>> This functions were previously made private since they
>>> were not used. However, these functions will be needed
>>> again.
>>>
>>> Partial revert of commit da21fde0fdb3
>>> ("spi: Make several public functions private to spi.c")
>>>
>>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> The series also looks good to me from the ACPI side, so what tree
> should it go into?

Minus the ALSA patch from 8/9 which should go through the sound
tree AFAIK, I would be happy to pick up the entire series in the
pdx86 tree.

This requires an ack from Mark though for me merging the spi bits,
Mark ?

Regards,

Hans


> 
>>> ---
>>>  drivers/spi/spi.c       |  6 ++++--
>>>  include/linux/spi/spi.h | 12 ++++++++++++
>>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 4599b121d744..1eb84101c4ad 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -532,7 +532,7 @@ static DEFINE_MUTEX(board_lock);
>>>   *
>>>   * Return: a pointer to the new device, or NULL.
>>>   */
>>> -static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>>> +struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>>>  {
>>>       struct spi_device       *spi;
>>>
>>> @@ -557,6 +557,7 @@ static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>>>       device_initialize(&spi->dev);
>>>       return spi;
>>>  }
>>> +EXPORT_SYMBOL_GPL(spi_alloc_device);
>>>
>>>  static void spi_dev_set_name(struct spi_device *spi)
>>>  {
>>> @@ -652,7 +653,7 @@ static int __spi_add_device(struct spi_device *spi)
>>>   *
>>>   * Return: 0 on success; negative errno on failure
>>>   */
>>> -static int spi_add_device(struct spi_device *spi)
>>> +int spi_add_device(struct spi_device *spi)
>>>  {
>>>       struct spi_controller *ctlr = spi->controller;
>>>       struct device *dev = ctlr->dev.parent;
>>> @@ -673,6 +674,7 @@ static int spi_add_device(struct spi_device *spi)
>>>       mutex_unlock(&ctlr->add_lock);
>>>       return status;
>>>  }
>>> +EXPORT_SYMBOL_GPL(spi_add_device);
>>>
>>>  static int spi_add_device_locked(struct spi_device *spi)
>>>  {
>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>>> index 7ab3fed7b804..0346a3ff27fd 100644
>>> --- a/include/linux/spi/spi.h
>>> +++ b/include/linux/spi/spi.h
>>> @@ -1452,7 +1452,19 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
>>>   * use spi_new_device() to describe each device.  You can also call
>>>   * spi_unregister_device() to start making that device vanish, but
>>>   * normally that would be handled by spi_unregister_controller().
>>> + *
>>> + * You can also use spi_alloc_device() and spi_add_device() to use a two
>>> + * stage registration sequence for each spi_device. This gives the caller
>>> + * some more control over the spi_device structure before it is registered,
>>> + * but requires that caller to initialize fields that would otherwise
>>> + * be defined using the board info.
>>>   */
>>> +extern struct spi_device *
>>> +spi_alloc_device(struct spi_controller *ctlr);
>>> +
>>> +extern int
>>> +spi_add_device(struct spi_device *spi);
>>> +
>>>  extern struct spi_device *
>>>  spi_new_device(struct spi_controller *, struct spi_board_info *);
>>>
>>>
>>
> 

