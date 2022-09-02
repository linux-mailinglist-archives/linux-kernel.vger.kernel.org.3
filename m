Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5198D5AAD16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiIBLGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiIBLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:06:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F74ABF25;
        Fri,  2 Sep 2022 04:06:15 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJw3g361Cz6HJ4j;
        Fri,  2 Sep 2022 19:02:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 13:06:13 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 12:06:12 +0100
Date:   Fri, 2 Sep 2022 12:06:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <20220902120611.000007a0@huawei.com>
In-Reply-To: <4067432b-b5a6-f3eb-a707-5fa298ba846b@linaro.org>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
        <20220901121700.1325733-4-ciprian.regus@analog.com>
        <4067432b-b5a6-f3eb-a707-5fa298ba846b@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 16:23:09 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 01/09/2022 15:16, Ciprian Regus wrote:
> > The LTC2499 is a 16-channel (eight differential), 24-bit,
> > ADC with Easy Drive technology and a 2-wire, I2C interface.
> > 
> > Implement support for the LTC2499 ADC by extending the LTC2497
> > driver. A new chip_info struct is added to differentiate between
> > chip types and resolutions when reading data from the device.
> > 
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf  
> 
> Missing blank line. Use standard Git tools for handling your patches or
> be sure you produce the same result when using some custom process.

My understanding is Datasheet is a standard tag as part of the main tag block.
There should not be a blank line between that and the Sign off.

+CC Andy who can probably point to a reference for that...

> 
> > Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>  
> 
> (...)
> 
> > +};
> > +
> >  static const struct i2c_device_id ltc2497_id[] = {
> > -	{ "ltc2497", 0 },
> > +	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
> > +	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },  
> 
> So they are the same, aren't they?
> 
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ltc2497_id);
> >  
> >  static const struct of_device_id ltc2497_of_match[] = {
> > -	{ .compatible = "lltc,ltc2497", },
> > +	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
> > +	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },  
> 
> I think this should be split into two patches for easier review - one
> working on driver data for existing variant and second for adding new
> variant 2499.
> 
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, ltc2497_of_match);
> > diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> > index d0b42dd6b8ad..95f6a5f4d4a6 100644
> > --- a/drivers/iio/adc/ltc2497.h
> > +++ b/drivers/iio/adc/ltc2497.h
> > @@ -4,9 +4,20 @@
> >  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
> >  #define LTC2497_CONVERSION_TIME_MS	150ULL
> >  
> > +enum ltc2497_chip_type {
> > +	TYPE_LTC2496,  
> 
> Why having here 2496 and not using it?
> 
> > +	TYPE_LTC2497,
> > +	TYPE_LTC2499,
> > +};
> > +  
> Krzysztof

