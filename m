Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3A527D83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiEPGWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiEPGWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:22:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC62528E
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:22:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so18980979wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xp1rVwPwZGm7aF8iBwYRdIWeIaUhDLQIkjkOwhePjAY=;
        b=iq2HX1uTXyQEWAi6ay0HnkfbkC3CVIsazuwyCJFW3C3Hh046BFw0kDWhDr2SxPQOmY
         gZ5/i9xcNzaF97stiCr81Cv1kkGPNEt8CvGSSPYgsTFA3s6PnuVqtQxLhhEnv4r1bWdQ
         ulQrZnlWAydV2ggzvePsMHij+glCwWkU3muVOF77nNrk7sVezY5HnCctHZXJioEkcai3
         axC6np97mR9mYdAXGmzkvheKzxcVIm3dq+aEB8tyW9vKcESJDhwtMw/n5NyQQYcWvt7S
         A7ns85Mk1OHpyCA8vjrNJ3qe8h39gKBCBM8v88ubQmI+tbsNKYivEd/iY4Mih3SEcszQ
         pk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xp1rVwPwZGm7aF8iBwYRdIWeIaUhDLQIkjkOwhePjAY=;
        b=Kkxv0o7kIzhR0b69g51ESR+nTAxBujLTeNbqYEa6Mr4v3zGKcqv99UFYYC3it+AuUE
         O7TmcOKdjmB1cdY3YYWGy8EOHq6PMrwi5WqZAMiXM7MwPgwzSGg+ycGBUwGeUUaD4Fvs
         dqpRC0dsMZuo3PHvrnjd3ov9LyMiQMrZxY4pmjN/yS/47o5cTQ8C34Q0o6PHjl+y39hN
         3FPrQUTz/QDLsFb+8Z/VdAjitI0m24DPA6sLyAXz2jQR0JerqWcogToop29+oIU6yoYe
         3K0PEIwqEkSFyYD4Xx8PrZPLigtcICwY5+QA8/w3dIh0miXdczCOQkWvK/JOYAre7SFI
         YBNg==
X-Gm-Message-State: AOAM5307eBO0/kjbh6fL/4Cuw4kfw+/kY6r1yPaLnMLYrKhYESE83+sT
        bdiIUabA120a89aNZwEbqGZGyA==
X-Google-Smtp-Source: ABdhPJxQ/XKcwgPOESm2/QEXJrNDYN9zyZ28eUqekJkdf8gu94KblmKplU/gsk700oAAqTuC4iC+UA==
X-Received: by 2002:adf:f543:0:b0:20d:80e:dde with SMTP id j3-20020adff543000000b0020d080e0ddemr3214144wrp.269.1652682119617;
        Sun, 15 May 2022 23:21:59 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id o5-20020adf8b85000000b0020c5253d8f0sm8552839wra.60.2022.05.15.23.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 23:21:59 -0700 (PDT)
Date:   Mon, 16 May 2022 08:21:55 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <YoHtg30ZrhxjVedA@Red>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net>
 <YoFWNAhiDrzpeBU8@Red>
 <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, May 15, 2022 at 05:29:54PM -0700, Guenter Roeck a écrit :
> On 5/15/22 12:36, LABBE Corentin wrote:
> > Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
> >> Corentin,
> >>
> >> On 5/8/22 23:30, Corentin Labbe wrote:
> >>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> >>> So let's convert the driver to use hwmon_device_register_with_info().
> >>>
> >>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >>> ---
> >> [ ... ]
> >>
> >>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>>    		if (res)
> >>>    			break;
> >>>    
> >>> -		remove_attrs(resource);
> >>> +		remove_domain_devices(resource);
> >>>    		setup_attrs(resource);
> >>
> >> Zhang Rui found an interesting problem with this code:
> >> It needs a call to sysfs_update_groups(hwmon_dev->groups)
> >> to update sysfs attribute visibility, probably between
> >> remove_domain_devices() and setup_attrs().
> >>
> >>>    		break;
> >>>    	case METER_NOTIFY_TRIP:
> >>> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> >>> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
> >>
> >> ... which makes realize: The notification device should be the hwmon device.
> >> That would be resource->hwmon_dev, not the acpi device.
> >>
> > 
> > Hello
> > 
> > Since my hardware lacks capabilities testing this, I have emulated it on qemu:
> > https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
> > 
> > I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
> > 
> > For testing config change I have tried lot of way:
> >                  res = read_capabilities(resource);
> > @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >   
> >                  remove_domain_devices(resource);
> >                  setup_attrs(resource);
> > +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
> > +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
> > +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> > +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
> 
> Did you add a debug log here ?

Yes I added debug log to check what is called.

> 
> acpi_power_groups would be the wrong parameter for sysfs_update_groups().
> It would have to be resource->hwmon_dev->groups.
> 

Even with that, no call to is_visible:
@@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 
                remove_domain_devices(resource);
                setup_attrs(resource);
+               res = sysfs_update_groups(&resource->hwmon_dev->kobj, resource->hwmon_dev->groups);
+               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
                break;

I checked drivers/hwmon/hwmon.c is seems that is_visible is only called by gen_attr/gen_attrs which is only called by __hwmon_create_attrs and then by registers functions.
So perhaps it explain why it is never called.
