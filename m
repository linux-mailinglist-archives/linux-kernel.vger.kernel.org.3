Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C854DCAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiCQQOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiCQQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:14:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3D19C19;
        Thu, 17 Mar 2022 09:13:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so6659882wrh.10;
        Thu, 17 Mar 2022 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jF/+b29n2k6QwgY1N7ytCrLXHO8Y7Zm3vkBb+Xdt3qs=;
        b=Uj7KjY3fF36OqFiimwFYxV7pRXYGE7AoLg7hDmDZIemHwqwiVsCR+j/WWUNbrL2svN
         VccqsNnUcjCUctBn5gJI90IFOf0axEhmCIRsp8lwM4NkqzRg+lVVir9qDtHi/yuaodTo
         fj2rECP9DlQ/7zNZjDwipzNOUfJ3fZqc8X1f7GmHZdNM3jpA1KC2dMtcqLj2wWs5FBnD
         rBjDFroMyz9qtRxBdM6v4DB35E8pdkXr9abM4RSmas/nx+Pv8b/ERsaPJ7mUdnWF5wc4
         sQVFPx09LZIiOruCkiMwfcUgZVtmHpFzaWOCqWByzXaG91bAOnlOmDi/OsjJsVGWztfi
         aorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jF/+b29n2k6QwgY1N7ytCrLXHO8Y7Zm3vkBb+Xdt3qs=;
        b=CYj9stgUX6Fu7Zhci9VlNOWVkHhHVFXV8ynxe+u1d8bvEzerSbiyazo2pVJ67pm3Yo
         7Gn9CsdnMK7yFZxjbuNl5yOCiAGHjHgOHTkTmAv+05qMOROUAnmsoxTD0CDV5KaIK6HL
         YEuRFukgadP9KvkAsJMAmGvvbnra4cGArY/h7z0GlXIQu1zJ/vBr5PIokwmTcu36r4pz
         DY2nuK6Z3BB7oOQU+RmF/WLIZMO8EfLVRc5nedv2Ga6uhRA6QNzvcUBglrw+uCsrDACp
         4Q5pyioOYxJhG7zvZujW2LFbqXvVWIYZC2yg3MPegzetxtyeDtl1ys6vwhwbwmb5re8u
         mQWg==
X-Gm-Message-State: AOAM532ArcmSVcmciv5nfbAc09bZiq7T1eDTTL92yAA+kmSgs2sXkoE2
        SVb0dTFlRLnNQEPG+5ElaQLzqvXTjwsyevRy04jk7P5ylDitog==
X-Google-Smtp-Source: ABdhPJzoKDyBbVV/h3RA8+GrQf9PozlA+frXzSHUXmbwV0v7vgqz+5I9Hmz1OQYOvh9UQdtU2mwZGkNja2h4nbhPbNk=
X-Received: by 2002:a5d:47a7:0:b0:203:d1b4:8f6 with SMTP id
 7-20020a5d47a7000000b00203d1b408f6mr4862024wrb.36.1647533604016; Thu, 17 Mar
 2022 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220311181014.3448936-1-bjwyman@gmail.com> <fa8b2d9f-e5c9-73f4-3916-84e370748687@roeck-us.net>
 <CAK_vbW2S07+S8+PrQnBLjvXYnLBXU06FHBvfM2zaT6RYx9HO+g@mail.gmail.com> <582086fe-1cc3-d161-a866-f4726d04a254@roeck-us.net>
In-Reply-To: <582086fe-1cc3-d161-a866-f4726d04a254@roeck-us.net>
From:   Brandon Wyman <bjwyman@gmail.com>
Date:   Thu, 17 Mar 2022 11:12:49 -0500
Message-ID: <CAK_vbW1Lfroo91cMxsLpuf-uuDwcsssG1=fjp3an_O5-FUHjMQ@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs entry
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 3:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/16/22 13:03, Brandon Wyman wrote:
> > On Sun, Mar 13, 2022 at 11:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 3/11/22 10:10, Brandon Wyman wrote:
> >>> Add a clear_faults write-only debugfs entry for the ibm-cffps device
> >>> driver.
> >>>
> >>> Certain IBM power supplies require clearing some latched faults in order
> >>> to indicate that the fault has indeed been observed/noticed.
> >>>
> >>
> >> That is insufficient, sorry. Please provide the affected power supplies as
> >> well as the affected faults, and confirm that the problem still exists
> >> in v5.17-rc6 or later kernels - or, more specifically, in any kernel which
> >> includes commit 35f165f08950 ("hwmon: (pmbus) Clear pmbus fault/warning
> >> bits after read").
> >>
> >> Thanks,
> >> Guenter
> >
> > Sorry for the delay in responding. I did some testing with commit
> > 35f165f08950. I could not get that code to send the CLEAR_FAULTS
> > command to the power supplies.
> >
> > I can update the commit message to be more specific about which power
> > supplies need this CLEAR_FAULTS sent, and which faults. It is observed
> > with the 1600W power supplies (2B1E model). The faults that latch are
> > the VIN_UV and INPUT faults in the STATUS_WORD. The corresponding
> > STATUS_INPUT fault bits are VIN_UV_FAULT and Unit is Off.
> >
>
> The point is that the respective fault bits should be reset when the
> corresponding alarm attributes are read. This isn't about executing
> a CLEAR_FAULTS command, but about selectively resetting fault bits
> while ensuring that faults are reported at least once. Executing
> CLEAR_FAULTS is a big hammer.
>
> With the patch I pointed to in place, input (and other) faults should
> be reset after the corresponding alarm attributes are read, assuming
> that the condition no longer exists. If that does not happen, we should
> fix the problem instead of deploying the big hammer.
>
> Thanks,
> Guenter

Okay, I see what you are pointing out there. I had been mostly looking
at the "files" in the debugfs paths. Those do not end up running
through that pmbus_get_boolean() function, so the individual fault
clearing was not being attempted. The fault I was interested in
appears to be associated with in1_lcrti_alarm. Reading that will give
me a 1 if there is a VIN_UV fault, and then it sends 0x10 to
STATUS_INPUT. That clears out VIN_UV, but the STATUS_INPUT command was
returning 0x18. Nothing appears to handle clearing BIT(3), that 0x08
mask.

Should there be some kind of define for BIT(3) over in pmbus.h?
Something like PB_VOLTAGE_OFF? Somehow we need something using that in
sbit of the attributes. I had a quick hack that just OR'ed BIT(3) with
BIT(4) for that PB_VOLTAGE_UV_FAULT. That resulted in a clear of both
bits in STATUS_INPUT, and the faults clearing in STATUS_WORD.

It is not clear if there should be a separate alarm for that "Unit Off
For Insufficient Input Voltage", or if the one for in1_lcrit_alarm
could just be the two bits OR'ed into one mask. I can send a patch
with a proposal on how to fix this one bit not getting cleared.

>
> >>
> >>> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
> >>> ---
> >>> V1 -> V2: Explain why this change is needed
> >>>
> >>>    drivers/hwmon/pmbus/ibm-cffps.c | 11 +++++++++++
> >>>    1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> >>> index e3294a1a54bb..3f02dde02a4b 100644
> >>> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> >>> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> >>> @@ -67,6 +67,7 @@ enum {
> >>>        CFFPS_DEBUGFS_CCIN,
> >>>        CFFPS_DEBUGFS_FW,
> >>>        CFFPS_DEBUGFS_ON_OFF_CONFIG,
> >>> +     CFFPS_DEBUGFS_CLEAR_FAULTS,
> >>>        CFFPS_DEBUGFS_NUM_ENTRIES
> >>>    };
> >>>
> >>> @@ -274,6 +275,13 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
> >>>                if (rc)
> >>>                        return rc;
> >>>
> >>> +             rc = 1;
> >>> +             break;
> >>> +     case CFFPS_DEBUGFS_CLEAR_FAULTS:
> >>> +             rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
> >>> +             if (rc < 0)
> >>> +                     return rc;
> >>> +
> >>>                rc = 1;
> >>>                break;
> >>>        default:
> >>> @@ -607,6 +615,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
> >>>        debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
> >>>                            &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
> >>>                            &ibm_cffps_fops);
> >>> +     debugfs_create_file("clear_faults", 0200, ibm_cffps_dir,
> >>> +                         &psu->debugfs_entries[CFFPS_DEBUGFS_CLEAR_FAULTS],
> >>> +                         &ibm_cffps_fops);
> >>>
> >>>        return 0;
> >>>    }
> >>
>
