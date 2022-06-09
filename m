Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5385544619
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbiFIIjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbiFIIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6231231
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E62A26192F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE2EC34114;
        Thu,  9 Jun 2022 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654763922;
        bh=MmIroiLl5n7oTiTKtxR5dvlyJHURVgdGQ646QdB2dXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwG2ZIS1E54jX+PUKqKJ+3i3Lg3kVNia7JwBBBzIvUI4Qm+lY0nTNBKvN8O61Y5RX
         9S2QARD1fCJ5Ojtzvj0Y8emnX6uwQq5kvdTv3I1OdEUC5ujnZ1fN2BbqNctA2k3aiY
         5cXZMNk49LIpRT6Rn6V4tFRe1FbehEUUYPPVAyNA=
Date:   Thu, 9 Jun 2022 10:38:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     jirislaby@kernel.org, fseidel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: nozomi: Return an error when failing to create the
 sysfs
Message-ID: <YqGxjwLHxaXG/646@kroah.com>
References: <20220609083133.4120738-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609083133.4120738-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 04:31:33PM +0800, Zheyu Ma wrote:
> The driver does not handle the error of the creation of sysfs, resulting
> in duplicate file names being created.
> 
> The following log can reveal it:
> 
> [   52.907211] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:05.0/card_type'

How is the same file being created in a normal codepath?

Is the same device being registered twice somehow?

> [   52.907224] Call Trace:
> [   52.907269]  sysfs_add_file_mode_ns+0x23f/0x2b0
> [   52.907281]  sysfs_create_file_ns+0xe9/0x170
> [   52.907321]  nozomi_card_init+0x97f/0x12c0 [nozomi]
> 
> Fix this bug by returning an error when failing to create the sysfs.
> 
> Fixes: 20fd1e3bea55 ("nozomi driver")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/tty/nozomi.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index 0454c78deee6..d0ad1b9898f5 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -1282,14 +1282,26 @@ static ssize_t open_ttys_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(open_ttys);
>  
> -static void make_sysfs_files(struct nozomi *dc)
> +static int make_sysfs_files(struct nozomi *dc)
>  {
> -	if (device_create_file(&dc->pdev->dev, &dev_attr_card_type))
> +	int err;
> +
> +	err = device_create_file(&dc->pdev->dev, &dev_attr_card_type);

Drivers shouldn't be calling this function anyway, it's a race
condition.  How about switching this to use the proper device groups
functionality instead which moves all of the handling of the sysfs files
to the driver core so that the driver can not get it wrong?

That should solve the error handling case.  The fact that this is trying
to be created twice is a symptom of a worse problem here.  How are you
duplicating this?

thanks,

greg k-h
