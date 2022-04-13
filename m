Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146EF5001FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiDMWrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiDMWrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:47:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681DE4C416;
        Wed, 13 Apr 2022 15:45:21 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1neljf-0006LW-0U; Thu, 14 Apr 2022 00:45:15 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
Date:   Thu, 14 Apr 2022 00:45:14 +0200
Message-ID: <3484357.R56niFO833@diego>
In-Reply-To: <8824147c-5512-a7a5-9e89-60b510111500@gmail.com>
References: <20220406014842.2771799-1-briannorris@chromium.org> <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid> <8824147c-5512-a7a5-9e89-60b510111500@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 14. April 2022, 00:14:40 CEST schrieb Chanwoo Choi:
> On 22. 4. 6. 10:48, Brian Norris wrote:
> > See the previous patch ("soc: rockchip: power-domain: Manage resource
> > conflicts with firmware") for a thorough explanation of the conflicts.
> > While ARM Trusted Firmware may be modifying memory controller and
> > power-domain states, we need to block the kernel's power-domain driver.
> > 
> > If the power-domain driver is disabled, there is no resource conflict
> > and this becomes a no-op.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >   drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> > index e494d1497d60..daff40702615 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -21,6 +21,7 @@
> >   #include <linux/rwsem.h>
> >   #include <linux/suspend.h>
> >   
> > +#include <soc/rockchip/pm_domains.h>
> >   #include <soc/rockchip/rk3399_grf.h>
> >   #include <soc/rockchip/rockchip_sip.h>
> >   
> > @@ -93,6 +94,16 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> >   
> >   	mutex_lock(&dmcfreq->lock);
> >   
> > +	/*
> > +	 * Ensure power-domain transitions don't interfere with ARM Trusted
> > +	 * Firmware power-domain idling.
> > +	 */
> > +	err = rockchip_pmu_block();
> > +	if (err) {
> > +		dev_err(dev, "Failed to block PMU: %d\n", err);
> > +		goto out_unlock;
> > +	}
> > +
> >   	/*
> >   	 * Some idle parameters may be based on the DDR controller clock, which
> >   	 * is half of the DDR frequency.
> > @@ -198,6 +209,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> >   	dmcfreq->volt = target_volt;
> >   
> >   out:
> > +	rockchip_pmu_unblock();
> > +out_unlock:
> >   	mutex_unlock(&dmcfreq->lock);
> >   	return err;
> >   }
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

so I guess you're ok with me picking up both patches, right?
[Just making sure :-) ]

Thanks
Heiko


