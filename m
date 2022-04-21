Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55D509A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386329AbiDUIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbiDUIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:03:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0E1B7A1;
        Thu, 21 Apr 2022 01:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0D4FCE20F3;
        Thu, 21 Apr 2022 08:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA691C385A9;
        Thu, 21 Apr 2022 08:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528054;
        bh=kzI7cNCI/MQ41Ygqo1vpDlykJ1QbTxbXNmI8WhhimmQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uvCakPe7gzWAmGB5n5HdstoT10rszEeh29X9NW6qZM1gttVKRTdRkLBYkf6Xkg8DK
         G1Xv+90XoOPqnpwponuDHH9V55BsaNasckVr/22M8AnYwCmoZueNSeL/h/mpb/b0nF
         vi04EMG8Rzt1Z3AVTrCpOxxGj/z9wn+m/YnJhXmfOqvfHXS0fppthn8qm3ZxIe+D9N
         B/OVJsGgwiCT0rVD2Gse8Hfe47nEq4iCLHZ0+mITw7ppmtGknb+CneBRRQ6o6XqwEw
         MKG5u7O/aqZglPpEHdUQFn9dn8xf9HYvJH4ogfQO4YRDP0ANDJWs1qNuXzQXLN0B1L
         6CuEj6R4Rj8ng==
Date:   Thu, 21 Apr 2022 10:00:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
In-Reply-To: <892475a2d458aa1e8f5027f13d6582f0f6b4b05e.camel@hadess.net>
Message-ID: <nycvar.YFH.7.76.2204211000150.30217@cbobk.fhfr.pm>
References: <20220407115406.115112-1-hadess@hadess.net>  <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm> <892475a2d458aa1e8f5027f13d6582f0f6b4b05e.camel@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022, Bastien Nocera wrote:

> > > POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports that
> > > are
> > > used to charge the machine itself (so a "system" scope), like the
> > > single USB port on a phone, rather than devices.
> > > 
> > > The wacom_sys driver is the only driver that sets its device
> > > battery as
> > > being a USB type, which doesn't seem correct based on its usage, so
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
> > > @@ -1777,7 +1777,7 @@ static int __wacom_initialize_battery(struct
> > > wacom *wacom,
> > >         bat_desc->get_property = wacom_battery_get_property;
> > >         sprintf(battery->bat_name, "wacom_battery_%ld", n);
> > >         bat_desc->name = battery->bat_name;
> > > -       bat_desc->type = POWER_SUPPLY_TYPE_USB;
> > > +       bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
> > >         bat_desc->use_for_apm = 0;
> > >  
> > >         ps_bat = devm_power_supply_register(dev, bat_desc,
> > > &psy_cfg);
> > 
> > Thanks Bastien, makes sense. CCing Jason and Ping (the Wacom driver 
> > maintainers) to get their Ack.
> 
> Hey,
> 
> I know both Jason and Ping, but their name didn't show up when running
> get_maintainers.pl and neither of their names are in the MAINTAINERS
> file.
> 
> This probably needs fixing.

Agreed. Wacom driver is by itself substantial enough in order to have 
MAINTAINERS entry.

Jason, Ping, could you please send me a patch adding yourself as 
maintainers?

Thanks,

-- 
Jiri Kosina
SUSE Labs

