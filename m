Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD505083F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbiDTIsJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Apr 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350981AbiDTIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:48:01 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 01:45:15 PDT
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6964ED;
        Wed, 20 Apr 2022 01:45:14 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A92B60002;
        Wed, 20 Apr 2022 08:45:10 +0000 (UTC)
Message-ID: <4439d19b13e2acf4c6b7f917eef590035460b06a.camel@hadess.net>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
From:   Bastien Nocera <hadess@hadess.net>
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <pinglinux@gmail.com>
Date:   Wed, 20 Apr 2022 10:45:10 +0200
In-Reply-To: <CANRwn3QSx=FpCT0=E1y88W0zuFLmChqmYe_y7uSs0bANNk4rvw@mail.gmail.com>
References: <20220407115406.115112-1-hadess@hadess.net>
         <CANRwn3QSx=FpCT0=E1y88W0zuFLmChqmYe_y7uSs0bANNk4rvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-11 at 11:51 -0700, Jason Gerecke wrote:
> It seems that the USB type was chosen to fit into a upower heuristic
> that still exists (see [1], [2]).

This heuristic was introduced in a commit that reads:
"
Hardcode wacom battery devices as not power-supply devices
    
We'll switch to a kernel property when the power_supply interface is
fixed.
"

Might be time :)

>  Looking at the upower code I suspect
> that swapping to the Battery type will at least cause
> "UP_DEVICE_KIND_TABLET" to no longer be used for our dongle-based
> wireless devices (Bluetooth-based might still be fine though). We
> haven't sold dongle-based devices in a while, but they're definitely
> still out there. If the batteries in those devices are seen as system
> batteries that could cause a problem -- e.g. triggering hibernation
> when the tablet battery gets low.

Whatever the type of "power_supply", the device will never be detected
as supplying the system, as the "scope" is correct.

> I think it would be wise to test this first to see if there's any
> obvious real-world fallout from the change...

Worse case scenario, the tablet is detected as something other than a
tablet. If that happens, please file a bug against upower and attach
the output of "udevadm info --export-db" and CC: me on the issue, and
I'll fix the detection.

Cheers

> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96983296281507f049425b84f0d244c40d506eba
> [2]:
> https://cgit.freedesktop.org/upower/tree/src/linux/up-device-supply.c
> 
> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can’t take seven from three,    /
> So you look at the sixty-fours....
> 
> 
> 
> On Thu, Apr 7, 2022 at 1:52 PM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports that
> > are
> > used to charge the machine itself (so a "system" scope), like the
> > single USB port on a phone, rather than devices.
> > 
> > The wacom_sys driver is the only driver that sets its device
> > battery as
> > being a USB type, which doesn't seem correct based on its usage, so
> > switch it to be a battery type like all the other USB-connected
> > devices.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/hid/wacom_sys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 066c567dbaa2..620fe74f5676 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -1777,7 +1777,7 @@ static int __wacom_initialize_battery(struct
> > wacom *wacom,
> >         bat_desc->get_property = wacom_battery_get_property;
> >         sprintf(battery->bat_name, "wacom_battery_%ld", n);
> >         bat_desc->name = battery->bat_name;
> > -       bat_desc->type = POWER_SUPPLY_TYPE_USB;
> > +       bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
> >         bat_desc->use_for_apm = 0;
> > 
> >         ps_bat = devm_power_supply_register(dev, bat_desc,
> > &psy_cfg);
> > --
> > 2.35.1
> > 

