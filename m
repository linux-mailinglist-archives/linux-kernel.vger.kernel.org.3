Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDC579636
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiGSJWH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbiGSJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:21:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FAB275FD;
        Tue, 19 Jul 2022 02:21:00 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnCsW3y7Gz6J6kN;
        Tue, 19 Jul 2022 17:17:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 11:20:57 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 10:20:56 +0100
Date:   Tue, 19 Jul 2022 10:20:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Paul Cercueil" <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220719102055.00000315@Huawei.com>
In-Reply-To: <4ffb757f64fdc2412af37a17242e3bac766aba94.camel@gmail.com>
References: <20220710091837.16057-1-ang.iglesiasg@gmail.com>
        <20220717160802.7690cafe@jic23-huawei>
        <4ffb757f64fdc2412af37a17242e3bac766aba94.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > +
> > > +static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
> > > +{
> > > +       int ret;
> > > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > > +       u8 buf[BMP380_CALIB_REG_COUNT];  
> > 
> > I'd missed this previously but for SPI drivers, we should be providing
> > regmap_bulk accesses with DMA safe buffers.  That means they can't be on the
> > stack and need to be appropriately aligned IIO_DMA_MINALIGN as part of
> > the *data structure.
> > 
> > Last time I checked the SPI regmap implementation doesn't currently use
> > the buffers directly but it has in the past and may do again in the future 
> > - hence we should be careful to allow for that.
> >   
> 
> As we only use this buffer once to store temporally the calibration data to
> parse, I would like to avoid adding extra overhead to the device data struct.
> I've been consulting on DMA rules and safety, and if I understood correctly
> (listed the sources below), it should be safe to use a buffer allocated at
> runtime with kmalloc, right?

Yes. That works too.

>  * https://elinux.org/images/0/03/20181023-Wolfram-Sang-ELCE18-
>    safe_dma_buffers.pdf
>  * https://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-
>    kmalloc-for-dma
> 
> Thanks in advance,
> Angel
