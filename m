Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F114F8D82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiDHEka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiDHEk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:40:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ACA3307E57;
        Thu,  7 Apr 2022 21:38:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D501C8125;
        Fri,  8 Apr 2022 04:36:00 +0000 (UTC)
Date:   Fri, 8 Apr 2022 07:38:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/4] dt-bindings: timer: Add am6 compatible for ti-timer
Message-ID: <Yk+8P5EdsdZR5h1Z@atomide.com>
References: <20220407071006.37031-1-tony@atomide.com>
 <20220407133344.v2x2b6rkmskatips@handled>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407133344.v2x2b6rkmskatips@handled>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Nishanth Menon <nm@ti.com> [220407 13:31]:
> On 10:10-20220407, Tony Lindgren wrote:
> > diff --git a/Documentation/devicetree/bindings/timer/ti,timer.txt b/Documentation/devicetree/bindings/timer/ti,timer.txt
> > --- a/Documentation/devicetree/bindings/timer/ti,timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/ti,timer.txt
> > @@ -14,6 +14,7 @@ Required properties:
> >  			ti,omap5430-timer (applicable to OMAP543x devices)
> >  			ti,am335x-timer	(applicable to AM335x devices)
> >  			ti,am335x-timer-1ms (applicable to AM335x devices)
> > +			ti,am6-timer (applicable to AM6 devices)
> 
> Suggestion:
> 
> Could we call this ti,am65-timer instead? AM6 is a bit nuanced and spans
> a couple of sub SoC architectures.

I think the timer hardware is the same across am64, am65 and j7. So we
should pick something to represent the am6 timers as it would allow using
shared dtsi files for the 16 - 30 timers there are.

Using shared timer dtsi files should work as long as the clocks are
defined in include/dt-bindings/clock for each SoC, and assuming we can use
the same compatible property for the timers.

Of course if the timers are really different across am64, am65 and j72
then multiple compatible properties are neeeded.

If the timer hardware is the same, then I guess we should just pick the
earliest version, so how about using ti,am64-timer?

Regards,

Tony
