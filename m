Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2456B39D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiGHHaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiGHHa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:30:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185777B379;
        Fri,  8 Jul 2022 00:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C02F8B82423;
        Fri,  8 Jul 2022 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F9BC341CA;
        Fri,  8 Jul 2022 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657265425;
        bh=DmtD/NXekOmsrRmhM0eIRgArmtKRjx4tlGqa7DQ/weU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oB289QgjD7T/WdzANmrmglVaSDxLIYxdkvkUfxu6Ss+JdHI0LJYfWywXeyVqaFRpr
         w8+8b5u22UJjKkBW5AWEvirj6EmTLttPooucNGd/XwMLnxrPQeV4rnva5m8nPUhK+4
         7BZEKPzfw2fcXJpvQyWUTgCjVgnX9lHhZQqxvuoQ=
Date:   Fri, 8 Jul 2022 09:30:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH v5 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <YsfdDgetpgMzteKt@kroah.com>
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

This is not a "node" it is just a file.


> +                isolation strategy. This strategy is a configured integer value.
> +                The default is 0. The maximum value is 65535. This value
> +                indicates the number of device slot resets per unit time
> +                that your service can tolerate.

I do not understand this, sorry.  What do you mean by "that your service
can tolerate"?

> +
> +What:           /sys/class/uacce/<dev_name>/isolate
> +Date:           Jul 2022
> +KernelVersion:  5.20
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A sysfs node that read the device isolated state. The value 0
> +                means that the device is working. The value 1 means that the
> +                device has been isolated.

So 1 means "not working"?  This seems odd, perhaps you can rephrase this
a bit better?

thanks,

greg k-h
