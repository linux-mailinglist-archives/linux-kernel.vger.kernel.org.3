Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E25809F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiGZDYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGZDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:24:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4C2A42C;
        Mon, 25 Jul 2022 20:24:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o12so12114158pfp.5;
        Mon, 25 Jul 2022 20:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wDnX02yXv6hz6/OVpmH/qcFt+Ere5J/wW7Qc2THVN8Y=;
        b=AVVQyZ6M/MrGKMRL/YA61Xnx0+6wqDZLDJ80lS3mqhLXNoRXuxAfOrTRfbQ3e4KGzm
         Gr2xPFdRMDcWL3Esc3DNT2+00VnRLRpOs3xVTFo56oBSd9+vbMCEEz8Cp36IcC3Bo146
         4ESywNHKCb2HdQgKcWGB+QOqKQ9ypmrJtENX/7YnyMM1Gj7gb42kbv6d8yl1314niZge
         Y98nL4ae8UrJPsbYVlCoDV7zLsQoHX8tUYYotXKiRZMrg4zcibheenbDFDZeTOAzMkZG
         swGO0GEt2WUcxbLaPQAlzeWegFt4xso/9PB6XsIvcUIfd92ZZQCI2uaJzHR8a4YbcvH6
         UrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wDnX02yXv6hz6/OVpmH/qcFt+Ere5J/wW7Qc2THVN8Y=;
        b=4PfHC8+RSG2TtsILIY1+qbwA/MqLa5r/Glt1AIyjpfQtqgXNuksfXAABcJMdQfobtu
         oFi+sOSCtqgR+/U7v7s1DeY5KYjmzXiK/T60aF28LqbbAT/n6Dqa5k27aeQqYqsXg2JF
         RUoD6WmcaU3XSVvkI1CwLjlmbp/rvIpxb1dG6oRbGHUV1dX3Esrj6/WZD0VoHujAvJvf
         yVIhpRmw7aMMvFfsSXzu+aCdLry81irqCkd6k1zn5+P1MBEw7s16HUkW9znuerqxDO23
         xI+8GxztF/fpnScOC0+qvEZfeh/vbwcIsSfHNahzcYSWFw5RRzeP2i1YqXxTZ33ut5/1
         GUmQ==
X-Gm-Message-State: AJIora/t0fAgG1mansLNcahuigxXU1CNapeoBHBfTl1eyBCEQPnlRIgt
        TRr5ZIY13ls3pLDSpVV8My/wbxgY6yyjzg==
X-Google-Smtp-Source: AGRyM1tlJkCuG4LYBkmfo4Pm8+w5y7bJEl7NGmfdD0I8TJghVFnQrmKq89XwiOMveKH04lxU2Go8Sg==
X-Received: by 2002:a63:f306:0:b0:41a:6258:dcd2 with SMTP id l6-20020a63f306000000b0041a6258dcd2mr12972793pgh.28.1658805868873;
        Mon, 25 Jul 2022 20:24:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b0016357fd0fd1sm2310120plx.69.2022.07.25.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 20:24:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Jul 2022 20:24:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexey Klimov <klimov.linux@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Message-ID: <20220726032425.GA1331080@roeck-us.net>
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <573466e4-e836-d053-d1b9-dc04c6a046e5@roeck-us.net>
 <CALW4P+JjO5zxEP4aLGzzcvK2QO0Ea_uYACjuOV6GZEMfh3Q5RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALW4P+JjO5zxEP4aLGzzcvK2QO0Ea_uYACjuOV6GZEMfh3Q5RA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:31:07AM +0100, Alexey Klimov wrote:
> On Mon, Jul 25, 2022 at 3:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 7/24/22 20:06, Alexey Klimov wrote:
> 
> [...]
> 
> > > + * one buffer is used for communication, however transmitted message is only
> > > + * 32 bytes long
> > > + */
> > > +#define BUFFER_TRANSFER_LENGTH       32
> > > +#define BUFFER_LENGTH                64
> > > +#define USB_TIMEOUT          350
> > > +
> > Comment about the unit (ms) might be useful.
> 
> Yes. I'll add it.
> 
> > > +#define STREAMLABS_CMD_START 0xaacc
> > > +#define STREAMLABS_CMD_STOP  0xbbff
> > > +
> > > +/* timeout values are taken from windows program */
> > > +#define STREAMLABS_WDT_MIN_TIMEOUT   1
> > > +#define STREAMLABS_WDT_MAX_TIMEOUT   46
> > > +
> > > +struct streamlabs_wdt {
> > > +     struct watchdog_device wdt_dev;
> > > +     struct usb_interface *intf;
> > > +     /* Serialises usb communication with a device */
> > > +     struct mutex lock;
> > > +     __le16 *buffer;
> > > +};
> > > +
> > > +static bool nowayout = WATCHDOG_NOWAYOUT;
> > > +module_param(nowayout, bool, 0);
> > > +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> > > +                     __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > > +
> > > +/* USB call wrappers to send and receive messages to/from the device. */
> > > +static int usb_streamlabs_send_msg(struct usb_device *usbdev, __le16 *buf)
> > > +{
> > > +     int retval;
> > > +     int size;
> > > +
> > > +     retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
> > > +                                buf, BUFFER_TRANSFER_LENGTH,
> > > +                                &size, USB_TIMEOUT);
> > > +
> > > +     if (size != BUFFER_TRANSFER_LENGTH)
> > > +             return -EIO;
> > > +
> >
> > If usb_interrupt_msg() returns an error, it will likely not set size,
> > which may result in a random -EIO. I think this should be something like
> >
> >         if (retval)
> >                 return retval;
> >         if (size != BUFFER_TRANSFER_LENGTH)
> >                 return -EIO;
> >
> >         return 0;
> 
> Good point. I'll change it.
> 
> 
> > > +     return retval;
> > > +}
> > > +
> > > +static int usb_streamlabs_get_msg(struct usb_device *usbdev, __le16 *buf)
> > > +{
> > > +     int retval;
> > > +     int size;
> > > +
> > > +     retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
> > > +                                buf, BUFFER_LENGTH,
> > > +                                &size, USB_TIMEOUT);
> > > +
> > > +     if (size != BUFFER_LENGTH)
> > > +             return -EIO;
> > > +
> > Same here.
> >
> > > +     return retval;
> > > +}
> > > +
> > > +/*
> > > + * This function is used to check if watchdog timeout in the received buffer
> > > + * matches the timeout passed from watchdog subsystem.
> > > + */
> > > +static int usb_streamlabs_wdt_check_timeout(__le16 *buf, unsigned long timeout)
> > > +{
> > > +     if (buf[3] != cpu_to_le16(timeout))
> > > +             return -EPROTO;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int usb_streamlabs_wdt_check_response(u8 *buf)
> > > +{
> > > +     /*
> > > +      * If watchdog device understood the command it will acknowledge
> > > +      * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
> > > +      * when response treated as 8bit message.
> > > +      */
> > > +     if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
> > > +             return -EPROTO;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +/*
> > > + * This function is used to check if watchdog command in the received buffer
> > > + * matches the command passed to the device.
> > > + */
> > > +static int usb_streamlabs_wdt_check_command(__le16 *buf, u16 cmd)
> > > +{
> > > +     if (buf[0] != cpu_to_le16(cmd))
> > > +             return -EPROTO;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int usb_streamlabs_wdt_validate_response(__le16 *buf, u16 cmd,
> > > +                                             unsigned long timeout_msec)
> > > +{
> > > +     int retval;
> > > +
> > > +     retval = usb_streamlabs_wdt_check_response((u8 *)buf);
> > > +     if (retval)
> > > +             return retval;
> > > +
> > > +     retval = usb_streamlabs_wdt_check_command(buf, cmd);
> > > +     if (retval)
> > > +             return retval;
> > > +
> > > +     retval = usb_streamlabs_wdt_check_timeout(buf, timeout_msec);
> > > +     return retval;
> >
> >         assignment to retval is unnecessary.
> 
> Ok.
> 
> > > +}
> > > +
> > > +static void usb_streamlabs_wdt_prepare_buf(__le16 *buf, u16 cmd,
> > > +                                        unsigned long timeout_msec)
> > > +{
> > > +     /*
> > > +      * remaining elements expected to be zero everytime during
> > > +      * communication
> > > +      */
> > > +     buf[0] = cpu_to_le16(cmd);
> > > +     buf[1] = cpu_to_le16(0x8000);
> > > +     buf[3] = cpu_to_le16(timeout_msec);
> >
> > Not setting buf[2] and buf[4] contradicts the comment above. Maybe
> > those offsets are not _expected_ to be set by the device, but that
> > is not guaranteed. It may be safer to just use memset() at the
> > beginning of the function to clear the buffer.
> 
> Sure. I guess it makes sense to zero the buffer before reading the
> message from the device too?
> Before usb_streamlabs_get_msg(usbdev, wdt->buffer).
> 
That should not be necessary unless your code accesses data beyond the
amount of data received (which it should not do in the first place).

> > > +     buf[5] = 0x0;
> > > +     buf[6] = 0x0;
> > > +}
> > > +
> > > +static int __usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
> > > +{
> > > +     struct usb_device *usbdev;
> > > +     unsigned long timeout_msec;
> > > +     /* how many times to re-try getting the state of the device */
> > > +     unsigned int retry_counter = 10;
> > > +     int retval;
> > > +
> > > +     if (unlikely(!wdt->intf))
> > > +             return -ENODEV;
> > > +
> > > +     usbdev = interface_to_usbdev(wdt->intf);
> > > +     timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
> > > +
> > > +     usb_streamlabs_wdt_prepare_buf(wdt->buffer, cmd, timeout_msec);
> > > +
> > > +     /* send command to watchdog */
> > > +     retval = usb_streamlabs_send_msg(usbdev, wdt->buffer);
> > > +     if (retval)
> > > +             return retval;
> > > +
> > > +     /*
> > > +      * Transition from one state to another in this device
> > > +      * doesn't happen immediately, especially stopping the device
> > > +      * is not observed on the first reading of the response.
> > > +      * Plus to avoid potentially stale response message in the device
> > > +      * we keep reading the state of the device until we see:
> > > +      * -- that device recognised the sent command;
> > > +      * -- the received state (started or stopped) matches the state
> > > +      * that was requested;
> > > +      * -- the timeout passed matches the timeout value read from
> > > +      * the device.
> > > +      * Keep retrying 10 times and if watchdog device doesn't respond
> > > +      * correctly as expected we bail out and return an error.
> > > +      */
> > > +     do {
> > > +             retval = usb_streamlabs_get_msg(usbdev, wdt->buffer);
> > > +             if (retval)
> > > +                     break;
> > > +
> > > +             retval = usb_streamlabs_wdt_validate_response(wdt->buffer, cmd,
> > > +                                                           timeout_msec);
> > > +     } while (retval && retry_counter--);
> > > +
> > > +     return retry_counter ? retval : -EIO;
> > > +}
> > > +
> > > +static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *streamlabs_wdt, u16 cmd)
> > > +{
> > > +     int retval;
> > > +
> > > +     mutex_lock(&streamlabs_wdt->lock);
> > > +     retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt, cmd);
> > > +     mutex_unlock(&streamlabs_wdt->lock);
> > > +
> > > +     return retval;
> > > +}
> > > +
> > > +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
> > > +{
> > > +     struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> > > +
> > > +     return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
> > > +}
> > > +
> > > +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
> > > +{
> > > +     struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> > > +
> > > +     return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
> > > +}
> > > +
> > > +static const struct watchdog_info streamlabs_wdt_ident = {
> > > +     .options        = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> > > +     .identity       = DRIVER_NAME,
> > > +};
> > > +
> > > +static const struct watchdog_ops usb_streamlabs_wdt_ops = {
> > > +     .owner  = THIS_MODULE,
> > > +     .start  = usb_streamlabs_wdt_start,
> > > +     .stop   = usb_streamlabs_wdt_stop,
> > > +};
> > > +
> > > +static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
> > > +                                 const struct usb_device_id *id)
> > > +{
> > > +     struct usb_device *usbdev = interface_to_usbdev(intf);
> > > +     struct streamlabs_wdt *streamlabs_wdt;
> > > +     int retval;
> > > +
> > > +     /*
> > > +      * USB IDs of this device appear to be weird/unregistered. Hence, do
> > > +      * an additional check on product and manufacturer.
> > > +      * If there is similar device in the field with same values then
> > > +      * there is stop command in probe() below that checks if the device
> > > +      * behaves as a watchdog.
> > > +      */
> > > +     if (!usbdev->product || !usbdev->manufacturer ||
> > > +         strncmp(usbdev->product, "USBkit", 6) ||
> > > +         strncmp(usbdev->manufacturer, "STREAM LABS", 11))
> > > +             return -ENODEV;
> > > +
> > > +     streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
> > > +                                   GFP_KERNEL);
> > > +     if (!streamlabs_wdt)
> > > +             return -ENOMEM;
> > > +
> > > +     streamlabs_wdt->buffer = devm_kzalloc(&intf->dev, BUFFER_LENGTH,
> > > +                                           GFP_KERNEL);
> > > +     if (!streamlabs_wdt->buffer)
> > > +             return -ENOMEM;
> > > +
> >
> > Nit: buffer could be made part of struct streamlabs_wdt and be tagged with
> > ____cacheline_aligned to avoid the double allocation.
> 
> It was discussed in the past.
> https://lore.kernel.org/linux-watchdog/5714E7D3.4030809@roeck-us.net/
> https://lore.kernel.org/linux-watchdog/1460988518.25119.28.camel@suse.com/
> 
> The conclusion there was that with separate allocation it is
> guaranteed to not share a cacheline with mutex lock.
> Do we know for sure that it is safe with ____cacheline_aligned attribute?
> 
> Oliver, thoughts?
> 
> I see that a lot of drivers use cacheline alignment for buffers, so I
> guess that should be okay nowadays and I can change it back to initial
> version with cacheline alignment.
> 

If you don't trust __cacheline_aligned, please add a respective comment
explaining that to avoid this from coming up again. 

> > > +     mutex_init(&streamlabs_wdt->lock);
> > > +
> > > +     streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
> > > +     streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
> > > +     streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> > > +     streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> > > +     streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
> > > +     streamlabs_wdt->wdt_dev.parent = &intf->dev;
> > > +
> > > +     streamlabs_wdt->intf = intf;
> > > +     usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
> > > +     watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
> > > +     watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
> > > +
> > > +     retval = usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> > > +     if (retval)
> > > +             return -ENODEV;
> > > +
> >
> > A comment explaining why the watchdog is explicitly stopped when running
> > might be useful.
> 
> What do you mean by saying "when running"?
> Everytime during my testing the initial state is "stopped" on
> boot/power on/after reset, so not sure what you mean by saying "when
> running".

Should I have used the term "active" ? "started" ?

> There is a comment above that explains the stop command but I will
> add/change comments that explain things better.
> The point of executing "stop" command here is to check that device
> being probed behaves like we expect it to. This is a bit paranoid
> check since I am a not 100% sure that all devices with such USB ids
> are watchdogs -- that's why additional checks for usbdev->product and
> usbdev->manufacturer and this stop command that doesn't change the
> initial state. In theory, I can remove this stop command at all.
> 

Normally one does not want a watchdog to stop if it is running (started ?
active ? pick your term) when the device is instantiated to avoid gaps
in watchdog coverage. The watchdog core provides a flag, WDOG_HW_RUNNING,
for this purpose (sorry, there is the 'running' term again). It is used
by many drivers, and ensures that the time from loading the Linux kernel
to opening the watchdog device is protected by the watchdog.

Calling the stop function during probe suggests that you at least
considered the possibility that the watchdog may be running/started/active.
Per your explanation, you still want it to stop explicitly if/when that
happens.  All I am asking you is to add a comment explaining why this is
not needed/wanted/relevant/supported for this driver. One explanation
might, for example, be that the state can not be detected reliably.

Thanks,
Guenter

> Thank you for the review.
> 
> [...]
> 
> Best regards,
> Alexey
