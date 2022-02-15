Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8D4B75E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbiBOUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:03:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbiBOUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:03:18 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705379C43
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id w7so25345673ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Bku1Hl5fEkgz+otT988o7TuLWt5dY0nq0/c4iSTdkMc=;
        b=bI4UKeyru4JVpL+f1sb1xj3fyM48nJ/VjjqBqQm8DTqc0JV//6TU28W47RbD351Aca
         Jr3snuiQ8lPidQla1JW+xYeT/5QO5kwjg7Koqa/WmfzQLFoC5yBZF5TqMNsZ9Ju5guKw
         VTs6XaVdUZ+muL4Tjq2t3T1cF0qzekqC7LR/wphZ6SK7IewFzKg7YPY6St89+3HdlcuU
         lmE0VT7f7ol/0zGHTOa4RXYB/6A1UOHgyLXm9N63m+Ymb2lj3LKhs9AXgdY5nAtZyBim
         MqLiP3dgHIMW8lPUiGt8T4Eu1ahm0ngh6cO+F5v3nT0CxSiYUSDtCwekr9bmXkepRXK5
         iP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bku1Hl5fEkgz+otT988o7TuLWt5dY0nq0/c4iSTdkMc=;
        b=IAKGk1YNzHwIZRmvtZV340WC/Gyfo2eJo2FMZKirfxJgloe3eX3XfihuGHBmUBqVuY
         WAH+yW/MgQJjepZH9FChst7oYxJbUaiyTfQBexZ4fRDF0VkRvg3yIT+QbqcuptiA90zA
         i4qDY1xxWIHeBURHSwQv68CW+aSTuOHgsQnnPgv6bCj0zaLA2hayGWSz/Y6lDiNwD6BT
         KVKe4Z62eAR5/fN44k79SqQPt9isVzd/PhkJOzUG60HyfKA7pDQZZPdl5LhiKDxWFMa2
         oCcii4LUABCYwdZgU8eq3i15tIOsSl0V2eUy0eM6ns2PEQIxryRgvqq8Q9QOcFaWs0T0
         B7tg==
X-Gm-Message-State: AOAM5311HdQFKjP99iQc9xq8j2WEnVFXeb6POEi7aaAssjT2KvUea4yF
        jMpUAENf/6Qb8N9akGuhlHAE+Q==
X-Google-Smtp-Source: ABdhPJy8dHbbuYtLRyKXNCvGG8YTuestTDnVDk8gCge6PB3wsVsPXYEmIxpoTIVtMTg2EdDPvC5J5A==
X-Received: by 2002:a6b:b7cf:: with SMTP id h198mr326683iof.166.1644955379353;
        Tue, 15 Feb 2022 12:02:59 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c24sm23651126ioh.40.2022.02.15.12.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:58 -0800 (PST)
Message-ID: <1cdd8e0c-85d7-dd91-a6f1-1390e7854350@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 10/25] bus: mhi: ep: Add support for creating and
 destroying MHI EP devices
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-11-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> This commit adds support for creating and destroying MHI endpoint devices.
> The MHI endpoint devices binds to the MHI endpoint channels and are used
> to transfer data between MHI host and endpoint device.
> 
> There is a single MHI EP device for each channel pair. The devices will be
> created when the corresponding channels has been started by the host and
> will be destroyed during MHI EP power down and reset.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

A few comments again, nothing major.

					-Alex

> ---
>   drivers/bus/mhi/ep/main.c | 77 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index f66404181972..fcaacf9ddbd1 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -67,6 +67,83 @@ static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl,
>   	return mhi_dev;
>   }
>   
> +/*
> + * MHI channels are always defined in pairs with UL as the even numbered
> + * channel and DL as odd numbered one.
> + */

Awesome comment.  And it seems that the channel ID passed
here is even, and that there *must* be a second mhi_chan[]
entry after the one specified.  And UL is also called the
"primary" channel.

> +static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
> +{
> +	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
> +	struct mhi_ep_device *mhi_dev;
> +	int ret;
> +
> +	/* Check if the channel name is same for both UL and DL */
> +	if (strcmp(mhi_chan->name, mhi_chan[1].name))
> +		return -EINVAL;

Maybe log an error to say what's wrong with it?

> +
> +	mhi_dev = mhi_ep_alloc_device(mhi_cntrl, MHI_DEVICE_XFER);
> +	if (IS_ERR(mhi_dev))
> +		return PTR_ERR(mhi_dev);

It looks like the only possible error is no memory, so you could
just have mhi_ep_alloc_device() return NULL.

> +
> +	/* Configure primary channel */
> +	mhi_dev->ul_chan = mhi_chan;
> +	get_device(&mhi_dev->dev);
> +	mhi_chan->mhi_dev = mhi_dev;
> +
> +	/* Configure secondary channel as well */
> +	mhi_chan++;
> +	mhi_dev->dl_chan = mhi_chan;
> +	get_device(&mhi_dev->dev);
> +	mhi_chan->mhi_dev = mhi_dev;
> +
> +	/* Channel name is same for both UL and DL */
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

Aren't they required to supply *both* channels?  Or maybe
it's just required that there are transfer callback functions
for both channels.  Anyway, no need to check for null, because
the creation function guarantees they're both non-null I think.

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

