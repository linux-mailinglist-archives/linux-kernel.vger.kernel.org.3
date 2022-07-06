Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3256917F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiGFSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbiGFSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961EF9FCF;
        Wed,  6 Jul 2022 11:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 309C261FF9;
        Wed,  6 Jul 2022 18:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321B0C341CA;
        Wed,  6 Jul 2022 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657131237;
        bh=sM4TNspEX9Bff5U2v6ScPqfbpzsVCvLpxc6cCswvR+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHN6NwqrZXoSMRvausUD8YF0N65d3qV3Qi+voMdwY8Cx1Z+KnC4MDMaMW7pTAeRKp
         OprBQXVZ/SFWYMl0FOsOFRb5dU9dY4BPuC+ly4MMTBTrXHTXlpUJVm9Evb9L/RJZV0
         PJl3lHGuOyXGf2tkZ21vZfXmn/c/6EALarXXsvmU=
Date:   Wed, 6 Jul 2022 20:13:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        balbi@kernel.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <YsXQ4hFDVjO+xm3s@kroah.com>
References: <20220706174634.20639-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706174634.20639-1-mdevaev@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 08:46:34PM +0300, Maxim Devaev wrote:
> It allows to reset prevent_medium_removal flag and "eject" the image.
> 
> The patch is a completely alternative implementation of the previously
> proposed [1], the idea of which was born after the mentioned discussion.
> 
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> Link: https://lore.kernel.org/lkml/20220406092445.215288-1-mdevaev@gmail.com [1]
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 25 ++++++++++++++++++++
>  drivers/usb/gadget/function/storage_common.c | 11 +++++++++
>  drivers/usb/gadget/function/storage_common.h |  2 ++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 6ad669dde41c..00cac2a38178 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2520,10 +2520,21 @@ static ssize_t file_store(struct device *dev, struct device_attribute *attr,
>  	return fsg_store_file(curlun, filesem, buf, count);
>  }
>  
> +static ssize_t forced_eject_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct fsg_lun		*curlun = fsg_lun_from_dev(dev);
> +	struct rw_semaphore	*filesem = dev_get_drvdata(dev);
> +
> +	return fsg_store_forced_eject(curlun, filesem, buf, count);
> +}
> +
>  static DEVICE_ATTR_RW(nofua);
>  /* mode wil be set in fsg_lun_attr_is_visible() */
>  static DEVICE_ATTR(ro, 0, ro_show, ro_store);
>  static DEVICE_ATTR(file, 0, file_show, file_store);
> +static DEVICE_ATTR_WO(forced_eject);

You have to document sysfs files in Documentation/ABI/ in order for us
to be able to accept them.

thanks,

greg k-h
