Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DDC4FF090
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiDMHaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiDMHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:30:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934EC3CA59
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 346A4B80C74
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A0C385A4;
        Wed, 13 Apr 2022 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649834880;
        bh=FceGUS5UxBxc0Dc2kBN/cY3kfOQ39VurE+gLc5V/9M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hle5dIkr+vORI47Bjib4y4WRpas9OC4XSMiTwWOQu6Q7d9kfbFgdZyBaeFfoR1gJo
         Mk1gdBMJGok4sb+lE3QCRwN/R4Sz0GsaHb1kShBF6gAW3goOSu4yEKk0myerJLZjpR
         bad72aOcyX5Q5F3cqhvq8evgMx8xOI4ov4Damjw8=
Date:   Wed, 13 Apr 2022 09:27:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: make MAX_UIO_MAPS & MAX_UIO_PORT_REGIONS
 configurable
Message-ID: <YlZ7fQIpXNJSbd+P@kroah.com>
References: <20220413071137.4023184-1-rfried.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413071137.4023184-1-rfried.dev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:11:37AM +0300, Ramon Fried wrote:
> MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS are hard-coded to 5.
> This is not always sufficiant for some drivers.

Why not?  What in-kernel drivers need more than this?

> Make the MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS configurable by
> providing Kconfig int option with the defaut value of 5.

Spelling check?

> 
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  drivers/uio/Kconfig        | 14 ++++++++++++++
>  include/linux/uio_driver.h |  4 ++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 2e16c5338e5b..bc1fe83cec13 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -13,6 +13,20 @@ menuconfig UIO
>  
>  if UIO
>  
> +config UIO_MAX_MAPS
> +	int "Maximum of memory nodes each uio device support(1-128)"

Space before "(" please.

> +	range 1 128
> +	default 5
> +	help
> +	  Maximum memory mapping each uio device can support.

Any hints as to what this means in more detail?

> +
> +config UIO_MAX_PORT_REGIONS
> +	int "Maximum of port regions each uio device support(1-128)"
> +	range 1 128
> +	default 5
> +	help
> +	  Maximum port regions each uio device can support.

Again more detail please.

thanks,

greg k-h
