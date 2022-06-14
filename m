Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8B54B1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiFNMnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiFNMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F148255B6;
        Tue, 14 Jun 2022 05:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A77B861614;
        Tue, 14 Jun 2022 12:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C5EC3411B;
        Tue, 14 Jun 2022 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655210515;
        bh=PVxCLrvTt74M1i6WSvd6jeGlE9dym9J9yAAEAD0ZhHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ceAo9+hN/CmiFu0PZCdYLgNOZhHZQUkmTuNMjt7UwDjMYvAiJj6pGfXBPMroepni
         WmQ6m2/lfSIvt3ejYuarhirtvfnoRgC+PTyfxKuG/oHI7sppKkEO88R/z4t5UQYmZm
         uFFFxb2wwOeGdCFOIOBcRo139zqvl5wXFtC970uw=
Date:   Tue, 14 Jun 2022 14:41:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 2/3] Documentation: add a isolation strategy vfs node
 for uacce
Message-ID: <YqiCEHTauCoceNNI@kroah.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-3-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614122943.1406-3-yekai13@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:29:39PM +0800, Kai Ye wrote:
> Update documentation describing DebugFS that could help to
> configure hard error frequency for users in th user space.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-uacce | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> index 08f2591138af..0c4226364182 100644
> --- a/Documentation/ABI/testing/sysfs-driver-uacce
> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> @@ -19,6 +19,23 @@ Contact:        linux-accelerators@lists.ozlabs.org
>  Description:    Available instances left of the device
>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>  
> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> +Date:           Jun 2022
> +KernelVersion:  5.19
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A vfs node that used to configures the hardware

What is a "vfs node"?

> +                error frequency. This frequency is abstract. Like once an hour
> +                or once a day. The specific isolation strategy can be defined in
> +                each driver module.

No, you need to be specific here and describe the units and the format.
Otherwise it is no description at all :(

> +
> +What:           /sys/class/uacce/<dev_name>/isolate
> +Date:           Jun 2022
> +KernelVersion:  5.19

5.19 will not have this change.

> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    A vfs node that show the device isolated state. The value 0
> +                means that the device is working. The value 1 means that the
> +                device has been isolated.

What does "working" or "isolated" mean?

thanks,

greg k-h
