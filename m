Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB31592DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiHOLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHOLML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:12:11 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628317AAD;
        Mon, 15 Aug 2022 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660561930; x=1692097930;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DRHImuij4vdlvwBxRg3dYj6/FaiAw51rqTCxN6M+co=;
  b=WDPJjRUzeZ2Gaa/903t2DGnsbFwl3dN1EI3lHTFB0/+5r+n04+1sG8T2
   jnbpDEr00PxqJO7HsMss0MMB+eTxu0EXxYKqy9y6Xk5Hu4PTrvXqq2+BT
   MtSUDCSrO37iERGJQHYdB/BP7ISRosZ0VfNDNcvnNLDj2wRx27qOcJQfn
   2Phtfp4/AC0g882mqcaCf0u0LKehzkfFAWY4yFpVY9m5/83KqurFPvoF3
   kPeob4+USO3GxP7Iwzog0jVcp6eDExp2DQDYQAmjGr/dYtXqC2+oq4KMH
   Zl82brMI1nKY2zZZTjmOZG880Zej9fnm2qAhVKmJs3ChmUqABf+Vh53UO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654552800"; 
   d="scan'208";a="25604452"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Aug 2022 13:12:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 15 Aug 2022 13:12:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 15 Aug 2022 13:12:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660561928; x=1692097928;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=6DRHImuij4vdlvwBxRg3dYj6/FaiAw51rqTCxN6M+co=;
  b=jwJKBxmGEkZoAGc31toilr6RbxQhWFhjj2ooV3TS1YXc3EvXiAiOuho7
   ByLEwIVZ4Tqi9m75sGFnKBHs5E9ELlpLOW3bhtpz5b/jkSrXz7D7awNLK
   QUlTWGqKO0OsbVWMMzCzdc/0H3A9p3tfyMRm22nRnw6c7o2sKm92hYin8
   Uv847KAmm5IwZ/3Lt/KYw396mu/mbz1x6tcZxkCyej1ifV5u6Lfm9gFlT
   encYkeiA7wswpUpjvdIadwd1NAqBUc/mO4rmw68bb4OJP07rRQBkQOlBM
   FXjkf90cdhg/NoUMkTyOqxsQjeBMEe8UTFO5uxraP1IjNZ8sesqOKs7TM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654552800"; 
   d="scan'208";a="25604451"
Subject: Re: Re: [PATCH] usb: misc: onboard_usb_hub: Drop reset delay in
 onboard_hub_power_off()
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Aug 2022 13:12:08 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id EC0D8280073;
        Mon, 15 Aug 2022 13:12:07 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Aug 2022 13:12:07 +0200
Message-ID: <5747717.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Yu118qfzoYcHgJs3@google.com>
References: <20220805111836.1.Id5a4dc0a2c046236116693aa55672295513a0f2a@changeid> <CAD=FV=W9VWbvWqdEEY9=OnNSsAnQ+CgQPRifbAu2ixrgPQd54A@mail.gmail.com> <Yu118qfzoYcHgJs3@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. August 2022, 21:56:34 CEST schrieb Matthias Kaehlcke:
> Hi Doug,
> 
> On Fri, Aug 05, 2022 at 12:26:35PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Fri, Aug 5, 2022 at 11:19 AM Matthias Kaehlcke <mka@chromium.org> 
wrote:
> > > onboard_hub_power_off() currently has a delay after asserting the
> > > reset of the hub. There is already a delay in onboard_hub_power_on()
> > > before de-asserting the reset, which ensures that the reset is
> > > asserted for the required time, so the delay in _power_off() is not
> > > needed.
> > > 
> > > Skip the reset GPIO check before calling gpiod_set_value_cansleep(),
> > > the function returns early when the GPIO descriptor is NULL.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > >  drivers/usb/misc/onboard_usb_hub.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > I was trying to figure out what this "reset" was defined to do and I
> > looked for the device tree bindings. They don't seem to exist. Was
> > that an oversight?
> 
> It's not in the binding of the RTS5411 which I guess you looked at,
> because that hub doesn't have a reset line.
> 
> The reset functionality was initially added for the TI USB8041, the
> binding has the reset, but I found it hasn't landed yet:
> 
> https://patchwork.kernel.org/project/linux-usb/patch/20220727093801.687361-1
> -alexander.stein@ew.tq-group.com/
> > In any case, I'm not convinced that your patch is correct. Timing
> > diagrams often show a needed delay between adjusting a reset GPIO and
> > turning on/off the power. The timing diagrams can sometimes show a
> > required delay on both sides. I guess at the moment the only user of
> > this reset GPIO has a symmetric delay, but I can totally expect that
> > someone could come along and say that they needed 10 ms on one side
> > and 1 ms on the other side...
> 
> As of now none of the supported hubs (there are only two of them) has
> an asymmetric delay. The RTS5411 doesn't have a reset line, and the
> TI USB8041 only specifies a power on delay (in my interpretation).
> 
> [1] has some discussion between Alexander and me about this second
> reset. The patch that added the delay was merged before this
> discussion concluded.
> 
> If the driver is going to support a hub that needs an additional
> reset delay when the hub is powered off I'm totally in favor of
> adding that delay, however that isn't currently the case in my
> understanding. If you draw a different conclusion from the TI
> USB8041 datasheet please let me know.
> 
> [1]
> https://patchwork.kernel.org/project/linux-usb/patch/20220727141117.909361-> 1-alexander.stein@ew.tq-group.com/

I'm OK with removing the delay. As mentioned, it can be added if needed for 
some reason.

Reviewed-By: Alexander Stein <alexander.stein@ew.tq-group.com>



