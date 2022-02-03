Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4574D4A8760
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351717AbiBCPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351694AbiBCPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:13:40 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:13:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so4151428pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODbvf1Ryrte+WtyXtkFy4143hA54VvL0jc79zCOMbQM=;
        b=Xpqy2kEoGwLDC0mCgToEY8c8KliIw3idiUMi1ofIlZm5VtTFRQykgcvaq58u/9/z7/
         1z2D6Pp5D4I3IjQXPC/4BU85LhwCCtr5h6P2EJTBhuojlrnkbPrcIOCnrwvMVnEK8QWZ
         G8WJlEEbag51npuNt4EwyeGaK9XiT6KIRL8qAMe8b4huksbwm0YZrdZwzGsjJ+RQtADu
         xZZX2L5v7wcTW4lGB5OKkFiYuaXhl7UVzbm3bTcd9CjoGe8m7TWvcT9dsyvigIYwLcts
         TdGJgdL4BRdIL7pi0KsjfRBLAj/t2wCNaB11EVMQCYyr5/7Q94lCs2Zq1+wnesiQ8XUZ
         rOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODbvf1Ryrte+WtyXtkFy4143hA54VvL0jc79zCOMbQM=;
        b=Is/thAYN8lPdNtID1rOOGaCFr7SXWnxjiqmk5iskQrkh/yhhNocQbQsUWyoQeXe9wU
         4uNcbCxQRP1dRvtNiSmuVcIrGtME/cDhJLQYyHDYAy36TKRAV1h5rfC+8zX8byMNl5er
         s7Q2KCT+WPpmwodeaiiBCbNMSCUGQYDVvbCTdwR1IbPPB2xuZLiKtoUmbAjTp/s2cELh
         /EhOjQ7SII8AqAyYs2ectkkqz6F1iMvUYM8JFTDdH7StBxU1wVjGHR0Uk/azE/dMq8OV
         /OtabHYZeEnIVsqPf0Tyo5/tKxAYzxQcrBLENJxTRlEGxkyqRC1f9eB9RRYcN38z+T9i
         u+3g==
X-Gm-Message-State: AOAM533NNVA8YLekKiS9rb4ZES0+bYltUv5BRuls48UG1s5wR6ZXaLJ+
        ZcjQDmpWTwdvanYHGHRgxUHB
X-Google-Smtp-Source: ABdhPJxXaBOJ7l5/8YGUfcYE3/XIkm967Wz6CW1H6z+lH490LRb4Td71zcb83YXBKH2gRBpFTXy6lg==
X-Received: by 2002:a17:902:ced2:: with SMTP id d18mr36412629plg.21.1643901219339;
        Thu, 03 Feb 2022 07:13:39 -0800 (PST)
Received: from thinkpad ([117.217.179.179])
        by smtp.gmail.com with ESMTPSA id n42sm28977548pfv.29.2022.02.03.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:13:38 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:43:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/20] bus: mhi: ep: Add support for creating and
 destroying MHI EP devices
Message-ID: <20220203151331.GF6298@thinkpad>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-8-manivannan.sadhasivam@linaro.org>
 <08a3b725-d211-b363-a3b4-2a325367b976@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a3b725-d211-b363-a3b4-2a325367b976@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:28:08PM -0600, Alex Elder wrote:
> On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> > This commit adds support for creating and destroying MHI endpoint devices.
> > The MHI endpoint devices binds to the MHI endpoint channels and are used
> > to transfer data between MHI host and endpoint device.
> > 
> > There is a single MHI EP device for each channel pair. The devices will be
> > created when the corresponding channels has been started by the host and
> > will be destroyed during MHI EP power down and reset.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/bus/mhi/ep/main.c | 85 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 85 insertions(+)
> > 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index ce0f99f22058..f0b5f49db95a 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -63,6 +63,91 @@ static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl)
> >   	return mhi_dev;
> >   }
> > +static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
> > +{
> > +	struct mhi_ep_device *mhi_dev;
> > +	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
> > +	int ret;
> > +
> > +	mhi_dev = mhi_ep_alloc_device(mhi_cntrl);
> > +	if (IS_ERR(mhi_dev))
> > +		return PTR_ERR(mhi_dev);
> > +
> > +	mhi_dev->dev_type = MHI_DEVICE_XFER;
> 
> Elsewhere (at least in mhi_ep_process_tre_ring()) in your code
> you assume that the even-numbered channel is UL.
> 
> I would say, either use that assumption throughout, or do
> not use that assumption at all.  (I prefer the latter.)
> 
> I don't really like how this assumes that the channels
> are defined in adjacent pairs.  It assumes one is
> upload and the next one is download, but doesn't
> specify the order in which they're defined.  If
> you're going to assume they are defined in pairs, you
> should be able to assume which one is defined first,
> and then simplify this code (and even verify that
> they are defined UL before DL, perhaps).
> 

Yes, the UL channel is always even numbered and DL is odd.
I've removed the checks.

> > +	/* Configure primary channel */
> > +	if (mhi_chan->dir == DMA_TO_DEVICE) {
> > +		mhi_dev->ul_chan = mhi_chan;
> > +		mhi_dev->ul_chan_id = mhi_chan->chan;
> > +	} else {
> > +		mhi_dev->dl_chan = mhi_chan;
> > +		mhi_dev->dl_chan_id = mhi_chan->chan;
> > +	}
> > +
> > +	get_device(&mhi_dev->dev);
> > +	mhi_chan->mhi_dev = mhi_dev;
> > +
> > +	/* Configure secondary channel as well */
> > +	mhi_chan++;
> > +	if (mhi_chan->dir == DMA_TO_DEVICE) {
> > +		mhi_dev->ul_chan = mhi_chan;
> > +		mhi_dev->ul_chan_id = mhi_chan->chan;
> > +	} else {
> > +		mhi_dev->dl_chan = mhi_chan;
> > +		mhi_dev->dl_chan_id = mhi_chan->chan;
> > +	}
> > +
> > +	get_device(&mhi_dev->dev);
> > +	mhi_chan->mhi_dev = mhi_dev;
> > +
> > +	/* Channel name is same for both UL and DL */
> 
> You could verify the two channels indeed have the
> same name.
> 

done.

Thanks,
Mani
