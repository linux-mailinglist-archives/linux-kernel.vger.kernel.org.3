Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4E561872
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiF3KmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiF3Klx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CBCE0B2;
        Thu, 30 Jun 2022 03:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B921562249;
        Thu, 30 Jun 2022 10:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D62C34115;
        Thu, 30 Jun 2022 10:39:45 +0000 (UTC)
Message-ID: <570a0a59-b81e-e5ab-83a7-a13b1d3e658e@xs4all.nl>
Date:   Thu, 30 Jun 2022 12:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: media: platform: visconti: Toshiba Visconti Video driver with
 media control framework.
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <TYAPR01MB62015A90154CDC75E6EF39D792F59@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <20220627032009.10250-1-yuji2.ishikawa@toshiba.co.jp>
 <91144047-f07f-0bf4-a2d7-6e36ce140862@xs4all.nl>
 <TYAPR01MB6201643D86153E12C875948892BA9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <TYAPR01MB6201643D86153E12C875948892BA9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 12:15, yuji2.ishikawa@toshiba.co.jp wrote:
> Hi Hans,
> 
> Thank you for your comment.
> I'm very happy to hear that the module design of VIIF driver better makes sense.
> 
>>> - How should I define ID number of vendor specific controls, such as
>> V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_CROP?
>>>   It seems, the standard way is to reserve vendor specific IDs relative to
>> V4L2_CID_USER_BASE.
>>>   Is that mean, vendor specific CID for ioctl(S_EXT_CTRLs) is shared,
>> limited resources among v4l2 drivers?
>>
>> Yes. You reserve a range of controls for use by the driver in
>> include/uapi/linux/v4l2-controls.
>> This is to avoid different drivers from using the same CID, that's not nice.
>>
>> Then in a driver-specific public header you define the CIDs for your driver,
>> including
>> documenting them.
> 
> I understand.
> I checked v4l2-controls.h and found some specific CIDs for H264, VP8, VP9 codecs.
> 
> 
>>> - How should I explain error/inconsistency of video format, resolution, ISP
>> configurations among v4l2 (sub-)devices?
>>>   Because the VIIF HW is not powered when the corresponding /dev/videoX
>> is closed,
>>>   settings from media-ctl and v4l2-ctl are held unchecked,
>>>   therefore, some of inconsistency would be detected at link_validate() call
>> back triggerd by start-streaming.
>>>   Currently, I set EXECUTE_ON_WRITE flag to every vendor specific controls
>> and reject changes when the HW is not powered,
>>>   although I hope there should be better idea.
>>
>> I am not sure I understand your question. I think your issue is that if the
>> VIIF HW is powered down, it also loses its configuration (i.e. control settings).
>> So is the question what to do when it is powered up again? I.e. how to restore
>> the controls?
>>
>> Or am I completely misunderstanding your question?
> 
> I hope I understand standard way to restore control values to HW. My understanding is ....
> * V4l2-controls hold the last value set by userland.
> * On restoration, stored control-value are provided by either of:
>   * Calling __v4l2_ctrl_handler_setup() function

A call to v4l2_ctrl_handler_setup() is typically done when the HW power is resumed,
yes. It will call the s_ctrl op for all controls in the handler, setting the currently
cached value.

>   * Checking each v4l2-ctrl instance.
> 
> This restoration is typically done at v4l2_subdev_video_ops::s_stream callback.
> Visconti5 VIIF HW is surely powered when s_stream is called. No problem.
> 
> My concern is ... if inconsistent set of configurations is provided through v4l2-controls, how drivers can report the error (which control value is not good) to userland.
> 1. when VIIF HW is turned off
> 2. v4l2-cotnrol value is set with v4l2-ctl tool
> 3. s_ctrl callback is called. However, the specified value is not checked completely because VIIF HW is not powered.
>   * Yes I know, this is mainly because of poor implementation of this VIIF driver.

Checking the value should be done in this step. It really shouldn't be necessary
for the hardware to be on to validate the controls. I'm assuming we are talking
about complex compound controls here, not about simple integer etc. controls.

If you have complex dependencies between controls, then try_ctrl may be necessary
to implement (some examples of that exist in drivers/media).

> 4. v4l2-ctl tool returns OK for request (with rough error check)
> 5. VIIF HW is turned on and ioctl(VIDIOC_STREAMON) is called
> 6. control values are restored with __v4l2_ctrl_handler_setup()
> 7. inconsistency among control values are detected when configuring HW.
> 8. ioctl(VIDIOC_STREAMON) fails. And user want to know which control value is not actually good.
> 
> I know the best solution is to detect inconsistency as early as possible, possibly at step 3.
> Is there some good practice to help user understand what the problem is ?
> We can use dev_err() to show detail?

dev_dbg is often used. A debug module parameter that you can turn on is often also helpful:
then you can use 'if (debug) dev_info()'.

The best thing to do is write good documentation.

Regards,

	Hans

> 
> Regards,
> 	Yuji 
> 
>> -----Original Message-----
>> From: Hans Verkuil <hverkuil@xs4all.nl>
>> Sent: Wednesday, June 29, 2022 10:21 PM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Cc: linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: media: platform: visconti: Toshiba Visconti Video driver with media
>> control framework.
>>
>> On 27/06/2022 05:20, Yuji Ishikawa wrote:
>>> Hi, Hans
>>> I'm now re-writing the top layer of Visconti5 video input driver following your
>> suggestions.
>>> I just applied media-controller framework, and implemented (limited number
>> of) compound controlls instead of private ioctls.
>>> Please let me know if this implementation satifies the latest standard of
>> media drivers.
>>>
>>> Here's some description of the driver and the corresponding hardware.
>>> Firstly, Visconti5 SoC video capture subsystem is composed of these units.
>>>
>>> - CSI2RX: receives MIPI CSI-2 signal
>>> - L1 ISP: correction and enhancement to RAW picture
>>> - L2 ISP: undistortion, scaling, up to 2 ROIs
>>> - VDMAC:  integrated to L2ISP, transfer picture to main memory.
>>>
>>> The updated Visconti Video input driver structure is:
>>>
>>> +--------------+       +----------------+       +----------------+
>>> | image sensor | ====> | ISP subdevice  | ====> | Capture device |
>>> +--------------+       +----------------+       +----------------+
>>
>> This design makes much more sense, nice!
>>
>>>
>>> - Image sensor
>>>   - tested with IMX219
>>>   - pad
>>>     - source
>>>       - format: SRGGB10 1920x1080
>>>       - selection
>>>         - crop
>>>         - native
>>> - ISP subdevice
>>>   - corresponds to: CSI2RX, L1ISP, L2ISP
>>>   - pad
>>>     - sink
>>>       - format: the same as sensor::pad::source::format
>>>       - selection
>>>         - crop: the same as format
>>>         - compose: (readonly) intermediate {width, height} derived by
>> undistortion and scaling.
>>>         - compose.bound: (fixed) 8192 x 4096
>>>     - source
>>>       - format: YUV8 for RAW/YUV sensor input, RGB888 for RGB sensor
>> input
>>>       - selection
>>>         - crop: {left, top, width, height} in isp::pad::sink::selection::compose
>>>   - compound controls
>>>     - undistortion and scaling
>>>       - updates isp::pad::sink::selection::compose
>>>     - other approx. 30 vendor specific controls to configure ISP operation
>>> - Capture device
>>>   - corresponds to: VDMAC
>>>   - pad
>>>     - sink: connected to ISP subdevice
>>>
>>> In terms of software implementation, the driver roughly composed of two
>> layers.
>>>
>>> - API layer: to communicate with V4L2 subsystem
>>>   - viif.c
>>>   - viif_capture.c: Capture V4L2 device node
>>>   - viif_isp.c: ISP v4l2 subdevice node
>>>     - viif_ioctl.c: s_ctrl handlers to configure ISP
>>> - HW specific layer: to handle hardware register values
>>>   - hwd_viif_*.[ch]
>>>
>>> Along with re-writing, I got some questions. Do you have rules or practices to
>> resolve them?
>>>
>>> - How should I define ID number of vendor specific controls, such as
>> V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_CROP?
>>>   It seems, the standard way is to reserve vendor specific IDs relative to
>> V4L2_CID_USER_BASE.
>>>   Is that mean, vendor specific CID for ioctl(S_EXT_CTRLs) is shared,
>> limited resources among v4l2 drivers?
>>
>> Yes. You reserve a range of controls for use by the driver in
>> include/uapi/linux/v4l2-controls.
>> This is to avoid different drivers from using the same CID, that's not nice.
>>
>> Then in a driver-specific public header you define the CIDs for your driver,
>> including
>> documenting them.
>>
>>> - How should I explain error/inconsistency of video format, resolution, ISP
>> configurations among v4l2 (sub-)devices?
>>>   Because the VIIF HW is not powered when the corresponding /dev/videoX
>> is closed,
>>>   settings from media-ctl and v4l2-ctl are held unchecked,
>>>   therefore, some of inconsistency would be detected at link_validate() call
>> back triggerd by start-streaming.
>>>   Currently, I set EXECUTE_ON_WRITE flag to every vendor specific controls
>> and reject changes when the HW is not powered,
>>>   although I hope there should be better idea.
>>
>> I am not sure I understand your question. I think your issue is that if the
>> VIIF HW is powered down, it also loses its configuration (i.e. control settings).
>> So is the question what to do when it is powered up again? I.e. how to restore
>> the controls?
>>
>> Or am I completely misunderstanding your question?
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>> I hope I'm not on the wrong way of re-writing.
>>>
>>> Regards,
>>> 	Yuji
>>>
>>> ---
>>> Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
>>> The Video Input Interface includes CSI2 receiver, frame grabber and image
>> signal processor.
>>>
>>> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
>>> ---
>>>  drivers/media/platform/visconti/Makefile      |   1 +
>>>  drivers/media/platform/visconti/viif.c        | 491 +++++++++
>>>  .../media/platform/visconti/viif_capture.c    | 948
>> +++++++++++++++++
>>>  drivers/media/platform/visconti/viif_ioctl.c  | 287 ++++++
>>>  drivers/media/platform/visconti/viif_isp.c    | 968
>> ++++++++++++++++++
>>>  5 files changed, 2695 insertions(+)
>>>  create mode 100644 drivers/media/platform/visconti/viif.c
>>>  create mode 100644 drivers/media/platform/visconti/viif_capture.c
>>>  create mode 100644 drivers/media/platform/visconti/viif_ioctl.c
>>>  create mode 100644 drivers/media/platform/visconti/viif_isp.c
>>>
>>> diff --git a/drivers/media/platform/visconti/Makefile
>> b/drivers/media/platform/visconti/Makefile
>>> index d27da611a..11d80aeb3 100644
>>> --- a/drivers/media/platform/visconti/Makefile
>>> +++ b/drivers/media/platform/visconti/Makefile
>>> @@ -3,6 +3,7 @@
>>>  # Makefile for the Visconti video input device driver
>>>  #
>>>
>>> +visconti-viif-objs = viif.o viif_capture.o viif_ioctl.o viif_isp.o
>>>  visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o hwd_viif_l1isp.o
>>>
>>>  obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
>>> diff --git a/drivers/media/platform/visconti/viif.c
>> b/drivers/media/platform/visconti/viif.c
>>> new file mode 100644
>>> index 000000000..ac778d6ab
>>> --- /dev/null
>>> +++ b/drivers/media/platform/visconti/viif.c
>>> @@ -0,0 +1,491 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +/* Toshiba Visconti Video Capture Support
>>> + *
>>> + * (C) Copyright 2022 TOSHIBA CORPORATION
>>> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of_graph.h>
>>> +#include <linux/platform_device.h>
>>> +#include <media/v4l2-fwnode.h>
>>> +
>>> +#include "viif.h"
>>> +
>>> +#define VIIF_ISP_GUARD_START(viif_dev)
>> \
>>> +	do
>> {
>>                 \
>>> +
>> 	hwd_VIIF_isp_disable_regbuf_auto_transmission(viif_dev->ch);
>> \
>>> +		ndelay(500);
>> \
>>> +		hwd_VIIF_main_mask_vlatch(viif_dev->ch,
>> HWD_VIIF_ENABLE);                          \
>>> +	} while (0)
>>> +
>>> +#define VIIF_ISP_GUARD_END(viif_dev)
>> \
>>> +	do
>> {
>>                 \
>>> +		hwd_VIIF_main_mask_vlatch(viif_dev->ch,
>> HWD_VIIF_DISABLE);                         \
>>> +		hwd_VIIF_isp_set_regbuf_auto_transmission(viif_dev->ch,
>> VIIF_ISP_REGBUF_0,         \
>>> +
>> VIIF_ISP_REGBUF_0, 0);                   \
>>> +	} while (0)
>>> +
>>> +void viif_hw_on(struct viif_device *viif_dev)
>>> +{
>>> +	hwd_VIIF_initialize(viif_dev->ch, viif_dev->csi2host_reg,
>> viif_dev->capture_reg);
>>> +}
>>> +
>>> +void viif_hw_off(struct viif_device *viif_dev)
>>> +{
>>> +	/* Uninitialize HWD driver */
>>> +	hwd_VIIF_uninitialize(viif_dev->ch);
>>> +}
>>> +
>>> +static inline struct viif_device *v4l2_to_viif(struct v4l2_device *v4l2_dev)
>>> +{
>>> +	return container_of(v4l2_dev, struct viif_device, v4l2_dev);
>>> +}
>>> +
>>> +static struct viif_subdev *to_viif_subdev(struct v4l2_async_subdev *asd)
>>> +{
>>> +	return container_of(asd, struct viif_subdev, asd);
>>> +}
>>> +
>>> +#define VIIF_ERR_M_EVENT_GAMMATBL_SHIFT 8U
>>> +#define VIIF_ERR_M_EVENT_GAMMATBL_MASK	0x7U
>>> +#define VIIF_SYNC_M_EVENT_DELAY2_SHIFT	2U
>>> +#define MAIN_DELAY_INT_ERR_MASK		0x01000000U
>>> +
>>> +extern void visconti_viif_capture_switch_buffer(struct viif_device *viif_dev,
>> uint32_t status_err,
>>> +						uint32_t l2_transfer_status);
>>> +
>>> +static void viif_vsync_irq_handler_w_isp(struct viif_device *viif_dev)
>>> +{
>>> +	uint32_t event_main, event_sub, mask, status_err, l2_transfer_status;
>>> +
>>> +	hwd_VIIF_vsync_irq_handler(viif_dev->ch, &event_main, &event_sub);
>>> +
>>> +	/* Delayed Vsync of MAIN unit */
>>> +	if (((event_main >> VIIF_SYNC_M_EVENT_DELAY2_SHIFT) & 0x1U)
>> == 0x1U) {
>>> +		/* unmask timeout error of gamma table */
>>> +		mask = MAIN_DELAY_INT_ERR_MASK;
>>> +		hwd_VIIF_main_status_err_set_irq_mask(viif_dev->ch,
>> &mask);
>>> +		viif_dev->masked_gamma_path = 0;
>>> +
>>> +		/* Get abort status of L2ISP */
>>> +		VIIF_ISP_GUARD_START(viif_dev);
>>> +		hwd_VIIF_isp_get_info(viif_dev->ch, VIIF_ISP_REGBUF_0,
>> NULL, NULL, NULL,
>>> +				      &l2_transfer_status, NULL, NULL);
>>> +		VIIF_ISP_GUARD_END(viif_dev);
>>> +
>>> +		status_err = viif_dev->status_err;
>>> +		viif_dev->status_err = 0;
>>> +
>>> +		visconti_viif_capture_switch_buffer(viif_dev, status_err,
>> l2_transfer_status);
>>> +	}
>>> +}
>>> +
>>> +static void viif_status_err_irq_handler(struct viif_device *viif_dev)
>>> +{
>>> +	uint32_t event_main, event_sub, val, mask;
>>> +
>>> +	hwd_VIIF_status_err_irq_handler(viif_dev->ch, &event_main,
>> &event_sub);
>>> +
>>> +	if (event_main != 0U) {
>>> +		/* mask for gamma table time out error which will be
>> unmasked in the next Vsync */
>>> +		val = (event_main >>
>> VIIF_ERR_M_EVENT_GAMMATBL_SHIFT) &
>>> +		      VIIF_ERR_M_EVENT_GAMMATBL_MASK;
>>> +		if (val != 0U) {
>>> +			viif_dev->masked_gamma_path |= val;
>>> +			mask = MAIN_DELAY_INT_ERR_MASK |
>>> +			       (viif_dev->masked_gamma_path <<
>> VIIF_ERR_M_EVENT_GAMMATBL_SHIFT);
>>> +
>> 	hwd_VIIF_main_status_err_set_irq_mask(viif_dev->ch, &mask);
>>> +		}
>>> +
>>> +		viif_dev->status_err = event_main;
>>> +	}
>>> +	dev_err(viif_dev->dev, "Status error 0x%x.\n", event_main);
>>> +}
>>> +
>>> +static void viif_csi2rx_err_irq_handler(struct viif_device *viif_dev)
>>> +{
>>> +	uint32_t event;
>>> +
>>> +	event = hwd_VIIF_csi2rx_err_irq_handler(viif_dev->ch);
>>> +	dev_err(viif_dev->dev, "CSI2RX error 0x%x.\n", event);
>>> +}
>>> +
>>> +static irqreturn_t visconti_viif_irq(int irq, void *dev_id)
>>> +{
>>> +	struct viif_device *viif_dev = dev_id;
>>> +	int irq_type = irq - viif_dev->irq[0];
>>> +
>>> +	spin_lock(&viif_dev->lock);
>>> +
>>> +	switch (irq_type) {
>>> +	case 0:
>>> +		viif_vsync_irq_handler_w_isp(viif_dev);
>>> +		break;
>>> +	case 1:
>>> +		viif_status_err_irq_handler(viif_dev);
>>> +		break;
>>> +	case 2:
>>> +		viif_csi2rx_err_irq_handler(viif_dev);
>>> +		break;
>>> +	}
>>> +
>>> +	spin_unlock(&viif_dev->lock);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +/* ----- Async Notifier Operations----- */
>>> +static int visconti_viif_notify_bound(struct v4l2_async_notifier *notifier,
>>> +				      struct v4l2_subdev *v4l2_sd, struct
>> v4l2_async_subdev *asd)
>>> +{
>>> +	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
>>> +	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
>>> +	struct viif_subdev *viif_sd = to_viif_subdev(asd);
>>> +
>>> +	viif_sd->v4l2_sd = v4l2_sd;
>>> +	viif_dev->num_sd++;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void visconti_viif_create_links(struct viif_device *viif_dev)
>>> +{
>>> +	unsigned int source_pad;
>>> +	int ret;
>>> +
>>> +	/* camera subdev pad0 -> isp suddev pad0 */
>>> +	ret = media_entity_get_fwnode_pad(&viif_dev->sd->v4l2_sd->entity,
>>> +					  viif_dev->sd->v4l2_sd->fwnode,
>> MEDIA_PAD_FL_SOURCE);
>>> +	if (ret < 0) {
>>> +		dev_err(viif_dev->dev, "failed to find source pad\n");
>>> +		return;
>>> +	}
>>> +	source_pad = ret;
>>> +
>>> +	ret = media_create_pad_link(&viif_dev->sd->v4l2_sd->entity,
>> source_pad,
>>> +				    &viif_dev->isp_subdev.sd.entity,
>> VIIF_ISP_PAD_SINK,
>>> +				    MEDIA_LNK_FL_ENABLED);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "failed create_pad_link (camera:src ->
>> isp:sink)\n");
>>> +
>>> +	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity,
>> VIIF_ISP_PAD_SRC,
>>> +				    &viif_dev->vdev.entity,
>> VIIF_CAPTURE_PAD_SINK,
>>> +				    MEDIA_LNK_FL_ENABLED);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "failed create_pad_link (isp:src ->
>> camera:sink)\n");
>>> +}
>>> +
>>> +static void visconti_viif_notify_unbind(struct v4l2_async_notifier *notifier,
>>> +					struct v4l2_subdev *subdev, struct
>> v4l2_async_subdev *asd)
>>> +{
>>> +	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
>>> +	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
>>> +	struct viif_subdev *viif_sd = to_viif_subdev(asd);
>>> +
>>> +	v4l2_ctrl_handler_free(&viif_dev->ctrl_handler);
>>> +	v4l2_dev->ctrl_handler = NULL;
>>> +	viif_sd->v4l2_sd = NULL;
>>> +}
>>> +
>>> +static int visconti_viif_notify_complete(struct v4l2_async_notifier *notifier)
>>> +{
>>> +	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
>>> +	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
>>> +	int ret;
>>> +
>>> +	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
>>> +	if (ret < 0) {
>>> +		dev_err(v4l2_dev->dev, "Failed to register subdev nodes\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* Make sure at least one sensor is primary and use it to initialize */
>>> +	if (!viif_dev->sd) {
>>> +		viif_dev->sd = &viif_dev->subdevs[0];
>>> +		viif_dev->sd_index = 0;
>>> +	}
>>> +
>>> +	/* TODO: might need to check if subdev's mbus code is valid for this
>> driver */
>>> +
>>> +	ret = v4l2_ctrl_add_handler(&viif_dev->ctrl_handler,
>> viif_dev->sd->v4l2_sd->ctrl_handler,
>>> +				    NULL, true);
>>> +	if (ret) {
>>> +		dev_err(v4l2_dev->dev, "Failed to add sensor ctrl_handler");
>>> +		return ret;
>>> +	}
>>> +	ret = v4l2_ctrl_add_handler(&viif_dev->ctrl_handler,
>> &viif_dev->isp_subdev.ctrl_handler,
>>> +				    NULL, true);
>>> +	if (ret) {
>>> +		dev_err(v4l2_dev->dev, "Failed to add isp subdev
>> ctrl_handler");
>>> +		return ret;
>>> +	}
>>> +
>>> +	visconti_viif_create_links(viif_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct v4l2_async_notifier_operations viif_notify_ops = {
>>> +	.bound = visconti_viif_notify_bound,
>>> +	.unbind = visconti_viif_notify_unbind,
>>> +	.complete = visconti_viif_notify_complete,
>>> +};
>>> +
>>> +/* ----- Probe and Remove ----- */
>>> +static int visconti_viif_init_async_subdevs(struct viif_device *viif_dev,
>> unsigned int n_sd)
>>> +{
>>> +	/* Reserve memory for 'n_sd' viif_subdev descriptors. */
>>> +	viif_dev->subdevs =
>>> +		devm_kcalloc(viif_dev->dev, n_sd, sizeof(*viif_dev->subdevs),
>> GFP_KERNEL);
>>> +	if (!viif_dev->subdevs)
>>> +		return -ENOMEM;
>>> +
>>> +	/* Reserve memory for 'n_sd' pointers to async_subdevices.
>>> +	 * viif_dev->asds members will point to &viif_dev.asd
>>> +	 */
>>> +	viif_dev->asds = devm_kcalloc(viif_dev->dev, n_sd,
>> sizeof(*viif_dev->asds), GFP_KERNEL);
>>> +	if (!viif_dev->asds)
>>> +		return -ENOMEM;
>>> +
>>> +	viif_dev->sd = NULL;
>>> +	viif_dev->sd_index = 0;
>>> +	viif_dev->num_sd = 0;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int visconti_viif_parse_dt(struct viif_device *viif_dev)
>>> +{
>>> +	struct device_node *of = viif_dev->dev->of_node;
>>> +	struct v4l2_fwnode_endpoint fw_ep;
>>> +	struct viif_subdev *viif_sd;
>>> +	struct device_node *ep;
>>> +	unsigned int i;
>>> +	int num_ep;
>>> +	int ret;
>>> +
>>> +	memset(&fw_ep, 0, sizeof(struct v4l2_fwnode_endpoint));
>>> +
>>> +	num_ep = of_graph_get_endpoint_count(of);
>>> +	if (!num_ep)
>>> +		return -ENODEV;
>>> +
>>> +	ret = visconti_viif_init_async_subdevs(viif_dev, num_ep);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < num_ep; i++) {
>>> +		ep = of_graph_get_endpoint_by_regs(of, 0, i);
>>> +		if (!ep) {
>>> +			dev_err(viif_dev->dev, "No subdevice connected on
>> endpoint %u.\n", i);
>>> +			ret = -ENODEV;
>>> +			goto error_put_node;
>>> +		}
>>> +
>>> +		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep),
>> &fw_ep);
>>> +		if (ret) {
>>> +			dev_err(viif_dev->dev, "Unable to parse endpoint
>> #%u.\n", i);
>>> +			goto error_put_node;
>>> +		}
>>> +
>>> +		if (fw_ep.bus_type != V4L2_MBUS_CSI2_DPHY ||
>>> +		    fw_ep.bus.mipi_csi2.num_data_lanes == 0) {
>>> +			dev_err(viif_dev->dev, "missing CSI-2 properties in
>> endpoint\n");
>>> +			ret = -EINVAL;
>>> +			goto error_put_node;
>>> +		}
>>> +
>>> +		/* Setup the ceu subdevice and the async subdevice. */
>>> +		viif_sd = &viif_dev->subdevs[i];
>>> +		INIT_LIST_HEAD(&viif_sd->asd.list);
>>> +
>>> +		viif_sd->mbus_flags = fw_ep.bus.mipi_csi2.flags;
>>> +		viif_sd->num_lane = fw_ep.bus.mipi_csi2.num_data_lanes;
>>> +		viif_sd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
>>> +		viif_sd->asd.match.fwnode =
>>> +
>> 	fwnode_graph_get_remote_port_parent(of_fwnode_handle(ep));
>>> +
>>> +		viif_dev->asds[i] = &viif_sd->asd;
>>> +		of_node_put(ep);
>>> +	}
>>> +
>>> +	return num_ep;
>>> +
>>> +error_put_node:
>>> +	of_node_put(ep);
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct of_device_id visconti_viif_of_table[] = {
>>> +	{
>>> +		.compatible = "toshiba,visconti-viif",
>>> +	},
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, visconti_viif_of_table);
>>> +
>>> +int visconti_viif_isp_register(struct viif_device *viif_dev);
>>> +int visconti_viif_capture_register(struct viif_device *viif_dev);
>>> +void visconti_viif_isp_unregister(struct viif_device *viif_dev);
>>> +void visconti_viif_capture_unregister(struct viif_device *viif_dev);
>>> +
>>> +static int visconti_viif_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct viif_device *viif_dev;
>>> +	int ret, i, num_sd;
>>> +	dma_addr_t table_paddr;
>>> +	const struct of_device_id *of_id;
>>> +
>>> +	//ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
>>> +	//if (ret)
>>> +	//	return ret;
>>> +
>>> +	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
>>> +	if (!viif_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	viif_dev->is_powered = 0;
>>> +
>>> +	platform_set_drvdata(pdev, viif_dev);
>>> +	viif_dev->dev = dev;
>>> +
>>> +	INIT_LIST_HEAD(&viif_dev->capture);
>>> +	spin_lock_init(&viif_dev->lock);
>>> +	mutex_init(&viif_dev->mlock);
>>> +
>>> +	viif_dev->capture_reg = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(viif_dev->capture_reg))
>>> +		return PTR_ERR(viif_dev->capture_reg);
>>> +
>>> +	viif_dev->csi2host_reg = devm_platform_ioremap_resource(pdev, 1);
>>> +	if (IS_ERR(viif_dev->csi2host_reg))
>>> +		return PTR_ERR(viif_dev->csi2host_reg);
>>> +
>>> +	device_property_read_u32(dev, "index", &viif_dev->ch);
>>> +
>>> +	for (i = 0; i < 3; i++) {
>>> +		viif_dev->irq[i] = ret = platform_get_irq(pdev, i);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "failed to acquire irq resource\n");
>>> +			return ret;
>>> +		}
>>> +		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq,
>> 0, "viif",
>>> +				       viif_dev);
>>> +		if (ret) {
>>> +			dev_err(dev, "irq request failed\n");
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	viif_dev->table_vaddr =
>>> +		dma_alloc_wc(dev, sizeof(struct viif_table_area), &table_paddr,
>> GFP_KERNEL);
>>> +	if (!viif_dev->table_vaddr) {
>>> +		dev_err(dev, "dma_alloc_wc failed\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +	viif_dev->table_paddr = (struct viif_table_area *)table_paddr;
>>> +
>>> +	/* build media_dev */
>>> +	viif_dev->media_dev.hw_revision = 0;
>>> +	strscpy(viif_dev->media_dev.model, "visconti_viif",
>> sizeof(viif_dev->media_dev.model));
>>> +	viif_dev->media_dev.dev = dev;
>>> +	strscpy(viif_dev->media_dev.bus_info, "platform:visconti_viif",
>>> +		sizeof(viif_dev->media_dev.bus_info));
>>> +	media_device_init(&viif_dev->media_dev);
>>> +
>>> +	/* build v4l2_dev */
>>> +	viif_dev->v4l2_dev.mdev = &viif_dev->media_dev;
>>> +	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
>>> +	if (ret)
>>> +		goto error_dma_free;
>>> +
>>> +	ret = media_device_register(&viif_dev->media_dev);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to register media device: %d\n", ret);
>>> +		goto error_v4l2_unregister;
>>> +	}
>>> +
>>> +	ret = visconti_viif_isp_register(viif_dev);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to register isp sub node: %d\n", ret);
>>> +		goto error_media_unregister;
>>> +	}
>>> +	ret = visconti_viif_capture_register(viif_dev);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to register capture node: %d\n", ret);
>>> +		goto error_media_unregister;
>>> +	}
>>> +	ret = v4l2_ctrl_handler_init(&viif_dev->ctrl_handler, 20);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed on v4l2_ctrl_handler_init");
>>> +		return -ENOMEM;
>>> +	}
>>> +	viif_dev->v4l2_dev.ctrl_handler = &viif_dev->ctrl_handler;
>>> +	viif_dev->vdev.ctrl_handler = &viif_dev->ctrl_handler;
>>> +
>>> +	/* check device type */
>>> +	of_id = of_match_device(visconti_viif_of_table, dev);
>>> +
>>> +	num_sd = visconti_viif_parse_dt(viif_dev);
>>> +	if (ret < 0) {
>>> +		ret = num_sd;
>>> +		goto error_media_unregister;
>>> +	}
>>> +
>>> +	viif_dev->notifier.v4l2_dev = &viif_dev->v4l2_dev;
>>> +	v4l2_async_nf_init(&viif_dev->notifier);
>>> +	for (i = 0; i < num_sd; i++) {
>>> +		__v4l2_async_nf_add_subdev(&viif_dev->notifier,
>> viif_dev->asds[i]);
>>> +	}
>>> +	viif_dev->notifier.ops = &viif_notify_ops;
>>> +	ret = v4l2_async_nf_register(&viif_dev->v4l2_dev,
>> &viif_dev->notifier);
>>> +	if (ret)
>>> +		goto error_media_unregister;
>>> +
>>> +	return 0;
>>> +
>>> +error_media_unregister:
>>> +	media_device_unregister(&viif_dev->media_dev);
>>> +error_v4l2_unregister:
>>> +	v4l2_device_unregister(&viif_dev->v4l2_dev);
>>> +error_dma_free:
>>> +	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area),
>> viif_dev->table_vaddr,
>>> +		    (dma_addr_t)viif_dev->table_paddr);
>>> +	return ret;
>>> +}
>>> +
>>> +static int visconti_viif_remove(struct platform_device *pdev)
>>> +{
>>> +	struct viif_device *viif_dev = platform_get_drvdata(pdev);
>>> +
>>> +	visconti_viif_isp_unregister(viif_dev);
>>> +	visconti_viif_capture_unregister(viif_dev);
>>> +	v4l2_async_nf_unregister(&viif_dev->notifier);
>>> +	media_device_unregister(&viif_dev->media_dev);
>>> +	v4l2_device_unregister(&viif_dev->v4l2_dev);
>>> +	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area),
>> viif_dev->table_vaddr,
>>> +		    (dma_addr_t)viif_dev->table_paddr);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver visconti_viif_driver = {
>>> +	.probe = visconti_viif_probe,
>>> +	.remove = visconti_viif_remove,
>>> +	.driver = {
>>> +			.name = "visconti_viif",
>>> +			.of_match_table = visconti_viif_of_table,
>>> +		},
>>> +};
>>> +
>>> +module_platform_driver(visconti_viif_driver);
>>> +
>>> +MODULE_AUTHOR("Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>");
>>> +MODULE_DESCRIPTION("Toshiba Visconti Video Input driver");
>>> +MODULE_LICENSE("Dual BSD/GPL");
>>> diff --git a/drivers/media/platform/visconti/viif_capture.c
>> b/drivers/media/platform/visconti/viif_capture.c
>>> new file mode 100644
>>> index 000000000..8b0a63852
>>> --- /dev/null
>>> +++ b/drivers/media/platform/visconti/viif_capture.c
>>> @@ -0,0 +1,948 @@
>>> +#include <linux/delay.h>
>>> +#include <media/v4l2-common.h>
>>> +#include <media/v4l2-subdev.h>
>>> +
>>> +#include "viif.h"
>>> +
>>> +#define VIIF_CROP_MAX_X_ISP (8062U)
>>> +#define VIIF_CROP_MAX_Y_ISP (3966U)
>>> +#define VIIF_CROP_MIN_W	    (128U)
>>> +#define VIIF_CROP_MAX_W_ISP (8190U)
>>> +#define VIIF_CROP_MIN_H	    (128U)
>>> +#define VIIF_CROP_MAX_H_ISP (4094U)
>>> +
>>> +#define VIIF_ISP_GUARD_START(viif_dev)
>> \
>>> +	do
>> {
>>                 \
>>> +
>> 	hwd_VIIF_isp_disable_regbuf_auto_transmission(viif_dev->ch);
>> \
>>> +		ndelay(500);
>> \
>>> +		hwd_VIIF_main_mask_vlatch(viif_dev->ch,
>> HWD_VIIF_ENABLE);                          \
>>> +	} while (0)
>>> +
>>> +#define VIIF_ISP_GUARD_END(viif_dev)
>> \
>>> +	do
>> {
>>                 \
>>> +		hwd_VIIF_main_mask_vlatch(viif_dev->ch,
>> HWD_VIIF_DISABLE);                         \
>>> +		hwd_VIIF_isp_set_regbuf_auto_transmission(viif_dev->ch,
>> VIIF_ISP_REGBUF_0,         \
>>> +
>> VIIF_ISP_REGBUF_0, 0);                   \
>>> +	} while (0)
>>> +
>>> +struct viif_buffer {
>>> +	struct vb2_v4l2_buffer vb;
>>> +	struct list_head queue;
>>> +};
>>> +
>>> +static inline struct viif_buffer *vb2_to_viif(struct vb2_v4l2_buffer *vbuf)
>>> +{
>>> +	return container_of(vbuf, struct viif_buffer, vb);
>>> +}
>>> +
>>> +/* ----- ISRs and VB2 Operations ----- */
>>> +static int viif_set_img(struct viif_device *viif_dev, struct vb2_buffer *vb)
>>> +{
>>> +	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
>>> +	struct hwd_viif_img next_out_img;
>>> +	dma_addr_t phys_addr;
>>> +	int i, ret = 0;
>>> +
>>> +	next_out_img.width = pix->width;
>>> +	next_out_img.height = pix->height;
>>> +	next_out_img.format = viif_dev->out_format;
>>> +
>>> +	for (i = 0; i < pix->num_planes; i++) {
>>> +		next_out_img.pixelmap[i].pitch =
>> pix->plane_fmt[i].bytesperline;
>>> +		phys_addr = vb2_dma_contig_plane_dma_addr(vb, i);
>>> +		/* address mapping:
>>> +		 * - DDR0: (CPU)0x0_8000_0000-0x0_FFFF_FFFF ->
>> (HW)0x8000_0000-0xFFFF_FFFF
>>> +		 * - DDR1: (CPU)0x8_8000_0000-0x8_FFFF_FFFF ->
>> (HW)0x0000_0000-0x7FFF_FFFF
>>> +		 */
>>> +		next_out_img.pixelmap[i].pmap_paddr = (phys_addr &
>> 0x800000000UL) ?
>>> +							      (phys_addr &
>> 0x7fffffff) :
>>> +							      (phys_addr &
>> 0xffffffff);
>>> +	}
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l2_set_img_transmission(viif_dev->ch,
>> VIIF_L2ISP_POST_0, VIIF_ISP_REGBUF_0,
>>> +					       HWD_VIIF_ENABLE,
>> &viif_dev->img_area,
>>> +					       &viif_dev->out_process,
>> &next_out_img);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "set img error. %d\n", ret);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +void visconti_viif_capture_switch_buffer(struct viif_device *viif_dev,
>> uint32_t status_err,
>>> +					 uint32_t l2_transfer_status)
>>> +{
>>> +	struct vb2_v4l2_buffer *vbuf;
>>> +	struct viif_buffer *buf;
>>> +	enum vb2_buffer_state state;
>>> +
>>> +	vbuf = viif_dev->dma_active;
>>> +	if (!vbuf)
>>> +		goto next;
>>> +
>>> +	viif_dev->buf_cnt--;
>>> +	vbuf->vb2_buf.timestamp = ktime_get_ns();
>>> +	vbuf->sequence = viif_dev->sequence++;
>>> +	vbuf->field = viif_dev->field;
>>> +	if (status_err || l2_transfer_status)
>>> +		state = VB2_BUF_STATE_ERROR;
>>> +	else
>>> +		state = VB2_BUF_STATE_DONE;
>>> +
>>> +	vb2_buffer_done(&vbuf->vb2_buf, state);
>>> +	viif_dev->dma_active = NULL;
>>> +
>>> +next:
>>> +	vbuf = viif_dev->active;
>>> +	if (!vbuf)
>>> +		return;
>>> +
>>> +	if (viif_dev->last_active) {
>>> +		viif_dev->dma_active = viif_dev->last_active;
>>> +		viif_dev->last_active = NULL;
>>> +	} else if (!viif_dev->dma_active) {
>>> +		viif_dev->dma_active = vbuf;
>>> +		buf = vb2_to_viif(vbuf);
>>> +		list_del_init(&buf->queue);
>>> +	}
>>> +
>>> +	if (!list_empty(&viif_dev->capture)) {
>>> +		buf = list_entry(viif_dev->capture.next, struct viif_buffer,
>> queue);
>>> +		viif_dev->active = &buf->vb;
>>> +		viif_set_img(viif_dev, &buf->vb.vb2_buf);
>>> +	} else {
>>> +		dev_dbg(viif_dev->dev, "no queue\n");
>>> +		viif_dev->last_active = viif_dev->dma_active;
>>> +		viif_dev->dma_active = NULL;
>>> +		viif_dev->active = NULL;
>>> +	}
>>> +}
>>> +
>>> +/* --- Capture buffer control --- */
>>> +static int viif_vb2_setup(struct vb2_queue *vq, unsigned int *count,
>> unsigned int *num_planes,
>>> +			  unsigned int sizes[], struct device *alloc_devs[])
>>> +{
>>> +	struct viif_device *viif_dev = vb2_get_drv_priv(vq);
>>> +	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
>>> +	unsigned int i;
>>> +
>>> +	/* num_planes is set: just check plane sizes. */
>>> +	if (*num_planes) {
>>> +		for (i = 0; i < pix->num_planes; i++)
>>> +			if (sizes[i] < pix->plane_fmt[i].sizeimage)
>>> +				return -EINVAL;
>>> +
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* num_planes not set: called from REQBUFS, just set plane sizes. */
>>> +	*num_planes = pix->num_planes;
>>> +	for (i = 0; i < pix->num_planes; i++)
>>> +		sizes[i] = pix->plane_fmt[i].sizeimage;
>>> +
>>> +	viif_dev->buf_cnt = 0;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void viif_vb2_queue(struct vb2_buffer *vb)
>>> +{
>>> +	struct viif_device *viif_dev = vb2_get_drv_priv(vb->vb2_queue);
>>> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>>> +	struct viif_buffer *buf = vb2_to_viif(vbuf);
>>> +	unsigned long irqflags;
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	list_add_tail(&buf->queue, &viif_dev->capture);
>>> +	viif_dev->buf_cnt++;
>>> +
>>> +	if (!viif_dev->active) {
>>> +		viif_dev->active = vbuf;
>>> +		if (!viif_dev->last_active)
>>> +			viif_set_img(viif_dev, vb);
>>> +	}
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +}
>>> +
>>> +static int viif_vb2_prepare(struct vb2_buffer *vb)
>>> +{
>>> +	struct viif_device *viif_dev = vb2_get_drv_priv(vb->vb2_queue);
>>> +	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < pix->num_planes; i++) {
>>> +		if (vb2_plane_size(vb, i) < pix->plane_fmt[i].sizeimage) {
>>> +			dev_err(viif_dev->dev, "Plane size too small (%lu
>> < %u)\n",
>>> +				vb2_plane_size(vb, i),
>> pix->plane_fmt[i].sizeimage);
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		vb2_set_plane_payload(vb, i, pix->plane_fmt[i].sizeimage);
>>> +	}
>>> +	return 0;
>>> +}
>>> +static int viif_start_streaming(struct vb2_queue *vq, unsigned int count)
>>> +{
>>> +	struct viif_device *viif_dev = vb2_get_drv_priv(vq);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +
>>> +	ret = media_pipeline_start(&viif_dev->vdev.entity, &viif_dev->pipe);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "start pipeline failed %d\n", ret);
>>> +	}
>>> +
>>> +	/* CSI2RX start */
>>> +	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, 1);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "Start isp subdevice stream
>> failed. %d\n", ret);
>>> +		spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* buffer control */
>>> +	viif_dev->sequence = 0;
>>> +
>>> +	/* finish critical section: some sensor driver (including imx219) calls
>> schedule() */
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	/* Camera (CSI2 source) start streaming */
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, 1);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "Start subdev stream failed. %d\n",
>> ret);
>>> +		(void)v4l2_subdev_call(&viif_dev->isp_subdev.sd, video,
>> s_stream, 0);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void viif_stop_streaming(struct vb2_queue *vq)
>>> +{
>>> +	struct viif_device *viif_dev = vb2_get_drv_priv(vq);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	struct viif_buffer *buf;
>>> +	unsigned long irqflags;
>>> +	int ret;
>>> +
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, 0);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "Stop subdev stream failed. %d\n",
>> ret);
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +
>>> +	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, 0);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "Stop isp subdevice stream
>> failed %d\n", ret);
>>> +
>>> +	/* buffer control */
>>> +	viif_dev->active = NULL;
>>> +	if (viif_dev->dma_active) {
>>> +		vb2_buffer_done(&viif_dev->dma_active->vb2_buf,
>> VB2_BUF_STATE_ERROR);
>>> +		viif_dev->buf_cnt--;
>>> +		viif_dev->dma_active = NULL;
>>> +	}
>>> +	if (viif_dev->last_active) {
>>> +		vb2_buffer_done(&viif_dev->last_active->vb2_buf,
>> VB2_BUF_STATE_ERROR);
>>> +		viif_dev->buf_cnt--;
>>> +		viif_dev->last_active = NULL;
>>> +	}
>>> +
>>> +	/* Release all queued buffers. */
>>> +	list_for_each_entry (buf, &viif_dev->capture, queue) {
>>> +		vb2_buffer_done(&buf->vb.vb2_buf,
>> VB2_BUF_STATE_ERROR);
>>> +		viif_dev->buf_cnt--;
>>> +	}
>>> +	INIT_LIST_HEAD(&viif_dev->capture);
>>> +	if (viif_dev->buf_cnt)
>>> +		dev_err(viif_dev->dev, "Buffer count error %d\n",
>> viif_dev->buf_cnt);
>>> +
>>> +	media_pipeline_stop(&viif_dev->vdev.entity);
>>> +
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +}
>>> +
>>> +static const struct vb2_ops viif_vb2_ops = {
>>> +	.queue_setup = viif_vb2_setup,
>>> +	.buf_queue = viif_vb2_queue,
>>> +	.buf_prepare = viif_vb2_prepare,
>>> +	.wait_prepare = vb2_ops_wait_prepare,
>>> +	.wait_finish = vb2_ops_wait_finish,
>>> +	.start_streaming = viif_start_streaming,
>>> +	.stop_streaming = viif_stop_streaming,
>>> +};
>>> +
>>> +/* --- VIIF hardware settings --- */
>>> +extern int viif_isp_main_set_unit(struct viif_device *viif_dev);
>>> +
>>> +/* L2ISP output csc setting for YUV to RGB(ITU-R BT.709) */
>>> +static const struct hwd_viif_csc_param viif_csc_yuv2rgb = {
>>> +	.r_cr_in_offset = 0x18000,
>>> +	.g_y_in_offset = 0x1f000,
>>> +	.b_cb_in_offset = 0x18000,
>>> +	.coef = {
>>> +			[0] = 0x1000,
>>> +			[1] = 0xfd12,
>>> +			[2] = 0xf8ad,
>>> +			[3] = 0x1000,
>>> +			[4] = 0x1d07,
>>> +			[5] = 0x0000,
>>> +			[6] = 0x1000,
>>> +			[7] = 0x0000,
>>> +			[8] = 0x18a2,
>>> +		},
>>> +	.r_cr_out_offset = 0x1000,
>>> +	.g_y_out_offset = 0x1000,
>>> +	.b_cb_out_offset = 0x1000,
>>> +};
>>> +
>>> +/* L2ISP output csc setting for RGB to YUV(ITU-R BT.709) */
>>> +static const struct hwd_viif_csc_param viif_csc_rgb2yuv = {
>>> +	.r_cr_in_offset = 0x1f000,
>>> +	.g_y_in_offset = 0x1f000,
>>> +	.b_cb_in_offset = 0x1f000,
>>> +	.coef = {
>>> +			[0] = 0x0b71,
>>> +			[1] = 0x0128,
>>> +			[2] = 0x0367,
>>> +			[3] = 0xf9b1,
>>> +			[4] = 0x082f,
>>> +			[5] = 0xfe20,
>>> +			[6] = 0xf891,
>>> +			[7] = 0xff40,
>>> +			[8] = 0x082f,
>>> +		},
>>> +	.r_cr_out_offset = 0x8000,
>>> +	.g_y_out_offset = 0x1000,
>>> +	.b_cb_out_offset = 0x8000,
>>> +};
>>> +
>>> +static int viif_l2_set_format(struct viif_device *viif_dev)
>>> +{
>>> +	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
>>> +	const struct hwd_viif_csc_param *csc_param = NULL;
>>> +	struct v4l2_subdev_selection sel = {
>>> +		.pad = VIIF_ISP_PAD_SRC,
>>> +		.target = V4L2_SEL_TGT_CROP,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	struct v4l2_subdev_format fmt = {
>>> +		.pad = VIIF_ISP_PAD_SRC,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	bool inp_is_rgb = false;
>>> +	bool out_is_rgb = false;
>>> +	int ret;
>>> +
>>> +	viif_dev->out_process.half_scale = HWD_VIIF_DISABLE;
>>> +	viif_dev->out_process.select_color = HWD_VIIF_COLOR_YUV_RGB;
>>> +	viif_dev->out_process.alpha = 0;
>>> +
>>> +	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection,
>> NULL, &sel);
>>> +	if (ret) {
>>> +		viif_dev->img_area.x = 0;
>>> +		viif_dev->img_area.y = 0;
>>> +		viif_dev->img_area.w = pix->width;
>>> +		viif_dev->img_area.h = pix->height;
>>> +	} else {
>>> +		viif_dev->img_area.x = sel.r.left;
>>> +		viif_dev->img_area.y = sel.r.top;
>>> +		viif_dev->img_area.w = sel.r.width;
>>> +		viif_dev->img_area.h = sel.r.height;
>>> +	}
>>> +
>>> +	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL,
>> &fmt);
>>> +	if (!ret)
>>> +		inp_is_rgb = (fmt.format.code ==
>> MEDIA_BUS_FMT_RGB888_1X24);
>>> +
>>> +	switch (pix->pixelformat) {
>>> +	case V4L2_PIX_FMT_RGB24:
>>> +		viif_dev->out_format = HWD_VIIF_RGB888_PACKED;
>>> +		out_is_rgb = true;
>>> +		break;
>>> +	case V4L2_PIX_FMT_ABGR32:
>>> +		viif_dev->out_format = HWD_VIIF_ARGB8888_PACKED;
>>> +		viif_dev->out_process.alpha = 0xff;
>>> +		out_is_rgb = true;
>>> +		break;
>>> +	case V4L2_PIX_FMT_YUV422M:
>>> +		viif_dev->out_format = HWD_VIIF_YCBCR422_8_PLANAR;
>>> +		break;
>>> +	case V4L2_PIX_FMT_YUV444M:
>>> +		viif_dev->out_format =
>> HWD_VIIF_RGB888_YCBCR444_8_PLANAR;
>>> +		break;
>>> +	case V4L2_PIX_FMT_Y16:
>>> +		viif_dev->out_format = HWD_VIIF_ONE_COLOR_16;
>>> +		viif_dev->out_process.select_color = HWD_VIIF_COLOR_Y_G;
>>> +		break;
>>> +	}
>>> +
>>> +	if (!inp_is_rgb && out_is_rgb)
>>> +		csc_param = &viif_csc_yuv2rgb; /* YUV -> RGB */
>>> +	else if (inp_is_rgb && !out_is_rgb)
>>> +		csc_param = &viif_csc_rgb2yuv; /* RGB -> YUV */
>>> +
>>> +	return hwd_VIIF_l2_set_output_csc(viif_dev->ch, VIIF_L2ISP_POST_0,
>> VIIF_ISP_REGBUF_0,
>>> +					  csc_param);
>>> +}
>>> +
>>> +int viif_l2_set_crop(struct viif_device *viif_dev, struct viif_l2_crop_config
>> *l2_crop)
>>> +{
>>> +	struct v4l2_subdev_selection sel = {
>>> +		.pad    = VIIF_ISP_PAD_SRC,
>>> +		.target = V4L2_SEL_TGT_CROP,
>>> +		.which  = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +		.r = {
>>> +			.left   = l2_crop->x,
>>> +			.top    = l2_crop->y,
>>> +			.width  = l2_crop->w,
>>> +			.height = l2_crop->h,
>>> +		},
>>> +	};
>>> +
>>> +	if ((l2_crop->x > VIIF_CROP_MAX_X_ISP) || (l2_crop->y >
>> VIIF_CROP_MAX_Y_ISP) ||
>>> +	    (l2_crop->w < VIIF_CROP_MIN_W) || (l2_crop->w >
>> VIIF_CROP_MAX_W_ISP) ||
>>> +	    (l2_crop->h < VIIF_CROP_MIN_H) || (l2_crop->h >
>> VIIF_CROP_MAX_H_ISP)) {
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, set_selection,
>> NULL, &sel);
>>> +}
>>> +
>>> +/* --- IOCTL Operations --- */
>>> +static const struct viif_fmt viif_fmt_list[] = {
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_RGB24,
>>> +		.bpp = { 24, 0, 0 },
>>> +		.num_planes = 1,
>>> +		.colorspace = V4L2_COLORSPACE_SRGB,
>>> +		.pitch_align = 384,
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_ABGR32,
>>> +		.bpp = { 32, 0, 0 },
>>> +		.num_planes = 1,
>>> +		.colorspace = V4L2_COLORSPACE_SRGB,
>>> +		.pitch_align = 512,
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_YUV422M,
>>> +		.bpp = { 8, 4, 4 },
>>> +		.num_planes = 3,
>>> +		.colorspace = V4L2_COLORSPACE_REC709,
>>> +		.pitch_align = 128,
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_YUV444M,
>>> +		.bpp = { 8, 8, 8 },
>>> +		.num_planes = 3,
>>> +		.colorspace = V4L2_COLORSPACE_REC709,
>>> +		.pitch_align = 128,
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_Y16,
>>> +		.bpp = { 16, 0, 0 },
>>> +		.num_planes = 1,
>>> +		.colorspace = V4L2_COLORSPACE_REC709,
>>> +		.pitch_align = 128,
>>> +	},
>>> +};
>>> +
>>> +static const struct viif_fmt *get_viif_fmt_from_fourcc(unsigned int fourcc)
>>> +{
>>> +	const struct viif_fmt *fmt = &viif_fmt_list[0];
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(viif_fmt_list); i++, fmt++)
>>> +		if (fmt->fourcc == fourcc)
>>> +			return fmt;
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static void viif_update_plane_sizes(struct v4l2_plane_pix_format *plane,
>> unsigned int bpl,
>>> +				    unsigned int szimage)
>>> +{
>>> +	memset(plane, 0, sizeof(*plane));
>>> +
>>> +	plane->sizeimage = szimage;
>>> +	plane->bytesperline = bpl;
>>> +}
>>> +
>>> +static void viif_calc_plane_sizes(const struct viif_fmt *viif_fmt,
>>> +				  struct v4l2_pix_format_mplane *pix)
>>> +{
>>> +	unsigned int i, bpl, szimage;
>>> +
>>> +	for (i = 0; i < viif_fmt->num_planes; i++) {
>>> +		bpl = pix->width * viif_fmt->bpp[i] / 8;
>>> +		/* round up ptch */
>>> +		bpl = (bpl + (viif_fmt->pitch_align - 1)) /
>> viif_fmt->pitch_align;
>>> +		bpl *= viif_fmt->pitch_align;
>>> +		szimage = pix->height * bpl;
>>> +		viif_update_plane_sizes(&pix->plane_fmt[i], bpl, szimage);
>>> +	}
>>> +	pix->num_planes = viif_fmt->num_planes;
>>> +}
>>> +
>>> +static int viif_querycap(struct file *file, void *priv, struct v4l2_capability
>> *cap)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	strscpy(cap->card, "Toshiba VIIF", sizeof(cap->card));
>>> +	strscpy(cap->driver, "viif", sizeof(cap->driver));
>>> +	snprintf(cap->bus_info, sizeof(cap->bus_info),
>> "platform:toshiba-viif-%s",
>>> +		 dev_name(viif_dev->dev));
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_enum_fmt_vid_cap(struct file *file, void *priv, struct
>> v4l2_fmtdesc *f)
>>> +{
>>> +	const struct viif_fmt *fmt;
>>> +
>>> +	if (f->index >= ARRAY_SIZE(viif_fmt_list))
>>> +		return -EINVAL;
>>> +
>>> +	fmt = &viif_fmt_list[f->index];
>>> +	f->pixelformat = fmt->fourcc;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/* size of minimum/maximum output image */
>>> +#define VIIF_MIN_OUTPUT_IMG_WIDTH     (128U)
>>> +#define VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
>>> +#define VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
>>> +
>>> +#define VIIF_MIN_OUTPUT_IMG_HEIGHT     (128U)
>>> +#define VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
>>> +#define VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
>>> +
>>> +static int viif_try_fmt(struct viif_device *viif_dev, struct v4l2_format
>> *v4l2_fmt)
>>> +{
>>> +	struct v4l2_pix_format_mplane *pix = &v4l2_fmt->fmt.pix_mp;
>>> +	struct v4l2_subdev_format format = {
>>> +		.pad = VIIF_ISP_PAD_SRC,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	const struct viif_fmt *viif_fmt;
>>> +	int ret;
>>> +
>>> +	/* fourcc check */
>>> +	viif_fmt = get_viif_fmt_from_fourcc(pix->pixelformat);
>>> +	if (!viif_fmt)
>>> +		return -EINVAL;
>>> +
>>> +	/* min/max width, height check */
>>> +	if (pix->width < VIIF_MIN_OUTPUT_IMG_WIDTH)
>>> +		pix->width = VIIF_MIN_OUTPUT_IMG_WIDTH;
>>> +
>>> +	if (pix->width > VIIF_MAX_OUTPUT_IMG_WIDTH_ISP)
>>> +		pix->width = VIIF_MAX_OUTPUT_IMG_WIDTH_ISP;
>>> +
>>> +	if (pix->height < VIIF_MIN_OUTPUT_IMG_HEIGHT)
>>> +		pix->height = VIIF_MIN_OUTPUT_IMG_HEIGHT;
>>> +
>>> +	if (pix->height > VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP)
>>> +		pix->height = VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP;
>>> +
>>> +	/* experimental: consistency with isp::pad::src::fmt */
>>> +	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL,
>> &format);
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +	if (pix->width != format.format.width)
>>> +		return -EINVAL;
>>> +	if (pix->height != format.format.height)
>>> +		return -EINVAL;
>>> +
>>> +	/* update derived parameters, such as bpp */
>>> +	viif_calc_plane_sizes(viif_fmt, pix);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format
>> *f)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	return viif_try_fmt(viif_dev, f);
>>> +}
>>> +
>>> +static int viif_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format
>> *f)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	int ret = 0;
>>> +
>>> +	if (vb2_is_streaming(&viif_dev->vb2_vq))
>>> +		return -EBUSY;
>>> +
>>> +	if (f->type != viif_dev->vb2_vq.type)
>>> +		return -EINVAL;
>>> +
>>> +	ret = viif_try_fmt(viif_dev, f);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* TODO: this function should be called from viif_isp_s_stream()?? */
>>> +	ret = viif_isp_main_set_unit(viif_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	viif_dev->v4l2_pix = f->fmt.pix_mp;
>>> +	viif_dev->field = V4L2_FIELD_NONE;
>>> +
>>> +	return viif_l2_set_format(viif_dev);
>>> +}
>>> +
>>> +static int viif_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format
>> *f)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	f->fmt.pix_mp = viif_dev->v4l2_pix;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_enum_input(struct file *file, void *priv, struct v4l2_input *inp)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd;
>>> +	struct v4l2_subdev *v4l2_sd;
>>> +	int ret;
>>> +
>>> +	if (inp->index >= viif_dev->num_sd)
>>> +		return -EINVAL;
>>> +
>>> +	viif_sd = &viif_dev->subdevs[inp->index];
>>> +	v4l2_sd = viif_sd->v4l2_sd;
>>> +
>>> +	ret = v4l2_subdev_call(v4l2_sd, video, g_input_status, &inp->status);
>>> +	if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
>>> +		return ret;
>>> +	inp->type = V4L2_INPUT_TYPE_CAMERA;
>>> +	inp->std = 0;
>>> +	if (v4l2_subdev_has_op(v4l2_sd, pad, dv_timings_cap))
>>> +		inp->capabilities = V4L2_IN_CAP_DV_TIMINGS;
>>> +	else
>>> +		inp->capabilities = V4L2_IN_CAP_STD;
>>> +	snprintf(inp->name, sizeof(inp->name), "Camera%u: %s", inp->index,
>> viif_sd->v4l2_sd->name);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_g_input(struct file *file, void *priv, unsigned int *i)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	*i = viif_dev->sd_index;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_s_input(struct file *file, void *priv, unsigned int i)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	if (i >= viif_dev->num_sd)
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_dv_timings_cap(struct file *file, void *priv_fh, struct
>> v4l2_dv_timings_cap *cap)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, dv_timings_cap, cap);
>>> +}
>>> +
>>> +static int viif_enum_dv_timings(struct file *file, void *priv_fh,
>>> +				struct v4l2_enum_dv_timings *timings)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, enum_dv_timings,
>> timings);
>>> +}
>>> +
>>> +static int viif_g_dv_timings(struct file *file, void *priv_fh, struct
>> v4l2_dv_timings *timings)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings,
>> timings);
>>> +}
>>> +
>>> +static int viif_s_dv_timings(struct file *file, void *priv_fh, struct
>> v4l2_dv_timings *timings)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, video, s_dv_timings,
>> timings);
>>> +}
>>> +
>>> +static int viif_query_dv_timings(struct file *file, void *priv_fh, struct
>> v4l2_dv_timings *timings)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, video, query_dv_timings,
>> timings);
>>> +}
>>> +
>>> +static int viif_g_edid(struct file *file, void *fh, struct v4l2_edid *edid)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_edid, edid);
>>> +}
>>> +
>>> +static int viif_s_edid(struct file *file, void *fh, struct v4l2_edid *edid)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +
>>> +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid, edid);
>>> +}
>>> +
>>> +static int viif_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	return v4l2_g_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd,
>> a);
>>> +}
>>> +
>>> +static int viif_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +
>>> +	return v4l2_s_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd,
>> a);
>>> +}
>>> +
>>> +static int viif_enum_framesizes(struct file *file, void *fh, struct
>> v4l2_frmsizeenum *fsize)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
>>> +	struct v4l2_subdev_frame_size_enum fse = {
>>> +		.code = viif_sd->mbus_code,
>>> +		.index = fsize->index,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	int ret;
>>> +
>>> +	ret = v4l2_subdev_call(v4l2_sd, pad, enum_frame_size, NULL, &fse);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
>>> +	fsize->discrete.width = fse.max_width;
>>> +	fsize->discrete.height = fse.max_height;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int viif_enum_frameintervals(struct file *file, void *fh, struct
>> v4l2_frmivalenum *fival)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
>>> +	struct v4l2_subdev_frame_interval_enum fie = {
>>> +		.code = viif_sd->mbus_code,
>>> +		.index = fival->index,
>>> +		.width = fival->width,
>>> +		.height = fival->height,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	int ret;
>>> +
>>> +	ret = v4l2_subdev_call(v4l2_sd, pad, enum_frame_interval, NULL,
>> &fie);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
>>> +	fival->discrete = fie.interval;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct v4l2_ioctl_ops viif_ioctl_ops = {
>>> +	.vidioc_querycap = viif_querycap,
>>> +
>>> +	.vidioc_enum_fmt_vid_cap = viif_enum_fmt_vid_cap,
>>> +	.vidioc_try_fmt_vid_cap_mplane = viif_try_fmt_vid_cap,
>>> +	.vidioc_s_fmt_vid_cap_mplane = viif_s_fmt_vid_cap,
>>> +	.vidioc_g_fmt_vid_cap_mplane = viif_g_fmt_vid_cap,
>>> +
>>> +	.vidioc_enum_input = viif_enum_input,
>>> +	.vidioc_g_input = viif_g_input,
>>> +	.vidioc_s_input = viif_s_input,
>>> +
>>> +	.vidioc_dv_timings_cap = viif_dv_timings_cap,
>>> +	.vidioc_enum_dv_timings = viif_enum_dv_timings,
>>> +	.vidioc_g_dv_timings = viif_g_dv_timings,
>>> +	.vidioc_s_dv_timings = viif_s_dv_timings,
>>> +	.vidioc_query_dv_timings = viif_query_dv_timings,
>>> +
>>> +	.vidioc_g_edid = viif_g_edid,
>>> +	.vidioc_s_edid = viif_s_edid,
>>> +
>>> +	.vidioc_g_parm = viif_g_parm,
>>> +	.vidioc_s_parm = viif_s_parm,
>>> +
>>> +	.vidioc_enum_framesizes = viif_enum_framesizes,
>>> +	.vidioc_enum_frameintervals = viif_enum_frameintervals,
>>> +
>>> +	.vidioc_reqbufs = vb2_ioctl_reqbufs,
>>> +	.vidioc_querybuf = vb2_ioctl_querybuf,
>>> +	.vidioc_qbuf = vb2_ioctl_qbuf,
>>> +	.vidioc_expbuf = vb2_ioctl_expbuf,
>>> +	.vidioc_dqbuf = vb2_ioctl_dqbuf,
>>> +	.vidioc_create_bufs = vb2_ioctl_create_bufs,
>>> +	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
>>> +	.vidioc_streamon = vb2_ioctl_streamon,
>>> +	.vidioc_streamoff = vb2_ioctl_streamoff,
>>> +
>>> +	.vidioc_log_status = v4l2_ctrl_log_status,
>>> +	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>>> +	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>>> +};
>>> +
>>> +/* --- File Operations --- */
>>> +void viif_hw_on(struct viif_device *viif_dev);
>>> +void viif_hw_off(struct viif_device *viif_dev);
>>> +
>>> +static int viif_capture_open(struct file *file)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	int ret, mask;
>>> +
>>> +	ret = v4l2_fh_open(file);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_DISABLE;
>>> +
>>> +	viif_dev->is_powered = 1;
>>> +
>>> +	mutex_lock(&viif_dev->mlock);
>>> +
>>> +	/* Initialize HWD driver */
>>> +	viif_hw_on(viif_dev);
>>> +
>>> +	/* VSYNC mask setting of MAIN unit */
>>> +	mask = 0x00050003;
>>> +	hwd_VIIF_main_vsync_set_irq_mask(viif_dev->ch, &mask);
>>> +
>>> +	/* STATUS error mask setting(unmask) of MAIN unit */
>>> +	mask = 0x01000000;
>>> +	hwd_VIIF_main_status_err_set_irq_mask(viif_dev->ch, &mask);
>>> +
>>> +	mutex_unlock(&viif_dev->mlock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int viif_capture_release(struct file *file)
>>> +{
>>> +	struct viif_device *viif_dev = video_drvdata(file);
>>> +	int ret;
>>> +
>>> +	ret = vb2_fop_release(file);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mutex_lock(&viif_dev->mlock);
>>> +	viif_hw_off(viif_dev);
>>> +	mutex_unlock(&viif_dev->mlock);
>>> +
>>> +	viif_dev->is_powered = 0;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct v4l2_file_operations viif_fops = {
>>> +	.owner = THIS_MODULE,
>>> +	.open = viif_capture_open,
>>> +	.release = viif_capture_release,
>>> +	.unlocked_ioctl = video_ioctl2,
>>> +	.mmap = vb2_fop_mmap,
>>> +	.poll = vb2_fop_poll,
>>> +};
>>> +
>>> +/* ----- media control callbacks ----- */
>>> +static int viif_capture_link_validate(struct media_link *link)
>>> +{
>>> +	/* TODO: add link validation at start-stream */
>>> +	pr_info("viif_capture_link_validate called\n");
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct media_entity_operations viif_media_ops = {
>>> +	.link_validate = viif_capture_link_validate,
>>> +};
>>> +
>>> +/* ----- register/remove capture device node ----- */
>>> +int visconti_viif_capture_register(struct viif_device *viif_dev)
>>> +{
>>> +	struct v4l2_device *v4l2_dev = &viif_dev->v4l2_dev;
>>> +	struct video_device *vdev = &viif_dev->vdev;
>>> +	struct vb2_queue *q = &viif_dev->vb2_vq;
>>> +	int ret;
>>> +
>>> +	/* Initialize vb2 queue. */
>>> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>>> +	q->io_modes = VB2_DMABUF;
>>> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>>> +	q->ops = &viif_vb2_ops;
>>> +	q->mem_ops = &vb2_dma_contig_memops;
>>> +	q->drv_priv = viif_dev;
>>> +	q->buf_struct_size = sizeof(struct viif_buffer);
>>> +	q->min_buffers_needed = 2;
>>> +	q->lock = &viif_dev->mlock;
>>> +	q->dev = viif_dev->v4l2_dev.dev;
>>> +
>>> +	ret = vb2_queue_init(q);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Register the video device. */
>>> +	strscpy(vdev->name, "viif_capture", sizeof(vdev->name));
>>> +	vdev->v4l2_dev = v4l2_dev;
>>> +	vdev->lock = &viif_dev->mlock;
>>> +	vdev->queue = &viif_dev->vb2_vq;
>>> +	vdev->ctrl_handler = NULL;
>>> +	vdev->fops = &viif_fops;
>>> +	vdev->ioctl_ops = &viif_ioctl_ops;
>>> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
>> V4L2_CAP_STREAMING;
>>> +	vdev->device_caps |= V4L2_CAP_IO_MC;
>>> +	vdev->entity.ops = &viif_media_ops;
>>> +	vdev->release = video_device_release_empty;
>>> +	video_set_drvdata(vdev, viif_dev);
>>> +	vdev->vfl_dir = VFL_DIR_RX;
>>> +	viif_dev->capture_pad.flags = MEDIA_PAD_FL_SINK;
>>> +
>>> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
>>> +	if (ret < 0) {
>>> +		dev_err(v4l2_dev->dev, "video_register_device failed: %d\n",
>> ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = media_entity_pads_init(&vdev->entity, 1,
>> &viif_dev->capture_pad);
>>> +	if (ret) {
>>> +		video_unregister_device(vdev);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void visconti_viif_capture_unregister(struct viif_device *viif_dev)
>>> +{
>>> +	media_entity_cleanup(&viif_dev->vdev.entity);
>>> +	vb2_video_unregister_device(&viif_dev->vdev);
>>> +}
>>> diff --git a/drivers/media/platform/visconti/viif_ioctl.c
>> b/drivers/media/platform/visconti/viif_ioctl.c
>>> new file mode 100644
>>> index 000000000..75a4bb83f
>>> --- /dev/null
>>> +++ b/drivers/media/platform/visconti/viif_ioctl.c
>>> @@ -0,0 +1,287 @@
>>> +#include <linux/delay.h>
>>> +#include <media/v4l2-common.h>
>>> +#include <media/v4l2-subdev.h>
>>> +
>>> +#include "viif.h"
>>> +
>>> +#define VIIF_ISP_GUARD_START(viif_dev)
>> \
>>> +	do
>> {
>>                 \
>>> +
>> 	hwd_VIIF_isp_disable_regbuf_auto_transmission(viif_dev->ch);
>> \
>>> +		ndelay(500);
>> \
>>> +		hwd_VIIF_main_mask_vlatch(viif_dev->ch,
>> HWD_VIIF_ENABLE);                          \
>>> +	} while (0)
>>> +
>>> +#define VIIF_ISP_GUARD_END(viif_dev)
>> \
>>> +	do
>> {
>>                 \
>>> +		hwd_VIIF_main_mask_vlatch(viif_dev->ch,
>> HWD_VIIF_DISABLE);                         \
>>> +		hwd_VIIF_isp_set_regbuf_auto_transmission(viif_dev->ch,
>> VIIF_ISP_REGBUF_0,         \
>>> +
>> VIIF_ISP_REGBUF_0, 0);                   \
>>> +	} while (0)
>>> +
>>> +int viif_l1_set_input_mode(struct viif_device *viif_dev,
>>> +			   struct viif_l1_input_mode_config *input_mode)
>>> +{
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	/* SDR input is not supported */
>>> +	ret = hwd_VIIF_l1_set_input_mode(viif_dev->ch, input_mode->mode,
>> input_mode->depth,
>>> +					 input_mode->raw_color_filter,
>> NULL);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_l1_set_main_process(struct viif_device *viif_dev, struct
>> viif_l1_main_process_config *mpro)
>>> +{
>>> +	struct hwd_viif_l1_color_matrix_correction color_matrix;
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	if (mpro->param) {
>>> +		if (copy_from_user(&color_matrix, (void __user
>> *)mpro->param,
>>> +				   sizeof(struct
>> hwd_viif_l1_color_matrix_correction)))
>>> +			return -EFAULT;
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l1_set_main_process(viif_dev->ch,
>> VIIF_ISP_REGBUF_0, mpro->demosaic_mode,
>>> +					   mpro->damp_lsbsel,
>> mpro->param ? &color_matrix : NULL,
>>> +					   mpro->dst_maxval);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_l1_set_black_level_correction(struct viif_device *viif_dev,
>>> +				       struct
>> viif_l1_black_level_correction_config *blc)
>>> +{
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l1_set_black_level_correction(
>>> +		viif_dev->ch, VIIF_ISP_REGBUF_0, (struct
>> hwd_viif_l1_black_level_correction *)blc);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_l1_set_awb(struct viif_device *viif_dev, struct viif_l1_awb_config
>> *l1_awb)
>>> +{
>>> +	struct hwd_viif_l1_awb param;
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	if (l1_awb->param) {
>>> +		if (copy_from_user(&param, (void __user *)l1_awb->param,
>>> +				   sizeof(struct hwd_viif_l1_awb)))
>>> +			return -EFAULT;
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l1_set_awb(viif_dev->ch, VIIF_ISP_REGBUF_0,
>> l1_awb->param ? &param : NULL,
>>> +				  l1_awb->awhb_wbmrg,
>> l1_awb->awhb_wbmgg, l1_awb->awhb_wbmbg);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_l1_set_hdrc(struct viif_device *viif_dev, struct viif_l1_hdrc_config
>> *hdrc)
>>> +{
>>> +	struct hwd_viif_l1_hdrc param;
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	if (hdrc->param) {
>>> +		if (copy_from_user(&param, (void __user *)hdrc->param,
>>> +				   sizeof(struct hwd_viif_l1_hdrc)))
>>> +			return -EFAULT;
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l1_set_hdrc(viif_dev->ch, VIIF_ISP_REGBUF_0,
>> hdrc->param ? &param : NULL,
>>> +				   hdrc->hdrc_thr_sft_amt);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_l1_set_img_quality_adjustment(struct viif_device *viif_dev,
>>> +				       struct
>> viif_l1_img_quality_adjustment_config *img_quality)
>>> +{
>>> +	struct viif_l1_nonlinear_contrast nonlinear;
>>> +	struct viif_l1_lum_noise_reduction lum_noise;
>>> +	struct viif_l1_edge_enhancement edge_enh;
>>> +	struct viif_l1_uv_suppression uv;
>>> +	struct viif_l1_coring_suppression coring;
>>> +	struct viif_l1_edge_suppression edge_sup;
>>> +	struct viif_l1_color_level color;
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	if (img_quality->nonlinear_contrast) {
>>> +		if (copy_from_user(&nonlinear, (void __user
>> *)img_quality->nonlinear_contrast,
>>> +				   sizeof(struct viif_l1_nonlinear_contrast)))
>>> +			return -EFAULT;
>>> +		img_quality->nonlinear_contrast = &nonlinear;
>>> +	}
>>> +	if (img_quality->lum_noise_reduction) {
>>> +		if (copy_from_user(&lum_noise, (void __user
>> *)img_quality->lum_noise_reduction,
>>> +				   sizeof(struct
>> viif_l1_lum_noise_reduction)))
>>> +			return -EFAULT;
>>> +		img_quality->lum_noise_reduction = &lum_noise;
>>> +	}
>>> +	if (img_quality->edge_enhancement) {
>>> +		if (copy_from_user(&edge_enh, (void __user
>> *)img_quality->edge_enhancement,
>>> +				   sizeof(struct viif_l1_edge_enhancement)))
>>> +			return -EFAULT;
>>> +		img_quality->edge_enhancement = &edge_enh;
>>> +	}
>>> +	if (img_quality->uv_suppression) {
>>> +		if (copy_from_user(&uv, (void __user
>> *)img_quality->uv_suppression,
>>> +				   sizeof(struct viif_l1_uv_suppression)))
>>> +			return -EFAULT;
>>> +		img_quality->uv_suppression = &uv;
>>> +	}
>>> +	if (img_quality->coring_suppression) {
>>> +		if (copy_from_user(&coring, (void __user
>> *)img_quality->coring_suppression,
>>> +				   sizeof(struct viif_l1_coring_suppression)))
>>> +			return -EFAULT;
>>> +		img_quality->coring_suppression = &coring;
>>> +	}
>>> +	if (img_quality->edge_suppression) {
>>> +		if (copy_from_user(&edge_sup, (void __user
>> *)img_quality->edge_suppression,
>>> +				   sizeof(struct viif_l1_edge_suppression)))
>>> +			return -EFAULT;
>>> +		img_quality->edge_suppression = &edge_sup;
>>> +	}
>>> +	if (img_quality->color_level) {
>>> +		if (copy_from_user(&color, (void __user
>> *)img_quality->color_level,
>>> +				   sizeof(struct viif_l1_color_level)))
>>> +			return -EFAULT;
>>> +		img_quality->color_level = &color;
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l1_set_img_quality_adjustment(
>>> +		viif_dev->ch, VIIF_ISP_REGBUF_0,
>>> +		(struct hwd_viif_l1_img_quality_adjustment *)img_quality);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +#define VISCONTI_VIIF_DPC_TABLE_SIZE_MIN 1024
>>> +#define VISCONTI_VIIF_DPC_TABLE_SIZE_MAX 8192
>>> +int viif_l2_set_undist(struct viif_device *viif_dev, struct
>> viif_l2_undist_config *undist)
>>> +{
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +	uintptr_t table_write_g_paddr = 0;
>>> +	uintptr_t table_read_b_paddr = 0;
>>> +	uintptr_t table_read_g_paddr = 0;
>>> +	uintptr_t table_read_r_paddr = 0;
>>> +
>>> +	if ((undist->size && (undist->size <
>> VISCONTI_VIIF_DPC_TABLE_SIZE_MIN)) ||
>>> +	    (undist->size > VISCONTI_VIIF_DPC_TABLE_SIZE_MAX))
>>> +		return -EINVAL;
>>> +
>>> +	if (undist->write_g) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->undist_write_g,
>>> +				   (void __user *)undist->write_g,
>> undist->size))
>>> +			return -EFAULT;
>>> +		table_write_g_paddr =
>> (uintptr_t)viif_dev->table_paddr->undist_write_g;
>>> +	}
>>> +	if (undist->read_b) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->undist_read_b,
>>> +				   (void __user *)undist->read_b,
>> undist->size))
>>> +			return -EFAULT;
>>> +		table_read_b_paddr =
>> (uintptr_t)viif_dev->table_paddr->undist_read_b;
>>> +	}
>>> +	if (undist->read_g) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->undist_read_g,
>>> +				   (void __user *)undist->read_g,
>> undist->size))
>>> +			return -EFAULT;
>>> +		table_read_g_paddr =
>> (uintptr_t)viif_dev->table_paddr->undist_read_g;
>>> +	}
>>> +	if (undist->read_r) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->undist_read_r,
>>> +				   (void __user *)undist->read_r,
>> undist->size))
>>> +			return -EFAULT;
>>> +		table_read_r_paddr =
>> (uintptr_t)viif_dev->table_paddr->undist_read_r;
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l2_set_undist_table_transmission(viif_dev->ch,
>> table_write_g_paddr,
>>> +							table_read_b_paddr,
>> table_read_g_paddr,
>>> +							table_read_r_paddr,
>> undist->size);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "l2_set_undist_table_transmission
>> error. %d\n", ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	ret = hwd_VIIF_l2_set_undist(viif_dev->ch, VIIF_ISP_REGBUF_0,
>>> +				     (struct hwd_viif_l2_undist
>> *)&undist->param);
>>> +err:
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_l2_set_roi(struct viif_device *viif_dev, struct viif_l2_roi_config *roi)
>>> +{
>>> +	int ret;
>>> +	unsigned long irqflags;
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	VIIF_ISP_GUARD_START(viif_dev);
>>> +	ret = hwd_VIIF_l2_set_roi(viif_dev->ch, VIIF_ISP_REGBUF_0, (struct
>> hwd_viif_l2_roi *)roi);
>>> +	VIIF_ISP_GUARD_END(viif_dev);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_csi2rx_get_calibration_status(
>>> +	struct viif_device *viif_dev,
>>> +	struct viif_csi2rx_dphy_calibration_status *calibration_status)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (!vb2_is_streaming(&viif_dev->vb2_vq))
>>> +		return -EIO;
>>> +
>>> +	ret = hwd_VIIF_csi2rx_get_calibration_status(
>>> +		viif_dev->ch, (struct hwd_viif_csi2rx_dphy_calibration_status
>> *)calibration_status);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int viif_csi2rx_get_err_status(struct viif_device *viif_dev, struct
>> viif_csi2rx_err_status *csi_err)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (!vb2_is_streaming(&viif_dev->vb2_vq))
>>> +		return -EIO;
>>> +
>>> +	ret = hwd_VIIF_csi2rx_get_err_status(viif_dev->ch,
>> &csi_err->err_phy_fatal,
>>> +					     &csi_err->err_pkt_fatal,
>> &csi_err->err_frame_fatal,
>>> +					     &csi_err->err_phy,
>> &csi_err->err_pkt,
>>> +					     &csi_err->err_line);
>>> +
>>> +	return ret;
>>> +}
>>> diff --git a/drivers/media/platform/visconti/viif_isp.c
>> b/drivers/media/platform/visconti/viif_isp.c
>>> new file mode 100644
>>> index 000000000..e271dff15
>>> --- /dev/null
>>> +++ b/drivers/media/platform/visconti/viif_isp.c
>>> @@ -0,0 +1,968 @@
>>> +#include <media/v4l2-common.h>
>>> +#include <media/v4l2-subdev.h>
>>> +
>>> +#include "viif.h"
>>> +
>>> +/* ----- supported MBUS formats ----- */
>>> +struct visconti_mbus_format {
>>> +	unsigned int code;
>>> +	unsigned int bpp;
>>> +	int rgb_out;
>>> +} static visconti_mbus_formats[] = {
>>> +	{ .code = MEDIA_BUS_FMT_RGB888_1X24, .bpp = 24, .rgb_out = 1 },
>>> +	{ .code = MEDIA_BUS_FMT_UYVY8_1X16, .bpp = 16, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_UYVY10_1X20, .bpp = 20, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_RGB565_1X16, .bpp = 16, .rgb_out = 1 },
>>> +	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .bpp = 8, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGBRG8_1X8, .bpp = 8, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGRBG8_1X8, .bpp = 8, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8, .bpp = 8, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SRGGB10_1X10, .bpp = 10, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGRBG10_1X10, .bpp = 10, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGBRG10_1X10, .bpp = 10, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SBGGR10_1X10, .bpp = 10, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SRGGB12_1X12, .bpp = 12, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGRBG12_1X12, .bpp = 12, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGBRG12_1X12, .bpp = 12, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SBGGR12_1X12, .bpp = 12, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SRGGB14_1X14, .bpp = 14, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGRBG14_1X14, .bpp = 14, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SGBRG14_1X14, .bpp = 14, .rgb_out = 0 },
>>> +	{ .code = MEDIA_BUS_FMT_SBGGR14_1X14, .bpp = 14, .rgb_out = 0 },
>>> +};
>>> +
>>> +static int viif_get_mbus_rgb_out(unsigned int mbus_code)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
>>> +		if (visconti_mbus_formats[i].code == mbus_code)
>>> +			return visconti_mbus_formats[i].rgb_out;
>>> +
>>> +	/* YUV intermediate code by default */
>>> +	return 0;
>>> +}
>>> +
>>> +static unsigned int viif_get_mbus_bpp(unsigned int mbus_code)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
>>> +		if (visconti_mbus_formats[i].code == mbus_code)
>>> +			return visconti_mbus_formats[i].bpp;
>>> +
>>> +	/* default bpp value */
>>> +	return 24;
>>> +}
>>> +
>>> +static bool viif_is_valid_mbus_code(unsigned int mbus_code)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
>>> +		if (visconti_mbus_formats[i].code == mbus_code)
>>> +			return true;
>>> +	return false;
>>> +}
>>> +
>>> +/* ----- handling main processing path ----- */
>>> +static int viif_get_dv_timings(struct viif_device *viif_dev, struct
>> v4l2_dv_timings *timings)
>>> +{
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	struct v4l2_ctrl *ctrl;
>>> +	int ret;
>>> +	struct v4l2_subdev_pad_config pad_cfg;
>>> +	struct v4l2_subdev_state pad_state = {
>>> +		.pads = &pad_cfg,
>>> +	};
>>> +	struct v4l2_subdev_format format = {
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +		.pad = 0,
>>> +	};
>>> +
>>> +	/* some video I/F support dv_timings query */
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings, timings);
>>> +	if (ret == 0)
>>> +		return 0;
>>> +
>>> +	/* others: call some discrete APIs */
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, &pad_state,
>> &format);
>>> +	if (ret != 0)
>>> +		return ret;
>>> +
>>> +	timings->bt.width = format.format.width;
>>> +	timings->bt.height = format.format.height;
>>> +
>>> +	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler,
>> V4L2_CID_HBLANK);
>>> +	if (!ctrl) {
>>> +		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	timings->bt.hsync = v4l2_ctrl_g_ctrl(ctrl);
>>> +
>>> +	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler,
>> V4L2_CID_VBLANK);
>>> +	if (!ctrl) {
>>> +		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	timings->bt.vsync = v4l2_ctrl_g_ctrl(ctrl);
>>> +
>>> +	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler,
>> V4L2_CID_PIXEL_RATE);
>>> +	if (!ctrl) {
>>> +		dev_err(viif_dev->dev, "subdev: V4L2_CID_PIXEL_RATE
>> error.\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	timings->bt.pixelclock = v4l2_ctrl_g_ctrl_int64(ctrl);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*TODO: should be moved below visconti_viif_isp_s_stream()?? */
>>> +int viif_isp_main_set_unit(struct viif_device *viif_dev)
>>> +{
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	struct v4l2_dv_timings timings;
>>> +	struct v4l2_subdev_format fmt = {
>>> +		.pad = 0,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	unsigned int dt_image, color_type, rawpack, yuv_conv;
>>> +	struct hwd_viif_input_img in_img_main;
>>> +	int ret = 0;
>>> +	int mag_hactive = 1;
>>> +	struct hwd_viif_l2_undist undist = { 0 };
>>> +
>>> +	ret = viif_get_dv_timings(viif_dev, &timings);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "could not get timing information of
>> subdev");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, NULL, &fmt);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "could not get pad information of
>> subdev");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	switch (fmt.format.code) {
>>> +	case MEDIA_BUS_FMT_RGB888_1X24:
>>> +		dt_image = VISCONTI_CSI2_DT_RGB888;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_UYVY8_1X16:
>>> +		dt_image = VISCONTI_CSI2_DT_YUV4228B;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_UYVY10_1X20:
>>> +		dt_image = VISCONTI_CSI2_DT_YUV42210B;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_RGB565_1X16:
>>> +		dt_image = VISCONTI_CSI2_DT_RGB565;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
>>> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
>>> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
>>> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
>>> +		dt_image = VISCONTI_CSI2_DT_RAW8;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
>>> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
>>> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
>>> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
>>> +		dt_image = VISCONTI_CSI2_DT_RAW10;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
>>> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
>>> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
>>> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
>>> +		dt_image = VISCONTI_CSI2_DT_RAW12;
>>> +		break;
>>> +	case MEDIA_BUS_FMT_SRGGB14_1X14:
>>> +	case MEDIA_BUS_FMT_SGRBG14_1X14:
>>> +	case MEDIA_BUS_FMT_SGBRG14_1X14:
>>> +	case MEDIA_BUS_FMT_SBGGR14_1X14:
>>> +		dt_image = VISCONTI_CSI2_DT_RAW14;
>>> +		break;
>>> +	default:
>>> +		dt_image = VISCONTI_CSI2_DT_RGB888;
>>> +		break;
>>> +	}
>>> +
>>> +	color_type = dt_image;
>>> +
>>> +	if ((color_type == VISCONTI_CSI2_DT_RAW8) || (color_type ==
>> VISCONTI_CSI2_DT_RAW10) ||
>>> +	    (color_type == VISCONTI_CSI2_DT_RAW12)) {
>>> +		rawpack = viif_dev->rawpack_mode;
>>> +		if (rawpack != HWD_VIIF_RAWPACK_DISABLE)
>>> +			mag_hactive = 2;
>>> +	} else
>>> +		rawpack = HWD_VIIF_RAWPACK_DISABLE;
>>> +
>>> +	if ((color_type == VISCONTI_CSI2_DT_YUV4228B) || (color_type ==
>> VISCONTI_CSI2_DT_YUV42210B))
>>> +		yuv_conv = HWD_VIIF_YUV_CONV_INTERPOLATION;
>>> +	else
>>> +		yuv_conv = HWD_VIIF_YUV_CONV_REPEAT;
>>> +
>>> +	in_img_main.hactive_size = timings.bt.width;
>>> +	in_img_main.vactive_size = timings.bt.height;
>>> +	in_img_main.htotal_size = timings.bt.width * mag_hactive +
>> timings.bt.hsync;
>>> +	in_img_main.vtotal_size = timings.bt.height + timings.bt.vsync;
>>> +	in_img_main.pixel_clock = timings.bt.pixelclock / 1000;
>>> +	in_img_main.vbp_size = timings.bt.vsync - 5;
>>> +
>>> +	in_img_main.interpolation_mode =
>> HWD_VIIF_L1_INPUT_INTERPOLATION_LINE;
>>> +	in_img_main.input_num = 1;
>>> +	in_img_main.hobc_width = 0;
>>> +	in_img_main.hobc_margin = 0;
>>> +
>>> +	/* configuration of MAIN unit */
>>> +	ret = hwd_VIIF_main_set_unit(viif_dev->ch, dt_image, 0,
>> &in_img_main, color_type, rawpack,
>>> +				     yuv_conv);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "main_set_unit error. %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* Enable regbuf */
>>> +	hwd_VIIF_isp_set_regbuf_auto_transmission(viif_dev->ch,
>> VIIF_ISP_REGBUF_0,
>>> +						  VIIF_ISP_REGBUF_0, 0);
>>> +
>>> +	/* L2 UNDIST Enable through mode as default  */
>>> +	undist.through_mode = HWD_VIIF_ENABLE;
>>> +	undist.sensor_crop_ofs_h = 1 - in_img_main.hactive_size;
>>> +	undist.sensor_crop_ofs_v = 1 - in_img_main.vactive_size;
>>> +	undist.grid_node_num_h = 16;
>>> +	undist.grid_node_num_v = 16;
>>> +	ret = hwd_VIIF_l2_set_undist(viif_dev->ch, VIIF_ISP_REGBUF_0,
>> &undist);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "l2_set_undist error. %d\n", ret);
>>> +	return ret;
>>> +}
>>> +
>>> +/* ----- handling CSI2RX hardware ----- */
>>> +static int viif_csi2rx_initialize(struct viif_device *viif_dev)
>>> +{
>>> +	struct viif_subdev *viif_sd = viif_dev->sd;
>>> +	struct hwd_viif_csi2rx_line_err_target err_target = { 0 };
>>> +	struct hwd_viif_csi2rx_irq_mask csi2rx_mask;
>>> +	struct v4l2_mbus_config cfg = { 0 };
>>> +	struct v4l2_subdev_format fmt = {
>>> +		.pad = 0,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	struct v4l2_dv_timings timings;
>>> +	int num_lane, dphy_rate;
>>> +	int ret;
>>> +
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_mbus_config, 0,
>> &cfg);
>>> +	if (ret) {
>>> +		dev_dbg(viif_dev->dev, "subdev: g_mbus_config error. %d\n",
>> ret);
>>> +		num_lane = viif_sd->num_lane;
>>> +	} else {
>>> +		switch (cfg.flags & V4L2_MBUS_CSI2_LANES) {
>>> +		case V4L2_MBUS_CSI2_1_LANE:
>>> +			num_lane = 1;
>>> +			break;
>>> +		case V4L2_MBUS_CSI2_2_LANE:
>>> +			num_lane = 2;
>>> +			break;
>>> +		case V4L2_MBUS_CSI2_3_LANE:
>>> +			num_lane = 3;
>>> +			break;
>>> +		case V4L2_MBUS_CSI2_4_LANE:
>>> +			num_lane = 4;
>>> +			break;
>>> +		default:
>>> +			num_lane = 4;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, 0, &fmt);
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>> +	ret = viif_get_dv_timings(viif_dev, &timings);
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>> +	dphy_rate = (timings.bt.pixelclock / 1000) *
>> viif_get_mbus_bpp(fmt.format.code) / num_lane;
>>> +	dphy_rate = dphy_rate / 1000;
>>> +
>>> +	/* check error for CH0: all supported DTs */
>>> +	err_target.dt[0] = VISCONTI_CSI2_DT_RGB565;
>>> +	err_target.dt[1] = VISCONTI_CSI2_DT_YUV4228B;
>>> +	err_target.dt[2] = VISCONTI_CSI2_DT_YUV42210B;
>>> +	err_target.dt[3] = VISCONTI_CSI2_DT_RGB888;
>>> +	err_target.dt[4] = VISCONTI_CSI2_DT_RAW8;
>>> +	err_target.dt[5] = VISCONTI_CSI2_DT_RAW10;
>>> +	err_target.dt[6] = VISCONTI_CSI2_DT_RAW12;
>>> +	err_target.dt[7] = VISCONTI_CSI2_DT_RAW14;
>>> +
>>> +	/* Define errors to be masked */
>>> +	csi2rx_mask.mask[0] = 0x0000000F; /*check all for PHY_FATAL*/
>>> +	csi2rx_mask.mask[1] = 0x0001000F; /*check all for PKT_FATAL*/
>>> +	csi2rx_mask.mask[2] = 0x000F0F0F; /*check all for FRAME_FATAL*/
>>> +	csi2rx_mask.mask[3] = 0x000F000F; /*check all for PHY*/
>>> +	csi2rx_mask.mask[4] = 0x000F000F; /*check all for PKT*/
>>> +	csi2rx_mask.mask[5] = 0x00FF00FF; /*check all for LINE*/
>>> +
>>> +	return hwd_VIIF_csi2rx_initialize(viif_dev->ch, num_lane,
>> HWD_VIIF_CSI2_DPHY_L0L1L2L3,
>>> +					  dphy_rate, HWD_VIIF_ENABLE,
>> &err_target,
>>> +					  HWD_VIIF_CSI2_INPUT_OWN,
>> &csi2rx_mask);
>>> +}
>>> +
>>> +static int viif_csi2rx_start(struct viif_device *viif_dev)
>>> +{
>>> +	uint32_t vc_main = 0;
>>> +	struct hwd_viif_csi2rx_packet packet = { 0 };
>>> +
>>> +	viif_dev->masked_gamma_path = 0U;
>>> +
>>> +	return hwd_VIIF_csi2rx_start(viif_dev->ch, vc_main,
>> HWD_VIIF_CSI2_NOT_CAPTURE, &packet,
>>> +				     HWD_VIIF_DISABLE);
>>> +}
>>> +
>>> +static int viif_csi2rx_stop(struct viif_device *viif_dev)
>>> +{
>>> +	int32_t ret;
>>> +
>>> +	ret = hwd_VIIF_csi2rx_stop(viif_dev->ch);
>>> +	if (ret)
>>> +		dev_err(viif_dev->dev, "csi2rx_stop error. %d\n", ret);
>>> +
>>> +	hwd_VIIF_csi2rx_uninitialize(viif_dev->ch);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/* ----- subdevice video operations ----- */
>>> +static int visconti_viif_isp_s_stream(struct v4l2_subdev *sd, int enable)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	if (enable) {
>>> +		int ret = viif_csi2rx_initialize(viif_dev);
>>> +		if (ret)
>>> +			return ret;
>>> +		viif_csi2rx_start(viif_dev);
>>> +	} else {
>>> +		(void)viif_csi2rx_stop(viif_dev);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +/* ----- subdevice pad operations ----- */
>>> +static int visconti_viif_isp_enum_mbus_code(struct v4l2_subdev *sd,
>>> +					    struct v4l2_subdev_state
>> *sd_state,
>>> +					    struct
>> v4l2_subdev_mbus_code_enum *code)
>>> +{
>>> +	if (code->pad == 0) {
>>> +		/* sink */
>>> +		if (code->index > ARRAY_SIZE(visconti_mbus_formats) - 1)
>>> +			return -EINVAL;
>>> +		code->code = visconti_mbus_formats[code->index].code;
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* source */
>>> +	if (code->index > 0)
>>> +		return -EINVAL;
>>> +	code->code = MEDIA_BUS_FMT_RGB888_1X24;
>>> +	return 0;
>>> +}
>>> +
>>> +static struct v4l2_mbus_framefmt *visconti_viif_isp_get_pad_fmt(struct
>> v4l2_subdev *sd,
>>> +								struct
>> v4l2_subdev_state *sd_state,
>>> +								unsigned
>> int pad, u32 which)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	struct v4l2_subdev_state state = {
>>> +		.pads = viif_dev->isp_subdev.pad_cfg,
>>> +	};
>>> +
>>> +	if (which == V4L2_SUBDEV_FORMAT_TRY)
>>> +		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd,
>> sd_state, pad);
>>> +	else
>>> +		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd,
>> &state, pad);
>>> +}
>>> +
>>> +static struct v4l2_rect *visconti_viif_isp_get_pad_crop(struct v4l2_subdev
>> *sd,
>>> +							struct
>> v4l2_subdev_state *sd_state,
>>> +							unsigned int pad,
>> u32 which)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	struct v4l2_subdev_state state = {
>>> +		.pads = viif_dev->isp_subdev.pad_cfg,
>>> +	};
>>> +
>>> +	if (which == V4L2_SUBDEV_FORMAT_TRY)
>>> +		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd,
>> sd_state, pad);
>>> +	else
>>> +		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd,
>> &state, pad);
>>> +}
>>> +
>>> +static struct v4l2_rect *visconti_viif_isp_get_pad_compose(struct
>> v4l2_subdev *sd,
>>> +							   struct
>> v4l2_subdev_state *sd_state,
>>> +							   unsigned int pad,
>> u32 which)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	struct v4l2_subdev_state state = {
>>> +		.pads = viif_dev->isp_subdev.pad_cfg,
>>> +	};
>>> +
>>> +	if (which == V4L2_SUBDEV_FORMAT_TRY)
>>> +		return
>> v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, pad);
>>> +	else
>>> +		return
>> v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, &state, pad);
>>> +}
>>> +
>>> +static int visconti_viif_isp_get_fmt(struct v4l2_subdev *sd, struct
>> v4l2_subdev_state *sd_state,
>>> +				     struct v4l2_subdev_format *fmt)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +
>>> +	mutex_lock(&viif_dev->isp_subdev.ops_lock);
>>> +	fmt->format = *visconti_viif_isp_get_pad_fmt(sd, sd_state, fmt->pad,
>> fmt->which);
>>> +	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void visconti_viif_isp_set_sink_fmt(struct v4l2_subdev *sd,
>>> +					   struct v4l2_subdev_state
>> *sd_state,
>>> +					   struct v4l2_mbus_framefmt
>> *format, u32 which)
>>> +{
>>> +	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
>>> +
>>> +	pr_info("visconti_viif_isp_set_sink_fmt called %d", which);
>>> +
>>> +	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, 0, which);
>>> +	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, 1, which);
>>> +
>>> +	/* update mbus code only if it's available */
>>> +	if (viif_is_valid_mbus_code(format->code))
>>> +		sink_fmt->code = format->code;
>>> +
>>> +	/* sink::mbus_code is derived from src::mbus_code */
>>> +	if (viif_get_mbus_rgb_out(sink_fmt->code))
>>> +		src_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
>>> +	else
>>> +		src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
>>> +
>>> +	/* size check */
>>> +	sink_fmt->width = format->width;
>>> +	sink_fmt->height = format->height;
>>> +
>>> +	*format = *sink_fmt;
>>> +}
>>> +
>>> +static void visconti_viif_isp_set_src_fmt(struct v4l2_subdev *sd,
>>> +					  struct v4l2_subdev_state
>> *sd_state,
>>> +					  struct v4l2_mbus_framefmt
>> *format, u32 which)
>>> +{
>>> +	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
>>> +	struct v4l2_rect *src_crop;
>>> +
>>> +	pr_info("visconti_viif_isp_set_src_fmt called %d", which);
>>> +
>>> +	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, 0,
>> V4L2_SUBDEV_FORMAT_ACTIVE);
>>> +	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, 1, which);
>>> +	src_crop = visconti_viif_isp_get_pad_crop(sd, sd_state, 1, which);
>>> +
>>> +	/* sink::mbus_code is derived from src::mbus_code */
>>> +	if (viif_get_mbus_rgb_out(sink_fmt->code))
>>> +		src_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
>>> +	else
>>> +		src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
>>> +
>>> +	/*size check*/
>>> +	src_fmt->width = format->width;
>>> +	src_fmt->height = format->height;
>>> +
>>> +	/*update crop*/
>>> +	src_crop->width = format->width;
>>> +	src_crop->height = format->height;
>>> +
>>> +	*format = *src_fmt;
>>> +}
>>> +
>>> +static int visconti_viif_isp_set_fmt(struct v4l2_subdev *sd, struct
>> v4l2_subdev_state *sd_state,
>>> +				     struct v4l2_subdev_format *fmt)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +
>>> +	mutex_lock(&viif_dev->isp_subdev.ops_lock);
>>> +
>>> +	if (fmt->pad == 0)
>>> +		visconti_viif_isp_set_sink_fmt(sd, sd_state, &fmt->format,
>> fmt->which);
>>> +	else
>>> +		visconti_viif_isp_set_src_fmt(sd, sd_state, &fmt->format,
>> fmt->which);
>>> +
>>> +	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int visconti_viif_isp_init_config(struct v4l2_subdev *sd, struct
>> v4l2_subdev_state *sd_state)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
>>> +	struct v4l2_rect *src_crop, *sink_compose;
>>> +	pr_info("visconti_viif_isp_init_config called");
>>> +
>>> +	sink_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd,
>> sd_state, 0);
>>> +	sink_fmt->width = 1920;
>>> +	sink_fmt->height = 1080;
>>> +	sink_fmt->field = V4L2_FIELD_NONE;
>>> +	sink_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
>>> +
>>> +	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd,
>> sd_state, 1);
>>> +	src_fmt->width = 1920;
>>> +	src_fmt->height = 1080;
>>> +	src_fmt->field = V4L2_FIELD_NONE;
>>> +	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
>>> +
>>> +	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd,
>> sd_state, 1);
>>> +	src_crop->top = 0;
>>> +	src_crop->left = 0;
>>> +	src_crop->width = 1920;
>>> +	src_crop->height = 1080;
>>> +
>>> +	sink_compose =
>> v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, 0);
>>> +	sink_compose->top = 0;
>>> +	sink_compose->left = 0;
>>> +	sink_compose->width = 1920;
>>> +	sink_compose->height = 1080;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int visconti_viif_isp_get_selection(struct v4l2_subdev *sd,
>>> +					   struct v4l2_subdev_state
>> *sd_state,
>>> +					   struct v4l2_subdev_selection *sel)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	struct v4l2_mbus_framefmt *sink_fmt;
>>> +	int ret = -EINVAL;
>>> +
>>> +	mutex_lock(&viif_dev->isp_subdev.ops_lock);
>>> +	if (sel->pad == 0) {
>>> +		/* SINK PAD */
>>> +		switch (sel->target) {
>>> +		case V4L2_SEL_TGT_CROP:
>>> +			sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state,
>> 0, sel->which);
>>> +			sel->r.top = 0;
>>> +			sel->r.left = 0;
>>> +			sel->r.width = sink_fmt->width;
>>> +			sel->r.height = sink_fmt->height;
>>> +			ret = 0;
>>> +			break;
>>> +		case V4L2_SEL_TGT_COMPOSE:
>>> +			sel->r = *visconti_viif_isp_get_pad_compose(sd,
>> sd_state, 0, sel->which);
>>> +			ret = 0;
>>> +			break;
>>> +		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
>>> +			/* fixed value */
>>> +			sel->r.top = 0;
>>> +			sel->r.left = 0;
>>> +			sel->r.width = 8192;
>>> +			sel->r.height = 4094;
>>> +			ret = 0;
>>> +			break;
>>> +		}
>>> +	} else {
>>> +		/* SRC PAD */
>>> +		switch (sel->target) {
>>> +		case V4L2_SEL_TGT_CROP:
>>> +			sel->r = *visconti_viif_isp_get_pad_crop(sd, sd_state,
>> 1, sel->which);
>>> +			ret = 0;
>>> +			break;
>>> +		}
>>> +	}
>>> +	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int visconti_viif_isp_set_selection(struct v4l2_subdev *sd,
>>> +					   struct v4l2_subdev_state
>> *sd_state,
>>> +					   struct v4l2_subdev_selection *sel)
>>> +{
>>> +	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
>>> +	struct v4l2_mbus_framefmt *sink_fmt;
>>> +	struct v4l2_rect *rect;
>>> +	int ret = -EINVAL;
>>> +
>>> +	mutex_lock(&viif_dev->isp_subdev.ops_lock);
>>> +	/* only source::selection::crop is writable */
>>> +	if (sel->pad == 1) {
>>> +		switch (sel->target) {
>>> +		case V4L2_SEL_TGT_CROP: {
>>> +			/* TODO: validation */
>>> +			rect = visconti_viif_isp_get_pad_crop(sd, sd_state, 1,
>> sel->which);
>>> +			*rect = sel->r;
>>> +			sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state,
>> 1, sel->which);
>>> +			sink_fmt->width = sel->r.width;
>>> +			sink_fmt->height = sel->r.height;
>>> +			ret = 0;
>>> +			break;
>>> +		}
>>> +		}
>>> +	}
>>> +	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct media_entity_operations visconti_viif_isp_media_ops = {
>>> +	.link_validate = v4l2_subdev_link_validate,
>>> +};
>>> +
>>> +static const struct v4l2_subdev_pad_ops visconti_viif_isp_pad_ops = {
>>> +	.enum_mbus_code = visconti_viif_isp_enum_mbus_code,
>>> +	.get_selection = visconti_viif_isp_get_selection,
>>> +	.set_selection = visconti_viif_isp_set_selection,
>>> +	.init_cfg = visconti_viif_isp_init_config,
>>> +	.get_fmt = visconti_viif_isp_get_fmt,
>>> +	.set_fmt = visconti_viif_isp_set_fmt,
>>> +	.link_validate = v4l2_subdev_link_validate_default,
>>> +};
>>> +
>>> +static const struct v4l2_subdev_video_ops visconti_viif_isp_video_ops = {
>>> +	.s_stream = visconti_viif_isp_s_stream,
>>> +};
>>> +
>>> +static const struct v4l2_subdev_ops visconti_viif_isp_ops = {
>>> +	.video = &visconti_viif_isp_video_ops,
>>> +	.pad = &visconti_viif_isp_pad_ops,
>>> +};
>>> +
>>> +/* ----- control handler ----- */
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_BASE
>> (V4L2_CID_USER_BASE + 0x1000)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 3)
>>> +#define
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION
>> \
>>> +	(V4L2_CID_VISCONTI_VIIF_ISP_BASE + 4)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 5)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 6)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 7)
>>> +#define
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT
>> \
>>> +	(V4L2_CID_VISCONTI_VIIF_ISP_BASE + 8)
>>> +#define
>> V4L2_CID_VISCONTI_VIIF_ISP_CSI2RX_GET_CALIBRATION_STATUS
>> \
>>> +	(V4L2_CID_VISCONTI_VIIF_ISP_BASE + 9)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_CSI2RX_GET_ERR_STATUS
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 10)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 11)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 12)
>>> +#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_CROP
>> (V4L2_CID_VISCONTI_VIIF_ISP_BASE + 13)
>>> +#define COMPOUND_TYPE_SAMPLE01
>> 0x0280
>>> +
>>> +int viif_l1_set_input_mode(struct viif_device *viif_dev,
>>> +			   struct viif_l1_input_mode_config *input_mode);
>>> +int viif_l1_set_black_level_correction(struct viif_device *viif_dev,
>>> +				       struct
>> viif_l1_black_level_correction_config *blc);
>>> +int viif_l1_set_main_process(struct viif_device *viif_dev,
>>> +			     struct viif_l1_main_process_config *mpro);
>>> +int viif_l1_set_awb(struct viif_device *viif_dev, struct viif_l1_awb_config
>> *l1_awb);
>>> +int viif_l1_set_hdrc(struct viif_device *viif_dev, struct viif_l1_hdrc_config
>> *hdrc);
>>> +int viif_l1_set_img_quality_adjustment(struct viif_device *viif_dev,
>>> +				       struct
>> viif_l1_img_quality_adjustment_config *img_quality);
>>> +int viif_csi2rx_get_calibration_status(
>>> +	struct viif_device *viif_dev,
>>> +	struct viif_csi2rx_dphy_calibration_status *calibration_status);
>>> +int viif_csi2rx_get_err_status(struct viif_device *viif_dev,
>>> +			       struct viif_csi2rx_err_status *csi_err);
>>> +int viif_l2_set_undist(struct viif_device *viif_dev, struct
>> viif_l2_undist_config *undist);
>>> +int viif_l2_set_roi(struct viif_device *viif_dev, struct viif_l2_roi_config *roi);
>>> +int viif_l2_set_crop(struct viif_device *viif_dev, struct viif_l2_crop_config
>> *l2_crop);
>>> +
>>> +static int viif_l2_set_roi_wrap(struct viif_device *viif_dev, struct
>> viif_l2_roi_config *roi)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = viif_l2_set_roi(viif_dev, roi);
>>> +	if (!ret) {
>>> +		struct v4l2_rect *rect;
>>> +		rect =
>> visconti_viif_isp_get_pad_compose(&viif_dev->isp_subdev.sd, NULL, 0,
>>> +
>> V4L2_SUBDEV_FORMAT_ACTIVE);
>>> +		rect->top = 0;
>>> +		rect->left = 0;
>>> +		rect->width = roi->corrected_hsize;
>>> +		rect->height = roi->corrected_vsize;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int visconti_viif_isp_set_ctrl(struct v4l2_ctrl *ctrl)
>>> +{
>>> +	struct viif_device *viif_dev = ctrl->priv;
>>> +
>>> +	pr_info("isp_set_ctrl: %s", ctrl->name);
>>> +	if (!viif_dev->is_powered) {
>>> +		pr_info("warning: visconti viif HW is not powered");
>>> +		return 0;
>>> +	}
>>> +
>>> +	switch (ctrl->id) {
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
>>> +		return viif_l1_set_input_mode(viif_dev, ctrl->p_new.p);
>>> +	case
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
>>> +		return viif_l1_set_black_level_correction(viif_dev,
>> ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
>>> +		return viif_l1_set_main_process(viif_dev, ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
>>> +		return viif_l1_set_awb(viif_dev, ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
>>> +		return viif_l1_set_hdrc(viif_dev, ctrl->p_new.p);
>>> +	case
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
>>> +		return viif_l1_set_img_quality_adjustment(viif_dev,
>> ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
>>> +		return viif_l2_set_undist(viif_dev, ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
>>> +		return viif_l2_set_roi_wrap(viif_dev, ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_CROP:
>>> +		return viif_l2_set_crop(viif_dev, ctrl->p_new.p);
>>> +	default:
>>> +		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
>>> +		break;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static int visconti_viif_isp_get_ctrl(struct v4l2_ctrl *ctrl)
>>> +{
>>> +	struct viif_device *viif_dev = ctrl->priv;
>>> +
>>> +	pr_info("isp_get_ctrl: %s", ctrl->name);
>>> +	if (!viif_dev->is_powered) {
>>> +		pr_info("warning: visconti viif HW is not powered");
>>> +		return 0;
>>> +	}
>>> +
>>> +	switch (ctrl->id) {
>>> +	case
>> V4L2_CID_VISCONTI_VIIF_ISP_CSI2RX_GET_CALIBRATION_STATUS:
>>> +		return viif_csi2rx_get_calibration_status(viif_dev,
>> ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_ISP_CSI2RX_GET_ERR_STATUS:
>>> +		return viif_csi2rx_get_err_status(viif_dev, ctrl->p_new.p);
>>> +	default:
>>> +		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
>>> +		break;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct v4l2_ctrl_ops visconti_viif_isp_ctrl_ops = {
>>> +	.g_volatile_ctrl = visconti_viif_isp_get_ctrl,
>>> +	.s_ctrl = visconti_viif_isp_set_ctrl,
>>> +};
>>> +
>>> +static bool visconti_viif_isp_custom_ctrl_equal(const struct v4l2_ctrl *ctrl,
>> u32 idx,
>>> +						union v4l2_ctrl_ptr ptr1,
>> union v4l2_ctrl_ptr ptr2)
>>> +{
>>> +	return !memcmp(ptr1.p_const, ptr2.p_const, ctrl->elem_size);
>>> +}
>>> +
>>> +static void visconti_viif_isp_custom_ctrl_init(const struct v4l2_ctrl *ctrl, u32
>> idx,
>>> +					       union v4l2_ctrl_ptr ptr)
>>> +{
>>> +	if (ctrl->p_def.p_const)
>>> +		memcpy(ptr.p, ctrl->p_def.p_const, ctrl->elem_size);
>>> +	else
>>> +		memset(ptr.p, 0, ctrl->elem_size);
>>> +}
>>> +
>>> +static void visconti_viif_isp_custom_ctrl_log(const struct v4l2_ctrl *ctrl)
>>> +{
>>> +	pr_cont("viif specific: %s", ctrl->name);
>>> +	return;
>>> +}
>>> +
>>> +static int visconti_viif_isp_custom_ctrl_validate(const struct v4l2_ctrl *ctrl,
>> u32 idx,
>>> +						  union v4l2_ctrl_ptr ptr)
>>> +{
>>> +	pr_info("std_validate: %s", ctrl->name);
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct v4l2_ctrl_type_ops custom_type_ops = {
>>> +	.equal = visconti_viif_isp_custom_ctrl_equal,
>>> +	.init = visconti_viif_isp_custom_ctrl_init,
>>> +	.log = visconti_viif_isp_custom_ctrl_log,
>>> +	.validate = visconti_viif_isp_custom_ctrl_validate,
>>> +};
>>> +
>>> +#define CTRL_CONFIG_DEFAULT_ENTRY
>> \
>>> +	.ops = &visconti_viif_isp_ctrl_ops, .type_ops = &custom_type_ops,
>> \
>>> +	.type = COMPOUND_TYPE_SAMPLE01, .flags =
>> V4L2_CTRL_FLAG_EXECUTE_ON_WRITE
>>> +
>>> +#define CTRL_CONFIG_RDONLY_ENTRY
>> \
>>> +	.ops = &visconti_viif_isp_ctrl_ops, .type_ops = &custom_type_ops,
>> \
>>> +	.type = COMPOUND_TYPE_SAMPLE01, .flags =
>> V4L2_CTRL_FLAG_VOLATILE
>>> +
>>> +static const struct v4l2_ctrl_config visconti_viif_isp_ctrl_config[] = {
>>> +	/* L1_SET_INPUT_MODE */ {
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE,
>>> +		.name = "l1_input_mode",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l1_input_mode_config),
>>> +	},
>>> +	/* L1_SET_BLACK_LEVEL_CORRECTION */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id =
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION,
>>> +		.name = "l1_black_level_correction",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct
>> viif_l1_black_level_correction_config),
>>> +	},
>>> +	/* L1_SET_MAIN_PROCESS */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id =
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS,
>>> +		.name = "l1_main_process",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l1_main_process_config),
>>> +	},
>>> +	/* L1_SET_AWB */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB,
>>> +		.name = "l1_awb",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l1_awb_config),
>>> +	},
>>> +	/* L1_SET_HDRC */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC,
>>> +		.name = "l1_hdrc",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l1_hdrc_config),
>>> +	},
>>> +	/* L1_SET_IMG_QUALITY_ADJUSTMENT */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id =
>> V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT,
>>> +		.name = "l1_img_quality_adjustment",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct
>> viif_l1_img_quality_adjustment_config),
>>> +	},
>>> +	/* CSI2RX_GET_CALIBRATION_STATUS */
>>> +	{
>>> +		CTRL_CONFIG_RDONLY_ENTRY,
>>> +		.id =
>> V4L2_CID_VISCONTI_VIIF_ISP_CSI2RX_GET_CALIBRATION_STATUS,
>>> +		.name = "csi2rx_calibration_status",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct
>> viif_csi2rx_dphy_calibration_status),
>>> +	},
>>> +	/* CSI2RX_GET_ERR_STATUS */
>>> +	{
>>> +		CTRL_CONFIG_RDONLY_ENTRY,
>>> +		.id =
>> V4L2_CID_VISCONTI_VIIF_ISP_CSI2RX_GET_ERR_STATUS,
>>> +		.name = "csi2rx_err_status",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_csi2rx_err_status),
>>> +	},
>>> +	/* L2_SET_UNDIST */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST,
>>> +		.name = "l2_undist",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l2_undist_config),
>>> +	},
>>> +	/* L2_SET_ROI */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI,
>>> +		.name = "l2_roi",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l2_roi_config),
>>> +	},
>>> +	/* L2_SET_CROP */
>>> +	{
>>> +		CTRL_CONFIG_DEFAULT_ENTRY,
>>> +		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_CROP,
>>> +		.name = "l2_crop",
>>> +		.p_def = { .p_const = NULL },
>>> +		.elem_size = sizeof(struct viif_l2_crop_config),
>>> +	},
>>> +
>>> +};
>>> +
>>> +static int visconti_viif_isp_init_controls(struct viif_device *viif_dev)
>>> +{
>>> +	struct v4l2_ctrl_handler *ctrl_handler =
>> &viif_dev->isp_subdev.ctrl_handler;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	ret = v4l2_ctrl_handler_init(ctrl_handler, 10);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "failed on v4l2_ctrl_handler_init");
>>> +		return ret;
>>> +	}
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(visconti_viif_isp_ctrl_config); i++) {
>>> +		struct v4l2_ctrl *ctrl;
>>> +
>>> +		ctrl = v4l2_ctrl_new_custom(ctrl_handler,
>> &visconti_viif_isp_ctrl_config[i],
>>> +					    viif_dev);
>>> +		if (ctrl == NULL) {
>>> +			dev_err(viif_dev->dev, "failed to add ctrl crop: %d",
>> ctrl_handler->error);
>>> +			return ctrl_handler->error;
>>> +		}
>>> +	}
>>> +
>>> +	viif_dev->isp_subdev.sd.ctrl_handler =
>> &viif_dev->isp_subdev.ctrl_handler;
>>> +	return 0;
>>> +}
>>> +
>>> +/* ----- register/remove isp subdevice node ----- */
>>> +int visconti_viif_isp_register(struct viif_device *viif_dev)
>>> +{
>>> +	struct v4l2_subdev_state state = {
>>> +		.pads = viif_dev->isp_subdev.pad_cfg,
>>> +	};
>>> +	struct media_pad *pads = viif_dev->isp_subdev.pads;
>>> +	struct v4l2_subdev *sd = &viif_dev->isp_subdev.sd;
>>> +	int ret;
>>> +
>>> +	viif_dev->isp_subdev.viif_dev = viif_dev;
>>> +
>>> +	v4l2_subdev_init(sd, &visconti_viif_isp_ops);
>>> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>>> +	sd->entity.ops = &visconti_viif_isp_media_ops;
>>> +	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
>>> +	sd->owner = THIS_MODULE;
>>> +	strscpy(sd->name, "visconti-viif:isp", sizeof(sd->name));
>>> +
>>> +	pads[0].flags = MEDIA_PAD_FL_SINK |
>> MEDIA_PAD_FL_MUST_CONNECT;
>>> +	pads[1].flags = MEDIA_PAD_FL_SOURCE |
>> MEDIA_PAD_FL_MUST_CONNECT;
>>> +
>>> +	mutex_init(&viif_dev->isp_subdev.ops_lock);
>>> +
>>> +	visconti_viif_isp_init_controls(viif_dev);
>>> +
>>> +	ret = media_entity_pads_init(&sd->entity, 2, pads);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "Failed on media_entity_pads_init\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = v4l2_device_register_subdev(&viif_dev->v4l2_dev, sd);
>>> +	if (ret) {
>>> +		dev_err(viif_dev->dev, "Failed to resize ISP subdev\n");
>>> +		goto err_cleanup_media_entity;
>>> +	}
>>> +
>>> +	visconti_viif_isp_init_config(sd, &state);
>>> +
>>> +	return 0;
>>> +
>>> +err_cleanup_media_entity:
>>> +	media_entity_cleanup(&sd->entity);
>>> +	return ret;
>>> +}
>>> +
>>> +void visconti_viif_isp_unregister(struct viif_device *viif_dev)
>>> +{
>>> +	v4l2_device_unregister_subdev(&viif_dev->isp_subdev.sd);
>>> +	media_entity_cleanup(&viif_dev->isp_subdev.sd.entity);
>>> +}

