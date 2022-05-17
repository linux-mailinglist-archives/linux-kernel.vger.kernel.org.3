Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E9529EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiEQKJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiEQKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:07:52 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55E82CDE2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:07:50 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 05B9E48B;
        Tue, 17 May 2022 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1652782070;
        bh=7/tSQcJTwFlAYZHGtTGrf3lNts+XD/u1WDbgTy1/QUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtOrTtJckFMCgB1Kh/uKzZFiJTssUMa2AnTJ557wFFDA0lC0NeVbCReLIqNVRj4WI
         oRpRAKh+LlvUMDY2l2aWPXJH1SEHC23TLCjXCIRrZ4HurkFSU0XnwGDsbF3s0jA0WQ
         4tok2RfF7GhCzV1W4hZ5C+5xobLfDLI7z1mzbMF8=
Date:   Tue, 17 May 2022 03:07:48 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, Chanwoo Choi <cwchoi00@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 2/2] extcon: Add extcon-regulator driver
Message-ID: <YoNz9NPLkYSd8i/s@hatter.bewilderbeest.net>
References: <20220505232557.10936-1-zev@bewilderbeest.net>
 <20220505232557.10936-3-zev@bewilderbeest.net>
 <e27ff1b2-c82f-8335-340f-ae1fa914ed30@gmail.com>
 <YnkyIBh2HnXXLHw3@sirena.org.uk>
 <CGME20220517010322epcas1p45d7fdaa06d23f07533350b7d0cf9e9d6@epcas1p4.samsung.com>
 <YoL0UGR+TiZojL9Y@hatter.bewilderbeest.net>
 <bc6595c8-5f05-ac2c-63e0-f442f9ec83be@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6595c8-5f05-ac2c-63e0-f442f9ec83be@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:15:31PM PDT, Chanwoo Choi wrote:
> Hi Mark, Zev,
> 
> On 5/17/22 10:03 AM, Zev Weiss wrote:
> > [Adding Sebastian for drivers/power discussion]
> > 
> > On Mon, May 09, 2022 at 08:24:16AM PDT, Mark Brown wrote:
> >> On Mon, May 09, 2022 at 09:24:39PM +0900, Chanwoo Choi wrote:
> >>> Hi Zev,
> >>>
> >>> I checked this patch. But, it doesn't look like the extcon provider
> >>> driver. Because basically, extcon provider driver need the circuit
> >>> in order to detect the kind of external connector. But, there are
> >>> no any code for detection. Just add the specific sysfs attribute
> >>> for only this driver. It is not standard interface.
> >>
> >> OTOH it's something where if I look at the physical system with the
> >> hardware there's a clearly visible external connector that I can point
> >> to - it just happens to not support hotplug.  It's not clear what other
> >> system it would sit in, and it seems like an application that displays
> >> external connections on a system in a UI would be able to do something
> >> sensible with it.
> > 
> > Chanwoo, any further thoughts on Mark's reasoning above?
> > 
> > I certainly understand the reluctance to add an extcon driver that 
> > doesn't really do anything with the extcon API, and I have no idea when 
> > we might end up enhancing it to do something more meaningful with that 
> > API (I don't know of any hardware at the moment that would need it).
> > 
> > That said, as Mark points out, the hardware *is* ultimately an "external 
> > connector" (if a very simplistic one).
> > 
> > Do you have any other ideas for where this functionality could go?  Greg 
> > wasn't enthusiastic about a previous revision that had it in 
> > drivers/misc -- though now a fair amount of what was in that version is 
> > now going to be in the regulator core, so maybe that could be 
> > reconsidered?
> > 
> > Or maybe something under drivers/power, though it's not really a supply 
> > or a reset device...drivers/power/output.c or something?
> > 
> > Personally I don't have any terribly strong opinions on this, I'd just 
> > like to reach a mutually-agreeable consensus on a place for it to live.
> > 
> 
> After Mark's reply, I considered extcon provider driver without hotplug
> feature. I think that extcon need to support the following something:
> 
> 1. Need to specify the type of external connector instead of EXTCON_NONE.
> 2. extcon subsystem provides the standard sysfs interface
>    for non-hotplug extcon provider driver.
> 3. User can control the state of external connector via
>    the standard extcon sysfs attributes.
> 
> 
> For example of extcon provider driver,
> static const unsigned int supported_cables[] = {
> 	EXTCON_USB,
> 	EXTCON_NONE,
> };
> 
> int extcon_usb_callback(int connector_id, int property_id, int state, void *data) {
> 	struct extcon_dev *edev = data;
> 
> 	if (id == EXTCON_USB && property_id == EXTCON_NOT_HOTPLUG) {
> 		regulator_enable() or regulator_disable()
> 	}
> 
> 	return 0;
> }
> 
> int extcon_provider_probe(...) {
> 	edev = devm_extcon_dev_allocate(dev, supported_cables);
> 
> 	devm_extcon_dev_register(dev, edev);
> 
> 	extcon_set_property_capability(edev, EXTCON_USB, EXTCON_NOT_HOTPLUG);
> 	extcon_set_property_callback(edev, EXTCON_USB, extcon_usb_callback);
> 
> 	...
> }
> 
> And then user can change the state of each external connector
> via '/sys/class/extcon/extcon0/cable.0/state' 
> if cable.0 contains the EXTCON_NOT_HOTPLUG property.
> 
> I'm designing this approach. But it has not yet decided
> because try to check that this approach is right or not.
> 

Okay, so if I'm understanding correctly we'd be using the extcon 
subsystem's existing attached/detached state to model (and control) the 
on/off state of the power output?

That could work for the particular hardware I'm dealing with at the 
moment, though I'd be a bit concerned that conflating the two might 
constrain things in the future if there's some similar but slightly more 
sophisticated hardware we'd want to extend the same driver to support.  
For example on a power connector with some capability for presence 
detection, we might want to be able to support "attached but powered 
off" as a valid state for it to be in -- would the above approach be 
able to do that?


Thanks,
Zev

