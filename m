Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF23E568348
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiGFJQs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jul 2022 05:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiGFJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:16:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1088B38
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:16:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o919C-0003MH-IH; Wed, 06 Jul 2022 11:16:38 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o9195-004jQf-K4; Wed, 06 Jul 2022 11:16:35 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o9198-0003QN-9M; Wed, 06 Jul 2022 11:16:34 +0200
Message-ID: <f28de0c61c06396e36756f2d4f3379fab26abdbf.camel@pengutronix.de>
Subject: Re: [PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code
 into a dedicated module
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Jul 2022 11:16:34 +0200
In-Reply-To: <20220705220757.dwzmrx34t2nsxfzl@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
         <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
         <e0869ae1b10ec19eaf87dc5fa53498f82e7deaac.camel@pengutronix.de>
         <20220705220757.dwzmrx34t2nsxfzl@mobilestation>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Mi, 2022-07-06 at 01:07 +0300, Serge Semin wrote:
[...]
> > What is the reason for separating ccu-rst.c and clk-ccu-rst.c?
> > 
> > I expect implementing the reset ops and registering the reset
> > controller in the same compilation unit would be easier.
> 
> From the very beginning of the Baikal-T1 driver live the Clock/Reset functionality
> has been split up into two parts:
> 1. ccu-{div,pll}.c - Clock/Reset operations implementation.
> 2. clk-ccu-{div,pll}.c - Clock/Reset kernel interface implementation.
> At least for the clk-part it has made the driver much easier to read.
> Code in 1. provides the interface methods like
> ccu_{div,pll}_hw_register() to register a clock provider corresponding
> to the CCU divider/PLL of the particular type. Code in 2. uses these
> methods to create the CCU Dividers/PLL clock descriptors and register
> the of-based clocks in the system. The reset functionality was
> redistributed in the same manner in the framework of the ccu-div.c and
> clk-ccu-div.c modules.
> 
> A similar approach I was trying to utilize in the framework of the
> separate CCU Resets implementation. Although it turned out to be not as
> handy as it was for the clock-part due to the different clock and
> reset subsystems API (clock subsystem provides a single clock
> source based API, while the reset subsystem expects to have the whole
> resets controller described). Anyway I've decided to preserve as much
> similarities as possible for the sake of the code unification and
> better readability/maintainability. Thus the reset lines control
> methods have been placed in the ccu-rst.c object file, while the reset
> control registration has been implemented in the clk-ccu-rst.c module.

Thank you for the detailed explanation. I think that splitting doesn't
help readability much in this case, but I realize that may just be a
matter of preference.

[...]
> > I don't think this is necessary, see my comments below. Since the reset
> > ids are contiguous, just setting nr_resets and using the default
> > .of_xlate should be enough to make sure this is never called with an
> > invalid id.
> 
> Using non-contiguous !Clock! IDs turned to be unexpectedly handy. Due to
> that design I was able to add the internal clock providers hidden from
> the DTS users but still visible in the clocks hierarchy. It has made the
> clocks implementation as detailed as possible and protected from the
> improper clocks usage. It also simplified a new clock providers adding
> in future (though there won't be clock sources left undefined in the
> SoC after this patchset is applied).
> 
> All of that made me thinking that the same approach can be useful in
> the framework of the CCU reset controls implementation too at the very
> least for the code unification. Although after the next patch in the
> series is applied there won't be resets left undefined in the
> Baikal-T1 SoC. So from another side you might be partly right on
> suggesting to drop the independent reset IDs/descriptors design and
> just assume the IDs contiguousness.
> 
> So could you please confirm that you still insists on dropping it?

Please drop it, then. I don't think there is value in carrying this
complexity just because it makes the code more similar to the
neighboring clk code.

I'd prefer to keep the reset ids contiguous, so future hardware should
just get a different set of contiguous IDs, or new IDs appended
contiguously as you do in patch 7.

[...]
> > 
> > 
> > 
> > I would fold this into ccu_rst_hw_unregister().
> 
> I disagree in this part. Splitting up the interface methods in a set
> of the small coherent methods like protagonists and respective
> antagonists makes the code much easier to read and maintain. So I
> will insist on having the ccu_rst_free_data() method even if it is
> left with only a single kfree() function invocation.
[...]
> I have to disagree for the same reason as I would preserve the
> ccu_rst_free_data() method here. Please see my comment above.

I'm fine with that.

> 
regards
Philipp
