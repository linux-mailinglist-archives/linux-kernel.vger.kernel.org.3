Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751450841B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352834AbiDTIz3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Apr 2022 04:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376964AbiDTIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:55:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680A1CFD5;
        Wed, 20 Apr 2022 01:52:39 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 206004000C;
        Wed, 20 Apr 2022 08:52:36 +0000 (UTC)
Message-ID: <7a50fc20503e43c8172c42c621e01a111bc8104f.camel@hadess.net>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
From:   Bastien Nocera <hadess@hadess.net>
To:     Jason Gerecke <killertofu@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Date:   Wed, 20 Apr 2022 10:52:36 +0200
In-Reply-To: <CANRwn3SVcqFtv0BTTtqpM7M4WRN4sMKVo7_-9t5M8itt-rEttQ@mail.gmail.com>
References: <20220407115406.115112-1-hadess@hadess.net>
         <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm>
         <CANRwn3SVcqFtv0BTTtqpM7M4WRN4sMKVo7_-9t5M8itt-rEttQ@mail.gmail.com>
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

On Wed, 2022-04-13 at 07:59 -0700, Jason Gerecke wrote:
> Following up on my previous comment. I've been able to test this
> patch
> with both flavors of wireless interface. Both Bluetooth (Intuos Pro)
> and dongle-based (Intuos5) appear to have mostly-correct behavior
> while charging and discharging, even when the battery level gradually
> drops to zero. The misbehaviors I see appear to be limited to upower
> mis-categorizing the devices as an e.g. keyboard or generic battery
> rather than as a tablet. This leads to some slightly confusing UI
> issues (e.g. GNOME and KDE referring to the device incorrectly), but
> nothing too annoying. If upower is taught to recognize tablets under
> more circumstances those issues should disappear.
> 
> Ping tells me you may have an Intuos4 Wireless, Bastien? Any
> additional testing you can do with that device would be appreciated,
> though even without it I'm personally comfortable enough to provide
> an
> ack:
> 
> Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Only devices I have is the original Wacom Graphire Bluetooth, and a
wired Intuos4 (PTK-640) which I think changed names not long after.

This might be enough:
https://gitlab.freedesktop.org/upower/upower/-/merge_requests/127

Please file an issue with the info discussed in the previous mail if it
isn't.

Cheers

> 
> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can’t take seven from three,    /
> So you look at the sixty-fours....
> 
> On Tue, Apr 12, 2022 at 1:53 AM Jiri Kosina <jikos@kernel.org> wrote:
> > 
> > On Thu, 7 Apr 2022, Bastien Nocera wrote:
> > 
> > > POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports
> > > that are
> > > used to charge the machine itself (so a "system" scope), like the
> > > single USB port on a phone, rather than devices.
> > > 
> > > The wacom_sys driver is the only driver that sets its device
> > > battery as
> > > being a USB type, which doesn't seem correct based on its usage,
> > > so
> > > switch it to be a battery type like all the other USB-connected
> > > devices.
> > > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  drivers/hid/wacom_sys.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 066c567dbaa2..620fe74f5676 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -1777,7 +1777,7 @@ static int
> > > __wacom_initialize_battery(struct wacom *wacom,
> > >       bat_desc->get_property = wacom_battery_get_property;
> > >       sprintf(battery->bat_name, "wacom_battery_%ld", n);
> > >       bat_desc->name = battery->bat_name;
> > > -     bat_desc->type = POWER_SUPPLY_TYPE_USB;
> > > +     bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
> > >       bat_desc->use_for_apm = 0;
> > > 
> > >       ps_bat = devm_power_supply_register(dev, bat_desc,
> > > &psy_cfg);
> > 
> > Thanks Bastien, makes sense. CCing Jason and Ping (the Wacom driver
> > maintainers) to get their Ack.
> > 
> > --
> > Jiri Kosina
> > SUSE Labs
> > 

