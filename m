Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A305E557629
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiFWJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFWJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA046B3B;
        Thu, 23 Jun 2022 02:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D84D61D6A;
        Thu, 23 Jun 2022 09:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19652C3411B;
        Thu, 23 Jun 2022 09:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655974914;
        bh=fT+IJvgPZNzB/PLxHleWMdWWCTFeEP1+X+n7+wANHeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtzNcfU389jSKDXr8ShHzMatCuDDaYfwgjwE/2ALel8Fj77b+9CjUPutqCVN8ghxO
         HNLS4O8Q5GI7hp9kmmRB+CAWVFlhlvRBO2QbjBl4YqxI5fw4F44YXJNTZzy4Lt27n4
         +CpPUrClPmWBIQd3iX3biBrKoHwHyxhUyVL+VMbI=
Date:   Thu, 23 Jun 2022 11:01:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v4 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <YrQr/3URWsdowov9@kroah.com>
References: <20220623061452.40732-1-yekai13@huawei.com>
 <20220623061452.40732-3-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623061452.40732-3-yekai13@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:14:51PM +0800, Kai Ye wrote:
> Update documentation describing sysfs node that could help to
> configure isolation method command for users in th user space.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-uacce | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> index 08f2591138af..8784efa96e01 100644
> --- a/Documentation/ABI/testing/sysfs-driver-uacce
> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> @@ -19,6 +19,24 @@ Contact:        linux-accelerators@lists.ozlabs.org
>  Description:    Available instances left of the device
>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>  
> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> +Date:           Jun 2022
> +KernelVersion:  5.20
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A sysfs node that used to configures the hardware error
> +                isolation method command. The command can be parsed
> +                in correct driver. e.g. If the device slot reset frequency
> +                exceeds the preset value in a time window, the device will be
> +                isolated.

What is the "command"?  What is being parsed?  This needs to be
documented a lot more here, this is very vague and not obvious at all.


> +
> +What:           /sys/class/uacce/<dev_name>/isolate
> +Date:           Jun 2022
> +KernelVersion:  5.20
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A sysfs node that show the device isolated state. The value 0
> +                means that the device is working. The value 1 means that the
> +                device has been isolated.

Are these read-only?  Write only?  read/write?

thanks,

greg k-h
