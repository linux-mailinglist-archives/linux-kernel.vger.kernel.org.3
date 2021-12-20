Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55A247A5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhLTIB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:01:58 -0500
Received: from mxout70.expurgate.net ([194.37.255.70]:50785 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhLTIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:01:57 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mzDcF-0008Vi-WB; Mon, 20 Dec 2021 09:01:52 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mzDcF-0001Jt-A3; Mon, 20 Dec 2021 09:01:51 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id BC61F240041;
        Mon, 20 Dec 2021 09:01:50 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 54654240040;
        Mon, 20 Dec 2021 09:01:50 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id F30C522AD6;
        Mon, 20 Dec 2021 09:01:49 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Dec 2021 09:01:49 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: ktd20xx: Add the KTD20xx family of the RGB
 LEDs driver from Kinetic
In-Reply-To: <20211215204606.GH28336@duo.ucw.cz>
References: <20211123101826.9069-1-fe@dev.tdt.de>
 <20211123101826.9069-2-fe@dev.tdt.de> <20211215204606.GH28336@duo.ucw.cz>
Message-ID: <350ab383a3a40439c73a2769b9034ec6@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
X-purgate-ID: 151534::1639987311-00005ED7-50CE745C/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

thanks for your reply.

>> Variant 1:
>> The device has the ability to group LED outputs into two banks so that
>> the two LED banks can be controlled with the same color. This could 
>> not
>> be done via the LEDs 'sysfs' entry because of the limitation on the 
>> color
>> register count. The color of the two banks can be configured via 
>> device
>> 'sysfs' entry for all LEDs at once [current_color0|current_color1].
>> Which color the LED is to be used can be set via the 'sysfs' of the
>> individual LEDs via the 'multi_intensity' file. Valid values for the
>> colors (RGB) are 0 | 1. The value 0 selects the color register 0 and 
>> the
>> value 1 selects the color register 1.
>> 
>> Variant 2:
>> The device can also set the LED color independently. Since the chip 
>> only
>> has two color registers, but we want to control the 12 LEDs
>> independently via the 'led-class-multicolour' sysfs entry,
>> the full RGB color depth cannot be used. Due to this limitation, only 
>> 7
>> colors and the color black (off) can be set. To use this mode the 
>> color
>> registers must be preset via the device tree or the device 'sysfs'. 
>> The
>> color registers 0 must be preset with 0x00 (Red=0x00 Green=0x00 
>> Blue=0x00).
>> The color register1 should be preset all with the same value. This 
>> value
>> depends on which light intensity is to be used in the setup.
> 
> Summary: some crazy hardware.

I agree with you completely.
But there was no other hardware to choose it was already on the board.

> 
>> +static ssize_t current_color0_store(struct device *dev,
>> +		struct device_attribute *a,
>> +		const char *buf, size_t size)
>> +{
> 
> And now we have custom interface. Undocumented.

I just wanted to implement all possibilities features for the chip and
not commit to one. It may be that someone else can use the hardware for
something else. If that is the problem, then I can document that.

> That is not acceptable, sorry.
> Find a way to squeeze it into current RGB framework, perhaps with
> reduced feature set.

Ok I'll try and focus on variant 2.

> AFAICT you could either pretend it is 2-LED driver with full 8bit RGB
> on each, or you could pretend it is 12-LED driver with 1bit
> RGB. Select one and implement that.

On my board the LED driver is used for 12 LEDs and 1bit RGB colour 
depth.
So I could select 7 colors and (off).
For my understanding, does this mean that I remove variant 1 from the
source and send a v3 patchset? Or do I have to take anything else into
account when I use variant 2 now?

 From my point of view, the driver should fit if I remove variant 1?

Best regards

Florian
