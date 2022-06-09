Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF34B545390
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbiFIR53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiFIR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019F1136
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B58A61BD1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A2C34114;
        Thu,  9 Jun 2022 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654797445;
        bh=XnUopzNoEHUCm8VMx3S4mXgZ/YQq3y9LUi2T1ntwXlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNw2tfBmb4oKVvkWfPnUlr84tMY2HcRcqGQaJSmFb9PxJMIH39X2EBTihQXrBwvgM
         +52B3LjSpJQ7UB7QXH9M/AUBcKCDafLjKTDshSbreeWvu110Sgw2bhd8fihEWs/9WK
         3wjhWJ5MysULwH0CJ3yBUtVPrjZSsAcUHjfMPZSE=
Date:   Thu, 9 Jun 2022 19:57:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Vetter <jvetter@kalrayinc.com>
Cc:     linux-kernel@vger.kernel.org, ysionneau@kalrayinc.com
Subject: Re: [PATCH 2/2] msi: Add sanity check if more than MAX_DEV_MSIS MSIs
 are requested
Message-ID: <YqI0gRCF4YOTnRMi@kroah.com>
References: <20220609153843.1991-1-jvetter@kalrayinc.com>
 <20220609153843.1991-3-jvetter@kalrayinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609153843.1991-3-jvetter@kalrayinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 05:38:43PM +0200, Julian Vetter wrote:
> If a device requests more than MAX_DEV_MSIS the MSI index will collide with
> the devid and might cause Linux to compute twice the same virtual interrupt
> number for two different devices.
> 
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
>  drivers/base/platform-msi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 4b0b2fe3a7ff..627d8f6b83ea 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -40,6 +40,8 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>  {
>  	u32 devid = desc->dev->msi.data->platform_data->devid;
>  
> +	WARN_ON(desc->msi_index >= MAX_DEV_MSIS);

So you just caused a system to reboot if you have panic-on-warn?  What
is someone supposed to do if this is ever hit?  Why can't you handle it
as an error and properly recover instead of just ignoring it?

thanks,

greg k-h
