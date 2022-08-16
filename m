Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D990595C33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiHPMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiHPMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:45:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD66606A9;
        Tue, 16 Aug 2022 05:44:37 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6W7B2srWz6889Z;
        Tue, 16 Aug 2022 20:44:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 14:44:34 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 13:44:34 +0100
Date:   Tue, 16 Aug 2022 13:44:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     George Mois <george.mois@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lucas.p.stankus@gmail.com>
Subject: Re: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Message-ID: <20220816134433.00002900@huawei.com>
In-Reply-To: <8cf4ea9e-89a4-1ab0-334b-9ecc5b1e6f25@linaro.org>
References: <20220816102828.182345-1-george.mois@analog.com>
        <20220816102828.182345-3-george.mois@analog.com>
        <8cf4ea9e-89a4-1ab0-334b-9ecc5b1e6f25@linaro.org>
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

On Tue, 16 Aug 2022 14:16:13 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/08/2022 13:28, George Mois wrote:
> > ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
> > with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
> > respectively.
> >   
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> >  
> >  static const struct spi_device_id adxl313_spi_id[] = {
> > -	{ "adxl313" },
> > +	{ "adxl312", ADXL312 },
> > +	{ "adxl313", ADXL313 },
> > +	{ "adxl314", ADXL314 },
> >  	{ }
> >  };
> >  
> >  MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
> >  
> >  static const struct of_device_id adxl313_of_match[] = {
> > +	{ .compatible = "adi,adxl312" },
> >  	{ .compatible = "adi,adxl313" },
> > +	{ .compatible = "adi,adxl314" },  
> 
> You miss here driver data. I don't remember which driver matching takes
> precedence (especially in various cases like DT platforms with device
> instantiated by MFD), but for consistency I think both device id tables
> should have same driver data.

You can set it up to try device_get_match_data() first then fallback
to the adxl313_spi_id[] table but there isn't a nice 'standard' way to
do it.

If that isn't done, then IIRC the match is against the compatible with
the vendor ID dropped and the table used is the spi_device_id one.
Which is just annoyingly complex and relies on the strings matching.

In the ideal world the spi_device_id table would go away but there are
still a few users (greybus - I think + remaining board files).
So for now something like

a = device_get_match_data(dev);
if (!a)
	a = &adxl31x_spi_regmap_config[id->data];

Provides a good way of ensuring the id tables don't need to remain
in sync.

Jonathan


> 
> 
> Best regards,
> Krzysztof

