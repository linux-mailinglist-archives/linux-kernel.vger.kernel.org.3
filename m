Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22B4CFF26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiCGMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiCGMw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:52:27 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 756BB4DF6A;
        Mon,  7 Mar 2022 04:51:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4CE2080A8;
        Mon,  7 Mar 2022 12:50:11 +0000 (UTC)
Date:   Mon, 7 Mar 2022 14:51:29 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] bus: ti-sysc: Fix gpt12 system timer issue with reserved
 status
Message-ID: <YiX/0c44p8AL1YIG@atomide.com>
References: <20210611060224.36769-1-tony@atomide.com>
 <7h7d99ehu4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7h7d99ehu4.fsf@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Kevin Hilman <khilman@baylibre.com> [220304 17:39]:
> Hi Tony,
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Jarkko Nikula <jarkko.nikula@bitmer.com> reported that Beagleboard
> > revision c2 stopped booting. Jarkko bisected the issue down to
> > commit 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend
> > and resume for am3 and am4").
> >
> > Let's fix the issue by tagging system timers as reserved rather than
> > ignoring them. And let's not probe any interconnect target module child
> > devices for reserved modules.
> >
> > This allows PM runtime to keep track of clocks and clockdomains for
> > the interconnect target module, and prevent the system timer from idling
> > as we already have SYSC_QUIRK_NO_IDLE and SYSC_QUIRK_NO_IDLE_ON_INIT
> > flags set for system timers.
> >
> > Fixes: 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and am4")
> > Reported-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> I'm debugging why suspend/resume on AM3x and AM4x are mostly working,
> but getting the warning that not all powerdomains are transitioning:
> 
>    pm33xx pm33xx: PM: Could not transition all powerdomains to target state
> 
> I bisected it down to $SUBJECT patch, and verified that reverting it
> makes both on am335x-boneblack and am437x-gp-evm fully suspend, and I'm
> now seeing:
> 
>    pm33xx pm33xx: PM: Successfully put all powerdomains to target state
> 
> Note that it doesn't revert cleanly due to some other changes, but this
> one-liner[1] effectively reverts the behavior of $SUBJECT patch, and
> also makes things work again.
> 
> I verified the revert (and hack[1]) on both v5.10 stable and mainline
> v5.16 but TBH, I'm still not 100% sure what's going on so looking for
> some guidance from you Tony on what the "real" fix should be.

Thanks for debugging the issue Kevin. It seems the issue is caused by the
extra runtime PM usage count done for modules tagged no-idle. However,
this causes issues for am335x timers as the PM coprocessor needs all
the domains idled for system suspend despite the system timers tagged
with no-idle.

We could patch ti-sysc.c for more timer workarounds, but I don't know if
that really makes sense. It would add further dependencies between the
system timer code and the interconnect code, and I'd rather go back to
no dependencies between the system timers and the interconnect code :)

So I suggest we make the omap3 gpt12 quirk checks SoC specific as below
for now, they are not needed for the other SoCs.

Then at some point we can plan on dropping support for the old beagleboard
revisions A to B4, and then reverting commit 3ff340e24c9d ("bus: ti-sysc:
Fix gpt12 system timer issue with reserved status").

Note that we now have commit 23885389dbbb ("ARM: dts: Fix timer regression
for beagleboard revision c"), so there no need to (wrongly) enable the
old timer quirks for working omap3 revision C and later boards.

Regards,

Tony

8< ----------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 7 Mar 2022 14:28:44 +0200
Subject: [PATCH] bus: ti-sysc: Make omap3 gpt12 quirk handling SoC
 specific

On beagleboard revisions A to B4 we need to use gpt12 as the system timer.
However, the quirk handling added for gpt12 caused a regression for system
suspend for am335x as the PM coprocessor needs the timers idled for
suspend.

Let's make the gpt12 quirk specific to omap34xx, other SoCs don't need
it. Beagleboard revisions C and later no longer need to use the gpt12
related quirk. Then at some point, if we decide to drop support for the old
beagleboard revisions A to B4, we can also drop the gpt12 related quirks
completely.

Fixes: 3ff340e24c9d ("bus: ti-sysc: Fix gpt12 system timer issue with reserved status")
Reported-by: Kevin Hilman <khilman@baylibre.com>
Suggested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3232,13 +3232,27 @@ static int sysc_check_disabled_devices(struct sysc *ddata)
  */
 static int sysc_check_active_timer(struct sysc *ddata)
 {
+	int error;
+
 	if (ddata->cap->type != TI_SYSC_OMAP2_TIMER &&
 	    ddata->cap->type != TI_SYSC_OMAP4_TIMER)
 		return 0;
 
+	/*
+	 * Quirk for omap3 beagleboard revision A to B4 to use gpt12.
+	 * Revision C and later are fixed with commit 23885389dbbb ("ARM:
+	 * dts: Fix timer regression for beagleboard revision c"). This all
+	 * can be dropped if we stop supporting old beagleboard revisions
+	 * A to B4 at some point.
+	 */
+	if (sysc_soc->soc == SOC_3430)
+		error = -ENXIO;
+	else
+		error = -EBUSY;
+
 	if ((ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&
 	    (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE))
-		return -ENXIO;
+		return error;
 
 	return 0;
 }
-- 
2.35.1
