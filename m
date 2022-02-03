Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745E4A8704
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbiBCOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiBCOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:53:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B957BC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:53:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so10291832pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qnnOceM2maKM4v0lSRw1xHTuBRgkTs7X+4u4TyFAGI=;
        b=mT8FyMffjwgFEfqNqfaAAgc08iUgWtx+YD3f3kKE2K+Upcs7PoWqjbbpFft36lFMot
         LkFLa9Q3+EEppuvpEzQzm6EOG5tB09kXhqabBoTbN9RYqUlMDPBTYB86QbLXjRW8gssh
         eiVinT+twyHtBQEfeRpzhYD/VG8mJaKn/SDmoQDOpBUCmJ7UzoLi+h/czKtdzhrmnS2r
         FhpLXur1gQk1lhyINuKNA3lAGDiReE7ADi3PR3erNA2jkrfbRNx6zORBU+fCfW7e/slj
         HhAFIK24SRSEPmXPRGB9/wMmivMzSk+RmUYzx2suoMZXfQGwHiEa3lr87W8xP7uN5QEM
         6Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qnnOceM2maKM4v0lSRw1xHTuBRgkTs7X+4u4TyFAGI=;
        b=q9L29b7jN2iH6ya70/Y39rK6jWbI6McrBBy29EjX6F+CPhd+jMq2Gv/Fsu9fyWIRgm
         lrhG4rIwlPmNFM10jGqqn+zFp8XXHrqrqSRCxFsH9JSDMYqpAtZ8revpWOS7hdClAMYB
         8Ye3SQgXG/V8lWSrBOiOi80xHp3kJE5tcoBZRszaIUmjuIZAn4RXdsrmyJSf9vuFJwND
         AhYSgAYYN1JuttsaaHmGZ/pyJa+50hwMmtwZPKiC58G8+oc0O3qQlZjZaiIHBNre7Quw
         tNAAI7c5fIziOBpXM4JNfakUqsQ1n+3D/8qn5pnmFLY/p4EJ1GDKzVKta8oqroXvtjxr
         f92A==
X-Gm-Message-State: AOAM5311P7NE9mRVmhyLx6XsLZyuGJBKB/fto/IiHXXoSJuM9lMQ1fBw
        qGUO2wMndKtw78/exTor+w8S
X-Google-Smtp-Source: ABdhPJxH+6KG3W9j50KVO7amcvvAvn/n7C/+nUlj7xSU1j/h/OoVhmEVNEidAm5IlJgkUZLD+ImB0g==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr35765124pls.114.1643899997166;
        Thu, 03 Feb 2022 06:53:17 -0800 (PST)
Received: from thinkpad ([117.217.179.179])
        by smtp.gmail.com with ESMTPSA id g17sm11817434pfj.148.2022.02.03.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:53:16 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:23:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] bus: mhi: ep: Add support for registering MHI
 endpoint client drivers
Message-ID: <20220203145309.GE6298@thinkpad>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-7-manivannan.sadhasivam@linaro.org>
 <06628c19-7839-2719-3263-7ab2b4410502@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06628c19-7839-2719-3263-7ab2b4410502@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:27:33PM -0600, Alex Elder wrote:
> On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> > This commit adds support for registering MHI endpoint client drivers
> > with the MHI endpoint stack. MHI endpoint client drivers binds to one
> > or more MHI endpoint devices inorder to send and receive the upper-layer
> > protocol packets like IP packets, modem control messages, and diagnostics
> > messages over MHI bus.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/bus/mhi/ep/main.c | 85 +++++++++++++++++++++++++++++++++++++++
> >   include/linux/mhi_ep.h    | 53 ++++++++++++++++++++++++
> >   2 files changed, 138 insertions(+)
> > 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index db664360c8ab..ce0f99f22058 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -193,9 +193,88 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
> >   }
> >   EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
> > +static int mhi_ep_driver_probe(struct device *dev)
> > +{
> > +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> > +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
> > +	struct mhi_ep_chan *ul_chan = mhi_dev->ul_chan;
> > +	struct mhi_ep_chan *dl_chan = mhi_dev->dl_chan;
> > +
> 
> Either ul_chan or dl_chan must be set, right?  Check this.
> Otherwise I think this looks OK.
> 

done

> 					-Alex
> 
> > +	if (ul_chan)
> > +		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
> > +
> > +	if (dl_chan)
> > +		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
> > +
> > +	return mhi_drv->probe(mhi_dev, mhi_dev->id);
> > +}
> 
> . . .
