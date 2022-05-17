Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFC52AD56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353157AbiEQVJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiEQVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:09:14 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D21532E9;
        Tue, 17 May 2022 14:09:12 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B921E240003;
        Tue, 17 May 2022 21:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652821751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4X0RThNZxtIdbfYHNEBRnxF0Yn3t5Yg/fIL7z0LUq1k=;
        b=Kw37BgzduEUeCEtlDU3OFs5YdMk0lvNTTZwRFRUpLg7h7hyTe7ZpI6ACJ/GpabFbiiN/JL
        jzMLbuNfs/Ds9ZW44fXyg3AEaPjtQ7k+NApU2CCjcREfzAk+ujwfwz6zVHLTB7qZunt3kL
        6ItRvBX8bgC5kBa74qnrwazeRYUFNWksJt4fzzkBH0hLXpOJ/B/2d/P54JbaimIJ5Dh8V1
        9wMgJ+kGIUGFEaon43qC5Nwqt3kz3H5zZUTYvPl5+WBzJ78Tz4CKmf++nvaWDz4y/cG2sh
        qal+2nPLsy79cymLNK9ZLdhzz3+lYkAK8Nw/+j3nr+rVsDyFg7m/3vAJ9GwMeg==
Date:   Tue, 17 May 2022 23:09:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     a.zummo@towertech.it, daire.mcnamara@microchip.com,
        lewis.hanly@microchip.com, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] rtc: Add driver for Microchip PolarFire SoC
Message-ID: <YoQO9or6g2r3EU8w@mail.local>
References: <20220516082838.3717982-1-conor.dooley@microchip.com>
 <20220516082838.3717982-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516082838.3717982-2-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/05/2022 09:28:38+0100, Conor Dooley wrote:
> +struct mpfs_rtc_dev {
> +	struct rtc_device *rtc;
> +	void __iomem *base;
> +	int wakeup_irq;

I believe this is only used in .probe so you make it local to this
function.

> +};
> +


> +static int mpfs_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct mpfs_rtc_dev *rtcdev = dev_get_drvdata(dev);
> +	u64 time;
> +
> +	time = ((u64)readl(rtcdev->base + DATETIME_UPPER_REG) & DATETIME_UPPER_MASK) << 32;
> +	time |= readl(rtcdev->base + DATETIME_LOWER_REG);

Are the registers properly latched on a DATETIME_UPPER_REG read?

> +	rtc_time64_to_tm(time + rtcdev->rtc->range_min, tm);

range_min is never set so it will end up being 0. I guess you can avoid
a bunch of arithmetic in all the driver. Offsetting will happen in the
core which will probably never happen anyway because the max year is
141338. I guess we will all be gone by then ;)

> +
> +	return 0;
> +}
> +

> +static int mpfs_rtc_probe(struct platform_device *pdev)
> +{
> +	struct mpfs_rtc_dev *rtcdev;
> +	struct clk *clk;
> +	u32 prescaler;
> +	int ret;
> +
> +	rtcdev = devm_kzalloc(&pdev->dev, sizeof(struct mpfs_rtc_dev), GFP_KERNEL);
> +	if (!rtcdev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, rtcdev);
> +
> +	rtcdev->rtc = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtcdev->rtc))
> +		return PTR_ERR(rtcdev->rtc);
> +
> +	rtcdev->rtc->ops = &mpfs_rtc_ops;
> +
> +	/* range is capped by alarm max, lower reg is 31:0 & upper is 10:0 */
> +	rtcdev->rtc->range_max = GENMASK_ULL(42, 0);
> +
> +	clk = mpfs_rtc_init_clk(&pdev->dev);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	rtcdev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rtcdev->base)) {
> +		dev_dbg(&pdev->dev, "invalid ioremap resources\n");
> +		return PTR_ERR(rtcdev->base);
> +	}
> +
> +	rtcdev->wakeup_irq = platform_get_irq(pdev, 0);
> +	if (rtcdev->wakeup_irq <= 0) {
> +		dev_dbg(&pdev->dev, "could not get wakeup irq\n");
> +		return rtcdev->wakeup_irq;
> +	}
> +	ret = devm_request_irq(&pdev->dev, rtcdev->wakeup_irq, mpfs_rtc_wakeup_irq_handler, 0,
> +			       dev_name(&pdev->dev), rtcdev);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "could not request wakeup irq\n");
> +		return ret;
> +	}
> +
> +	/* prescaler hardware adds 1 to reg value */
> +	prescaler = clk_get_rate(devm_clk_get(&pdev->dev, "rtcref")) - 1;
> +
> +	if (prescaler > MAX_PRESCALER_COUNT) {
> +		dev_dbg(&pdev->dev, "invalid prescaler %d\n", prescaler);
> +		return -EINVAL;
> +	}
> +
> +	writel(prescaler, rtcdev->base + PRESCALER_REG);
> +	dev_info(&pdev->dev, "prescaler set to: 0x%X \r\n", prescaler);
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	ret = dev_pm_set_wake_irq(&pdev->dev, rtcdev->wakeup_irq);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to enable irq wake\n");
> +
> +	return devm_rtc_register_device(rtcdev->rtc);
> +}
> +
> +static int mpfs_rtc_remove(struct platform_device *pdev)
> +{
> +	mpfs_rtc_alarm_irq_enable(&pdev->dev, 0);

This is not something you want to do if you want to wake up from
hibernate or any similar sleep state.

> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mpfs_rtc_of_match[] = {
> +	{ .compatible = "microchip,mpfs-rtc" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, mpfs_rtc_of_match);
> +
> +static struct platform_driver mpfs_rtc_driver = {
> +	.probe = mpfs_rtc_probe,
> +	.remove = mpfs_rtc_remove,
> +	.driver	= {
> +		.name = "mpfs_rtc",
> +		.of_match_table = mpfs_rtc_of_match,
> +	},
> +};
> +
> +module_platform_driver(mpfs_rtc_driver);
> +
> +MODULE_DESCRIPTION("Real time clock for Microchip Polarfire SoC");
> +MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.36.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
