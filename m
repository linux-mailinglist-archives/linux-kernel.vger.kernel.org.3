Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF9579545
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiGSIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiGSIdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F18730F57;
        Tue, 19 Jul 2022 01:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382EB61784;
        Tue, 19 Jul 2022 08:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA8C341C6;
        Tue, 19 Jul 2022 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219592;
        bh=z1LzE70cPNQsqpra2mY+nHzyu/ROdNvbnYE3LasHjb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KLFIrmnjnTZrtjEgjsVQj4d6RtyGAIa2+Z1oQ/4UQVXumayhm2ITQRwg9IRFMg1TK
         b1OtQNIGACk/AFh9Ebsw8K5tlVrK2h3x4yA6K7tsBfMQ77+9BGTEem2BkoIOzNt8dR
         ztIbzWeFZTOk3heCZT/K7LFe7rB78mWsEFxYOd9luKnvxYJofA7xOQ+F6lxVICkw1v
         CRsgasaFfOvMMFPl8lTc+kLiL/m3pi7rP2Ww1LsOJMgGavYVZNMeHxeB97S7etjqPf
         5OvgJTm4Hh9XvA3/r7N1OLBFeO0gz6opfNbfV2BhZ5a3w3cUapa8scAzmR5CyjPA2T
         0sAipM1LsqEjw==
Date:   Tue, 19 Jul 2022 09:43:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: isl29028: Fix the warning in
 isl29028_remove()
Message-ID: <20220719094309.4811f385@jic23-huawei>
In-Reply-To: <20220717004241.2281028-1-zheyuma97@gmail.com>
References: <20220717004241.2281028-1-zheyuma97@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 08:42:41 +0800
Zheyu Ma <zheyuma97@gmail.com> wrote:

> The driver use the non-managed form of the register function in
> isl29028_remove(). To keep the release order as mirroring the ordering
> in probe, the driver should use non-managed form in probe, too.
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
As I'm doing one last pull request before the merge window, I've applied
this to the togreg branch of iio.git and marked it for stable.

Thanks,

Jonathan

> ---
> Changes in v2:
>     - Use the non-managed form to register the device
> ---
>  drivers/iio/light/isl29028.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 9de3262aa688..a62787f5d5e7 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -625,7 +625,7 @@ static int isl29028_probe(struct i2c_client *client,
>  					 ISL29028_POWER_OFF_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
>  
> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
>  			"%s(): iio registration failed with error %d\n",

