Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1D51577E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358677AbiD2WA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358529AbiD2WAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:00:24 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E268DC58D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:57:02 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220429215657euoutp01b52caa7fa2a0ce90194a6e18a54f0a1c~qfMlS_lhl0890308903euoutp01D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:56:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220429215657euoutp01b52caa7fa2a0ce90194a6e18a54f0a1c~qfMlS_lhl0890308903euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651269417;
        bh=7J8rtnDsMQWZWHd+b1WNNYuDDtLNUDrGaXcixOOSXis=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=I+v6+0XNi8bqSj73UnTHpZD65DZluW2ATk2JhuHg9VW2gGKLhSIVQzWzkXfIolTLr
         WIVQLIBSCVWpJshN00tfMNL35+YCtAF/jkdH7riyeTURKdFAMWQravpbggBmPNciAe
         mlKFxTrEmD6MnLZarQj5i25AyCFS8qXK4wK1NPR8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429215657eucas1p2d8101c18a677b9dccf203992ff286105~qfMk12rN81633416334eucas1p29;
        Fri, 29 Apr 2022 21:56:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.A2.09887.82F5C626; Fri, 29
        Apr 2022 22:56:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220429215656eucas1p28b290e1a8b4eb96d78bdad84163b9b6b~qfMkN91sc1108311083eucas1p2g;
        Fri, 29 Apr 2022 21:56:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220429215656eusmtrp10ab16ce363e33a04f529a0c42283f7c6~qfMkNPbul2137421374eusmtrp1p;
        Fri, 29 Apr 2022 21:56:56 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-5c-626c5f28ab35
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.3F.09522.82F5C626; Fri, 29
        Apr 2022 22:56:56 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220429215655eusmtip1e5918148f011778f859da0e025c4d11e~qfMjxxX-r1196411964eusmtip17;
        Fri, 29 Apr 2022 21:56:55 +0000 (GMT)
Message-ID: <ac28b69a-df20-ee17-a567-026096ed5498@samsung.com>
Date:   Fri, 29 Apr 2022 23:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] rpmsg: Fix calling device_lock() on non-initialized
 device
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220429195946.1061725-2-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzneV2N+Jwkg64FBhan979jsWhevJ7N
        Yu/rrewWl3fNYbNoPq9ksXXPASYHNo871/aweeyfu4bd4/MmuQDmKC6blNSczLLUIn27BK6M
        Syf+MBe0G1Qs3bKMsYHxqVoXIyeHhICJxLvHVxm7GLk4hARWMEqc7ljEBOF8YZR4+2Y1G0iV
        kMBnRolth5hhOu5sn8YCUbScUaLx6Reojo+MEt33zoNV8QrYSUxZcoEFxGYRUJX4u+krVFxQ
        4uTMJ2BxUYEkibn77oHFhQVCJTYuusAEYjMLiEvcejIfbKiIQDeTxOlV+8CK2AQMJbredoGd
        xCngJrFu1mJmiAZ5ie1v5zCDNEgI7OGQWLdwISPErS4Sd9fuZoOwhSVeHd/CDmHLSJye3AN0
        BQeQnS/xd4YxRLhC4trrNVBvWkvcOfeLDaSEWUBTYv0ufYiwo8TcWzOYITr5JG68FYS4gE9i
        0rbpUGFeiY42IYhqNYlZx9fB7Tx44RLUcA+Jtt332SYwKs5CCpRZSJ6fheSvWQg3LGBkWcUo
        nlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYYE7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4f2y
        OyNJiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1NNQKXS
        5/dPQqakHP8pmbrvzimT4+qXS/v51eeUsfqEzg1xf8jCK6jK8val7X/rbbN8Vf2z3W6+vpzY
        cLhNTGVxx8kZVeoiEsqHN3DYPsgulKpp6Px/7EPG5wN5xct5Pc7oSzdaCPhHXtln6MJwLDM4
        zt0l59Ta78KHU6zvCDt07HdVT3x6XTjlrtb0sHltf2N2yRn2vRZWOp7aIZjB9e+sZcIXlYwl
        7X/vcx3/1pAQuOl2gpRxZAhrSdXmuqdCnBPyJS62L+wQP2OkpLZX9W/50WkXRJ/sX8zLP3X1
        dn/jvtWTbkUxx7lWPqtxTEx/of+h/Hx9ZdgyqYi7b5792xvN2X3vXvFTxV0FH98zKbEUZyQa
        ajEXFScCADwCXpqfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7oa8TlJBp9+81uc3v+OxaJ58Xo2
        i72vt7JbXN41h82i+bySxdY9B5gc2DzuXNvD5rF/7hp2j8+b5AKYo/RsivJLS1IVMvKLS2yV
        og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyLp34w1zQblCxdMsyxgbGp2pd
        jJwcEgImEne2T2MBsYUEljJKnF7uABGXkTg5rYEVwhaW+HOti62LkQuo5j2jRPes3WAJXgE7
        iSlLLoA1swioSvzd9JUZIi4ocXLmE7C4qECSxIttzxlBbGGBUImNiy4wgdjMAuISt57MZwIZ
        KiLQyyRxcMkbqA1XGSWW7tsBVsUmYCjR9RZkNScHp4CbxLpZi5khus0kurZ2MULY8hLb385h
        nsAoOAvJ8llIlsxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgfGz7djPzTsY
        5736qHeIkYmD8RCjBAezkgjvl90ZSUK8KYmVValF+fFFpTmpxYcYTYEhMJFZSjQ5HxjBeSXx
        hmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTBvXB2zSC/BYrWT4R/Xy
        4+dcyZKnXZfeaLkqK6Y4+cIDn8OfWr/eeHJqb13sb5UgwZPtt7okQqWjBFY7rjqWV3PhgnxJ
        ucWDFdOWT1asNCwO/Jm77cm1k/XTrUPjvSQ7f/zUe9jXGMzPO2NGzf5Gy/79kRJbJ4kf0978
        5K5W2kfR9Xf7dp6SYCo9uIrbfzaPyFONLRFHuzbu2jsjUmie1c8Xk98X36v+kvdL5bj+7Ulb
        pKbd3sFU/tdD0v552dXdB5ZJLdol+L/Xjb9gW5CBnDbrV3+tSayrnEq5XIP4v+ddDKtn+qtm
        sPuuir2Gxdb2orOW3y8Ide7lMlvRk9fANvPilSWtXs1CVWrqIbIT9iuxFGckGmoxFxUnAgAd
        HO30KAMAAA==
X-CMS-MailID: 20220429215656eucas1p28b290e1a8b4eb96d78bdad84163b9b6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220429195958eucas1p11ae281abca3e039a337cf46be15d8b86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220429195958eucas1p11ae281abca3e039a337cf46be15d8b86
References: <20220429195946.1061725-1-krzysztof.kozlowski@linaro.org>
        <CGME20220429195958eucas1p11ae281abca3e039a337cf46be15d8b86@eucas1p1.samsung.com>
        <20220429195946.1061725-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.2022 21:59, Krzysztof Kozlowski wrote:
> driver_set_override() helper uses device_lock() so it should not be
> called before rpmsg_register_device() (which calls device_register()).
> Effect can be seen with CONFIG_DEBUG_MUTEXES:
>
>    DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>    WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582 __mutex_lock+0x1ec/0x430
>    ...
>    Call trace:
>     __mutex_lock+0x1ec/0x430
>     mutex_lock_nested+0x44/0x50
>     driver_set_override+0x124/0x150
>     qcom_glink_native_probe+0x30c/0x3b0
>     glink_rpm_probe+0x274/0x350
>     platform_probe+0x6c/0xe0
>     really_probe+0x17c/0x3d0
>     __driver_probe_device+0x114/0x190
>     driver_probe_device+0x3c/0xf0
>     ...
>
> Refactor the rpmsg_register_device() function to use two-step device
> registering (initialization + add) and call driver_set_override() in
> proper moment.
>
> This moves the code around, so while at it also NULL-ify the
> rpdev->driver_override in error path to be sure it won't be kfree()
> second time.
>
> Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Commit SHA from linux-next - Greg's tree.
> ---
>   drivers/rpmsg/rpmsg_core.c     | 33 ++++++++++++++++++++++++++++++---
>   drivers/rpmsg/rpmsg_internal.h | 14 +-------------
>   drivers/rpmsg/rpmsg_ns.c       | 14 +-------------
>   include/linux/rpmsg.h          |  8 ++++++++
>   4 files changed, 40 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 95fc283f6af7..4938fc4eff00 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -593,24 +593,51 @@ static struct bus_type rpmsg_bus = {
>   	.remove		= rpmsg_dev_remove,
>   };
>   
> -int rpmsg_register_device(struct rpmsg_device *rpdev)
> +/*
> + * A helper for registering rpmsg device with driver override and name.
> + * Drivers should not be using it, but instead rpmsg_register_device().
> + */
> +int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> +				   const char *driver_override)
>   {
>   	struct device *dev = &rpdev->dev;
>   	int ret;
>   
> +	if (driver_override)
> +		strcpy(rpdev->id.name, driver_override);
> +
>   	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
>   		     rpdev->id.name, rpdev->src, rpdev->dst);
>   
>   	rpdev->dev.bus = &rpmsg_bus;
>   
> -	ret = device_register(&rpdev->dev);
> +	device_initialize(dev);
> +	if (driver_override) {
> +		ret = driver_set_override(dev, &rpdev->driver_override,
> +					  driver_override,
> +					  strlen(driver_override));
> +		if (ret) {
> +			dev_err(dev, "device_set_override failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = device_add(dev);
>   	if (ret) {
> -		dev_err(dev, "device_register failed: %d\n", ret);
> +		dev_err(dev, "device_add failed: %d\n", ret);
> +		kfree(rpdev->driver_override);
> +		rpdev->driver_override = NULL;
>   		put_device(&rpdev->dev);
>   	}
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL(rpmsg_register_device_override);
> +
> +int rpmsg_register_device(struct rpmsg_device *rpdev)
> +{
> +	return rpmsg_register_device_override(rpdev, NULL);
> +}
>   EXPORT_SYMBOL(rpmsg_register_device);
>   
>   /*
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 3e81642238d2..a22cd4abe7d1 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -94,19 +94,7 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
>    */
>   static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
>   {
> -	int ret;
> -
> -	strcpy(rpdev->id.name, "rpmsg_ctrl");
> -	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
> -				  rpdev->id.name, strlen(rpdev->id.name));
> -	if (ret)
> -		return ret;
> -
> -	ret = rpmsg_register_device(rpdev);
> -	if (ret)
> -		kfree(rpdev->driver_override);
> -
> -	return ret;
> +	return rpmsg_register_device_override(rpdev, "rpmsg_ctrl");
>   }
>   
>   #endif
> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> index 8eb8f328237e..c70ad03ff2e9 100644
> --- a/drivers/rpmsg/rpmsg_ns.c
> +++ b/drivers/rpmsg/rpmsg_ns.c
> @@ -20,22 +20,10 @@
>    */
>   int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
>   {
> -	int ret;
> -
> -	strcpy(rpdev->id.name, "rpmsg_ns");
> -	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
> -				  rpdev->id.name, strlen(rpdev->id.name));
> -	if (ret)
> -		return ret;
> -
>   	rpdev->src = RPMSG_NS_ADDR;
>   	rpdev->dst = RPMSG_NS_ADDR;
>   
> -	ret = rpmsg_register_device(rpdev);
> -	if (ret)
> -		kfree(rpdev->driver_override);
> -
> -	return ret;
> +	return rpmsg_register_device_override(rpdev, "rpmsg_ns");
>   }
>   EXPORT_SYMBOL(rpmsg_ns_register_device);
>   
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 20c8cd1cde21..523c98b96cb4 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -165,6 +165,8 @@ static inline __rpmsg64 cpu_to_rpmsg64(struct rpmsg_device *rpdev, u64 val)
>   
>   #if IS_ENABLED(CONFIG_RPMSG)
>   
> +int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> +				   const char *driver_override);
>   int rpmsg_register_device(struct rpmsg_device *rpdev);
>   int rpmsg_unregister_device(struct device *parent,
>   			    struct rpmsg_channel_info *chinfo);
> @@ -192,6 +194,12 @@ ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>   
>   #else
>   
> +static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> +						 const char *driver_override)
> +{
> +	return -ENXIO;
> +}
> +
>   static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
>   {
>   	return -ENXIO;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

