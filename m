Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECA46CEBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbhLHISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbhLHIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:18:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF41C061574;
        Wed,  8 Dec 2021 00:14:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F13DCE1C4D;
        Wed,  8 Dec 2021 08:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC05AC00446;
        Wed,  8 Dec 2021 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638951284;
        bh=KVsNWqz0LaHuOzAI9G88zVXV9PP8KjnltwvPn55ga7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDFbrJkHWeenBXGlHXNtkemb0nGKWN8nZh0iS2bxJm2Y8LQuK2SqoRet7/M8LrU0W
         I1oGFBN634ZJbswhxXJ888He8WQpkjSNMw40eyGFQm/S/CbjKWA4jsZ8GynDFXWDnw
         HqSctFX5YKeTRhgOBf1u9kEQslCSyyf+vi/2kjlE=
Date:   Wed, 8 Dec 2021 09:14:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Carl Yin <carl.yin@quectel.com>,
        Carl Huang <cjhuang@codeaurora.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] bus: mhi: core: replace snprintf with sysfs_emit
Message-ID: <YbBpcJLUQUYHygGM@kroah.com>
References: <20211208080816.43351-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208080816.43351-1-hanyihao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:07:53AM -0800, Yihao Han wrote:
> coccinelle report:
> ./drivers/bus/mhi/core/init.c:97:8-16:
> WARNING: use scnprintf or sprintf
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/bus/mhi/core/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 5aaca6d0f52b..a5a5c722731e 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -94,7 +94,7 @@ static ssize_t serial_number_show(struct device *dev,
>  	struct mhi_device *mhi_dev = to_mhi_device(dev);
>  	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>  
> -	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
> +	return sysfs_emit(buf, "Serial Number: %u\n",
>  			mhi_cntrl->serial_number);
>  }
>  static DEVICE_ATTR_RO(serial_number);
> -- 
> 2.17.1
> 

Why are you only changing one function in this file?  If you realyl want
to make a change like this, fix ALL sysfs show functions.

thanks,

greg k-h
