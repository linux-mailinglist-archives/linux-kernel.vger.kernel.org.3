Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DB4D9D55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiCOOVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbiCOOV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:21:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6E55230
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D41B816A0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0665C340F4;
        Tue, 15 Mar 2022 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647354011;
        bh=5XVDJC7uc13UhWf3yhjqKWWYwUIS5nlOD6GoK/QBfb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7/r29grUn90JowR7b2ja/7MjlF1hugLq6zLA7RNR1hJ4cD03RAJcIqN9/S9JQv3X
         4FCXVg5Er+hai1hZMk6SjJhIQKK7AfYenOP+0OL8XHHye7fZa7oN6ofm2ZgDVeOxIZ
         xra7qphE4DX70v9EBx72BjwWuV/kC4ZR2juYcMEY=
Date:   Tue, 15 Mar 2022 15:20:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Resolve checkpath.pl issues.
Message-ID: <YjCglwPG1rJFp1/x@kroah.com>
References: <Yi/5nEXVmzZrbfbz@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi/5nEXVmzZrbfbz@sckzor-linux.localdomain>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:27:40PM -0400, Charlie Sands wrote:
> This patch remedies the following checkpath.pl issues:
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> + dev_info(&dev->pci->dev, "%s called\n", __func__);
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> + dev_info(&dev->pci->dev, "%s called\n", __func__);
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> + dev_info(&pci->dev, "%s called\n", __func__);
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
>  drivers/staging/rts5208/rtsx.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 5a58dac76c88..643d33b9a239 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -159,8 +159,6 @@ static int command_abort(struct scsi_cmnd *srb)
>  	struct rtsx_dev *dev = host_to_rtsx(host);
>  	struct rtsx_chip *chip = dev->chip;
>  
> -	dev_info(&dev->pci->dev, "%s called\n", __func__);
> -
>  	scsi_lock(host);
>  
>  	/* Is this command still active? */
> @@ -188,8 +186,6 @@ static int device_reset(struct scsi_cmnd *srb)
>  {
>  	struct rtsx_dev *dev = host_to_rtsx(srb->device->host);
>  
> -	dev_info(&dev->pci->dev, "%s called\n", __func__);
> -
>  	return SUCCESS;
>  }
>  
> @@ -968,8 +964,6 @@ static void rtsx_remove(struct pci_dev *pci)
>  {
>  	struct rtsx_dev *dev = pci_get_drvdata(pci);
>  
> -	dev_info(&pci->dev, "%s called\n", __func__);
> -
>  	quiesce_and_remove_host(dev);
>  	release_everything(dev);
>  	pci_release_regions(pci);
> -- 
> 2.35.1
> 
> 

Always test-build your patches.  Applying this change results in a build
failure :(

Please fix up and resend.

thanks,

greg k-h
