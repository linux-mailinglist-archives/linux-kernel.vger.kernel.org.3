Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922524FE433
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiDLO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiDLO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:56:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B44EA08;
        Tue, 12 Apr 2022 07:53:52 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kd7wK6Km6z685Z9;
        Tue, 12 Apr 2022 22:51:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 16:53:50 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 15:53:49 +0100
Date:   Tue, 12 Apr 2022 15:53:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
CC:     Shreeya Patel <shreeya.patel@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>, <krzk@kernel.org>,
        <lars@metafoo.de>, <robh+dt@kernel.org>, <Zhigang.Shi@liteon.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>,
        <alvaro.soliverez@collabora.com>
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220412155346.00005d25@Huawei.com>
In-Reply-To: <875ynexup1.fsf@collabora.com>
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-4-shreeya.patel@collabora.com>
        <20220327153049.10e525e9@jic23-huawei>
        <d5de6b56-ad90-feec-c65a-53699c8ddbe9@collabora.com>
        <875ynexup1.fsf@collabora.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 10:06:18 -0400
Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> Shreeya Patel <shreeya.patel@collabora.com> writes:
> 
> >>> +	val_1 = i2c_smbus_read_byte_data(data->client, addr + 1);
> >>> +	val_2 = i2c_smbus_read_byte_data(data->client, addr + 2);
> >>> +	ret = (val_2 << 16) + (val_1 << 8) + val_0;  
> >> This is a le24_to_cpu() conversion.
> >> Preferred choice would be to use something like
> >> 	u8 buf[3];
> >> 	int i;
> >>
> >> 	for (i = 0; i < 3; i++) {
> >> 		ret = i2c_smbus_read_byte_data(data->client, addr);
> >> 		if (ret < 0)
> >> 			return ret;
> >> 		buf[i] = ret;
> >> 	}
> >> 	return le24_to_cpu(buf);
> >>  
> >
> > We do not have any le24_to_cpu() function in current kernel source code.
> > I was thinking to use le32_to_cpu() instead but it requires an argument of
> > type __le32 and our case we storing the values in u8 buf[3] so I'm not
> > really sure if it's possible to use le32_to_cpu() or any other function.  
> 
> I guess you could make it a 32-bit buffer, keep the most
> significant byte zeroed and return le32_to_cpu:
> 
>   u8 buf[4];
> 
>   memset(buf, 0x0, sizeof(buf));
> 
>   for (i = 0; i < 3; i++) {
>  	ret = i2c_smbus_read_byte_data(data->client, addr);
>  	if (ret < 0)
>  		return ret;
> 	buf[i] = ret;
>   }
>   return le32_to_cpu(buf);

> 
I was being silly.  It's not aligned for obvious reasons that we don't do
24bit alignment, so you need
get_unaligned_le24()

Jonathan



