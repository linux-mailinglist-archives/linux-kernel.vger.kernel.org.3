Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7435A46F37A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhLIS7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhLIS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639076155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJJhns/5ANrFZqpJu+n3IPAn/jBjNqXQdVDYeLj+Qtw=;
        b=BLsTiyg0nYCzs5EXx8zDl0ZcQG9XeZVJRTZ3UB0tsLj+nlTdQVHaZeyyZ2qRwRZnlBt5l8
        hbCd2B+bi5hcKpZ0YDiY3EeeRR2/Jfx/OfxMD7OsYxkvgoYXR5LF8YPtc7QquU9si6OcoR
        xyS5kIQbVfSNIV4QgFyIZ6Pv+tuRJz4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-fduxRs2uMIyusYn94AdpWQ-1; Thu, 09 Dec 2021 13:55:54 -0500
X-MC-Unique: fduxRs2uMIyusYn94AdpWQ-1
Received: by mail-oi1-f197.google.com with SMTP id bm27-20020a0568081a9b00b002bd445624cdso4425507oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FJJhns/5ANrFZqpJu+n3IPAn/jBjNqXQdVDYeLj+Qtw=;
        b=12MZDoYKapqyfTeaRk5+xzqury6LIQtcd+lMt172fVDCL+5b4diotwVOHaLZ5XznQi
         GON05DNlBgvnh0cNcr6nZNv5krLJ0FItQjGP1cYcL+HbOVrpVTwDVEJ0g61jw8OrPeDi
         8alqOVhFaui2Rv028LlwoCh5c6nmTcmCTpa/E1IrG03pX16r3s0Mgdoqg22ux1PyGJYa
         X78UdlfCau0D8un8wu8oWvEG2VmFwbBM/7nQ0hN41xr+Vyy2IOTq5E4ieCO90fg1RAm6
         UdRiqVvv8mcRmLM9fmy1UuOfYPywsnE+vx42NbFXfgc3sG9Cn6jaunXHpI9kt0hvtgSt
         6uzg==
X-Gm-Message-State: AOAM531A8nqr8FnPZjfa1XWIN8DlSo4QQfX9XSPDLYLH+tCWErsu7VCT
        5CMHastOTzCjvQh/N+MOzQjtg6QiGRYyaxMvl7yxgucT2iprbUjJyx9q+/1UexBO6XVeK1cJ684
        +N1F9xB3Ns2NLmeH12YYiWN5I
X-Received: by 2002:a05:6808:f8c:: with SMTP id o12mr7621870oiw.50.1639076153978;
        Thu, 09 Dec 2021 10:55:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8W5gtppFnKSeXK5jW9FR6fIgyCXJwopREqmMA9w0l/tuJlkn/e5ILKIlTp7rzLm0vt3znnw==
X-Received: by 2002:a05:6808:f8c:: with SMTP id o12mr7621857oiw.50.1639076153782;
        Thu, 09 Dec 2021 10:55:53 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y17sm121187ote.48.2021.12.09.10.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 10:55:53 -0800 (PST)
Subject: Re: [RFC PATCH 0/5] Firmware Upload Framework
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russ Weight <russell.h.weight@intel.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        "Gong, Richard" <richard.gong@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <8b7bbdcd-ef48-9f48-10c0-021c41575522@redhat.com> <YZVV98XoiI3NQHQ1@ripper>
 <2a7e266f-6646-dff5-5682-b81df4d39237@redhat.com>
 <YbIiCkhaAqWvsm2g@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bd55273c-8eb6-840f-7d1e-0ff98734fe38@redhat.com>
Date:   Thu, 9 Dec 2021 10:55:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YbIiCkhaAqWvsm2g@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/21 7:34 AM, Greg KH wrote:
> On Thu, Dec 09, 2021 at 07:15:06AM -0800, Tom Rix wrote:
>> On 11/17/21 11:20 AM, Bjorn Andersson wrote:
>>> On Mon 15 Nov 05:57 PST 2021, Tom Rix wrote:
>>>
>>>> On 11/10/21 5:13 PM, Russ Weight wrote:
>>>>> The Firmware Upload framework provides a common API for uploading firmware
>>>>> files to target devices. An example use case involves FPGA devices that
>>>>> load FPGA, Card BMC, and firmware images from FLASH when the card boots.
>>>>> Users need the ability to update these firmware images while the card is
>>>>> in use.
>>>>>
>>>>> Device drivers that instantiate the Firmware Upload class driver will
>>>>> interact with the target device to transfer and authenticate the firmware
>>>>> data. Uploads are performed in the context of a kernel worker thread in
>>>>> order to facilitate progress indicators during lengthy uploads.
>>>>>
>>>>> This driver was previously submitted in the context of the FPGA sub-
>>>>> system as the "FPGA Image Load Framework", but the framework is generic
>>>>> enough to support other devices as well. The previous submission of this
>>>>> patch-set can be viewed here:
>>>>>
>>>>> https://marc.info/?l=linux-kernel&m=163295640216820&w=2
>>>>>
>>>>> The n3000bmc-sec-update driver is the first driver to use the Firmware
>>>>> Upload API. A recent version of these patches can be viewed here:
>>>>>
>>>>> https://marc.info/?l=linux-kernel&m=163295697217095&w=2
>>>>>
>>>>> I don't think I am duplicating any functionality that is currently covered
>>>>> in the firmware subsystem. I appreciate your feedback on these patches.
>>>> This may be a common api for fpga/dfl-, but it is not likely common for
>>>> general devices.
>>>>
>>> During my years of hacking on device drivers I've run into the need for
>>> being able to reflash/update firmware in things such as touchscreen
>>> controllers, hdmi bridges, usb network devices and (embedded) usb hubs.
>>>
>>> The implementation typically manifest itself as some sysfs or debugfs
>>> knob which when written triggers a request_firmware() followed by the
>>> operation to write the content to flash. But the result is often quite
>>> hacky and requires that you store the firmware-to-be-written in some
>>> path that will be looked at by request_firmware() - and hence these
>>> patches often doesn't end up upstream.
>>>
>>> So I'm certainly in favor of some generic way for drivers to expose an
>>> interface for userspace to flash new firmware to their associated
>>> hardware.
>> The image to be loaded is not really firmware and not really a partial
>> reconfiguration image.  It is both.
> The kernel does not care.  It is a "blob of data to be sent to the
> device".  Traditionally we have called this "firmware", and so the api
> is called that.  But it could be anything, the kernel does not parse it
> or care at all, it is just a pipe from userspace to the device to
> transfer the data.
>
>> Which image is used depends on the end user's workload for the n3000 and
>> could change and need reloading day to day.
>>
>> Because the n3000 is unusable without this change, I would like to see
>> updating working first for the n3000.
>>
>> Then the interface generalized as other devices are found that have a
>> similar use case.
>>
>> This is a device specific feature so it should go somewhere like
>> drivers/fpga/dfl-n3000-update.c
> Then have that driver call the firmware api, that's what it is there
> for.

Yes.

My point is this patchset has had several iterations on inventing a 
general interface that is used only by the n3000 board and possibly some 
of the other dfl boards.  Let's not do another round of a general 
interface inventing.  Let's focus on solving only n3000.

As an example of reducing the scope of the changes,

My understanding of the n3000 is that it does not have hw support for 
partial reconfiguration, there is only this full reimaging using the 
boards bmc, this is the intel-m10-bmc-sec-update change.  A solution 
would be to have a n3000 version of the fpga_manager_ops, with the ops 
using the intel-m10-bmc-sec-update lower level routines and reuse the 
fpga_manager's firmware api high level calls.

Tom


>
> thanks,
>
> greg k-h
>

