Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE64FBD77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiDKNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbiDKNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C933B2ADC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649684462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UL4VC3xNL12j2w1KHO9njXE09mphZepoMWPC1sq8ni4=;
        b=R28XdzyLQb0Hu7ThX6XHGdHWgASsBM70z4IfrPnFPCGTD+Iefo5+y7EHM4/Q9Vb528nR0X
        uVYiWCh/bQSAi2d/Ek5apeja7nGdIUAyi311hLFK50u0Fg2iPU6LE8mt496YhNndizBZa+
        YjUeoSg1BufOzxKYviXycsvt2/YLTIg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-35vXXLyvO8mygSP-cSAN0A-1; Mon, 11 Apr 2022 09:41:01 -0400
X-MC-Unique: 35vXXLyvO8mygSP-cSAN0A-1
Received: by mail-ed1-f69.google.com with SMTP id eg29-20020a056402289d00b0041d6db0fbc9so3778433edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UL4VC3xNL12j2w1KHO9njXE09mphZepoMWPC1sq8ni4=;
        b=WsTZ+pMM6Rgz4jQ8Dey9VWCJ0DnKJpV3qkbvqmPe0FrOcYj2+rGhhw385bMj6WQ1H6
         DtVIMq2rMoCtSol09pueNrzNYMa1+zN8AkwvrTkt2SoZ0+8h18c1AjE/n3FG5/rcRnCI
         vxnzRKDIzormmiiawK+xgx84cRV1ffwI/K/QwLqCGwrZdzpBRWk+SPuEgkei8jw5oyNJ
         PEqXHPjwAdHsPrX3jB+e6jg8krE6B4nAAQZnXKrbCQGi2bYB26RnuYP3YW3q90eQS/Iu
         zCsBCUNjyDgL5oJdE4L8iyZM9MAKoCLMjuWs62Nhoj7gmvYGLPtI1E+r3di47m8sEbGQ
         u43Q==
X-Gm-Message-State: AOAM530tKiKQBYv/P+u+XCmzNG7Enp8aWr1+KaiD79P03BUA8M0TMxSj
        qkWyNGjsUlaccPaouMsyuoOCUZ/spUa/1jqRNnfWCtNdRek8GiNIuRudNRhNOAwCumLk4QDTy2F
        /C7Ox50Qn6/zkXFNHh0LYicRY
X-Received: by 2002:a17:906:58c9:b0:6e8:6bbb:3b7 with SMTP id e9-20020a17090658c900b006e86bbb03b7mr10796301ejs.252.1649684460336;
        Mon, 11 Apr 2022 06:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxOwY7W61+4P6gNnoRNEF1DoqwVewwh4An9ai4g2HZYPzMQeQ5RAmTsYwwQwPRa1V7B86d9Q==
X-Received: by 2002:a17:906:58c9:b0:6e8:6bbb:3b7 with SMTP id e9-20020a17090658c900b006e86bbb03b7mr10796272ejs.252.1649684460064;
        Mon, 11 Apr 2022 06:41:00 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090617d300b006cea86ca384sm11897209eje.40.2022.04.11.06.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:40:59 -0700 (PDT)
Message-ID: <e25f5599-10f5-90b7-227a-01616f722cca@redhat.com>
Date:   Mon, 11 Apr 2022 15:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v6] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
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
References: <Yk7aeAcKIBrTupcq@debian-BULLSEYE-live-builder-AMD64>
 <708fb1ec-4e57-7a1d-b0a0-a3a10b3cacf3@redhat.com>
 <CAJZ5v0g2UDOR3mYsdqnPcpYgmecY706YQcTKTWMRtezkK0sfaQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0g2UDOR3mYsdqnPcpYgmecY706YQcTKTWMRtezkK0sfaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/11/22 15:37, Rafael J. Wysocki wrote:
> On Mon, Apr 11, 2022 at 3:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 4/7/22 14:35, Muhammad Usama Anjum wrote:
>>> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>
>>> The x86 Chromebooks have ChromeOS ACPI device. This driver attaches to
>>> the ChromeOS ACPI device and exports the values reported by ACPI in a
>>> sysfs directory. This data isn't present in ACPI tables when read
>>> through ACPI tools, hence a driver is needed to do it. The driver gets
>>> data from firmware using ACPI component of the kernel. The ACPI values
>>> are presented in string form (numbers as decimal values) or binary
>>> blobs, and can be accessed as the contents of the appropriate read only
>>> files in the standard ACPI device's sysfs directory tree. This data is
>>> consumed by the ChromeOS user space.
>>>
>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>
>>
>> Thanks overall this looks pretty good to me.  The only remark which
>> I have is that I would like to see the Kconfig symbol changed
>> from CONFIG_ACPI_CHROMEOS to CONFIG_CHROMEOS_ACPI to match the
>> filename.
>>
>> CONFIG_ACPI_CHROMEOS to me suggests that this is an ACPI subsystem
>> Kconfig option which, with the driver living under
>> drivers/platform/x86 it is not.
>>
>> There is no need to send a new version for this, if you agree
>> with the change let me know and I can change this while merging
>> the driver.
>>
>> Rafael, before I merge this do you have any (more) remarks
>> about this driver?
> 
> I'm not sure why it has to be an acpi_driver.
> 
> I think that the generic enumeration code creates a platform device
> for this ACPI device object, so why can't it bind to that platform
> device?
> 
> Generally speaking, IMV we should avoid adding drivers binding
> directly to ACPI device objects, because that is confusing (it is kind
> of like binding directly to an of_node) and it should be entirely
> avoidable.

Ah I missed that, good point.

Muhammad can you give turning this into a platform driver a try please?

Note this will change all the sysfs attribute paths from:

/sys/bus/acpi/devices/GGL0001:00/...

to:

/sys/bus/platform/devices/GGL0001:00/...

and the ABI documentation should be updated accordingly.

Regards,

Hans



