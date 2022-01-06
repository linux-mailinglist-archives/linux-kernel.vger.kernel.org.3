Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80055486580
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiAFNsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiAFNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:48:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C529C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 05:48:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B6861671
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F6C36AE0;
        Thu,  6 Jan 2022 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641476908;
        bh=PgXH7pcqFif2gxuO4rbqz6wSChAqn48shM3SxiUmUc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUJB1LC8OdYWaAtdDetmhNfk9T2fupxPyVFah2O2U6xNY2GZHUzo5HhF6PQh2c+XI
         HGrOMeuAefThvEGXv94w1C7ybvtmytGnZOZoMKVmq/YqNLf0JjFCAS0XXKUxZD5jQN
         URWn4SoDy6rBXCMMuuxlFqsTTcJA2l/GLryptexg=
Date:   Thu, 6 Jan 2022 14:48:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: vc04_services: rename macros
 BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
Message-ID: <YdbzKaKQW7N04QgA@kroah.com>
References: <cover.1641414449.git.gascoar@gmail.com>
 <d450b9e22e5ab335a61591dbf0d2104031c9fc46.1641414449.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d450b9e22e5ab335a61591dbf0d2104031c9fc46.1641414449.git.gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 05:35:47PM -0300, Gaston Gonzalez wrote:
> In the kernel, all names related to the chip BCM2835 are always named
> bcm2835_*. To avoid confusion, and to make things more consistent,
> rename the macros BM2835_MMAL_VERSION and BM2835_MMAL_MODULE_NAME
> accordingly.
> 
> While at it, some realignments were made to improve readability.
> 
> Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---
>  .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index aaf529f2186c..c729b1b7de71 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -33,8 +33,8 @@
>  #include "mmal-parameters.h"
>  #include "bcm2835-camera.h"
>  
> -#define BM2835_MMAL_VERSION "0.0.2"
> -#define BM2835_MMAL_MODULE_NAME "bcm2835-v4l2"
> +#define BCM2835_MMAL_VERSION "0.0.2"

MODULE_VERSION means nothing when the code is in the kernel tree, this
shold just be removed entirely.

> +#define BCM2835_MMAL_MODULE_NAME "bcm2835-v4l2"

KBUILD_MODULE_NAME provides this, please delete this and just use that
instead.

This can be 2 different commits because of this.

thanks,

greg k-h
