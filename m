Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5775A56B39B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiGHHa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiGHHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E67C183;
        Fri,  8 Jul 2022 00:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2562662581;
        Fri,  8 Jul 2022 07:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEF8C341C0;
        Fri,  8 Jul 2022 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657265451;
        bh=YM5abWNg2tGKSxJB89i/WV2dIVGzmizPdBTihjybm5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPY3fZ+dFcI3zmfDty9fdhxFAmOlf3JlGHXUUEgg+GccZc7z5gt2DcsgE0wlqE61h
         WIZxyaEGCcLg9RCTEbI1GyvvlSTZuDk71hgp2gnmbMOGvorOZ0W4FOAXdfLvPmiGon
         5GmMnxo+nnCFXppmpt2nQx2i1PeniIJ+5VXHePSM=
Date:   Fri, 8 Jul 2022 09:30:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH v5 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <YsfdKcMtgRr4wB3z@kroah.com>
References: <20220708070820.43958-1-yekai13@huawei.com>
 <20220708070820.43958-3-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708070820.43958-3-yekai13@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 03:08:19PM +0800, Kai Ye wrote:
> Update documentation describing sysfs node that could help to
> configure isolation strategy for users in the user space. And
> describing sysfs node that could read the device isolated state.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-uacce | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> index 08f2591138af..a8056271a963 100644
> --- a/Documentation/ABI/testing/sysfs-driver-uacce
> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> @@ -19,6 +19,24 @@ Contact:        linux-accelerators@lists.ozlabs.org
>  Description:    Available instances left of the device
>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>  
> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> +Date:           Jul 2022
> +KernelVersion:  5.20
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A sysfs node that used to configures the hardware error
> +                isolation strategy. This strategy is a configured integer value.
> +                The default is 0. The maximum value is 65535. This value
> +                indicates the number of device slot resets per unit time
> +                that your service can tolerate.
> +
> +What:           /sys/class/uacce/<dev_name>/isolate
> +Date:           Jul 2022
> +KernelVersion:  5.20
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A sysfs node that read the device isolated state. The value 0
> +                means that the device is working. The value 1 means that the
> +                device has been isolated.
> +

You only describe 2 files here, yet your patch had 3 sysfs files.
Please always document everything.

thanks,

greg k-h
