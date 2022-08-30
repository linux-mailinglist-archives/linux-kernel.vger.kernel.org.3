Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A85A63C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiH3Mph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiH3Mpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B9072EEB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661863525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6lLY78Wc8lf6E8TWvHKF7hjnpeKQ3HWLEElYEyNDXg=;
        b=ag/j9yPD/8OYv/0rqCQmQsP77p6DmWHCvGf059iTEivNWQRYeV9kIGP8HLxgPSTtX3V++H
        FulVkDwt2QaZJ0g5Y9zH+oJBh4Rdlz8gzqXzyKMDjdZINMZkKjZKyf+WskSVvBPBFfV3mt
        1c2jHB+XCxO1+nlGq3Jj+2/ERkdPBZw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-FOsT5RnLOtC2e10W4Fu2zQ-1; Tue, 30 Aug 2022 08:45:23 -0400
X-MC-Unique: FOsT5RnLOtC2e10W4Fu2zQ-1
Received: by mail-pj1-f69.google.com with SMTP id a17-20020a17090abe1100b001fda49516e2so4734445pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=P6lLY78Wc8lf6E8TWvHKF7hjnpeKQ3HWLEElYEyNDXg=;
        b=iWEFkpf9Hy5g1C7u5b0R4D2kJxdCmx1M3n2l2C2h5GyukEGhYmCPCKpR0WCtyPXSS3
         Adcf0XCfhhL9v2vYF8Rv4ffnoFl6hbxBOxbbafZDic/wvV7tPnj9bFSZ/fFITV/8naQV
         Q8mG5Bb4zxfiV6QeZ3Ox9eqYj2/WYn/1LPvBZUSi5V+nnrV+zdVHLE3bBPdLxa/a9/QF
         aX9k33/9n5FpmMTUUmdSB+vA45hmqia0QssjdU8zP/eHtF6Fr6C+hvTMjAB4Uhx2Xgk0
         ZN6HqlsdIa4cZUDskHQyFNsveAoQ+22KH7Nmzdp79Wh0M6TnCBgI7HTcEeQAmU4eeeUf
         +aNA==
X-Gm-Message-State: ACgBeo3J139BemDC0vmIC5gmxGVeGNGU4Ad17bwjYF8gDjifN4fQLx9V
        GbqwPGjVNB7HOxuKi/HSobTJ4A1qVS+DpXq6/b/N+gMmpMMTk1ysmJwW2T4fmYwPpUds7cXztGh
        AZkEX2q+j1wcCoMIwcmfCXM5rgMJbXONor7lUK94b
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id a10-20020a170902b58a00b0016ef91a486bmr21633483pls.119.1661863522407;
        Tue, 30 Aug 2022 05:45:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5AA7wC0SVH7YTQhdNe+xb9pQTfXWCtn3s/hf21gnrtMo82myalIshC5+FI+7b4PKj9iSOv+w6lLFKReazeMNs=
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id
 a10-20020a170902b58a00b0016ef91a486bmr21633469pls.119.1661863522121; Tue, 30
 Aug 2022 05:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com> <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
 <YwcbVJswrL1Doi4s@gmail.com>
In-Reply-To: <YwcbVJswrL1Doi4s@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 30 Aug 2022 14:45:11 +0200
Message-ID: <CAO-hwJJ86oAuaFD+uX7Rwv7cASO=4mchRJ1UBTxz9gYs6M1rUg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 8:44 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Hi Benjamin,
>
> Thank you!
> I have a few questions regarding the report descriptor, please see
> below.
>
> On Tue, Aug 23, 2022 at 06:43:47PM +0200, Benjamin Tissoires wrote:
[...]
>
> Got it.
> I've parsed [4] the report descriptor for VRC2, and I guess it does not looks
> that good:
>
> 0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
> 0x09, 0x00,        // Usage (Undefined)
> 0xA1, 0x01,        // Collection (Application)
> 0x15, 0x00,        //   Logical Minimum (0)
> 0x25, 0x01,        //   Logical Maximum (1)
> 0x75, 0x01,        //   Report Size (1)
> 0x05, 0x09,        //   Usage Page (Button)
> 0x19, 0x01,        //   Usage Minimum (0x01)
> 0x29, 0x3F,        //   Usage Maximum (0x3F)
> 0x95, 0x40,        //   Report Count (64)
> 0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
> 0xC0,              // End Collection
>
> The Usage should rather be Joystick than undefined, the other
> fields does also looks wrong to me.

yep, as you saw already :)

>
> The data for each axis (WHEEL and GAS) is 11 bit long (Logical maximum
> 2047 ?), how does the report descriptor map to the actual data in terms
> of offset, order and length?

You probably already got it, but it all depends on how much data is
used on the wire:
- if you have 2 bytes used per each value, then the report size will
be 16 and you set the logical max to 2047
- if the values are packed, then the report size is 11, and then you
probably have to add padding *after* the 22 bits.

>
> >
> > >
> > >
> > > >
> > > > > +
> > > > > +static int rcsim_raw_event(struct hid_device *hdev,
> > > > > +                              struct hid_report *report,
> > > > > +                              u8 *raw_data, int size)
> > > > > +{
> > > > > +       struct rcsim_priv *priv = hid_get_drvdata(hdev);
> > > > > +       u16 value;
> > > > > +
> > > > > +       switch (priv->controller) {
> > > > > +       case PHOENIXRC:
> > > > > +               if (size != PHOENIXRC_DSIZE)
> > > > > +                       break;
> > > > > +
> > > > > +               /* X, RX, Y and RY, RUDDER and THROTTLE are sent every time */
> > > > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[0]);
> > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[4]);
> > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
> > > > > +
> > > > > +               /* Z and RZ are sent every other time */
> > > > > +               if (priv->alt)
> > > > > +                       input_report_abs(priv->input, ABS_Z, raw_data[7]);
> > > > > +               else
> > > > > +                       input_report_abs(priv->input, ABS_RZ, raw_data[7]);
> > > > > +
> > > > > +               priv->alt ^= 1;
> > > > > +               break;
> > > > > +       case VRC2:
> > > > > +               if (size != VRC2_DSIZE)
> > > > > +                       break;
> > > > > +               value = (raw_data[1] << 8 | raw_data[0]) & GENMASK(10, 0);
> > > > > +               input_report_abs(priv->input, ABS_GAS, value);
> > > > > +               value = (raw_data[3] << 8 | raw_data[2]) & GENMASK(10, 0);
> > > > > +               input_report_abs(priv->input, ABS_WHEEL, value);
> > > > > +               break;
> > > > > +       case REALFLIGHT:
> > > > > +               if (size != REALFLIGHT_DSIZE)
> > > > > +                       break;
> > > > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[1]);
> > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[5]);
> > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > > > +               input_report_abs(priv->input, ABS_MISC, raw_data[4]);
> > > > > +               input_report_key(priv->input, BTN_A,
> > > > > +                               raw_data[7] & REALFLIGHT_BTN_A);
> > > > > +               input_report_key(priv->input, BTN_B,
> > > > > +                               raw_data[7] & REALFLIGHT_BTN_B);
> > > > > +               break;
> > > > > +       case XTRG2FMS:
> > > > > +               if (size != XTRG2FMS_DSIZE)
> > > > > +                       break;
> > > > > +
> > > > > +               /* X, RX, Y and RY are sent every time */
> > > > > +               value = FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[1];
> > > > > +               input_report_abs(priv->input, ABS_X, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[2];
> > > > > +               input_report_abs(priv->input, ABS_Y, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[0];
> > > > > +               input_report_abs(priv->input, ABS_RX, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[4];
> > > > > +               input_report_abs(priv->input, ABS_RY, value);
> > > > > +
> > > > > +               /* Z, RZ, RUDDER and THROTTLE are sent every other time */
> > > > > +               value = FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
> > > > > +               value = (value << 8) | raw_data[6];
> > > > > +               if (priv->alt)
> > > > > +                       input_report_abs(priv->input, ABS_Z, value);
> > > > > +               else
> > > > > +                       input_report_abs(priv->input, ABS_RUDDER, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
> > > > > +               value = (value << 8) | raw_data[5];
> > > > > +               if (priv->alt)
> > > > > +                       input_report_abs(priv->input, ABS_RZ, value);
> > > > > +               else
> > > > > +                       input_report_abs(priv->input, ABS_THROTTLE, value);
> > > > > +
> > > > > +               priv->alt ^= 1;
> > > > > +               break;
> > > > > +       case ORANGERX:
> > > > > +               if (size != ORANGERX_DSIZE)
> > > > > +                       break;
> > > > > +               input_report_abs(priv->input, ABS_X, raw_data[0]);
> > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[2]);
> > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[3]);
> > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[1]);
> > > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
> > > > > +               break;
> > > > > +       };
> > > > > +
> > > > > +       input_sync(priv->input);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int rcsim_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > > > > +{
> > > > > +       struct device *dev = &hdev->dev;
> > > > > +       struct rcsim_priv *priv;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
> > > > > +               return -ENODEV;
> > > >
> > > > You are not accessing anything in the USB stack, so there is no need
> > > > to prevent regression tests that could inject uhid devices to your
> > > > drivers.
> > >
> > > Ok, thanks.
> > >
> > > >
> > > > Cheers,
> > > > Benjamin
> > > >
> > >
> > > Best regards,
> > > Marcus Folkesson
> > >
> > > [1] https://www.usb.org/hid
> > >
> >
> > If you need help in writing report descriptors, I can give you some,
> > but the easiest might be for you to start from the report descriptor
> > in hid-sony.c. I used to have a tool to dynamically write a report
> > descriptor, but I'm not sure it still works...
>
> I think at least some advice would be great :-)
>
> The VRC2 would be the most simple of those, it only has 2 axis with
> resolution of 11-bit.
> If you have time, would you please give some advice what a report descriptor would look
> like and I could probably come up with something for the others.
>
> >
> > FYI, I just re-read rcsim_raw_event() and there is stuff that would
> > require more than just a report descriptor fixup (the fact that some
> > data is sent every other report is not good and will need some manual
> > handling though).
>
>
> Is the fact that more than one button share the same
> byte hard to describe in the report?

No, this is actually easy to describe. You say that there is one usage
of "something" which has a report size of 1 bit, and then you have
another usage of "something else" with the same report size.

But usually you have to add padding after to make up to 8 bits (so 6
bits in that case).

I was referring to the case  where you are parsing the same bit on the
wire, and give a different usage based if you have received an odd or
an even number of reports. In that case, we probably need to use move
this bit to a const field in the original report descriptor and say
that the data is now not const:

- initial report (completely random example):
  X (2 bytes) | Y (2 bytes) | button this_or_that (1 bit, depending of
odd or even received reports) | 7 bits of padding
- we can declare it as:
  X (2 bytes) | Y (2 bytes) | button this (1 bit) | button that (1
bit) | 6 bits of padding

and have raw_event do the translation for the button "this_or_that"
that would populate the correct bit in the translated report.

Cheers,
Benjamin

>
>   value = FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
>   value = (value << 8) | raw_data[6];
>
> ...
>   value = FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
>   value = (value << 8) | raw_data[5];
>
>
> >
> > Cheers,
> > Benjamin
> >
>
> Best regards
> Marcus Folkesson
>
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-uclogic-rdesc.c
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-input.c#n817
> [4] https://eleccelerator.com/usbdescreqparser/

