Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40078553491
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiFUOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiFUOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:33:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D717585;
        Tue, 21 Jun 2022 07:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6948CB81817;
        Tue, 21 Jun 2022 14:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57C1C3411D;
        Tue, 21 Jun 2022 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655822005;
        bh=JYrLpERtN5LzOmO2YH5CtQSk8rM2T/YTYKNbWl0hAtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZpc974jigr8blzNaQR+GCYzCfAXB7D7nnVJ+txJ66DPrFx2kyPs0XuTbblsRM8hG
         vXQk0i+yMcycm2xmFJUH2tFNxx/WRld5aAKGycVRYTHI9ePzW+tbDP+z3NwRXPsBVX
         MkpNlOd+H1wNqn7T47nDMfENWBg1v+1ShQZCwGIQ=
Date:   Tue, 21 Jun 2022 16:33:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: sysfs: convert sysfs snprintf to sysfs_emit
Message-ID: <YrHWsiwEh3YouRWo@kroah.com>
References: <20220613023553.103441-1-zhangxuezhi1@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613023553.103441-1-zhangxuezhi1@coolpad.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:35:53AM +0800, Xuezhi Zhang wrote:
> Fix the following coccicheck warnings:
> drivers/usb/core/sysfs.c:921:8-16:
> WARNING: use scnprintf or sprintf
> drivers/usb/core/sysfs.c:730:8-16:
> WARNING: use scnprintf or sprintf

Please do not wrap error or warning messages.

> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
> v2: add correct public mailing list
> ---
>  drivers/usb/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index fa2e49d432ff..6387c0dfe30e 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct usb_device *usb_dev = to_usb_device(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
> +	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
>  }
>  
>  /*
> @@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
>  	struct usb_hcd *hcd;
>  
>  	hcd = bus_to_hcd(usb_bus);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
> +	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
>  }

Any specific reason you are not fixing up all sysfs show entries in this
file?  Only doing a few feels odd and wrong, please do the whole file at
once.

thanks,

greg k-h
