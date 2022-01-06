Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06B1485D29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbiAFA3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbiAFA2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:28:11 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B938C0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:28:10 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id de30so1188452qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=eDrDfVNJVUtQdzTJNWlse2IvObCGLXp2kWh28tXrL8o=;
        b=RSLo/d0J1YVtTDPWc/lVoI5hUUIy4sHkZU1TXS7F2wu+H+rLS1Uzdbs57830ps3N1l
         0I6rcKjK5d7JBegdfttVTqfTD1gEbKDb1mNvEASB4+Iy/jJjCskS3DqpVD7SzscWFdZi
         OTHCRMRn+scI89emzQ+DpBDwnN2h6b9gA6dsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=eDrDfVNJVUtQdzTJNWlse2IvObCGLXp2kWh28tXrL8o=;
        b=V/zVLLJpErBNKJeQGxmDrIogIdTpf5O0xIn/G+Jf5lRDoIkWuBdl2Wg9auEqnmSKKh
         7t6IwnhNwYmKW8Hwz0uAuVoZxWBzduvmlUDEYguR8z7Jeh+vnFUqfhljD034hIK9J/67
         Oj6QAOS22+vYQdAbWOKa22E7oMVqa7JzLZii7lb2LVA0At8T+akkDpqhk6FsithfSha3
         ZsZdEJ0GfYpKoIo6KWyjnYwBZkmw1mY4fAQXPDmBAUmU02yvHRXeTQiRQQw4EBRcyD6b
         CDO688FG6871RoCLzTBmFZyKoqR+wPnTmXXAO+De20SlOcNripq2uMZ66mCK56Fi4EGV
         7u3w==
X-Gm-Message-State: AOAM533aGzVUmLJ4Lm69t8H+AOivJUuK4VLwe8rpF2OrIV6KIr/RYNKo
        JFe4/WgDvODEALYyqsR5O8w23rAYGzJVdw==
X-Google-Smtp-Source: ABdhPJzF7IuKCqHgfU7kvUYEPysREFPXgllBSZQ4/StdK+CHeoh5NbYL/bCdVDvQy4WKJwbOnqkGIg==
X-Received: by 2002:a37:d205:: with SMTP id f5mr40443950qkj.698.1641428889749;
        Wed, 05 Jan 2022 16:28:09 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id j16sm370802qtx.92.2022.01.05.16.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 16:28:09 -0800 (PST)
Message-ID: <08a3b725-d211-b363-a3b4-2a325367b976@ieee.org>
Date:   Wed, 5 Jan 2022 18:28:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 07/20] bus: mhi: ep: Add support for creating and
 destroying MHI EP devices
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-8-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
In-Reply-To: <20211202113553.238011-8-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> This commit adds support for creating and destroying MHI endpoint devices.
> The MHI endpoint devices binds to the MHI endpoint channels and are used
> to transfer data between MHI host and endpoint device.
> 
> There is a single MHI EP device for each channel pair. The devices will be
> created when the corresponding channels has been started by the host and
> will be destroyed during MHI EP power down and reset.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/ep/main.c | 85 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index ce0f99f22058..f0b5f49db95a 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -63,6 +63,91 @@ static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl)
>   	return mhi_dev;
>   }
>   
> +static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
> +{
> +	struct mhi_ep_device *mhi_dev;
> +	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
> +	int ret;
> +
> +	mhi_dev = mhi_ep_alloc_device(mhi_cntrl);
> +	if (IS_ERR(mhi_dev))
> +		return PTR_ERR(mhi_dev);
> +
> +	mhi_dev->dev_type = MHI_DEVICE_XFER;

Elsewhere (at least in mhi_ep_process_tre_ring()) in your code
you assume that the even-numbered channel is UL.

I would say, either use that assumption throughout, or do
not use that assumption at all.  (I prefer the latter.)

I don't really like how this assumes that the channels
are defined in adjacent pairs.  It assumes one is
upload and the next one is download, but doesn't
specify the order in which they're defined.  If
you're going to assume they are defined in pairs, you
should be able to assume which one is defined first,
and then simplify this code (and even verify that
they are defined UL before DL, perhaps).

> +	/* Configure primary channel */
> +	if (mhi_chan->dir == DMA_TO_DEVICE) {
> +		mhi_dev->ul_chan = mhi_chan;
> +		mhi_dev->ul_chan_id = mhi_chan->chan;
> +	} else {
> +		mhi_dev->dl_chan = mhi_chan;
> +		mhi_dev->dl_chan_id = mhi_chan->chan;
> +	}
> +
> +	get_device(&mhi_dev->dev);
> +	mhi_chan->mhi_dev = mhi_dev;
> +
> +	/* Configure secondary channel as well */
> +	mhi_chan++;
> +	if (mhi_chan->dir == DMA_TO_DEVICE) {
> +		mhi_dev->ul_chan = mhi_chan;
> +		mhi_dev->ul_chan_id = mhi_chan->chan;
> +	} else {
> +		mhi_dev->dl_chan = mhi_chan;
> +		mhi_dev->dl_chan_id = mhi_chan->chan;
> +	}
> +
> +	get_device(&mhi_dev->dev);
> +	mhi_chan->mhi_dev = mhi_dev;
> +
> +	/* Channel name is same for both UL and DL */

You could verify the two channels indeed have the
same name.

					-Alex

> +	mhi_dev->name = mhi_chan->name;
> +	dev_set_name(&mhi_dev->dev, "%s_%s",
> +		     dev_name(&mhi_cntrl->mhi_dev->dev),
> +		     mhi_dev->name);
> +
> +	ret = device_add(&mhi_dev->dev);
> +	if (ret)
> +		put_device(&mhi_dev->dev);
> +
> +	return ret;
> +}
> +
> +static int mhi_ep_destroy_device(struct device *dev, void *data)
> +{
> +	struct mhi_ep_device *mhi_dev;
> +	struct mhi_ep_cntrl *mhi_cntrl;
> +	struct mhi_ep_chan *ul_chan, *dl_chan;
> +
> +	if (dev->bus != &mhi_ep_bus_type)
> +		return 0;
> +
> +	mhi_dev = to_mhi_ep_device(dev);
> +	mhi_cntrl = mhi_dev->mhi_cntrl;
> +
> +	/* Only destroy devices created for channels */
> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		return 0;
> +
> +	ul_chan = mhi_dev->ul_chan;
> +	dl_chan = mhi_dev->dl_chan;
> +
> +	if (ul_chan)
> +		put_device(&ul_chan->mhi_dev->dev);
> +
> +	if (dl_chan)
> +		put_device(&dl_chan->mhi_dev->dev);
> +
> +	dev_dbg(&mhi_cntrl->mhi_dev->dev, "Destroying device for chan:%s\n",
> +		 mhi_dev->name);
> +
> +	/* Notify the client and remove the device from MHI bus */
> +	device_del(dev);
> +	put_device(dev);
> +
> +	return 0;
> +}
> +
>   static int parse_ch_cfg(struct mhi_ep_cntrl *mhi_cntrl,
>   			const struct mhi_ep_cntrl_config *config)
>   {
> 

