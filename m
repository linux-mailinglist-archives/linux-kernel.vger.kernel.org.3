Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011F50095C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiDNJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiDNJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:10:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7E6D962;
        Thu, 14 Apr 2022 02:07:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 148F51F4778C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649927262;
        bh=SGjdvm2jxn/wrvUxD5fVBXM2K5YNhQcQ079/GSOHMTM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=m1VxcuIEimr1pL6AXUPBpixE9KfydqWy+Yvf7QNvQCWgfZo4BqCHbv/VeS0fgkaK7
         1ce043sto+XbA7wCsuXlYMm46Pjr3b0K6ijEEEcnMa6OIa5IhG6naZZ0B0mS1aC/qL
         2ufKmOPdsV2BBhhBlrzCxZjPMf+FDyA8YmhcGALPXXotqpUQEmZcuWAtJiz6ZUdJAy
         Uh0QoNEw2Z//xRPlNnYNYWhQ9ZlX6/aPt4WMKtsKe5/fejMMQn6EujuyDQtbjSCmqE
         Lzbad2vaSYyKkCJMUe1hKffhFCSqfhhPys50gVT1hhVV6JWn0OCVD5fngPfWivyCTN
         jgs2mwU7cXpgQ==
Message-ID: <fdd5ac4e-bff1-af65-23f8-d73d6b5306e7@collabora.com>
Date:   Thu, 14 Apr 2022 14:07:30 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com, Len Brown <lenb@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
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
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH RESEND v6] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <Yk7aeAcKIBrTupcq@debian-BULLSEYE-live-builder-AMD64>
 <708fb1ec-4e57-7a1d-b0a0-a3a10b3cacf3@redhat.com>
 <CAJZ5v0g2UDOR3mYsdqnPcpYgmecY706YQcTKTWMRtezkK0sfaQ@mail.gmail.com>
 <e25f5599-10f5-90b7-227a-01616f722cca@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <e25f5599-10f5-90b7-227a-01616f722cca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 6:40 PM, Hans de Goede wrote:
> Hi,
> 
> On 4/11/22 15:37, Rafael J. Wysocki wrote:
>> On Mon, Apr 11, 2022 at 3:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 4/7/22 14:35, Muhammad Usama Anjum wrote:
>>>> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>
>>>> The x86 Chromebooks have ChromeOS ACPI device. This driver attaches to
>>>> the ChromeOS ACPI device and exports the values reported by ACPI in a
>>>> sysfs directory. This data isn't present in ACPI tables when read
>>>> through ACPI tools, hence a driver is needed to do it. The driver gets
>>>> data from firmware using ACPI component of the kernel. The ACPI values
>>>> are presented in string form (numbers as decimal values) or binary
>>>> blobs, and can be accessed as the contents of the appropriate read only
>>>> files in the standard ACPI device's sysfs directory tree. This data is
>>>> consumed by the ChromeOS user space.
>>>>
>>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>
>>>
>>> Thanks overall this looks pretty good to me.  The only remark which
>>> I have is that I would like to see the Kconfig symbol changed
>>> from CONFIG_ACPI_CHROMEOS to CONFIG_CHROMEOS_ACPI to match the
>>> filename.
>>>

I'll rename in next version.

>>> CONFIG_ACPI_CHROMEOS to me suggests that this is an ACPI subsystem
>>> Kconfig option which, with the driver living under
>>> drivers/platform/x86 it is not.
>>>
>>> There is no need to send a new version for this, if you agree
>>> with the change let me know and I can change this while merging
>>> the driver.
>>>
>>> Rafael, before I merge this do you have any (more) remarks
>>> about this driver?
>>
>> I'm not sure why it has to be an acpi_driver.
>>
>> I think that the generic enumeration code creates a platform device
>> for this ACPI device object, so why can't it bind to that platform
>> device?
>>
>> Generally speaking, IMV we should avoid adding drivers binding
>> directly to ACPI device objects, because that is confusing (it is kind
>> of like binding directly to an of_node) and it should be entirely
>> avoidable.
> 
> Ah I missed that, good point.
> 
> Muhammad can you give turning this into a platform driver a try please?
> 
> Note this will change all the sysfs attribute paths from:
> 
> /sys/bus/acpi/devices/GGL0001:00/...
> 
> to:
> 
> /sys/bus/platform/devices/GGL0001:00/...
> 
> and the ABI documentation should be updated accordingly.
> 

Thank you for comments and directions. They mean a lot. I'll make the
changes in next version.

> Regards,
> 
> Hans
> 
> 
> 

-- 
Muhammad Usama Anjum
