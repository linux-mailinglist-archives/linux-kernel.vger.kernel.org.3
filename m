Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB131592F50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiHONDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiHONDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:41 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D8A71182B;
        Mon, 15 Aug 2022 06:03:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 60EAA80FB;
        Mon, 15 Aug 2022 12:56:48 +0000 (UTC)
Date:   Mon, 15 Aug 2022 16:03:37 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Fix compile test warning
Message-ID: <YvpEKWftsukBchlO@atomide.com>
References: <20220815120334.51887-1-tony@atomide.com>
 <CAK8P3a120ekWQzOLLfDF5jVHJ6XKpz5fKRrh8R-yk6S9PmoeTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a120ekWQzOLLfDF5jVHJ6XKpz5fKRrh8R-yk6S9PmoeTA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [220815 12:48]:
> On Mon, Aug 15, 2022 at 2:03 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > We can get a warning with COMPILE_TEST enabled for omap_timer_match
> > for 'omap_timer_match' defined but not used.
> >
> > Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/clocksource/timer-ti-dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> > --- a/drivers/clocksource/timer-ti-dm.c
> > +++ b/drivers/clocksource/timer-ti-dm.c
> > @@ -1040,7 +1040,7 @@ static const struct dmtimer_platform_data am6_pdata = {
> >         .timer_ops = &dmtimer_ops,
> >  };
> >
> > -static const struct of_device_id omap_timer_match[] = {
> > +static const __maybe_unused struct of_device_id omap_timer_match[] = {
> >         {
> >                 .compatible = "ti,omap2420-timer",
> >         },
> 
> I think a better way to address this is to remove the of_match_ptr()
> usage from the driver. The only reason to use of_match_ptr() is to save
> a few bytes on machines that don't have CONFIG_OF enabled, but this
> driver is not used on such machines any more.

OK makes sense, will send v2 patch.

Thanks,

Tony
