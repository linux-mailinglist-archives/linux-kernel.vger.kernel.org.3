Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA159D0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiHWGCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiHWGCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:02:03 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462145FF48;
        Mon, 22 Aug 2022 23:02:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EE54280F9;
        Tue, 23 Aug 2022 05:54:54 +0000 (UTC)
Date:   Tue, 23 Aug 2022 09:02:00 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/9] Clean-up timer-ti-dm a bit
Message-ID: <YwRtWCu5niFOqYVS@atomide.com>
References: <20220815131250.34603-1-tony@atomide.com>
 <CAGfqbt5R3LEECvzpGZOx5pB+iL=B+hptLTkBLNk6MBHWZoW-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGfqbt5R3LEECvzpGZOx5pB+iL=B+hptLTkBLNk6MBHWZoW-yQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [220822 22:22]:
> Hi Tony,
> 
> On Monday, 15 August 2022 15:12:41 CEST Tony Lindgren wrote:
> > Hi all,
> >
> > This series of changes cleans up timer-ti-dm a bit. After this series we
> > can start replacing the custom PWM related functions with standard
> > Linux frameworks and use things like clk_set_duty_cycle().
> >
> > I have only tested this on K3 and omap2+ devices, I don't have any
> > omap1 devices online right now. Aaro & Janusz, if you could give this
> > series a quick boot test for omap1 that would be great.
> 
> AFAICS, OMAP1 timer-ti-dm compatible "omap_timer" device requires OMAP16xx
> at least, while I only have OMAP15xx.  Then, my testing (successful) was
> limited to a single function -- omap_dm_timer_modify_idlect_mask() -- which
> is called on any OMAP1 as long as CONFIG_OMAP_DM_TIMER is set (requires
> CONFIG_COMPILE_TEST).  However, I've reviewed the series and it looks good
> to me.  I'm only not sure if we may expect any external users of
> omap_dm_timer_get_irq(), if not than we could make it local to the driver while
> being at it.

OK thanks for testing. And thanks for spotting that omap_dm_timer_get_irq()
can be static, I'll post a separate patch for that.

Regards,

Tony
