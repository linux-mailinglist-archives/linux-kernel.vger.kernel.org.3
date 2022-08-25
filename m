Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC535A0C76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiHYJXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiHYJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:23:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A83EA4062
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:22:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220825092253euoutp02ceac81f8f411523431c9c4aee93c9174~OjB4sqv4M0779507795euoutp02p
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220825092253euoutp02ceac81f8f411523431c9c4aee93c9174~OjB4sqv4M0779507795euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661419373;
        bh=xjnXAAwWtpfUx+TdPneJl08XbYG5EmXZD+I1BOByEbU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=iDVIsf+VWCed0pObPHseai8aEb4J6qzyIUP4iX0/nnfMeBszMRINKhvYXdvdPotmQ
         nUoITYXW4nAqz7eHHd9okkh9vMHOUE2XXunsiEfjPyViOt1kl8WQ5KzHeTe2p1s8ua
         BjaZaUaXEIIHxgv43Wu8fyrtyCvHcG4oJ0Qwc/aA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220825092253eucas1p29de6f14d8f45c1352fa024249546d011~OjB4Hk18c1481114811eucas1p2G;
        Thu, 25 Aug 2022 09:22:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.A0.07817.D6F37036; Thu, 25
        Aug 2022 10:22:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220825092252eucas1p2e9b1ad010137838fa97db6a25b213ace~OjB3q0qxY1481114811eucas1p2F;
        Thu, 25 Aug 2022 09:22:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220825092252eusmtrp212dc681cc001f2d71b77e6b21f5a90e2~OjB3pc7Yo3002530025eusmtrp2B;
        Thu, 25 Aug 2022 09:22:52 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-d3-63073f6d3e25
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.8D.10862.C6F37036; Thu, 25
        Aug 2022 10:22:52 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220825092252eusmtip1ae6b86ce689075c33cce97740cf691ca~OjB3Ev_KR2574125741eusmtip1w;
        Thu, 25 Aug 2022 09:22:51 +0000 (GMT)
Message-ID: <b1100fe9-9cf4-26e0-7fa5-b40f6a25ef44@samsung.com>
Date:   Thu, 25 Aug 2022 11:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Content-Language: en-US
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220815211919.2028890-1-isaacmanjarres@google.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7q59uzJBu2fWSyaF69ns+hv3Mps
        sWO7iMXlXXPYLJ4sPMNkMffLVGaLzR9esll0HfrLZvHp/AU2i761l9gsjq8Nd+D22LZ7G6tH
        S3MPm8eOu0sYPRZsKvXYtKqTzePOtT1sHvvnrmH32Pm9gd3j8ya5AM4oLpuU1JzMstQifbsE
        rozJsw+zFqyTrli25ARjA+Nu0S5GTg4JAROJzhvXmboYuTiEBFYwShzetosFwvnCKPFt3hNW
        COczo8T62x/YYFoWf33GBpFYzihxcUkjVNVHRok/K84zg1TxCthJvFn4mBHEZhFQlfi/+zg7
        RFxQ4uTMJywgtqhAssSz/4vB4sICHhJ7P/eD2cwC4hK3nsxnArFFBCYySRw/IAwRn8Uocf+U
        B4jNJmAo0fW2C+wiTgFHiS+t/5ggauQltr+dwwxykITAZE6Jn//7WSDOdpG4P6eNCcIWlnh1
        fAs7hC0j8X8nyDIOIDtf4u8MY4hwhcS112uYIWxriTvnfrGBlDALaEqs36UPEXaUWLelBaqT
        T+LGW0GIC/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzOgxcuMU9gVJqFFCazkPw+C8kvsxD2LmBk
        WcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYyk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS
        4bU6xpIsxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6YklqdmpqQWoRTJaJg1Oqgam3
        793kyD/P1nfdtm+RmK7MwTBhT1ju0nPNS3f2LlQWMMnZqdEr2H/DXtNedVLfBvejVofseGZl
        3GFfs72RY47sEs6ffKK/eK8cECz/4Wj+747D6S2Jq+1kTD5cm++xfXNhYOz6KkeDbRIp2VKr
        ObqFL5+cI6n12MzkYryMlsrHCamqTHvqpzKVqWz4Nv2oyvX7oRVJvmVvRJL2PxecyL6vsVW3
        0nNrVkrZX95pnyUnSEZ7TVUOT3+0/mzUx8aAU28395482Dk/p1UrVvxVvsVpSb09XHdqIw6f
        TLog6i2Tybzzygc2D9snEhpXnr+WMIuXXeGwxPXzy3jeGc5rLBXfizm+Uej+IzZBxtssVYml
        OCPRUIu5qDgRAPxSwTjUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7o59uzJBstWqlg0L17PZtHfuJXZ
        Ysd2EYvLu+awWTxZeIbJYu6XqcwWmz+8ZLPoOvSXzeLT+QtsFn1rL7FZHF8b7sDtsW33NlaP
        luYeNo8dd5cweizYVOqxaVUnm8eda3vYPPbPXcPusfN7A7vH501yAZxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmTZx9mLVgnXbFsyQnGBsbd
        ol2MnBwSAiYSi78+Y+ti5OIQEljKKLGnbx8jREJG4uS0BlYIW1jiz7UuqKL3jBLfJ60EK+IV
        sJN4s/AxmM0ioCrxf/dxdoi4oMTJmU9YQGxRgWSJBYeWgtnCAh4Sez/3g9UwC4hL3Hoynwlk
        qIjAZCaJN9vXs0Ik5jBKPPmVCLFtCqPE/pN3mUESbAKGEl1vQc7g5OAUcJT40vqPCaLBTKJr
        axcjhC0vsf3tHOYJjEKzkBwyC8nCWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93
        EyMwhrcd+7llB+PKVx/1DjEycTAeYpTgYFYS4bU6xpIsxJuSWFmVWpQfX1Sak1p8iNEUGBoT
        maVEk/OBSSSvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFpQXrO
        A3YXN7v64vurl3400RGbWDBFf+PSqj0H5s7N/nXlTs5Wa7U/TMzXd5WnXZ/rJdYd/kKvalv/
        A57TXQyK5zwP8Hw8odbJ73jBxIzjf3Hh9lW/5m13+/xn3xKzZNuerSa8HEe3CNa+LZ9Rdljr
        /80uF+OvwfeO2jIxVuZaFIXyxh3aaLYwP3FT3/rLT/sqgtbrSygYTTOPjA+onDzl7fkHN4Uv
        snzXfDCzr1Aqp22N0A6hJZyPQ/WCYsMCxCcf5bq67tAcwdfK85xcwwNUvu9wfFsisP+O1+Gv
        C60U3xxb/a82hycgQrUsq15lubDHw2flj6vLnV7ZCUsaiR6817Z8oWH2ofaFn+WzTmUqsRRn
        JBpqMRcVJwIASXpqsWoDAAA=
X-CMS-MailID: 20220825092252eucas1p2e9b1ad010137838fa97db6a25b213ace
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220815211927eucas1p275ed3f63f1baf76b319a828c214c651f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220815211927eucas1p275ed3f63f1baf76b319a828c214c651f
References: <CGME20220815211927eucas1p275ed3f63f1baf76b319a828c214c651f@eucas1p2.samsung.com>
        <20220815211919.2028890-1-isaacmanjarres@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.2022 23:19, Isaac J. Manjarres wrote:
> Both __device_attach_driver() and __driver_attach() check the return
> code of the bus_type.match() function to see if the device needs to be
> added to the deferred probe list. After adding the device to the list,
> the logic attempts to bind the device to the driver anyway, as if the
> device had matched with the driver, which is not correct.
>
> If __device_attach_driver() detects that the device in question is not
> ready to match with a driver on the bus, then it doesn't make sense for
> the device to attempt to bind with the current driver or continue
> attempting to match with any of the other drivers on the bus. So, update
> the logic in __device_attach_driver() to reflect this.
>
> If __driver_attach() detects that a driver tried to match with a device
> and that results in any error, then the driver should not attempt to bind
> with the device. However, the driver can still attempt to match and bind
> with other devices on the bus, as drivers can be bound to multiple
> devices. So, update the logic in __driver_attach() to reflect this.
>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: stable@kernel.org
> Fixes: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

This fixes the boot issue observed on Qualcomm APQ8016 based DragonBoard 
410c, which I've missed while testing the "amba: Remove deferred device 
addition" patch. Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/base/dd.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> v1 -> v2:
> - Fixed the logic in __driver_attach() to allow a driver to continue
>    attempting to match and bind with devices in case of any error, not
>    just probe deferral.
>
> Guenter,
>
> Can you please give test this patch to make sure it still works for you?
>
> Thanks,
> Isaac
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 70f79fc71539..453eb19a9a27 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>   		dev_dbg(dev, "Device match requests probe deferral\n");
>   		dev->can_match = true;
>   		driver_deferred_probe_add(dev);
> +		/*
> +		 * Device can't match with a driver right now, so don't attempt
> +		 * to match or bind with other drivers on the bus.
> +		 */
> +		return ret;
>   	} else if (ret < 0) {
>   		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
>   		return ret;
> @@ -1120,9 +1125,18 @@ static int __driver_attach(struct device *dev, void *data)
>   		dev_dbg(dev, "Device match requests probe deferral\n");
>   		dev->can_match = true;
>   		driver_deferred_probe_add(dev);
> +		/*
> +		 * Driver could not match with device right now, but may match
> +		 * with another device on the bus.
> +		 */
> +		return 0;
>   	} else if (ret < 0) {
>   		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> -		return ret;
> +		/*
> +		 * Driver could not match with device, but may match with
> +		 * another device on the bus.
> +		 */
> +		return 0;
>   	} /* ret > 0 means positive match */
>   
>   	if (driver_allows_async_probing(drv)) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

