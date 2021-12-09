Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F390446EAF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhLIPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhLIPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639062912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vE0/+Mi/cOzPBG66/IWjyusF5u8YQbvLafnivhpTb5s=;
        b=PF1i8BWtq1ddkk0O7XYfmAZ2bGK4fEaqxkF2hG9LROsh2tVbzju/Ni4LarMS+A3Zfn4RZo
        8tWGMpg/5p7S3zanGNy/FKXZoodAqhpIzLWRdrwFcu8xxtozCPELcUPAzqZ0495B8EGzje
        Ms5cwcHkGn2ehiv8LXvXap4bDg0jUT4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-NSgUoMBjOpSqppHZ7YzUVg-1; Thu, 09 Dec 2021 10:15:11 -0500
X-MC-Unique: NSgUoMBjOpSqppHZ7YzUVg-1
Received: by mail-oo1-f72.google.com with SMTP id 68-20020a4a0347000000b002c2ac2c476dso3431363ooi.21
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vE0/+Mi/cOzPBG66/IWjyusF5u8YQbvLafnivhpTb5s=;
        b=i/6bGprUbl0RpCu2PZRWtjloFNjRlJMHC000K+p6pRjfcBjZrLLR+OZR+V5pd2d34c
         ubNT5kxFi6PaukQ+ZXWz6Z7FMtGfRxP5hVhA0K77p//xjhOOBDc8wsp46M6oXygls/pt
         ELUYEMM+f3VyxtHVeRteVede9g9AzLuEFeeEt13KysYJWCdkYCXkHSKFFs8rYyvv/jf3
         Cu4D2yDMaEMb5NGPSyqfNiGIKlJb34NIGC2TXD54pAmVa3BQnWnTS9r37omAie5sPUC2
         wAVv5UeklvnyZHqUQVf4XFxdEukuZNVyO5y8FR18ldMcF5M1USr7KC8/qTrBjjB6hRfo
         I+/Q==
X-Gm-Message-State: AOAM531COawOCStNLE8e09xj9n+9UPaJ324sPXMe7Ki3SJMOH3a4Gt75
        hVMUxSTKhsqJHoY3GOiwDra68xKSs/bUfL6QaxtZB1T4VC/0syRp/dYJkqD0AA4ItFbwnTH/QoK
        T0T4hEAIvZVX8oxJtWkgFVzm0
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr5740894ott.256.1639062909974;
        Thu, 09 Dec 2021 07:15:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPobSizk1C/Oc1YtMOv/ZDDBvMRST314OawTMhljRugUFciR8kxfuhJlmz8Mohjx1rbV7uyQ==
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr5740852ott.256.1639062909711;
        Thu, 09 Dec 2021 07:15:09 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x16sm24362otq.47.2021.12.09.07.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 07:15:09 -0800 (PST)
Subject: Re: [RFC PATCH 0/5] Firmware Upload Framework
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Russ Weight <russell.h.weight@intel.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ardb@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, "Gong, Richard" <richard.gong@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <8b7bbdcd-ef48-9f48-10c0-021c41575522@redhat.com> <YZVV98XoiI3NQHQ1@ripper>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2a7e266f-6646-dff5-5682-b81df4d39237@redhat.com>
Date:   Thu, 9 Dec 2021 07:15:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YZVV98XoiI3NQHQ1@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/21 11:20 AM, Bjorn Andersson wrote:
> On Mon 15 Nov 05:57 PST 2021, Tom Rix wrote:
>
>> On 11/10/21 5:13 PM, Russ Weight wrote:
>>> The Firmware Upload framework provides a common API for uploading firmware
>>> files to target devices. An example use case involves FPGA devices that
>>> load FPGA, Card BMC, and firmware images from FLASH when the card boots.
>>> Users need the ability to update these firmware images while the card is
>>> in use.
>>>
>>> Device drivers that instantiate the Firmware Upload class driver will
>>> interact with the target device to transfer and authenticate the firmware
>>> data. Uploads are performed in the context of a kernel worker thread in
>>> order to facilitate progress indicators during lengthy uploads.
>>>
>>> This driver was previously submitted in the context of the FPGA sub-
>>> system as the "FPGA Image Load Framework", but the framework is generic
>>> enough to support other devices as well. The previous submission of this
>>> patch-set can be viewed here:
>>>
>>> https://marc.info/?l=linux-kernel&m=163295640216820&w=2
>>>
>>> The n3000bmc-sec-update driver is the first driver to use the Firmware
>>> Upload API. A recent version of these patches can be viewed here:
>>>
>>> https://marc.info/?l=linux-kernel&m=163295697217095&w=2
>>>
>>> I don't think I am duplicating any functionality that is currently covered
>>> in the firmware subsystem. I appreciate your feedback on these patches.
>> This may be a common api for fpga/dfl-, but it is not likely common for
>> general devices.
>>
> During my years of hacking on device drivers I've run into the need for
> being able to reflash/update firmware in things such as touchscreen
> controllers, hdmi bridges, usb network devices and (embedded) usb hubs.
>
> The implementation typically manifest itself as some sysfs or debugfs
> knob which when written triggers a request_firmware() followed by the
> operation to write the content to flash. But the result is often quite
> hacky and requires that you store the firmware-to-be-written in some
> path that will be looked at by request_firmware() - and hence these
> patches often doesn't end up upstream.
>
> So I'm certainly in favor of some generic way for drivers to expose an
> interface for userspace to flash new firmware to their associated
> hardware.

The image to be loaded is not really firmware and not really a partial 
reconfiguration image.  It is both.

Which image is used depends on the end user's workload for the n3000 and 
could change and need reloading day to day.

Because the n3000 is unusable without this change, I would like to see 
updating working first for the n3000.

Then the interface generalized as other devices are found that have a 
similar use case.

This is a device specific feature so it should go somewhere like 
drivers/fpga/dfl-n3000-update.c

Tom

>
> Regards,
> Bjorn
>
>> Could the scope of this patchset be reduced to just fpga/dfl for now ?
>>
>> Something more like stratix10-rsu.
>>
>> Tom
>>
>>> - Russ
>>>
>>> Russ Weight (5):
>>>     firmware: Create firmware upload framework
>>>     firmware: upload: Enable firmware uploads
>>>     firmware: upload: Signal eventfd when complete
>>>     firmware: upload: Add status ioctl
>>>     firmware: upload: Enable cancel of firmware upload
>>>
>>>    .../driver-api/firmware/firmware-upload.rst   |  54 +++
>>>    Documentation/driver-api/firmware/index.rst   |   1 +
>>>    MAINTAINERS                                   |   9 +
>>>    drivers/firmware/Kconfig                      |   8 +
>>>    drivers/firmware/Makefile                     |   1 +
>>>    drivers/firmware/firmware-upload.c            | 413 ++++++++++++++++++
>>>    include/linux/firmware/firmware-upload.h      |  69 +++
>>>    include/uapi/linux/firmware-upload.h          |  73 ++++
>>>    8 files changed, 628 insertions(+)
>>>    create mode 100644 Documentation/driver-api/firmware/firmware-upload.rst
>>>    create mode 100644 drivers/firmware/firmware-upload.c
>>>    create mode 100644 include/linux/firmware/firmware-upload.h
>>>    create mode 100644 include/uapi/linux/firmware-upload.h
>>>

