Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A84B4E18
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiBNL0I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:26:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347011AbiBNLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:25:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B936E57D;
        Mon, 14 Feb 2022 03:01:36 -0800 (PST)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy1Vh3wNSz67y1n;
        Mon, 14 Feb 2022 19:01:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 12:01:21 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 11:01:20 +0000
Date:   Mon, 14 Feb 2022 11:01:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jonathan Cameron <jic23@kernel.org>, Qing Wang <wangqing@vivo.com>,
        "Jyoti Bhayana" <jbhayana@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: use div64_u64() instead of do_div()
Message-ID: <20220214110119.00006347@Huawei.com>
In-Reply-To: <29e74800-1c3f-e043-97e6-d83f7a53fafb@wanadoo.fr>
References: <1644395873-3937-1-git-send-email-wangqing@vivo.com>
        <20220213175940.1066f5a8@jic23-huawei>
        <9e5ed543-cd45-85db-50b5-52c2afd54c55@wanadoo.fr>
        <29e74800-1c3f-e043-97e6-d83f7a53fafb@wanadoo.fr>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 19:54:01 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 13/02/2022 à 19:50, Christophe JAILLET a écrit :
> > Le 13/02/2022 à 18:59, Jonathan Cameron a écrit :  
> >> On Wed,  9 Feb 2022 00:37:53 -0800
> >> Qing Wang <wangqing-DGpbCiVdSXo@public.gmane.org> wrote:
> >>  
> >>> From: Wang Qing <wangqing-DGpbCiVdSXo@public.gmane.org>
> >>>
> >>> do_div() does a 64-by-32 division.
> >>> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> >>> can test non-zero and be truncated to zero for division.
> >>>
> >>> fix do_div.cocci warning:
> >>> do_div() does a 64-by-32 division, please consider using div64_u64 
> >>> instead.
> >>>
> >>> Signed-off-by: Wang Qing <wangqing-DGpbCiVdSXo@public.gmane.org>  
> >> These look correct to me.  Jyoti, please could give these a sanity check?
> >>  
> > 
> > This is wrong.
> > 
> > See [1].
> > 
> > CJ
> > 
> > [1]: 
> > https://lore.kernel.org/linux-kernel/20211117112559.jix3hmx7uwqmuryg-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org/   
> 
> Broken link, sorry:
> 
> [1] 
> https://lore.kernel.org/linux-kernel/20211117112559.jix3hmx7uwqmuryg@pengutronix.de/
> 
oops.  Thanks for the heads up. I'd forgotten the slightly odd convention
around do_div

Jonathan


> > 
> >   
> >> Thanks,
> >>
> >> Jonathan
> >>  
> >>> ---
> >>>   drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
> >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c 
> >>> b/drivers/iio/common/scmi_sensors/scmi_iio.c
> >>> index d538bf3..d6df5da
> >>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> >>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> >>> @@ -160,7 +160,7 @@ static int scmi_iio_set_odr_val(struct iio_dev 
> >>> *iio_dev, int val, int val2)
> >>>       mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
> >>>       sec = int_pow(10, mult) * UHZ_PER_HZ;
> >>> -    do_div(sec, uHz);
> >>> +    div64_u64(sec, uHz);
> >>>       if (sec == 0) {
> >>>           dev_err(&iio_dev->dev,
> >>>               "Trying to set invalid sensor update value for sensor %s",
> >>> @@ -237,10 +237,10 @@ static void convert_ns_to_freq(u64 interval_ns, 
> >>> u64 *hz, u64 *uhz)
> >>>       u64 rem, freq;
> >>>       freq = NSEC_PER_SEC;
> >>> -    rem = do_div(freq, interval_ns);
> >>> +    rem = div64_u64(freq, interval_ns);
> >>>       *hz = freq;
> >>>       *uhz = rem * 1000000UL;
> >>> -    do_div(*uhz, interval_ns);
> >>> +    div64_u64(*uhz, interval_ns);
> >>>   }
> >>>   static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, 
> >>> int *val2)
> >>> @@ -266,7 +266,7 @@ static int scmi_iio_get_odr_val(struct iio_dev 
> >>> *iio_dev, int *val, int *val2)
> >>>       mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
> >>>       if (mult < 0) {
> >>>           sensor_interval_mult = int_pow(10, abs(mult));
> >>> -        do_div(sensor_update_interval, sensor_interval_mult);
> >>> +        div64_u64(sensor_update_interval, sensor_interval_mult);
> >>>       } else {
> >>>           sensor_interval_mult = int_pow(10, mult);
> >>>           sensor_update_interval =
> >>> @@ -500,7 +500,7 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
> >>>       mult = SCMI_SENS_INTVL_GET_EXP(val);
> >>>       if (mult < 0) {
> >>>           sensor_interval_mult = int_pow(10, abs(mult));
> >>> -        do_div(sensor_update_interval, sensor_interval_mult);
> >>> +        div64_u64(sensor_update_interval, sensor_interval_mult);
> >>>       } else {
> >>>           sensor_interval_mult = int_pow(10, mult);
> >>>           sensor_update_interval =  
> >>
> >>  
> > 
> >   
> 

