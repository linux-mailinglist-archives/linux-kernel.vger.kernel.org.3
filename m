Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7772B4F7A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiDGIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDGIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:55:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DC7B60D98;
        Thu,  7 Apr 2022 01:53:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9DD6C8125;
        Thu,  7 Apr 2022 08:50:42 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:53:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] clocksource/drivers/timer-ti-dm: Update defines for
 am6 for inline functions
Message-ID: <Yk6mb1HjEH4H/b7p@atomide.com>
References: <20220407071006.37031-1-tony@atomide.com>
 <20220407071006.37031-2-tony@atomide.com>
 <9671f0a5-6860-8a75-d65e-345ce890cd88@linaro.org>
 <Yk6drKxwOSVdrKp+@atomide.com>
 <7f3cbdf3-401c-6c30-20fa-b5121bd3f63d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f3cbdf3-401c-6c30-20fa-b5121bd3f63d@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [220407 08:23]:
> On 07/04/2022 10:15, Tony Lindgren wrote:
> > * Daniel Lezcano <daniel.lezcano@linaro.org> [220407 08:01]:
> > > On 07/04/2022 09:10, Tony Lindgren wrote:
> > > > @@ -251,7 +251,8 @@ int omap_dm_timers_active(void);
> > > >     * The below are inlined to optimize code size for system timers. Other code
> > > >     * should not need these at all.
> > > >     */
> > > > -#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
> > > > +#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS) || \
> > > > +	defined(CONFIG_ARCH_K3)
> > > 
> > > Why not replace the above by CONFIG_OMAP_DM_TIMER ?
> > 
> > Hmm that's a good question for why it was not that way earlier.
> > 
> > This series changes things for tristate "OMAP dual-mode timer driver" if
> > ARCH_K3 || COMPILE_TEST though. So the inline stubs are still needed for
> > COMPILE_TEST it seems.
> 
> But if ARCH_K3 or COMPILE_TEST is set, CONFIG_DM_TIMER is also set, no?

Right but I suspect that COMPILE_TEST will produce a build error on other
architectures. I need to check that though, maybe that is no longer the
case.

Regards,

Tony
