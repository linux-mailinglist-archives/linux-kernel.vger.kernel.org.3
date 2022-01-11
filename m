Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D248AA58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349236AbiAKJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:20:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349230AbiAKJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641892838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJ1YqPO7Xit3OrTXhT/TYDES9bJJk2fXlWiLmQ/iCOQ=;
        b=irrRj5IBTgFCw1FGWFFAsRdn+4KcNsPgfKkekt5xbxexi2V761sdKHmFuY+wy/FynwogEg
        LYJck1MR9YSQ4VW423NYgx4ruef5ACM76JhJVOuwnCMw5HPkvznR0Qe8yxQ/yC/Z6OFYx6
        m/PnRIxsBWWZWc2VxYy+aEfSkZsu+NY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-s1Xb8XxoPxagAzNVMQzj2A-1; Tue, 11 Jan 2022 04:20:37 -0500
X-MC-Unique: s1Xb8XxoPxagAzNVMQzj2A-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a056402520700b003f841380832so12744883edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uJ1YqPO7Xit3OrTXhT/TYDES9bJJk2fXlWiLmQ/iCOQ=;
        b=l1dsgYBqb5jyKu59zg9R7CZSxIBk2xSc3v38zLYk0/jlcrnsFqDWEvjjOgCf99dJnb
         IIkxPyMvyknhk/5LHjlDyQhVQJ7zkV8UKtyQ/lm25Mum4EmIRfa0hZxz3wBCOWdmqjeG
         sAen2mcL0vp/6gXqu2l8JJPmDs83cvacL1zseKkkHtPc7PnwUGbyDQR08g8er1+rD4MG
         d8nPnhRxCeVmmEF8U9iBM5FGcswzgOCHbJAJY/9q1YkkbclqA9EJiopb9MV84gPV/5Jo
         TR4HlodiUiNWechGACTjUuhC3wZL+mQ6dgwPl9p3gjJ9m6KdfwWHMjChGmKfDD+PdaEC
         Pgfw==
X-Gm-Message-State: AOAM530M2TwBRcpPZGKr/ATXKGyi15SmQNVT7lzNb7BX/sjMpTYLS/4Q
        cA6l8La0b6/kxp+B+qP3fPtJAxCBCB+vEXzvH+gjq+iH+iDwLedACLB2StjTMhrQfIRmZwSGrkE
        t7wcBt9APck2P+j8TFI9o5vfT
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr2843869ejw.70.1641892835805;
        Tue, 11 Jan 2022 01:20:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXuRWJ4cHHSS27BhJ/iVwz/12FvR8jmZfdmnIZZPxYco9NzHX7vZnxSjKW05qyZhnGf2vOKg==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr2843853ejw.70.1641892835568;
        Tue, 11 Jan 2022 01:20:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id kv11sm2255731ejc.156.2022.01.11.01.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 01:20:35 -0800 (PST)
Message-ID: <a066f0bc-7b27-771c-544d-cacd15aa2374@redhat.com>
Date:   Tue, 11 Jan 2022 10:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 6/6] ACPI: bus-multi-instantiate: Add SPI support
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        'Mark Brown' <broonie@kernel.org>,
        "'Rafael J . Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Mark Gross' <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
 <20211210154050.3713-7-sbinding@opensource.cirrus.com>
 <c311642f-38ab-4914-cf92-852e6a20cfc9@redhat.com>
 <00af01d8062f$75aed010$610c7030$@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <00af01d8062f$75aed010$610c7030$@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/10/22 15:36, Stefan Binding wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: 21 December 2021 18:32
>> To: Stefan Binding <sbinding@opensource.cirrus.com>; Mark Brown
>> <broonie@kernel.org>; Rafael J . Wysocki <rafael@kernel.org>; Len Brown
>> <lenb@kernel.org>; Mark Gross <markgross@kernel.org>
>> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-
>> acpi@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> patches@opensource.cirrus.com
>> Subject: Re: [PATCH v2 6/6] ACPI: bus-multi-instantiate: Add SPI support
> 
>>> +	ret = bmi_spi_count_resources(adev);
>>> +	if (ret <= 0)
>>> +		return ret;
>>> +	count = ret;
>>
>> Ok, so why not do the following here instead (and drop a whole bunch of
>> functions above):
>>
>> 	ret = acpi_dev_get_resources(adev, &r, bmi_spi_count, &count);
>> 	if (ret < 0)
>> 		return ret;
>>
>> 	if (count <= 0) {
>> 		acpi_dev_free_resource_list(&r);
>> 		return count;
>> 	}
>>
>> 	/* Note we are not freeing the resource list yet here !!! */
>>
>>> +
>>> +	bmi->spi_devs = devm_kcalloc(dev, count, sizeof(*bmi->spi_devs),
>> GFP_KERNEL);
>>> +	if (!bmi->spi_devs)
>>> +		return -ENOMEM;
>>> +
>>> +	acpi_data = bmi_spi_get_resources(dev, adev, count);
>>> +	if (!acpi_data)
>>> +		return -ENOMEM;
>>
>> Remove the bmi_spi_get_resources() call here.
>>
>>> +
>>> +	for (i = 0; i < count && inst_array[i].type; i++) {
>>
>> Write a new:
>>
>> int bmi_get_spi_resource_by_index(list_head *resource_list, struct
>> acpi_resource_spi_serialbus *sb_ret, int index)
>> {}
>>
>> Helper which walks the list and fills in *sb_ret with the Nth (matching index)
>> SpiSerialBus resource found in the
>> list.
>>
>> And then do:
>>
>> 		ret = bmi_get_spi_resource_by_index(&r, &sb, i);
>> 		if (ret)
>> 			return ret;
>>
>> 		ctrl =
>> bmi_find_spi_controller(sb.resource_source.string_ptr);
>>
>>
>>> +		ctlr = bmi_find_spi_controller(acpi_data-
>>> acpi_data[i].resource_source);
>>> +		if (!ctlr) {
>>> +			ret = -EPROBE_DEFER;
>>> +			goto error;
>>> +		}
>>> +
>>> +		spi_dev = spi_alloc_device(ctlr);
>>> +		if (!spi_dev) {
>>> +			dev_err(&ctlr->dev, "failed to allocate SPI device for
>> %s\n",
>>> +				dev_name(&adev->dev));
>>> +			ret = -ENOMEM;
>>> +			goto error;
>>> +		}
>>> +
>>> +		strscpy(spi_dev->modalias, inst_array[i].type,
>> sizeof(spi_dev->modalias));
>>> +
>>
>> And replace all the "acpi_data->acpi_data[i].sb." reference below with
>> simple "sb.".
>>
>>
>>> +		if (ctlr->fw_translate_cs) {
>>> +			ret = ctlr->fw_translate_cs(ctlr,
>>> +						    acpi_data-
>>> acpi_data[i].sb.device_selection);
>>> +			if (ret < 0) {
>>> +				spi_dev_put(spi_dev);
>>> +				goto error;
>>> +			}
>>> +			spi_dev->chip_select = ret;
>>> +		} else {
>>> +			spi_dev->chip_select = acpi_data-
>>> acpi_data[i].sb.device_selection;
>>> +		}
>>> +
>>> +		spi_dev->max_speed_hz = acpi_data-
>>> acpi_data[i].sb.connection_speed;
>>> +		spi_dev->bits_per_word = acpi_data-
>>> acpi_data[i].sb.data_bit_length;
>>> +
>>> +		if (acpi_data->acpi_data[i].sb.clock_phase ==
>> ACPI_SPI_SECOND_PHASE)
>>> +			spi_dev->mode |= SPI_CPHA;
>>> +		if (acpi_data->acpi_data[i].sb.clock_polarity ==
>> ACPI_SPI_START_HIGH)
>>> +			spi_dev->mode |= SPI_CPOL;
>>> +		if (acpi_data->acpi_data[i].sb.device_polarity ==
>> ACPI_SPI_ACTIVE_HIGH)
>>> +			spi_dev->mode |= SPI_CS_HIGH;
>>> +
>>> +		ret = bmi_get_irq(pdev, adev, &inst_array[i]);
>>> +		if (ret < 0) {
>>> +			spi_dev_put(spi_dev);
>>> +			goto error;
>>> +		}
>>> +		spi_dev->irq = ret;
>>> +
>>> +		snprintf(name, sizeof(name), "%s-%s-%s.%d",
>> dev_name(&ctlr->dev), dev_name(dev),
>>> +			 inst_array[i].type, i);
>>> +		spi_dev->dev.init_name = name;
>>> +
>>> +		ret = spi_add_device(spi_dev);
>>> +		if (ret) {
>>> +			dev_err(&ctlr->dev, "failed to add SPI device %s from
>> ACPI: %d\n",
>>> +				dev_name(&adev->dev), ret);
>>> +			spi_dev_put(spi_dev);
>>> +			goto error;
>>> +		}
>>> +
>>> +		dev_dbg(dev, "SPI device %s using chip select %u", name,
>> spi_dev->chip_select);
>>> +
>>> +		bmi->spi_devs[i] = spi_dev;
>>> +		bmi->spi_num++;
>>> +	}
>>> +
>>> +	if (bmi->spi_num < count) {
>>> +		dev_err(dev, "Error finding driver, idx %d\n", i);
>>> +		ret = -ENODEV;
>>> +		goto error;
>>> +	}
>>> +
>>> +	dev_info(dev, "Instantiate %d SPI devices.\n", bmi->spi_num);
>>
>> And here replace the bmi_spi_res_free(acpi_data); call in both exit paths
>> with:
>> acpi_dev_free_resource_list(&r); .
>>
>> To me this way, simply using the already allocated resources from the list,
>> rather then making a temp copy of them and throwing that away seems like
>> a simpler solution ?
>>
>> If you go this route, please also remove the struct bmi_spi_acpi and
>> struct bmi_spi_sb_acpi data types which you now no longer need.
>>
> 
> I tried to implement this idea, and reuse the resource list, but I hit an issue. 
> The resources saved in the list are not "struct acpi_resource", but instead the 
> generic "struct resource".
> We need the acpi_resource structure to pull the parameters from to be able to
> create the spi devices.
> As far as I know there is no way to convert the "struct resource" into a
> "struct acpi_resource". Is there another way to do this?

Ugh, you're right. Sorry about that. I still don't realy like the code
from your original v2 patch for this.

So maybe this comment from my second reply on this patch can help
clean things up:

"So thinking a bit more about this, then looking up the nth SpiSerialBus
resource, and then turning that into a spi_client is something which
the SPI core ACPI code should already be doing for index==0. So I think
that you should be able to modify the SPI core ACPI code to take index
as a parameter and then have it export a helper for this which you
can use rather then duplicate the SPI core ACPI code  ? Note this is
also what the I2C code is already doing.

And if you go that route you may also want to consider to add the SPI
equivalent of the i2c_acpi_client_count() helper."

Maybe that is a possible route to go to clean this up?

Note there are also 2 other small remarks pending:

1. My comment about adding the _t_ at the end of detect
2. + Mark's remark about patch 3/6 missing your Signed-off-by.

Regards,

Hans

