Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FA54B3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbiFNOu2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jun 2022 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiFNOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:50:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D521FA5E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:50:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o17rZ-00014b-20; Tue, 14 Jun 2022 16:49:49 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o17rH-000VXG-2n; Tue, 14 Jun 2022 16:49:32 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o17rH-000Bzr-Qd; Tue, 14 Jun 2022 16:49:31 +0200
Message-ID: <a929309891f9f28ae71f7ee09e990dc8bc362fdf.camel@pengutronix.de>
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset
 Controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Date:   Tue, 14 Jun 2022 16:49:31 +0200
In-Reply-To: <20220613195658.5607-16-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
         <20220613195658.5607-16-brad@pensando.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Mo, 2022-06-13 at 12:56 -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> This patch adds the reset controller functionality for the
> AMD Pensando Elba System Resource Chip.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
[...]
> diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
> new file mode 100644
> index 000000000000..6e429cb11466
> --- /dev/null
> +++ b/drivers/reset/reset-elbasr.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 AMD Pensando
> + */
> +
> +#include <linux/mfd/pensando-elbasr.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/regmap.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +
> +#include <dt-bindings/reset/amd,pensando-elba-reset.h>
> +
> +struct elbasr_reset {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +};
> +
> +static inline struct elbasr_reset *to_elbasr_rst(struct reset_controller_dev *rc)
> +{
> +	return container_of(rc, struct elbasr_reset, rcdev);
> +}
> +
> +static inline int elbasr_reset_shift(unsigned long id)
> +{
> +	switch (id) {
> +	case EMMC_HW_RESET:

Are there more reset controls than EMMC_HW_RESET?
If so, please list them all.
If not, why is this a function with a switch statement for a single
reset bit?

> +		return 6;
> +	default:
> +		return -EINVAL;

The error return value is never checked.
This can't be reached, since ELBASR_NR_RESETS == 1. So id will only
ever be 0.

> +static int elbasr_reset_probe(struct platform_device *pdev)
> +{
> +	struct elbasr_data *elbasr = dev_get_drvdata(pdev->dev.parent);

Peeking into the MFD driver's private data structure seems unnecessary.
Consider using dev_get_regmap() instead.


regards
Philipp
