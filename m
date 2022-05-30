Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16853751D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiE3HHq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 May 2022 03:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiE3HHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:07:42 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D69101FF;
        Mon, 30 May 2022 00:07:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 40A7F1C0BAB; Mon, 30 May 2022 09:07:29 +0200 (CEST)
Date:   Mon, 30 May 2022 09:07:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        daire.mcnamara@microchip.com, lewis.hanly@microchip.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] rtc: Add driver for Microchip PolarFire SoC
Message-ID: <20220530070728.GH1363@bug>
References: <20220516082838.3717982-1-conor.dooley@microchip.com>
 <20220516082838.3717982-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20220516082838.3717982-2-conor.dooley@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add support for the built-in RTC on Microchip PolarFire SoC

> +#define CONTROL_UPLOAD_BIT	BIT(5)
> +#define CONTROL_DOWNLOAD_BIT	BIT(6)
> +#define CONTROL_DOWNLOAD_BIT	BIT(6)
> +#define CONTROL_WAKEUP_CLR_BIT	BIT(8)

Dup?

> +static void mpfs_rtc_start(struct mpfs_rtc_dev *rtcdev)
> +{
> +	u32 ctrl;
> +
> +	ctrl = readl(rtcdev->base + CONTROL_REG);
> +	ctrl &= ~(CONTROL_STOP_BIT | CONTROL_START_BIT);
> +	ctrl |= CONTROL_START_BIT;
> +	writel(ctrl, rtcdev->base + CONTROL_REG);
> +}

You don't need to clear bit just to set it.

> +	do {
> +		prog = readl(rtcdev->base + CONTROL_REG);
> +		prog &= CONTROL_UPLOAD_BIT;
> +	} while (prog);

Limit to XY iterations?

> +
> +static int mpfs_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	u32 mode = readl(rtcdev->base + MODE_REG);
> +	u64 time;
> +
> +	mode = readl(rtcdev->base + MODE_REG);

Dup?

> + if (mode & MODE_WAKE_EN) + alrm->enabled = true; + else + alrm->enabled = false; + 

enabled = ()?

Best regards,
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
