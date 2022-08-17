Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCA597539
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiHQRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiHQRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:43:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42851A2622
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:42:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 73so12560877pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=Sf6LOmL6mOLSaxI2agjxFaRW9864QrMgWoNUmoMpQ80=;
        b=6Bwai0Xg4RD70xdgvA0lmRpCPb6+X+eGTpw62WAOxGUoAadpJQJDCziu8yAncyH+5J
         +cCbaTJnSW92Bz5g0MoRyYudb0zTwYcDwJp+r38teoaDWAcdeER6HKeqmU2l7puIrutJ
         dTNPI1PTojamQfY70B6o7LDToA+A/6Ymjav/WMZrjvJ5ISkDwiiAaUnazvPqlZrglL3+
         faDKzVG1wFR4wWj04BmjbGDCdfs/38hyW/s1pwplgLsEV8N7YdjHbFY64daNE4zYpOYC
         kYVyoSLIFu6j+/5R4ITiBf6McBe2L3EUkLKkak+WxO41lq8DEq6OxirAMIxhHiryCLyi
         7DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Sf6LOmL6mOLSaxI2agjxFaRW9864QrMgWoNUmoMpQ80=;
        b=T33boofqNUQJap4N+MwE2CTQ6yyYHCw/STxjk6wGagbC8Oo1rzkxfro0ZNDfz81Jbu
         ihdNInGjyNLF/drvA0L0Vihe9K+ZNAblddzK91PDFXRfcnWeci3CqRfJxyVx7YfQHiG/
         KrDxOB121nfjasiqYbXoryMYclfYggfB7jVCrInaEWbqzKZ9YZTnzbZTWjYUh55D0z6e
         wKHSjVyn1syMcK+qSKnh8eJxmnf0Vfbzq0WEnNPPrfm1nzvUwJdlpJkSY9di2h3GIWLF
         p966B1q1jCKoQYvomqMUGqsHpBG3hBV04BIPY2vFs26K/z1zkkDH2dtFOugbE0nccVj/
         PH2w==
X-Gm-Message-State: ACgBeo0YG+Oden/XGvme4vwBQNKHXh3fc4cUwXJj84E0XlmgvuhfC4eB
        z9UmYZfAsBj96E8W552+oKhm9HQPxqx/ivcX
X-Google-Smtp-Source: AA6agR5vGeCGtJdNSBM7GRZhsUeASaov9dZ1wKYxq2MQgkxWz/K8JcTfe3V3a2NZq67ekWW4BwCm3Q==
X-Received: by 2002:a63:2148:0:b0:427:17f6:7c05 with SMTP id s8-20020a632148000000b0042717f67c05mr16755601pgm.200.1660758179332;
        Wed, 17 Aug 2022 10:42:59 -0700 (PDT)
Received: from ghaven-kernel ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id ep3-20020a17090ae64300b001f4ebd47ae7sm1808058pjb.54.2022.08.17.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:42:58 -0700 (PDT)
Date:   Wed, 17 Aug 2022 10:42:57 -0700
From:   Nate Yocom <nate@yocom.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     dmitry.torokhov@gmail.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Input: joystick: xpad: Add X-Box Adaptive
 Controller Layer button
Message-ID: <Yv0ooQXqxenQ852I@ghaven-kernel>
References: <20220813185343.2306-1-nate@yocom.org>
 <20220813185343.2306-3-nate@yocom.org>
 <b32cee349fdfa6ffdc60cd31f662dbd479b01e4d.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b32cee349fdfa6ffdc60cd31f662dbd479b01e4d.camel@hadess.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:37:25PM +0200, Bastien Nocera wrote:
> On Sat, 2022-08-13 at 11:53 -0700, Nate Yocom wrote:
> > Adds a new quirk for controllers that have a Layer button which has 4
> > states, reflected as an ABS_MISC axis with 4 values.
> 
> It's called the "Profile Button" in the official documentation:
> https://support.xbox.com/en-US/help/account-profile/accessibility/get-to-know-adaptive-controller
> so best to call it that.

Agreed - thanks for the pointer, will send a v4 shortly.

> I wonder we have any other examples of profile handling in input
> drivers. The xpadneo driver implements the profiles in the kernel
> driver directly.
> 
> Benjamin?
> 
> Tested-by: Bastien Nocera <hadess@hadess.net>
> 
> > 
> > Signed-off-by: Nate Yocom <nate@yocom.org>
> > ---
> >  drivers/input/joystick/xpad.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/joystick/xpad.c
> > b/drivers/input/joystick/xpad.c
> > index c8b38bb73d34..83a4f4d07af5 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -80,6 +80,7 @@
> >  #define MAP_TRIGGERS_TO_BUTTONS                (1 << 1)
> >  #define MAP_STICKS_TO_NULL             (1 << 2)
> >  #define MAP_SELECT_BUTTON              (1 << 3)
> > +#define MAP_LAYER_BUTTON               (1 << 4)
> >  #define DANCEPAD_MAP_CONFIG    (MAP_DPAD_TO_BUTTONS
> > |                  \
> >                                 MAP_TRIGGERS_TO_BUTTONS |
> > MAP_STICKS_TO_NULL)
> >  
> > @@ -131,7 +132,7 @@ static const struct xpad_device {
> >         { 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0,
> > XTYPE_XBOXONE },
> >         { 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0,
> > XTYPE_XBOXONE },
> >         { 0x045e, 0x0719, "Xbox 360 Wireless Receiver",
> > MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
> > -       { 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", 0,
> > XTYPE_XBOXONE },
> > +       { 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller",
> > MAP_LAYER_BUTTON, XTYPE_XBOXONE },
> >         { 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller",
> > MAP_SELECT_BUTTON, XTYPE_XBOXONE },
> >         { 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360
> > },
> >         { 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360
> > },
> > @@ -927,6 +928,10 @@ static void xpadone_process_packet(struct
> > usb_xpad *xpad, u16 cmd, unsigned char
> >                                  (__u16) le16_to_cpup((__le16 *)(data
> > + 8)));
> >         }
> >  
> > +       /* Layer button has a value of 0-4, so it is reported as an
> > axis */
> > +       if (xpad->mapping & MAP_LAYER_BUTTON)
> > +               input_report_abs(dev, ABS_MISC, data[34]);
> > +
> >         input_sync(dev);
> >  }
> >  
> > @@ -1623,6 +1628,9 @@ static void xpad_set_up_abs(struct input_dev
> > *input_dev, signed short abs)
> >         case ABS_HAT0Y: /* the d-pad (only if dpad is mapped to axes
> > */
> >                 input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
> >                 break;
> > +       case ABS_MISC: /* 4 value layer button (such as on XAC) */
> > +               input_set_abs_params(input_dev, abs, 0, 4, 0, 0);
> > +               break;
> >         default:
> >                 input_set_abs_params(input_dev, abs, 0, 0, 0, 0);
> >                 break;
> > @@ -1715,6 +1723,10 @@ static int xpad_init_input(struct usb_xpad
> > *xpad)
> >                         xpad_set_up_abs(input_dev,
> > xpad_abs_triggers[i]);
> >         }
> >  
> > +       /* setup layer button as an axis with 4 possible values */
> > +       if (xpad->mapping & MAP_LAYER_BUTTON)
> > +               xpad_set_up_abs(input_dev, ABS_MISC);
> > +
> >         error = xpad_init_ff(xpad);
> >         if (error)
> >                 goto err_free_input;
> 
