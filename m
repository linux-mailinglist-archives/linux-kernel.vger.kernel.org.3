Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC54AC0FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390160AbiBGOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390596AbiBGN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:59:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F2FC043189;
        Mon,  7 Feb 2022 05:59:02 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JsnhL2S46z67wM9;
        Mon,  7 Feb 2022 21:54:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 7 Feb 2022 14:58:59 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 13:58:59 +0000
Date:   Mon, 7 Feb 2022 13:58:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linus.walleij@linaro.org>,
        <caihuoqing@baidu.com>, <aardelean@deviqon.com>,
        <andy.shevchenko@gmail.com>, <hdegoede@redhat.com>,
        <Qing-wu.Li@leica-geosystems.com.cn>, <stephan@gerhold.net>,
        <linux-iio@vger.kernel.org>,
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH RESEND 0/2] Solve data access delay of ST sensors
Message-ID: <20220207135858.00000745@Huawei.com>
In-Reply-To: <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
        <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
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

On Mon,  7 Feb 2022 09:04:41 +0000
Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com> wrote:

> Reading raw data from ST sensors implies enabling the device and
> waiting for its activation.
> This leads to significant delays every time the data is fetched,
> especially if the operation has to be repeated.
> 
> The introduction of the 'always_on' flag as sysfs attribute can
> solve this issue, by allowing the user to keep the device enabled
> during the entire read session and therefore, to perform a much
> faster data access.
> 
> This implementation has been already tested on a ST magnetometer.
> 
> I forgot to add maintainers as recepients, so I resend the patches.
> 
> Massimo Toscanelli (2):
>   iio: st_sensors: add always_on flag
>   iio: st_magn_core.c: activate always_on attribute
> 
>  .../iio/common/st_sensors/st_sensors_core.c   | 85 +++++++++++++++++--
>  drivers/iio/magnetometer/st_magn_core.c       |  2 +
>  include/linux/iio/common/st_sensors.h         | 14 +++
>  3 files changed, 96 insertions(+), 5 deletions(-)
> 
> 
> base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60

Hi Massimo,

The standard approach to avoiding rapid power up and power down cycles
is to use runtime_pm with autosuspend and a period set at a period
of perhaps 1 second.  Would that work for you?  You'll pay the costs
of power up only on the first read after a period of not reading.

Exposing the control to userspace for this sort of thing is normally
a bad idea because userspace generally has no idea if it should use it
as there is no clean way of telling userspace the costs of not using
it (as those will be device specific).

If you have a usecase that requires regular reading you should also
think about whether using the buffered interface is more appropriate.
IIRC that will keep these devices powered up continuously whilst
the buffer is enabled and will provide a lower overhead way of
reading data than sysfs reads.

Jonathan
