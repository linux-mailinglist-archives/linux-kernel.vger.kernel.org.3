Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617B505D89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiDRReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346882AbiDRReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:34:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44F2E9D0;
        Mon, 18 Apr 2022 10:31:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 8F5C41F43401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650303080;
        bh=mz68syY+TXaUMaWTzwA0UZdrUTQUGhs7WvFzMxPkjEY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hYxxZo+3YPQCgaNaahvFFIpssMOrFxvlGt9R9tNwGNyFTD9OhKhYh0YK27yoeEshT
         ejEvUNgcqmZxxtS+I+zSXnXVXcNEdpRFavMM6MaX+qLfVlQXxam0yXRrzOVnqE2xUZ
         oqjXJxyjnEvdRJVFe5LwTygNk38eS5H1Xpq3if0xwrGaYkSXZsO1U6D4okGCfanPCx
         ANwdV4fZ+Aid5/Bh/Xicqu6w2vIZCePqN7aMpQIB1pFs7C0fAbSRZ5pXx59fmS8beo
         b4K43MsX9lgWUTlm++avuPXri1sX7oTFmHdrIXLJ7Ddy3kK3Db2y+sZ9g2DgtydCEt
         wbn6UqLG8MBKw==
Message-ID: <78e3e1e9-e21f-052a-ecff-1d13714b4303@collabora.com>
Date:   Mon, 18 Apr 2022 22:31:08 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
 <eygNMwL4gadqjJuOq-syanavJ5sAb5_dHTcQ0V9TU5kM5uh5TZUQXdYsNFTtnSm1ZI5WKhw7BgzG8lXEwJKEZz4agWq5_HkFDGWiFuuo7fE=@protonmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <eygNMwL4gadqjJuOq-syanavJ5sAb5_dHTcQ0V9TU5kM5uh5TZUQXdYsNFTtnSm1ZI5WKhw7BgzG8lXEwJKEZz4agWq5_HkFDGWiFuuo7fE=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reviewing.

>> +	switch (element->type) {
>> +	case ACPI_TYPE_BUFFER:
>> +		length = element->buffer.length;
>> +		info->data = kmemdup(element->buffer.pointer,
>> +				     length, GFP_KERNEL);
>> +		break;
>> +	case ACPI_TYPE_INTEGER:
>> +		length = snprintf(buffer, sizeof(buffer), "%d",
>> +				  (int)element->integer.value);
>> +		info->data = kmemdup(buffer, length, GFP_KERNEL);
> 
> You can use `kasprintf()` here, no?
> 
Choosing kmemdup vs k*printf depends on what is being achieved. Usage of
kmemdup indicates that only the memory is being duplicated here. While
in case of k*printf, some transformation is done. Thus in normal memory
duplication cases like this, the usage of kmemdup makes code more
readable and seems preferable to me.

>> +static int chromeos_acpi_handle_package(struct platform_device *pdev,
>> +					union acpi_object *obj, char *name)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int count = obj->package.count;
>> +	union acpi_object *element;
>> +	int i, ret;
>> +
>> +	element = obj->package.elements;
>> +	for (i = 0; i < count; i++, element++) {
>> +		if (element->type == ACPI_TYPE_BUFFER ||
>> +		    element->type == ACPI_TYPE_STRING ||
>> +		    element->type == ACPI_TYPE_INTEGER) {
>> +			/* Create a single attribute in the root directory */
>> +			ret = chromeos_acpi_add_attr(chromeos_acpi.root,
>> +						     element, name,
>> +						     count, i);
>> +			if (ret) {
>> +				dev_err(dev, "error adding attributes (%d)\n",
>> +					ret);
>> +				return ret;
>> +			}
>> +			chromeos_acpi.num_attrs++;
>> +		} else if (element->type == ACPI_TYPE_PACKAGE) {
>> +			/* Create a group of attributes */
>> +			ret = chromeos_acpi_add_group(element, name, count, i);
>> +			if (ret) {
>> +				dev_err(dev, "error adding a group (%d)\n",
>> +					ret);
>> +				return ret;
>> +			}
>> +		} else {
>> +			if (ret) {
> 
> `ret` can be potentially uninitialized here, no?
> 
> 
This driver is written in this way that the element->type must be from
these 4 types always. Having a second look, it seems a bit illogical to
check the value of ret if some other element->type happen to be present.
I'll remove this `if (ret)` condition entirely.

>> +				dev_err(dev, "error on element type (%d)\n",
>> +					ret);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * chromeos_acpi_add_method() - Evaluate an ACPI method and create sysfs
>> + *				attributes
>> + *
>> + * @pdev: Platform device
>> + * @name: Name of the method to evaluate
>> + *
>> + * Return: 0 on success, non-zero on failure
>> + */
>> +static int chromeos_acpi_add_method(struct platform_device *pdev, char *name)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	acpi_status status;
>> +	int ret = 0;
>> +
>> +	status = acpi_evaluate_object(ACPI_COMPANION(&pdev->dev)->handle, name, NULL, &output);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(dev, "failed to retrieve %s (%d)\n", name, status);
> 
> (maybe `acpi_format_exception(status)` would be more meaningful than the numeric value)
>
Yeah, it'll be more better. I'll use this macro.

> 
>> +		return status;
> 
> This return value is potentially propagated to become the return value of
> the probe function. The problem is that it is not a negative errno that the probe
> method should return but rather an ACPI status code.
> 
Good catch. I'll return -EINVAL here instead.

> 
>> +	}
>> +
>> +	if (((union acpi_object *)output.pointer)->type == ACPI_TYPE_PACKAGE)
>> +		ret = chromeos_acpi_handle_package(pdev, output.pointer, name);
>> +
>> +	kfree(output.pointer);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * chromeos_acpi_process_mlst() - Evaluate the MLST method and add methods
>> + *				  listed in the response
>> + *
>> + * @pdev: Platform device
>> + *
>> + * Returns: 0 if successful, non-zero if error.
>> + */
>> +static int chromeos_acpi_process_mlst(struct platform_device *pdev)
>> +{
>> +	struct chromeos_acpi_attribute_group *aag;
>> +	char name[ACPI_NAMESEG_SIZE + 1];
>> +	union acpi_object *element, *obj;
>> +	struct device *dev = &pdev->dev;
>> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	acpi_status status;
>> +	int ret = 0;
>> +	int size;
>> +	int i;
>> +
>> +	status = acpi_evaluate_object(ACPI_COMPANION(&pdev->dev)->handle, MLST, NULL,
>> +				      &output);
>> +	if (ACPI_FAILURE(status))
>> +		return status;
>> +
>> +	obj = output.pointer;
>> +	if (obj->type != ACPI_TYPE_PACKAGE) {
>> +		ret = -EINVAL;
>> +		goto free_acpi_buffer;
>> +	}
>> +
>> +	element = obj->package.elements;
>> +	for (i = 0; i < obj->package.count; i++, element++) {
>> +		if (element->type == ACPI_TYPE_STRING) {
>> +			size = min(element->string.length + 1,
>> +				   (u32)ACPI_NAMESEG_SIZE + 1);
> 
> Is truncation a real possibility? Shouldn't it abort/etc. in that case?
> And `min()` "returns" a u32 here but `size` is an `int`.
> 
There is not likely, but can still happen. We want to not abort and
carry on with truncated string. I'll update the type of size to u32.

> 
>> +			strscpy(name, element->string.pointer, size);
>> +			ret = chromeos_acpi_add_method(pdev, name);
>> +			if (ret) {
>> +				chromeos_acpi_remove_groups();
>> +				break;
> 
> Is just a `break` is enough here to handle the error? If this is not fatal,
> then why is a `dev_warn()` not sufficient? If this is fatal, why continue
> with the rest of the function?
> 
I'll have a look.

> 
> Excuse me if I have missed previous discussions about it, but I am confused by
> the design. Why is a global variable needed here? The global struct's members
> are overwritten in the probe method in any case.
> 
The global variable is needed in probe and remove functions. Researching
this more, I think dev->driver_data can be used instead of global
variable. I'll test it. Thanks for mentioning it.

> And checkpatch reports that no MAINTAINERS entry has been added for the new file.
> (And it appears to be right if I have not missed anything.)
> 
I thought there will be default maintainer of this directory. But there
isn't. I'll send a separate email to discuss this.

> 
> Regards,
> Barnabás Pőcze

-- 
Muhammad Usama Anjum
