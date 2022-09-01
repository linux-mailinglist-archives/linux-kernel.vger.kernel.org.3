Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6A5A9BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiIAPl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiIAPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2175A3FA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662046876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYoFtYjF1V+qwYcerU3qx9YeyX1w8Ov3wZ1QYftIVaQ=;
        b=OKatM3SXccNMG5aDgrbhQYKz+wmrMofGila/L/RvQ1o/QR0vCR15we7k95CR+eojfxEDpP
        8w9gkjDcYgEBpKEyTyCGgKd1hCxQK0PUgGCLK2Akcl/UPUvHVRoYOcgNwfZrbCChrznpmX
        Fc7xsNIcahN+uBBpkFqNRY4QeX84PKk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-Rrgi-uWpM5Ou8OtwAlJuMw-1; Thu, 01 Sep 2022 11:41:14 -0400
X-MC-Unique: Rrgi-uWpM5Ou8OtwAlJuMw-1
Received: by mail-ej1-f70.google.com with SMTP id nb19-20020a1709071c9300b0074151953770so6121475ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NYoFtYjF1V+qwYcerU3qx9YeyX1w8Ov3wZ1QYftIVaQ=;
        b=lk3PWwMF/9uN7XZ8xgOVPlk0PO6P+rDADSswe7OW8N1gPGwMnSmA5Zj7sa83SxYXcU
         AQ1nfe3nyPIx947QpWVGxv1+NBz+DuV/LUIdGUNtQ+JpVmFwQZ8pUPplG3UF1v41prY5
         QvUKupHN9SQbjgfp2B+cAsYZMkGn9jmTXS0O1awCSTNNivjVyWWfa9STYOT1VU8r54lK
         uiwWWKckdgtLgLTM6D3k+lS67ZDyBCEj0qfl2PUGuJr3TItrgC71rzh5g5sHY9m1LEfj
         38qXlVnNAdHI7zVeD8Mnpddj7qm/qs/bA8ef5fIhxceyMpIruC96tThgaSCkz3s5fETv
         k6iA==
X-Gm-Message-State: ACgBeo0HtJYqh3uhFdXGtDH887ZuSIHByCF1vlY5ZKXeGCT1Y5gdLH9K
        qrTpccEh1FKrz7v/cDLmeCqLLiakn/2/sBGpE4KWzWYB1sl7gaVsE2odU/sojMGiUVnlrQ7OpKH
        4Z9DpbKglfGmdcNhDEOpGmv7n
X-Received: by 2002:a17:907:6d1d:b0:741:5b1b:5c9a with SMTP id sa29-20020a1709076d1d00b007415b1b5c9amr16289872ejc.642.1662046873302;
        Thu, 01 Sep 2022 08:41:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kUKy50HgQPipp6hTm1cKVdFjk8aQzOrrTyDTDNMTXxEwut13kcOojubSlvSxAd8rjdxhcuA==
X-Received: by 2002:a17:907:6d1d:b0:741:5b1b:5c9a with SMTP id sa29-20020a1709076d1d00b007415b1b5c9amr16289855ejc.642.1662046873099;
        Thu, 01 Sep 2022 08:41:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v12-20020a056402184c00b0044629b54b00sm1545641edy.46.2022.09.01.08.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:41:12 -0700 (PDT)
Message-ID: <7912c9bd-e2a6-f02d-835b-0379e354920e@redhat.com>
Date:   Thu, 1 Sep 2022 17:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220829201500.6341-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220829201500.6341-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/22 22:14, Mario Limonciello wrote:
> The WMI subsystem in the kernel currently tracks WMI devices by
> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
> module however is available from many devices on nearly every machine.
> 
> This originally was though to be a bug, but as it happens on most
> machines it is a design mistake.  It has been fixed by tying an ACPI
> device to the driver with struct wmi_driver. So drivers that have
> moved over to struct wmi_driver can actually support multiple
> instantiations of a GUID without any problem.
> 
> Add an allow list into wmi.c for GUIDs that the drivers that are known
> to use struct wmi_driver.  The list is populated with `wmi-bmof` right
> now. The additional instances of that in sysfs with be suffixed with -%d
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Change to an allow list for wmi-bmof and suffix the extra instances

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



> 
>  drivers/platform/x86/wmi.c | 45 ++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index aed293b5af81..2997dad79e8b 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -105,6 +105,12 @@ static const struct acpi_device_id wmi_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
>  
> +/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
> +static const char * const allow_duplicates[] = {
> +	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
> +	NULL,
> +};
> +
>  static struct platform_driver acpi_wmi_driver = {
>  	.driver = {
>  		.name = "acpi-wmi",
> @@ -1073,6 +1079,19 @@ static const struct device_type wmi_type_data = {
>  	.release = wmi_dev_release,
>  };
>  
> +static int guid_count(const guid_t *guid)
> +{
> +	struct wmi_block *wblock;
> +	int count = 0;
> +
> +	list_for_each_entry(wblock, &wmi_block_list, list) {
> +		if (guid_equal(&wblock->gblock.guid, guid))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
>  static int wmi_create_device(struct device *wmi_bus_dev,
>  			     struct wmi_block *wblock,
>  			     struct acpi_device *device)
> @@ -1080,6 +1099,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
>  	struct acpi_device_info *info;
>  	char method[WMI_ACPI_METHOD_NAME_SIZE];
>  	int result;
> +	uint count;
>  
>  	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
>  		wblock->dev.dev.type = &wmi_type_event;
> @@ -1134,7 +1154,11 @@ static int wmi_create_device(struct device *wmi_bus_dev,
>  	wblock->dev.dev.bus = &wmi_bus_type;
>  	wblock->dev.dev.parent = wmi_bus_dev;
>  
> -	dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
> +	count = guid_count(&wblock->gblock.guid);
> +	if (count)
> +		dev_set_name(&wblock->dev.dev, "%pUL-%d", &wblock->gblock.guid, count);
> +	else
> +		dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
>  
>  	device_initialize(&wblock->dev.dev);
>  
> @@ -1154,11 +1178,20 @@ static void wmi_free_devices(struct acpi_device *device)
>  	}
>  }
>  
> -static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
> +static bool guid_already_parsed_for_legacy(struct acpi_device *device, const guid_t *guid)
>  {
>  	struct wmi_block *wblock;
>  
>  	list_for_each_entry(wblock, &wmi_block_list, list) {
> +		/* skip warning and register if we know the driver will use struct wmi_driver */
> +		for (int i = 0; allow_duplicates[i] != NULL; i++) {
> +			guid_t tmp;
> +
> +			if (guid_parse(allow_duplicates[i], &tmp))
> +				continue;
> +			if (guid_equal(&tmp, guid))
> +				return false;
> +		}
>  		if (guid_equal(&wblock->gblock.guid, guid)) {
>  			/*
>  			 * Because we historically didn't track the relationship
> @@ -1208,13 +1241,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
>  		if (debug_dump_wdg)
>  			wmi_dump_wdg(&gblock[i]);
>  
> -		/*
> -		 * Some WMI devices, like those for nVidia hooks, have a
> -		 * duplicate GUID. It's not clear what we should do in this
> -		 * case yet, so for now, we'll just ignore the duplicate
> -		 * for device creation.
> -		 */
> -		if (guid_already_parsed(device, &gblock[i].guid))
> +		if (guid_already_parsed_for_legacy(device, &gblock[i].guid))
>  			continue;
>  
>  		wblock = kzalloc(sizeof(*wblock), GFP_KERNEL);

