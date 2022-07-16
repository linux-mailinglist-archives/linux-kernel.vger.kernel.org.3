Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA795770B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGPSTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGPSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:19:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FDCE1E;
        Sat, 16 Jul 2022 11:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30BD3B80C85;
        Sat, 16 Jul 2022 18:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943B1C34115;
        Sat, 16 Jul 2022 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657995536;
        bh=9AbXPRBr5uZ4dK0zA9NCwEvirkJr7WqQ+79fBtM453I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XjAv2iWm7xWVQh2LHkcmBOuXRak21Vg8U7keqOtoUC+Wjq+/f8s70j4W6XTUg04uq
         chxjHeA40+x9BYgsfpc/be0WvIc2iqiPIJD6ZPqPkOj7v5b1ev1IAkcdqqiVUmj5Mp
         BsKMISsMPM+zRPHLreE2Y9sfGvyxZJFvcQr9Mi3Qnn8t0FniUvC5LnWOt1Xpl7QsCi
         Tu/tRLnN6BIBO1krfQ2hNlnWlhvZDhIpzQrmOm7dlbZPvW53hixPGsZHast8MvOjCe
         9VgbdGHMjrDrmi9O7FTs04thXxuK4aQOYMXi5xxMb43fqfq2htzrj1gjoirXkeq6p/
         KpCERiBkRxdhQ==
Date:   Sat, 16 Jul 2022 19:28:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29028: Fix the warning in
 isl29028_remove()
Message-ID: <20220716192850.2becdc44@jic23-huawei>
In-Reply-To: <20220715132909.480548-1-zheyuma97@gmail.com>
References: <20220715132909.480548-1-zheyuma97@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 21:29:09 +0800
Zheyu Ma <zheyuma97@gmail.com> wrote:

> The driver uses managed resource API to register the iio device, so it
> is unnecessarg to unregister the device manually.
> 
> The following log reveals it:
> 
> [   32.374955] isl29028 0-0010: remove
> [   32.376861] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> [   32.377676] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> [   32.379432] RIP: 0010:kernfs_find_and_get_ns+0x28/0xe0
> [   32.385461] Call Trace:
> [   32.385807]  sysfs_unmerge_group+0x59/0x110
> [   32.386110]  dpm_sysfs_remove+0x58/0xc0
> [   32.386391]  device_del+0x296/0xe50
> [   32.386959]  cdev_device_del+0x1d/0xd0
> [   32.387231]  devm_iio_device_unreg+0x27/0xb0
> [   32.387542]  devres_release_group+0x319/0x3d0
> [   32.388162]  i2c_device_remove+0x93/0x1f0
> 
> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Unfortunately the fix still leaves the release order as not mirroring the ordering
in probe.  As such, I think the right fix is to not use devm_iio_device_register()
but rather use the non managed form.

Thanks,

Jonathan
> ---
>  drivers/iio/light/isl29028.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 9de3262aa688..505235903bd8 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -641,8 +641,6 @@ static int isl29028_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct isl29028_chip *chip = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  

