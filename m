Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7B529F48
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbiEQKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbiEQKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:18:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238738DB3;
        Tue, 17 May 2022 03:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 703BCB8179C;
        Tue, 17 May 2022 10:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3611AC385B8;
        Tue, 17 May 2022 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652782647;
        bh=PCtKPg+A7aw+WZhiBLKRgYNLuap3imxl4feEQ8tnkJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrQm0WeRZjhhgDHcqE261YARlXN8htL6onH8c+x05t3UsRRsc7AlPxQuiHMItv/k/
         S07j1/kUYSdMqDHevnmu7iayWHQam8VTgVJoLo3atvaiHdhNdYP9nSCwjZPn3v2x4k
         N0ldfp+pxgVKBscSNKyRCYTwWK+FpG0rEMyWybNk=
Date:   Tue, 17 May 2022 12:17:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaochao49@huawei.com
Subject: Re: [PATCH -next] tty: serial: max3100: Add missing
 uart_unregister_driver in max3100_probe
Message-ID: <YoN2L5B6PE5pJU7c@kroah.com>
References: <20220511071523.3128725-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511071523.3128725-1-zhengbin13@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:15:23PM +0800, Zheng Bin wrote:
> max3100_probe misses a call uart_unregister_driver in error path,
> this patch fixes that.
> 
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  drivers/tty/serial/max3100.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 0b5f21fbb53d..6d34ca2a3f7b 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -752,6 +752,7 @@ static int max3100_probe(struct spi_device *spi)
>  		if (!max3100s[i])
>  			break;
>  	if (i == MAX_MAX3100) {
> +		uart_unregister_driver(&max3100_uart_driver);
>  		dev_warn(&spi->dev, "too many MAX3100 chips\n");
>  		mutex_unlock(&max3100s_lock);
>  		return -ENOMEM;
> @@ -759,6 +760,7 @@ static int max3100_probe(struct spi_device *spi)
> 
>  	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
>  	if (!max3100s[i]) {
> +		uart_unregister_driver(&max3100_uart_driver);
>  		dev_warn(&spi->dev,
>  			 "kmalloc for max3100 structure %d failed!\n", i);
>  		mutex_unlock(&max3100s_lock);

As Jiri said, this change would break the existing devices that are
registered with this driver.

How did you test this change?  What tool found this?  How was it
verified?

thanks,

greg k-h
