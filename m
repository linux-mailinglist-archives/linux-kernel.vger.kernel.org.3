Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4847F432
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhLYSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 13:05:01 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55785 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYSFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 13:05:00 -0500
Received: (Authenticated sender: frank@zago.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7952760002;
        Sat, 25 Dec 2021 18:04:57 +0000 (UTC)
Message-ID: <d949f737-7cb8-e466-06c7-b3fd7efadfd7@zago.net>
Date:   Sat, 25 Dec 2021 12:04:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] iio: position: Add support for ams AS5600 angle sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211216202651.120172-1-frank@zago.net>
 <20211223132800.682a56d2@jic23-huawei>
From:   Frank Zago <frank@zago.net>
In-Reply-To: <20211223132800.682a56d2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonaathan,

>> +What:		sys/bus/iio/devices/iio:deviceX/agc
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_fth
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_hyst
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_outs
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_pm
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_pwmf
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_sf
>> +What:		sys/bus/iio/devices/iio:deviceX/conf_wd
>> +What:		sys/bus/iio/devices/iio:deviceX/magnitude
>> +What:		sys/bus/iio/devices/iio:deviceX/mang
>> +What:		sys/bus/iio/devices/iio:deviceX/mpos
>> +What:		sys/bus/iio/devices/iio:deviceX/status_md
>> +What:		sys/bus/iio/devices/iio:deviceX/status_mh
>> +What:		sys/bus/iio/devices/iio:deviceX/status_ml
>> +What:		sys/bus/iio/devices/iio:deviceX/zmco
>> +What:		sys/bus/iio/devices/iio:deviceX/zpos
>> +KernelVersion:	TBD
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +	Read and write the ams AS5600 internal registers and their
>> +	fields. zpos/mpos can be used to create a subset of the 0-360
>> +	degree range. status_md will tell whether the magnet is
>> +	detected. Check the datasheet
>> +	(https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf)
>> +	for more information.
> 
> No to this lot.  If you need raw register access it needs to be debugfs
> not sysfs.  IIO provides a standard way of doing that.
> (just grep debugfs and you will find lots of examples).

I've moved them all to debugfs, but I think this is abusing what debugfs
is for. It may not be mounted on a system after all.

Why not have a namespace in sysfs for things specific to a device that
can't be abstracted to other devices?

>> + * The rotating magnet is installed from 0.5mm to 3mm parallel to and
>> + * above the chip.
>> + *
>> + * The raw angle value returned by the chip is [0..4095]. The channel
>> + * 0 (in_angl0_raw) returns the unscaled and unmodified angle, always
>> + * covering the 360 degrees. The channel 1 returns the chip adjusted
>> + * angle, covering from 18 to 360 degrees, as modified by its
>> + * ZPOS/MPOS/MANG values,
> 
> So, the raw case is simple, the other one more complex.
> 
> I think zpos maps well to offset in iio terms. Mpos is harder because
> we don't typically define a maximum value for a channel. I'm also not
> sure what the point is in either of these unless MANG is used and
> as you observer that is not exposed (good thing too given limited write cycles).
> Without MANG you might as well just do it in userspace - unless the DAC or PWM
> outputs are of interest...

zpos/mpos define an arc in the circle. Physically that could reflect a
rotating button that can't do full circles. I've documented that a bit in v2.

I'm unclear how MANG works, as I haven't been able to set it. My only option 
would be to flash it (OTP) it to a value to my only device.


>> +	ret = i2c_smbus_read_byte_data(client, REG_STATUS);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* No magnet present could be a problem. */
> 
> :) Good understatement.  Why not just fail the probe if this occurs?

I left that in place, since I think it could be possible for the magnet to
not be present when the driver loads, for instance some sort of door could be
opened. Also it doesn't break anything besides not returning an valid angle.

Frank
