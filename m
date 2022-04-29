Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3037514A77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359772AbiD2N1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359773AbiD2N1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:27:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3796C8A87;
        Fri, 29 Apr 2022 06:24:16 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqY4j5gxhz67NKJ;
        Fri, 29 Apr 2022 21:20:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:24:14 +0200
Received: from localhost (10.81.206.67) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:24:13 +0100
Date:   Fri, 29 Apr 2022 14:24:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ruslan Zalata <rz@fabmicro.ru>, Jean Delvare <jdelvare@suse.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220429142412.00001e43@Huawei.com>
In-Reply-To: <f79a8edf-36d4-02af-da8f-32b4e491bd47@roeck-us.net>
References: <20220428210906.29527-1-rz@fabmicro.ru>
        <f79a8edf-36d4-02af-da8f-32b4e491bd47@roeck-us.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.206.67]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 14:30:06 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 4/28/22 14:09, Ruslan Zalata wrote:
> > Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
> > low rate (6 bit) ADC that is often used for extra keys. There's a driver
> > for that already implementing standard input device, but it has these
> > limitations: 1) it cannot be used for general ADC data equisition, and  
> 
> acquisition
> 
> > 2) it uses only one LRADC channel of two available.
> > 
> > This driver provides basic hwmon interface to both channels of LRADC on
> > such Allwinner SoCs.
> > 
> > Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>  
> 
> Ok, next phase of review.
> 

One thing noticed whilst randomly glancing at this patch.


> > +#ifdef CONFIG_PM
> > +static int sun4i_lradc_resume(struct device *dev)
> > +{
> > +	struct sun4i_lradc_data *lradc = dev_get_drvdata(dev);
> > +
> > +	return sun4i_lradc_start(lradc);
> > +}
> > +
> > +static int sun4i_lradc_suspend(struct device *dev)
> > +{
> > +	struct sun4i_lradc_data *lradc = dev_get_drvdata(dev);
> > +
> > +	sun4i_lradc_stop(lradc);
> > +	return 0;
> > +}
> > +
> > +#define SUN4I_LRADC_DEV_PM_OPS	(&sun4i_lradc_dev_pm_ops)
> > +#else
> > +#define SUN4I_LRADC_DEV_PM_OPS	NULL
> > +#endif /* CONFIG_PM */
> > +
> > +static const struct dev_pm_ops sun4i_lradc_dev_pm_ops = {

We have much better infrastructure for this these days.

Take a look at DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr()

Those two in combination will let you get rid of all the ifdef stuff
here by letting the compiler remove the unused code automatically.

> > +	.suspend = sun4i_lradc_suspend,
> > +	.resume = sun4i_lradc_resume,
> > +};
> > +
> > +static const struct of_device_id sun4i_lradc_of_match[] = {
> > +	{ .compatible = "allwinner,sun4i-a10-lradc-keys", .data = &variant_sun4i_a10_lradc},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
> > +
> > +static struct platform_driver sun4i_lradc_driver = {
> > +	.driver = {
> > +		.name	= "sun4i-lradc-hwmon",
> > +		.of_match_table = of_match_ptr(sun4i_lradc_of_match),
> > +		.pm = SUN4I_LRADC_DEV_PM_OPS,
> > +	},
> > +	.probe	= sun4i_lradc_probe,
> > +};
> > +
> > +module_platform_driver(sun4i_lradc_driver);
> > +
> > +MODULE_DESCRIPTION("Allwinner A13/A20 LRADC hwmon driver");
> > +MODULE_AUTHOR("Ruslan Zalata <rz@fabmicro.ru>");
> > +MODULE_LICENSE("GPL");
> > +No empty line at end, please  
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

