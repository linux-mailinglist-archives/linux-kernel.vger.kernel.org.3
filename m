Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111B46D538
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhLHOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:11:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58544 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbhLHOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:11:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6814EB8210D;
        Wed,  8 Dec 2021 14:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883AAC00446;
        Wed,  8 Dec 2021 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638972475;
        bh=6Fmc/O6IWh4KKiblSsLfPo3G5MJCj6eVA7GE+x9omuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUmag+9mNSiymWKwgDU6vNUcMMbCtppZ8KkmGiqIG+gHFI5fN6ZFZtJt2UB9utSKq
         yZar2z4iCNOkNiiOwZJ87EBaEKnl3rYVtdO2AENxbNUTOMmhOncaSNutG7eDrNIiMG
         OvjsLVhFDYZsZx7mZg0iEIVcJCb01m+pr1GODB8o=
Date:   Wed, 8 Dec 2021 15:07:51 +0100
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
Message-ID: <YbC8N/Y1Z0CJbWnY@kroah.com>
References: <20211208080816.43351-1-hanyihao@vivo.com>
 <AJgA9gCdE-A6eTTRwvPvy4qL.9.1638951289781.Hmail.hanyihao@vivo.com.@PFliQnBjSkxVUVVZSHlnR01Aa3JvYWguY29tPg==>
 <a0f8b64e-7086-b23a-acc6-dd3255d33fc7@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f8b64e-7086-b23a-acc6-dd3255d33fc7@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:03:30PM +0800, Yihao Han wrote:
> 
> 
> On 2021/12/8 16:14, Greg Kroah-Hartman wrote:
> > On Wed, Dec 08, 2021 at 12:07:53AM -0800, Yihao Han wrote:
> > > coccinelle report:
> > > ./drivers/bus/mhi/core/init.c:97:8-16:
> > > WARNING: use scnprintf or sprintf
> > > Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> > > 
> > > Signed-off-by: Yihao Han <hanyihao@vivo.com>
> > > ---
> > >   drivers/bus/mhi/core/init.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> > > index 5aaca6d0f52b..a5a5c722731e 100644
> > > --- a/drivers/bus/mhi/core/init.c
> > > +++ b/drivers/bus/mhi/core/init.c
> > > @@ -94,7 +94,7 @@ static ssize_t serial_number_show(struct device *dev,
> > >   	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > >   	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> > > -	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
> > > +	return sysfs_emit(buf, "Serial Number: %u\n",
> > >   			mhi_cntrl->serial_number);
> > >   }
> > >   static DEVICE_ATTR_RO(serial_number);
> > > -- 
> > > 2.17.1
> > > 
> > 
> > Why are you only changing one function in this file?  If you realyl want
> > to make a change like this, fix ALL sysfs show functions.
> > 
> > thanks,
> > 
> > greg k-h
> Because "sysfs_emit()" is "scnprintf()" equivalent with "size" parameter
> equals to PAGE_SIZE,So sysfs_emit can only be used here in this file. And
> "scnprintf" is better than "snprintf" because the former returns number of
> characters written to "buf". So I think we can use "sysfs_emit()" instead of
> "snprintf()".

I am not disagreeing with changing this at all that is is incorrect.  I
am complaining that you are only changing ONE of the functions in this
file and not ALL of them.  If this type of change is so important to
make, please do it for all places it is needed in the file, and in all
of the drivers/bus/mhi/ code.

thanks,

greg k-h
