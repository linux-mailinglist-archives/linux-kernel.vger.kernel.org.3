Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE6509E70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388803AbiDULYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388780AbiDULYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:24:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDA2BB35;
        Thu, 21 Apr 2022 04:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5A27B82431;
        Thu, 21 Apr 2022 11:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68112C385A7;
        Thu, 21 Apr 2022 11:21:47 +0000 (UTC)
Message-ID: <733c4775-777d-b0cd-83b6-934fecb1475e@xs4all.nl>
Date:   Thu, 21 Apr 2022 13:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: imx-jpeg: Encoder support to set jpeg quality
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220406094623.7887-1-ming.qian@nxp.com>
 <80bcabe7-5761-7244-c6ea-1b5893395170@oss.nxp.com>
 <AM6PR04MB63412692BEAA7D9A81071368E7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <AM6PR04MB63412692BEAA7D9A81071368E7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 12:04, Ming Qian wrote:
>> From: Mirela Rabulea (OSS)
>> Sent: Thursday, April 14, 2022 5:42 PM
>> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de
>> Cc: hverkuil-cisco@xs4all.nl; kernel@pengutronix.de; festevam@gmail.com;
>> dl-linux-imx <linux-imx@nxp.com>; linux-media@vger.kernel.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH] media: imx-jpeg: Encoder support to set jpeg quality
>>
>> Hi Ming,
>>
>> On 06.04.2022 12:46, Ming Qian wrote:
>>> Implement V4L2_CID_JPEG_COMPRESSION_QUALITY to set jpeg quality
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 ++--
>>>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
>>>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 50
>> +++++++++++++++++++
>>>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
>>>   4 files changed, 61 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> index 29c604b1b179..c482228262a3 100644
>>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> @@ -100,9 +100,6 @@ void mxc_jpeg_enc_mode_conf(struct device *dev,
>>> void __iomem *reg)
>>>
>>>   	/* all markers and segments */
>>>   	writel(0x3ff, reg + CAST_CFG_MODE);
>>> -
>>> -	/* quality factor */
>>> -	writel(0x4b, reg + CAST_QUALITY);
>>>   }
>>>
>>>   void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg) @@
>>> -114,6 +111,14 @@ void mxc_jpeg_enc_mode_go(struct device *dev, void
>> __iomem *reg)
>>>   	writel(0x140, reg + CAST_MODE);
>>>   }
>>>
>>> +void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg,
>>> +u8 quality) {
>>> +	dev_dbg(dev, "CAST Encoder Quality %d...\n", quality);
>>> +
>>> +	/* quality factor */
>>> +	writel(quality, reg + CAST_QUALITY); }
>>> +
>>>   void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg)
>>>   {
>>>   	dev_dbg(dev, "CAST Decoder GO...\n"); diff --git
>>> a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
>>> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
>>> index ae70d3a0dc24..356e40140987 100644
>>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
>>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
>>> @@ -119,6 +119,7 @@ int mxc_jpeg_enable(void __iomem *reg);
>>>   void wait_frmdone(struct device *dev, void __iomem *reg);
>>>   void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg);
>>>   void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg);
>>> +void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg,
>>> +u8 quality);
>>>   void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg);
>>>   int mxc_jpeg_get_slot(void __iomem *reg);
>>>   u32 mxc_jpeg_get_offset(void __iomem *reg, int slot); diff --git
>>> a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> index 0c3a1efbeae7..ccc26372e178 100644
>>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> @@ -624,6 +624,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void
>> *priv)
>>>   	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
>>>   		ctx->enc_state = MXC_JPEG_ENCODING;
>>>   		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
>>> +		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);
>>
>> I think the setting of the quality should be moved in device_run, to keep the
>> interrupt handler lean, I checked it works fine after:
>> dev_dbg(dev, "Encoder config finished. Start encoding...\n");
>>
> 
> Considering the multi-slot situation, the quality register is a global register for all slots.
> So to avoid access it in the same time by different slots. It's safe to set after configure done but before encode.
> And we only support yet, but I think we will support multi slots after we fix some issues.
> 
> 
>>>   		mxc_jpeg_enc_mode_go(dev, reg);
>>>   		goto job_unlock;
>>>   	}
>>> @@ -1563,6 +1564,44 @@ static void mxc_jpeg_set_default_params(struct
>> mxc_jpeg_ctx *ctx)
>>>   	}
>>>   }
>>>
>>> +static int mxc_jpeg_s_ctrl(struct v4l2_ctrl *ctrl) {
>>> +	struct mxc_jpeg_ctx *ctx =
>>> +		container_of(ctrl->handler, struct mxc_jpeg_ctx, ctrl_handler);
>>> +
>>> +	switch (ctrl->id) {
>>> +	case V4L2_CID_JPEG_COMPRESSION_QUALITY:
>>
>> Looks like this is allowed for decoder, which is not ok, maybe return -EINVAL
>> for decoder.
>>
> 
> This control is created for encoder only, so decoder has no chance to execute here
> 
>>> +		ctx->jpeg_quality = ctrl->val;
>>> +		break;
>>> +	default:
>>> +		dev_err(ctx->mxc_jpeg->dev, "Invalid control, id = %d, val = %d\n",
>>> +			ctrl->id, ctrl->val);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct v4l2_ctrl_ops mxc_jpeg_ctrl_ops = {
>>> +	.s_ctrl = mxc_jpeg_s_ctrl,
>>> +};
>>> +
>>> +static void mxc_jpeg_encode_ctrls(struct mxc_jpeg_ctx *ctx) {
>>> +	v4l2_ctrl_new_std(&ctx->ctrl_handler, &mxc_jpeg_ctrl_ops,
>>> +			  V4L2_CID_JPEG_COMPRESSION_QUALITY, 1, 100, 1, 75);
>>
>> The v4l2_ctrl_new_std may return an error, which is not checked here (NULL is
>> returned and @hdl->error is set...), please fix.
>>
> 
> Almost no driver check the return value of v4l2_ctrl_new_std. except some driver want to change some property of the created ctrl.
> And if it return NULL, it won't bring some serious problems, just not support this control

The typical behavior is to add all controls, then at the end check if
hdl->error was set, and if so, v4l2_ctrl_handler_free is called and
the error is returned.

> 
>>> +}
>>> +
>>> +static int mxc_jpeg_ctrls_setup(struct mxc_jpeg_ctx *ctx) {
>>> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 2);
>>
>> ctrl_handler has a lock member, which could be setup here.
>>
> 
> The lock will be set in v4l2_ctrl_handler_init:
> mutex_init(&hdl->_lock);
> hdl->lock = &hdl->_lock;
> 
>>> +
>>> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
>>> +		mxc_jpeg_encode_ctrls(ctx);

So:

	if (&ctx->ctrl_handler.error) {
		int err = ctx->ctrl_handler.error;
		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
		return err;
	}

Regards,

	Hans

>>> +
>>> +	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
>>> +}
>>> +
>>>   static int mxc_jpeg_open(struct file *file)
>>>   {
>>>   	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file); @@ -1594,6
>>> +1633,12 @@ static int mxc_jpeg_open(struct file *file)
>>>   		goto error;
>>>   	}
>>>
>>> +	ret = mxc_jpeg_ctrls_setup(ctx);
>>> +	if (ret) {
>>> +		dev_err(ctx->mxc_jpeg->dev, "failed to setup mxc jpeg controls\n");
>>> +		goto err_ctrls_setup;
>>> +	}
>>> +	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
>>>   	mxc_jpeg_set_default_params(ctx);
>>>   	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
>>>
>>> @@ -1605,6 +1650,8 @@ static int mxc_jpeg_open(struct file *file)
>>>
>>>   	return 0;
>>>
>>> +err_ctrls_setup:
>>> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>>>   error:
>>>   	v4l2_fh_del(&ctx->fh);
>>>   	v4l2_fh_exit(&ctx->fh);
>>> @@ -1962,6 +2009,8 @@ static int mxc_jpeg_subscribe_event(struct
>> v4l2_fh *fh,
>>>   		return v4l2_event_subscribe(fh, sub, 0, NULL);
>>>   	case V4L2_EVENT_SOURCE_CHANGE:
>>>   		return v4l2_src_change_event_subscribe(fh, sub);
>>> +	case V4L2_EVENT_CTRL:
>>> +		return v4l2_ctrl_subscribe_event(fh, sub);
>>>   	default:
>>>   		return -EINVAL;
>>>   	}
>>> @@ -2035,6 +2084,7 @@ static int mxc_jpeg_release(struct file *file)
>>>   	else
>>>   		dev_dbg(dev, "Release JPEG encoder instance on slot %d.",
>>>   			ctx->slot);
>>> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
>>>   	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>>>   	v4l2_fh_del(&ctx->fh);
>>>   	v4l2_fh_exit(&ctx->fh);
>>> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
>>> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
>>> index 9ae56e6e0fbe..9c9da32b2125 100644
>>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
>>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
>>> @@ -96,6 +96,8 @@ struct mxc_jpeg_ctx {
>>>   	unsigned int			slot;
>>>   	unsigned int			source_change;
>>>   	bool				header_parsed;
>>> +	struct v4l2_ctrl_handler	ctrl_handler;
>>> +	u8				jpeg_quality;
>>>   };
>>>
>>>   struct mxc_jpeg_slot_data {

