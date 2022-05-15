Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735752798A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiEOTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiEOTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 15:36:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3CDF71
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 12:36:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e29so8305900wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MS34JneIXe2cr4Zw4VSoJkkUB+splLBi5YgL0r5NFUE=;
        b=1fVCx2XCO96HWGHmqMT+95KanFG/MaZFOk5g1B2M/olyqrfQhG9tu9sldvEU5xvUM8
         ahDSybUlSbc0r/i0kTH1ewcB3/Zu/n5qUK5hxshIvF/5qXlQIeMCMV0zcrZ3iE+zG8tK
         xOxouRhFxtCxk+iIH24gFXr19GbPG+DRWVaOO2Iqo4cwScoMd1FWaUc+7GNJZnbUWbk8
         uh10A2jKl0jv7VYmXSYviPQq7lHSHmi27JwOxxkQ1jKIy5uRd8Gs5NAU4PhUMFfbEkUl
         op6hZRubjkhbFUHP2RYhgzLi3FKn2rjmceNdJxv/g/x3yK61MbixjAX6kbQPdVmm3Lgf
         1B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MS34JneIXe2cr4Zw4VSoJkkUB+splLBi5YgL0r5NFUE=;
        b=d49WMvD8I8+lVi5blp8p2unAKf7e5j63uCNl6w4yHWWUJxEtqM+OfOJOcB4qpAzUUU
         FkONfj6DvO58LSfztgc/kePjhEtliDCoCPps8iPivgJC9UeHRbBDswsATpwz01bkHGjK
         9EJ+hfipZZ8r/BAG7iDNA5qCFFF87JX+On/7T7hcTlGoJpw6vmlIm2jTTS7WjdC5JIhz
         pAfT5XVG5c7ufk/CKzIvt4dxLWWbBHYUL04lW7Jvm074QijmevynuQZ+Psc+TrM6ee/z
         ykXrfSictNOxeQ8OuDgat4i3VHT3clalnKgH4FeIly2MW4UWuyqgvfsW86dnFw4xleCL
         C9PQ==
X-Gm-Message-State: AOAM533zrfPG718ahkU5egSUo2Sp9j7Sk1370Jqz7Fta8zCqE+tU2MDC
        WRglyAhYdBdJl1zh21jsu+Wewmb34IpHQg==
X-Google-Smtp-Source: ABdhPJy5g2iblnEBSZTxvgjc3b5oSMRyyCmenrG289QeOSNqfVatufCv1wQZcIoYniIBy/y92lK2zA==
X-Received: by 2002:a05:6000:381:b0:20c:6911:f85b with SMTP id u1-20020a056000038100b0020c6911f85bmr11479995wrf.406.1652643385471;
        Sun, 15 May 2022 12:36:25 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g23-20020adfa497000000b0020d0a070c80sm570044wrb.35.2022.05.15.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 12:36:24 -0700 (PDT)
Date:   Sun, 15 May 2022 21:36:20 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <YoFWNAhiDrzpeBU8@Red>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
> Corentin,
> 
> On 5/8/22 23:30, Corentin Labbe wrote:
> > Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> > So let's convert the driver to use hwmon_device_register_with_info().
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> [ ... ]
> 
> > @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >   		if (res)
> >   			break;
> >   
> > -		remove_attrs(resource);
> > +		remove_domain_devices(resource);
> >   		setup_attrs(resource);
> 
> Zhang Rui found an interesting problem with this code:
> It needs a call to sysfs_update_groups(hwmon_dev->groups)
> to update sysfs attribute visibility, probably between
> remove_domain_devices() and setup_attrs().
> 
> >   		break;
> >   	case METER_NOTIFY_TRIP:
> > -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> > +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
> 
> ... which makes realize: The notification device should be the hwmon device.
> That would be resource->hwmon_dev, not the acpi device.
> 

Hello

Since my hardware lacks capabilities testing this, I have emulated it on qemu:
https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b

I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).

For testing config change I have tried lot of way:
                res = read_capabilities(resource);
@@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 
                remove_domain_devices(resource);
                setup_attrs(resource);
+               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
+               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
                break;
        case METER_NOTIFY_TRIP:
-               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
                break;
        case METER_NOTIFY_CAP:
-               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_cap, 0);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
                break;
        case METER_NOTIFY_INTERVAL:
-               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average_interval, 0);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average_interval, 0);
                break;
        case METER_NOTIFY_CAPPING:
-               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_alarm, 0);
+               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_alarm, 0);
                dev_info(&device->dev, "Capping in progress.\n");
                break;
        default:

But nothing force visibility to be rerun.

Any idea on how to force visibility to be re-run ?
