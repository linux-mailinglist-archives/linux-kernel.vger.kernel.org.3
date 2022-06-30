Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AAC561E65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiF3OtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiF3OtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:49:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED21928C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:49:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k22so27665860wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B2VBBLTftlA/l3gTdMjDOBBbQmg8ClblnW9BWc7XV/U=;
        b=Vu094SS+BHfwuFgoi9Yjp8sT4hN5kcheuXTIrzHOGbAAW0rkfuob2bcKVR2UhUts4A
         +gR2GZgbcTamrZxqlwtwI2xIqNiRxFLvTpLbfe5sgC7PrH9Wl5RXAMxTIrkYKRBHQcGY
         Ww4cOJHmjXhKSTXtL+M50rkbDHSGnHEq/Rf7exkvbFom4GpeNDNe/M9zc/OKy7T1yrMb
         H1aEwQCVXV/Dzg2j2McnHMWQMreLVNtEp/nrrttCDX1buorH154IWkI2i66wlSDYl5kx
         LNdBl8RsdJo0tQ9NsttT9xFwMAbYLbg6x3SbTUNprJ8HelaCB+n4sgvuwnG1p1/1aHI2
         UHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B2VBBLTftlA/l3gTdMjDOBBbQmg8ClblnW9BWc7XV/U=;
        b=Q1bX0zRqpgi7tj0faq7QVB5dgFLP5HEPlr1dGt89nNJg71HmMOtgexIS3vYK32XOpl
         01c9rPRWR6xRwi5u1u4+cTX0JVDcZbqrqMINFJ67dIiT8/61nOQu4rMhgSPdnObQL/N2
         MgPJgY7Nf+XiRGJ1m4Y7dlIaUkeVDFED0UAkRsj0Rw/GBkkzuHkPclGrKxvJ3Er7mqDz
         Rgtm8Uuuhnys5ijlkL0MH7B3YprvlbnRieqZ31ve5YfcFmQxCfxIJIdrzWRYBELi6MSS
         eM0sFd+77Yvlk6QM90/qALM2dvhFElXXHX6S2cOhHmMCc4qOZk0qDeURd0IrpxtWnMt9
         sQJA==
X-Gm-Message-State: AJIora9TjzMGeT5luVAeJzOL1XKkI3pz7wYMtuELkZzQ1YjRCq8ddSdD
        ZgRXCLvhzQhsfrJFRFYRyTltSA==
X-Google-Smtp-Source: AGRyM1vcN1eGR7FpEPgCDeUc/U1ZFLrd+Cp5fJweUbWlgdFrNMz9HQHXfRWTYZAx5kx60mqMPzmrmg==
X-Received: by 2002:a5d:4251:0:b0:21b:885b:2fcc with SMTP id s17-20020a5d4251000000b0021b885b2fccmr9054531wrr.52.1656600550333;
        Thu, 30 Jun 2022 07:49:10 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id a3-20020a056000100300b0021b943a50b3sm20146551wrx.85.2022.06.30.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:49:08 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:49:07 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <Yr234pcBeCQZ250b@Red>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net>
 <YoFWNAhiDrzpeBU8@Red>
 <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net>
 <YoHtg30ZrhxjVedA@Red>
 <1747d709-6640-193d-8290-893b1541fae8@roeck-us.net>
 <b038aa19-9cba-d16a-15c5-e02fc749ab96@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b038aa19-9cba-d16a-15c5-e02fc749ab96@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, May 21, 2022 at 06:52:15AM -0700, Guenter Roeck a écrit :
> On 5/16/22 05:21, Guenter Roeck wrote:
> > On 5/15/22 23:21, LABBE Corentin wrote:
> >> Le Sun, May 15, 2022 at 05:29:54PM -0700, Guenter Roeck a écrit :
> >>> On 5/15/22 12:36, LABBE Corentin wrote:
> >>>> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
> >>>>> Corentin,
> >>>>>
> >>>>> On 5/8/22 23:30, Corentin Labbe wrote:
> >>>>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> >>>>>> So let's convert the driver to use hwmon_device_register_with_info().
> >>>>>>
> >>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >>>>>> ---
> >>>>> [ ... ]
> >>>>>
> >>>>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>>>>>             if (res)
> >>>>>>                 break;
> >>>>>> -        remove_attrs(resource);
> >>>>>> +        remove_domain_devices(resource);
> >>>>>>             setup_attrs(resource);
> >>>>>
> >>>>> Zhang Rui found an interesting problem with this code:
> >>>>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
> >>>>> to update sysfs attribute visibility, probably between
> >>>>> remove_domain_devices() and setup_attrs().
> >>>>>
> >>>>>>             break;
> >>>>>>         case METER_NOTIFY_TRIP:
> >>>>>> -        sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> >>>>>> +        hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
> >>>>>
> >>>>> ... which makes realize: The notification device should be the hwmon device.
> >>>>> That would be resource->hwmon_dev, not the acpi device.
> >>>>>
> >>>>
> >>>> Hello
> >>>>
> >>>> Since my hardware lacks capabilities testing this, I have emulated it on qemu:
> >>>> https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
> >>>>
> >>>> I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
> >>>>
> >>>> For testing config change I have tried lot of way:
> >>>>                   res = read_capabilities(resource);
> >>>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>>>                   remove_domain_devices(resource);
> >>>>                   setup_attrs(resource);
> >>>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
> >>>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
> >>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> >>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
> >>>
> >>> Did you add a debug log here ?
> >>
> >> Yes I added debug log to check what is called.
> >>
> >>>
> >>> acpi_power_groups would be the wrong parameter for sysfs_update_groups().
> >>> It would have to be resource->hwmon_dev->groups.
> >>>
> >>
> >> Even with that, no call to is_visible:
> >> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>                  remove_domain_devices(resource);
> >>                  setup_attrs(resource);
> >> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, resource->hwmon_dev->groups);
> >> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
> >> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> >> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
> >>                  break;
> >>
> >> I checked drivers/hwmon/hwmon.c is seems that is_visible is only called by gen_attr/gen_attrs which is only called by __hwmon_create_attrs and then by registers functions.
> >> So perhaps it explain why it is never called.
> > 
> > Ah yes, you are correct. Sorry, it has been too long ago that I wrote that code.
> > Effectively that means we'll have to rework the hwmon core to generate attributes
> > anyway and leave it up to the driver core to call the is_visible function.
> > 
> 
> Attached is an outline of what would be needed in the hwmon core.
> Completely untested. I wonder if it may be easier to always
> create all attributes and have them return -ENODATA if not
> supported.
> 
> Guenter


Hello

Do you plan to send your change as patch ?
My patch serie is stuck since now it depend on it.

Or can I send a new iteration of my serie with partial support for notify.

Regards
