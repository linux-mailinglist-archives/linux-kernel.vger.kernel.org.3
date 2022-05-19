Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4F52D97D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiESPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiESPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC12ED;
        Thu, 19 May 2022 08:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CFF61B0B;
        Thu, 19 May 2022 15:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E812DC385AA;
        Thu, 19 May 2022 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652975742;
        bh=0Q6QP0eskYKVTTnuAHEYWq0r6PWR5R4PDnMXnJYu0O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wi3xGE3m4+LfAiwBepGL7lTBwLSEHUhJBCeBlrqW1P3lXU/K2mBwjl7DA2U61QSai
         Ypr9fAo+Aw/qBLqHp6L55JvRAFUBtS9eC3fdGvAZ1HqMCiPsxZ6w+8jCeKawyyPU2c
         9agUkB74YKY9Ww2rWlwunv+v+AXR2kOGu8RwH7O8=
Date:   Thu, 19 May 2022 17:55:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     dbaryshkov@gmail.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: host: ohci-tmio: Fix unchecked return value
 for device_wakeup_enable
Message-ID: <YoZoe3iOJDbd6SJ9@kroah.com>
References: <20220519020434.31575-1-lizhengyu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519020434.31575-1-lizhengyu3@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:04:34AM +0800, Li Zhengyu wrote:
> The return value of device_wakeup_enable() is unchecked, as the result
> usb_remove_hcd() is unreachable even if device_wakeup_enable() is failed.
> 
> Fixes: 78c73414f4f6 ("USB: ohci: add support for tmio-ohci cell")
> 
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---
>  drivers/usb/host/ohci-tmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
> index 49539b9f0e94..8148dc90c066 100644
> --- a/drivers/usb/host/ohci-tmio.c
> +++ b/drivers/usb/host/ohci-tmio.c
> @@ -244,7 +244,7 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
>  	if (ret)
>  		goto err_add_hcd;
>  
> -	device_wakeup_enable(hcd->self.controller);
> +	ret = device_wakeup_enable(hcd->self.controller);
>  	if (ret == 0)
>  		return ret;

But now if there is an error you do not clean up properly, so you have
memory leaks?

How did you test this?

thanks,

greg k-h
