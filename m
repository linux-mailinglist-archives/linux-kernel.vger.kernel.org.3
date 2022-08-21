Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487C859B522
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiHUPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C161CB14;
        Sun, 21 Aug 2022 08:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B86B60F04;
        Sun, 21 Aug 2022 15:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BB5C433C1;
        Sun, 21 Aug 2022 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661096508;
        bh=93PclUVO1BVNqwydjTRtUJajm+fIYY5f8aL+MFhY4to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh78gCvtJcinyu+SuOhYYnq7P2u5/x1paSdyeGjHH2ZBSlWcGH4mrsMeq+AvwLBdr
         Spwf/5jc0sO/95NeOtLsgM/ViQyXMsUwmNkRHx2GYEL/kjCDMCnz+FrmaHvd0yjdEJ
         z7pcD/oG8QMkTrPUtYjjeclTUP6+taedShSJAo/s6I2hnV5IcEjdsJKCQv9wfUJy3o
         hCm/QA2Q9enMNny1zRD0hWjH00zKsRtf/DHEQQj95wiVn59AhV1RmNz2o0M+9Lp8bq
         Ir1bU/7ssG7d9xd9R3SZ9wljjiz+jbZJXWn67Pxj9fPEPaFyGydb1IsA6n+HqmGHf2
         edMwEO20sqHFw==
Received: by pali.im (Postfix)
        id 9CA3B828; Sun, 21 Aug 2022 17:41:45 +0200 (CEST)
Date:   Sun, 21 Aug 2022 17:41:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (dell-smm) Fail probing when cooling device
 registration fails
Message-ID: <20220821154145.v7da76besv2qzqhj@pali>
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821151713.11198-2-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 August 2022 17:17:11 Armin Wolf wrote:
> Previously, it was thought that failing to register a cooling device
> would not be critical, so the probing was not aborted in such a case.
> This however would lead to userspace being unable to rely on those
> cooling devices, since they might not represent all fans being present.
> Fix that by failing probing when cooling device registration fails.

This patch does not fix address this issue fully. CONFIG_THERMAL can be
disabled during compile time and then cooling device would not be
registered too.

> Tested on a Dell Inspiron 3505.
> 
> Fixes: e0d3f7cb2606 ("hwmon: (dell-smm) Add cooling device support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 7f8d95dd2717..1dab7591576a 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1013,12 +1013,10 @@ static int __init dell_smm_init_hwmon(struct device *dev)
> 
>  		data->fan[i] = true;
> 
> -		/* the cooling device is not critical, ignore failures */
>  		if (IS_REACHABLE(CONFIG_THERMAL)) {
>  			err = dell_smm_init_cdev(dev, i);
>  			if (err < 0)
> -				dev_warn(dev, "Failed to register cooling device for fan %u\n",
> -					 i + 1);
> +				return err;
>  		}
> 
>  		data->fan_nominal_speed[i] = devm_kmalloc_array(dev, data->i8k_fan_max + 1,
> --
> 2.30.2
> 
