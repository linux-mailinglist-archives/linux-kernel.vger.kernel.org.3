Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9008497828
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiAXE1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiAXE1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:27:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A1C06173B;
        Sun, 23 Jan 2022 20:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B0560C5B;
        Mon, 24 Jan 2022 04:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B0AC340E1;
        Mon, 24 Jan 2022 04:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642998462;
        bh=bu82sJ+NjeI3uuIOGsgPoe/ycAxxYC9Q8Zij5mql5gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVPWgMTA02LQv8gB3uq7owgnzrPNGUiCM4YT3xgA77kT6KA3hA+SQD6QN0msD/Hhh
         bnxZRUK+WooyMo9annjlUjtKlHUuMVzljUt9X02FV+yeuGeHfADMz0bMXp/tJ3dTaN
         UEkj7/W6wPcOIhyawaXAdMj67OENQNURc59pzr3gBez7deoSmd7ZxCo5Ok5JDFxJ0m
         U6ys6+KAfHCd2gqMENcXlc9LumQlcsyNP4OfXmPdY1N6IQEvHZxvTb8p2SCyNhMNWQ
         MpwxXqdzMwf//SxFa3MvBz98MdB29y4NdAh5HNeTeXTGcPYrd8IYgUJH5ZExpI0nnN
         mSzKOSaLraSGg==
Date:   Mon, 24 Jan 2022 09:57:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: phy: qcom: ipq806x-usb: conver latch
 function to pool macro
Message-ID: <Ye4qujlrcfxPTy2j@matsya>
References: <20220117002641.26773-1-ansuelsmth@gmail.com>
 <20220117002641.26773-2-ansuelsmth@gmail.com>
 <Ye1BcvaneH0sWeQV@matsya>
 <61ed6a44.1c69fb81.35728.5e8b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ed6a44.1c69fb81.35728.5e8b@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-22, 15:46, Ansuel Smith wrote:
> On Sun, Jan 23, 2022 at 05:22:18PM +0530, Vinod Koul wrote:
> > On 17-01-22, 01:26, Ansuel Smith wrote:
> > > Convert latch function to readl pool macro to tidy things up.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> > > index 6788e0e8272a..ab2d1431546d 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> > > @@ -112,6 +112,9 @@
> > >  #define SS_CR_READ_REG				BIT(0)
> > >  #define SS_CR_WRITE_REG				BIT(0)
> > >  
> > > +#define LATCH_SLEEP				40
> > > +#define LATCH_TIMEOUT				100
> > > +
> > >  struct usb_phy {
> > >  	void __iomem		*base;
> > >  	struct device		*dev;
> > > @@ -156,19 +159,9 @@ static inline void usb_phy_write_readback(struct usb_phy *phy_dwc3,
> > >  
> > >  static int wait_for_latch(void __iomem *addr)
> > >  {
> > > -	u32 retry = 10;
> > > -
> > > -	while (true) {
> > > -		if (!readl(addr))
> > > -			break;
> > 
> > we break if read returns non zero value...
> > 
> > Do you know what is the value expected?
> >
> 
> If I understand the logic here, we write a value and we wait for it to
> get applied. To confirm that we execute a writel and then we readl the
> same address until it does return a value. That is the way used to
> understand that the write process has finished and that the value has
> been applied/we can write again.
> 
> > > -
> > > -		if (--retry == 0)
> > > -			return -ETIMEDOUT;
> > > -
> > > -		usleep_range(10, 20);
> > > -	}
> > > +	u32 val;
> > 
> > Okay this contains garbage..
> 
> I think I didn't understand, val value will get replaced by readl in
> the pool_timeout function.
> 
> > >  
> > > -	return 0;
> > > +	return readl_poll_timeout(addr, val, !val, LATCH_SLEEP, LATCH_TIMEOUT);
> > 
> > and we are waiting for it read a garbage value!
> > 
> 
> Again could be very confused and wrong but the pool_timeout macro does
> the exact same thing of the wait_for_latch function with th only
> difference of handling the sleep differently. We put in val the return
> of readl and the break condition as !val. Or I didn't understand the
> concern about garbage value.

Sorry I read the readl_poll_timeout wrongly, this seems correct, I will
pick these now.

-- 
~Vinod
