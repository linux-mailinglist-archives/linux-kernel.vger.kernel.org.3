Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3AC514630
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357241AbiD2KGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiD2KGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F66C44CD;
        Fri, 29 Apr 2022 03:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D83622E9;
        Fri, 29 Apr 2022 10:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A53DC385A4;
        Fri, 29 Apr 2022 10:03:13 +0000 (UTC)
Message-ID: <c21c4b34-812e-7ccd-5bb2-4d9b29d1acec@xs4all.nl>
Date:   Fri, 29 Apr 2022 12:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 08/13] media: atmel: atmel-isc: change format
 propagation to subdev into only verification
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu.Beznea@microchip.com, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
 <20220310095202.2701399-9-eugen.hristev@microchip.com>
 <39f541ec-313f-fe15-b93f-dd78469b2366@xs4all.nl>
 <b6630c65-0720-3633-d5ed-aadf4716f206@microchip.com>
 <dabbff36-a10c-0a8a-94e8-ce7c2d896403@xs4all.nl>
 <20220429095848.ec4xnul6tin6n7sf@uno.localdomain>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220429095848.ec4xnul6tin6n7sf@uno.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 11:58, Jacopo Mondi wrote:
> Hello
> 
> On Fri, Apr 29, 2022 at 10:43:09AM +0200, Hans Verkuil wrote:
>> On 29/04/2022 10:28, Eugen.Hristev@microchip.com wrote:
>>> On 4/29/22 11:17 AM, Hans Verkuil wrote:
>>>> On 10/03/2022 10:51, Eugen Hristev wrote:
>>>>> As a top MC video driver, the atmel-isc should not propagate the format to the
>>>>> subdevice, it should rather check at start_streaming() time if the subdev is properly
>>>>> configured with a compatible format.
>>>>> Removed the whole format finding logic, and reworked the format verification
>>>>> at start_streaming time, such that the ISC will return an error if the subdevice
>>>>> is not properly configured. To achieve this, media_pipeline_start
>>>>> is called and a link_validate callback is created to check the formats.
>>>>> With this being done, the module parameter 'sensor_preferred' makes no sense
>>>>> anymore. The ISC should not decide which format the sensor is using. The
>>>>> ISC should only cope with the situation and inform userspace if the streaming
>>>>> is possible in the current configuration.
>>>>> The redesign of the format propagation has also risen the question of the
>>>>> enumfmt callback. If enumfmt is called with an mbus_code, the enumfmt handler
>>>>> should only return the formats that are supported for this mbus_code.
>>>>> Otherwise, the enumfmt will report all the formats that the ISC could output.
>>>>> With this rework, the dynamic list of user formats is removed. It makes no
>>>>> more sense to identify at complete time which formats the sensor could emit,
>>>>> and add those into a separate dynamic list.
>>>>> The ISC will start with a simple preconfigured default format, and at
>>>>> link validate time, decide whether it can use the format that is configured
>>>>> on the sink or not.
>>>>>
>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>>>> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
>>>>> ---
>>>>> Changes in v9:
>>>>> - isc_link_validate now static
>>>>>
>>>>> Changes in v7:
>>>>> - minor typos as suggested by Jacopo
>>>>> - small changes, reduce some indentation, modified an index, as suggested by
>>>>> Jacopo
>>>>>
>>>>> Changes in v6:
>>>>> - reworked a bit enum_fmt as suggested by Jacopo
>>>>>
>>>>> Changes in v5:
>>>>> - removed user_formats dynamic list as it is now pointless
>>>>> - greatly simplified the enum_fmt function
>>>>> - removed some init code that was useless now
>>>>>
>>>>> Changes in v4:
>>>>> - moved validation code into link_validate and used media_pipeline_start
>>>>> - merged this patch with the enum_fmt patch which was previously in v3 of
>>>>> the series
>>>>>
>>>>> Changes in v3:
>>>>> - clamp to maximum resolution once the frame size from the subdev is found
>>>>>   drivers/media/platform/atmel/atmel-isc-base.c | 412 ++++++++----------
>>>>>   .../media/platform/atmel/atmel-isc-scaler.c   |   5 +
>>>>>   drivers/media/platform/atmel/atmel-isc.h      |  13 +-
>>>>>   .../media/platform/atmel/atmel-sama5d2-isc.c  |  20 +
>>>>>   .../media/platform/atmel/atmel-sama7g5-isc.c  |  20 +
>>>>>   5 files changed, 236 insertions(+), 234 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
>>>>> index ee1dda6707a0..fe2c0af58060 100644
>>>>> --- a/drivers/media/platform/atmel/atmel-isc-base.c
>>>>> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
>>>>> @@ -36,11 +36,6 @@ static unsigned int debug;
>>>>>   module_param(debug, int, 0644);
>>>>>   MODULE_PARM_DESC(debug, "debug level (0-2)");
>>>>>
>>>>> -static unsigned int sensor_preferred = 1;
>>>>> -module_param(sensor_preferred, uint, 0644);
>>>>> -MODULE_PARM_DESC(sensor_preferred,
>>>>> -              "Sensor is preferred to output the specified format (1-on 0-off), default 1");
>>>>> -
>>>>>   #define ISC_IS_FORMAT_RAW(mbus_code) \
>>>>>        (((mbus_code) & 0xf000) == 0x3000)
>>>>>
>>>>> @@ -337,6 +332,10 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>>>>>        unsigned long flags;
>>>>>        int ret;
>>>>>
>>>>> +     ret = media_pipeline_start(&isc->video_dev.entity, &isc->mpipe);
>>>>
>>>> The pipeline validation is done in start_streaming, but I don't think that
>>>> is the best place: if STREAMON is called before buffers are queued, then
>>>> an invalid pipeline isn't discovered until enough buffers are queued to
>>>> kick off start_streaming.
>>>>
>>>> Drivers like vsp1, omap3isp and the samsung drivers all do this in streamon().
>>>>
>>>> I think that is the correct time to do this.
>>>
>>> Hello Hans,
>>>
>>> Initially (v2, v3) I had this in streamon(). The problem that I faced at
>>> that time was that streamoff was never called, so I could not call
>>> media_pipeline_stop(). Then Jacopo told me to move it to start_streaming
>>> (see change log for v4) , and I did not face any more problems.
> 
> Yes indeed, seems I suggested to use media_pipeline_handler in a
> comment on your v3
> 
> "at s_stream time your top driver calls media_pipeline_start()"
> 
> sorry about that, I should have looked around a bit more carefully and
> notice most drivers do so at vb2 streamon
> 
> However I don't see media_pipeline_start being called at all in v3 of
> the patch
> 
>>
>> It's a mess. Looking at some drivers I see that omap3isp calls media_pipeline_stop
>> in streamoff (so will have the same problem as you described if VIDIOC_STREAMOFF
>> isn't called), exynos4-is does the same, but it also checks the streaming state in
>> the release() fop callback, so that would fix this problem. And vimc does this
>> in stop_streaming.
>>
>> I'm in favor of fixing this in vb2, that framework knows exactly when this needs
>> to be called.
> 
> Are you suggesting to have vb2 to call media_pipeline_start() or is it
> more complex than this ?

No, I don't think vb2 should do that. But it needs two new ops: pipeline_start/stop
(or some other name) that are called at VIDIOC_STREAMON time and when the streaming
stops (due to STREAMOFF or by closing the fh). The driver can then take appropriate
action, which will typically be calling media_pipeline_start/stop, but other checks
may also be needed at that time.

Regards,

	Hans

> 
>>
>> I'd like to know what others think.
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>> Eugen
>>>
>>>>
>>>> Laurent, Jacopo, do you agree with that?
>>>>
>>>> I notice that quite a few other drivers do this in start_streaming as well,
>>>> but I think it just weird that a QBUF can return EPIPE while STREAMON might
>>>> succeed.
>>>>
>>>> Perhaps we need an optional vb2 validate() callback that is called by
>>>> vb2_core_streamon() to validate the pipeline before streaming. That makes
>>>> it easier to implement these checks rather than having to implement your
>>>> own streamon ioctl.
>>>>
>>>> Regards,
>>>>
>>>>          Hans
>>>>
>>>>> +     if (ret)
>>>>> +             goto err_pipeline_start;
>>>>> +
>>>>>        /* Enable stream on the sub device */
>>>>>        ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
>>>>>        if (ret && ret != -ENOIOCTLCMD) {
>>>>> @@ -385,6 +384,9 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>>>>>        v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
>>>>>
>>>>>   err_start_stream:
>>>>> +     media_pipeline_stop(&isc->video_dev.entity);
>>>>> +
>>>>> +err_pipeline_start:
>>>>>        spin_lock_irqsave(&isc->dma_queue_lock, flags);
>>>>>        list_for_each_entry(buf, &isc->dma_queue, list)
>>>>>                vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
>>>>> @@ -423,6 +425,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
>>>>>        if (ret && ret != -ENOIOCTLCMD)
>>>>>                v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
>>>>>
>>>>> +     /* Stop media pipeline */
>>>>> +     media_pipeline_stop(&isc->video_dev.entity);
>>>>> +
>>>>>        /* Release all active buffers */
>>>>>        spin_lock_irqsave(&isc->dma_queue_lock, flags);
>>>>>        if (unlikely(isc->cur_frm)) {
>>>>> @@ -453,22 +458,6 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
>>>>>        spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
>>>>>   }
>>>>>
>>>>> -static struct isc_format *find_format_by_fourcc(struct isc_device *isc,
>>>>> -                                              unsigned int fourcc)
>>>>> -{
>>>>> -     unsigned int num_formats = isc->num_user_formats;
>>>>> -     struct isc_format *fmt;
>>>>> -     unsigned int i;
>>>>> -
>>>>> -     for (i = 0; i < num_formats; i++) {
>>>>> -             fmt = isc->user_formats[i];
>>>>> -             if (fmt->fourcc == fourcc)
>>>>> -                     return fmt;
>>>>> -     }
>>>>> -
>>>>> -     return NULL;
>>>>> -}
>>>>> -
>>>>>   static const struct vb2_ops isc_vb2_ops = {
>>>>>        .queue_setup            = isc_queue_setup,
>>>>>        .wait_prepare           = vb2_ops_wait_prepare,
>>>>> @@ -497,23 +486,57 @@ static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
>>>>>   {
>>>>>        struct isc_device *isc = video_drvdata(file);
>>>>>        u32 index = f->index;
>>>>> -     u32 i, supported_index;
>>>>> +     u32 i, supported_index = 0;
>>>>> +     struct isc_format *fmt;
>>>>> +
>>>>> +     /*
>>>>> +      * If we are not asked a specific mbus_code, we have to report all
>>>>> +      * the formats that we can output.
>>>>> +      */
>>>>> +     if (!f->mbus_code) {
>>>>> +             if (index >= isc->controller_formats_size)
>>>>> +                     return -EINVAL;
>>>>>
>>>>> -     if (index < isc->controller_formats_size) {
>>>>>                f->pixelformat = isc->controller_formats[index].fourcc;
>>>>> +
>>>>> +             return 0;
>>>>> +     }
>>>>> +
>>>>> +     /*
>>>>> +      * If a specific mbus_code is requested, check if we support
>>>>> +      * this mbus_code as input for the ISC.
>>>>> +      * If it's supported, then we report the corresponding pixelformat
>>>>> +      * as first possible option for the ISC.
>>>>> +      * E.g. mbus MEDIA_BUS_FMT_YUYV8_2X8 and report
>>>>> +      * 'YUYV' (YUYV 4:2:2)
>>>>> +      */
>>>>> +     fmt = isc_find_format_by_code(isc, f->mbus_code, &i);
>>>>> +     if (!fmt)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     if (!index) {
>>>>> +             f->pixelformat = fmt->fourcc;
>>>>> +
>>>>>                return 0;
>>>>>        }
>>>>>
>>>>> -     index -= isc->controller_formats_size;
>>>>> +     supported_index++;
>>>>>
>>>>> -     supported_index = 0;
>>>>> +     /* If the index is not raw, we don't have anymore formats to report */
>>>>> +     if (!ISC_IS_FORMAT_RAW(f->mbus_code))
>>>>> +             return -EINVAL;
>>>>>
>>>>> -     for (i = 0; i < isc->formats_list_size; i++) {
>>>>> -             if (!ISC_IS_FORMAT_RAW(isc->formats_list[i].mbus_code) ||
>>>>> -                 !isc->formats_list[i].sd_support)
>>>>> +     /*
>>>>> +      * We are asked for a specific mbus code, which is raw.
>>>>> +      * We have to search through the formats we can convert to.
>>>>> +      * We have to skip the raw formats, we cannot convert to raw.
>>>>> +      * E.g. 'AR12' (16-bit ARGB 4-4-4-4), 'AR15' (16-bit ARGB 1-5-5-5), etc.
>>>>> +      */
>>>>> +     for (i = 0; i < isc->controller_formats_size; i++) {
>>>>> +             if (isc->controller_formats[i].raw)
>>>>>                        continue;
>>>>> -             if (supported_index == index) {
>>>>> -                     f->pixelformat = isc->formats_list[i].fourcc;
>>>>> +             if (index == supported_index) {
>>>>> +                     f->pixelformat = isc->controller_formats[i].fourcc;
>>>>>                        return 0;
>>>>>                }
>>>>>                supported_index++;
>>>>> @@ -584,20 +607,30 @@ static int isc_try_validate_formats(struct isc_device *isc)
>>>>>                break;
>>>>>        default:
>>>>>        /* any other different formats are not supported */
>>>>> +             v4l2_err(&isc->v4l2_dev, "Requested unsupported format.\n");
>>>>>                ret = -EINVAL;
>>>>>        }
>>>>>        v4l2_dbg(1, debug, &isc->v4l2_dev,
>>>>>                 "Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
>>>>>                 rgb, yuv, grey, bayer);
>>>>>
>>>>> -     /* we cannot output RAW if we do not receive RAW */
>>>>> -     if ((bayer) && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
>>>>> +     if (bayer &&
>>>>> +         !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
>>>>> +             v4l2_err(&isc->v4l2_dev, "Cannot output RAW if we do not receive RAW.\n");
>>>>>                return -EINVAL;
>>>>> +     }
>>>>>
>>>>> -     /* we cannot output GREY if we do not receive RAW/GREY */
>>>>>        if (grey && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code) &&
>>>>> -         !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code))
>>>>> +         !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
>>>>> +             v4l2_err(&isc->v4l2_dev, "Cannot output GREY if we do not receive RAW/GREY.\n");
>>>>>                return -EINVAL;
>>>>> +     }
>>>>> +
>>>>> +     if ((rgb || bayer || yuv) &&
>>>>> +         ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
>>>>> +             v4l2_err(&isc->v4l2_dev, "Cannot convert GREY to another format.\n");
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>>
>>>>>        return ret;
>>>>>   }
>>>>> @@ -825,7 +858,7 @@ static void isc_try_fse(struct isc_device *isc,
>>>>>         * If we do not know yet which format the subdev is using, we cannot
>>>>>         * do anything.
>>>>>         */
>>>>> -     if (!isc->try_config.sd_format)
>>>>> +     if (!isc->config.sd_format)
>>>>>                return;
>>>>>
>>>>>        fse.code = isc->try_config.sd_format->mbus_code;
>>>>> @@ -846,180 +879,140 @@ static void isc_try_fse(struct isc_device *isc,
>>>>>        }
>>>>>   }
>>>>>
>>>>> -static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
>>>>> -                     u32 *code)
>>>>> +static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f)
>>>>>   {
>>>>> -     int i;
>>>>> -     struct isc_format *sd_fmt = NULL, *direct_fmt = NULL;
>>>>>        struct v4l2_pix_format *pixfmt = &f->fmt.pix;
>>>>> -     struct v4l2_subdev_pad_config pad_cfg = {};
>>>>> -     struct v4l2_subdev_state pad_state = {
>>>>> -             .pads = &pad_cfg
>>>>> -             };
>>>>> -     struct v4l2_subdev_format format = {
>>>>> -             .which = V4L2_SUBDEV_FORMAT_TRY,
>>>>> -     };
>>>>> -     u32 mbus_code;
>>>>> -     int ret;
>>>>> -     bool rlp_dma_direct_dump = false;
>>>>> +     unsigned int i;
>>>>>
>>>>>        if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>>>>>                return -EINVAL;
>>>>>
>>>>> -     /* Step 1: find a RAW format that is supported */
>>>>> -     for (i = 0; i < isc->num_user_formats; i++) {
>>>>> -             if (ISC_IS_FORMAT_RAW(isc->user_formats[i]->mbus_code)) {
>>>>> -                     sd_fmt = isc->user_formats[i];
>>>>> +     isc->try_config.fourcc = isc->controller_formats[0].fourcc;
>>>>> +
>>>>> +     /* find if the format requested is supported */
>>>>> +     for (i = 0; i < isc->controller_formats_size; i++)
>>>>> +             if (isc->controller_formats[i].fourcc == pixfmt->pixelformat) {
>>>>> +                     isc->try_config.fourcc = pixfmt->pixelformat;
>>>>>                        break;
>>>>>                }
>>>>> -     }
>>>>> -     /* Step 2: We can continue with this RAW format, or we can look
>>>>> -      * for better: maybe sensor supports directly what we need.
>>>>> -      */
>>>>> -     direct_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
>>>>> -
>>>>> -     /* Step 3: We have both. We decide given the module parameter which
>>>>> -      * one to use.
>>>>> -      */
>>>>> -     if (direct_fmt && sd_fmt && sensor_preferred)
>>>>> -             sd_fmt = direct_fmt;
>>>>> -
>>>>> -     /* Step 4: we do not have RAW but we have a direct format. Use it. */
>>>>> -     if (direct_fmt && !sd_fmt)
>>>>> -             sd_fmt = direct_fmt;
>>>>> -
>>>>> -     /* Step 5: if we are using a direct format, we need to package
>>>>> -      * everything as 8 bit data and just dump it
>>>>> -      */
>>>>> -     if (sd_fmt == direct_fmt)
>>>>> -             rlp_dma_direct_dump = true;
>>>>> -
>>>>> -     /* Step 6: We have no format. This can happen if the userspace
>>>>> -      * requests some weird/invalid format.
>>>>> -      * In this case, default to whatever we have
>>>>> -      */
>>>>> -     if (!sd_fmt && !direct_fmt) {
>>>>> -             sd_fmt = isc->user_formats[isc->num_user_formats - 1];
>>>>> -             v4l2_dbg(1, debug, &isc->v4l2_dev,
>>>>> -                      "Sensor not supporting %.4s, using %.4s\n",
>>>>> -                      (char *)&pixfmt->pixelformat, (char *)&sd_fmt->fourcc);
>>>>> -     }
>>>>> -
>>>>> -     if (!sd_fmt) {
>>>>> -             ret = -EINVAL;
>>>>> -             goto isc_try_fmt_err;
>>>>> -     }
>>>>> -
>>>>> -     /* Step 7: Print out what we decided for debugging */
>>>>> -     v4l2_dbg(1, debug, &isc->v4l2_dev,
>>>>> -              "Preferring to have sensor using format %.4s\n",
>>>>> -              (char *)&sd_fmt->fourcc);
>>>>>
>>>>> -     /* Step 8: at this moment we decided which format the subdev will use */
>>>>> -     isc->try_config.sd_format = sd_fmt;
>>>>> +     isc_try_configure_rlp_dma(isc, false);
>>>>>
>>>>>        /* Limit to Atmel ISC hardware capabilities */
>>>>> -     if (pixfmt->width > isc->max_width)
>>>>> -             pixfmt->width = isc->max_width;
>>>>> -     if (pixfmt->height > isc->max_height)
>>>>> -             pixfmt->height = isc->max_height;
>>>>> -
>>>>> -     /*
>>>>> -      * The mbus format is the one the subdev outputs.
>>>>> -      * The pixels will be transferred in this format Sensor -> ISC
>>>>> -      */
>>>>> -     mbus_code = sd_fmt->mbus_code;
>>>>> -
>>>>> -     /*
>>>>> -      * Validate formats. If the required format is not OK, default to raw.
>>>>> -      */
>>>>> -
>>>>> -     isc->try_config.fourcc = pixfmt->pixelformat;
>>>>> -
>>>>> -     if (isc_try_validate_formats(isc)) {
>>>>> -             pixfmt->pixelformat = isc->try_config.fourcc = sd_fmt->fourcc;
>>>>> -             /* Re-try to validate the new format */
>>>>> -             ret = isc_try_validate_formats(isc);
>>>>> -             if (ret)
>>>>> -                     goto isc_try_fmt_err;
>>>>> -     }
>>>>> -
>>>>> -     ret = isc_try_configure_rlp_dma(isc, rlp_dma_direct_dump);
>>>>> -     if (ret)
>>>>> -             goto isc_try_fmt_err;
>>>>> -
>>>>> -     ret = isc_try_configure_pipeline(isc);
>>>>> -     if (ret)
>>>>> -             goto isc_try_fmt_err;
>>>>> -
>>>>> -     /* Obtain frame sizes if possible to have crop requirements ready */
>>>>> -     isc_try_fse(isc, &pad_state);
>>>>> -
>>>>> -     v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
>>>>> -     ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
>>>>> -                            &pad_state, &format);
>>>>> -     if (ret < 0)
>>>>> -             goto isc_try_fmt_subdev_err;
>>>>> -
>>>>> -     v4l2_fill_pix_format(pixfmt, &format.format);
>>>>> +     v4l_bound_align_image(&pixfmt->width, 16, isc->max_width, 0,
>>>>> +                           &pixfmt->height, 16, isc->max_height, 0, 0);
>>>>> +     /* If we did not find the requested format, we will fallback here */
>>>>> +     pixfmt->pixelformat = isc->try_config.fourcc;
>>>>> +     pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
>>>>> +     pixfmt->field = V4L2_FIELD_NONE;
>>>>>
>>>>> -     /* Limit to Atmel ISC hardware capabilities */
>>>>> -     if (pixfmt->width > isc->max_width)
>>>>> -             pixfmt->width = isc->max_width;
>>>>> -     if (pixfmt->height > isc->max_height)
>>>>> -             pixfmt->height = isc->max_height;
>>>>>
>>>>> -     pixfmt->field = V4L2_FIELD_NONE;
>>>>>        pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
>>>>>        pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
>>>>>                             pixfmt->height;
>>>>>
>>>>> -     if (code)
>>>>> -             *code = mbus_code;
>>>>> +     isc->try_fmt = *f;
>>>>>
>>>>>        return 0;
>>>>> +}
>>>>>
>>>>> -isc_try_fmt_err:
>>>>> -     v4l2_err(&isc->v4l2_dev, "Could not find any possible format for a working pipeline\n");
>>>>> -isc_try_fmt_subdev_err:
>>>>> -     memset(&isc->try_config, 0, sizeof(isc->try_config));
>>>>> +static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
>>>>> +{
>>>>> +     isc_try_fmt(isc, f);
>>>>>
>>>>> -     return ret;
>>>>> +     /* make the try configuration active */
>>>>> +     isc->config = isc->try_config;
>>>>> +     isc->fmt = isc->try_fmt;
>>>>> +
>>>>> +     v4l2_dbg(1, debug, &isc->v4l2_dev, "ISC set_fmt to %.4s @%dx%d\n",
>>>>> +              (char *)&f->fmt.pix.pixelformat,
>>>>> +              f->fmt.pix.width, f->fmt.pix.height);
>>>>> +
>>>>> +     return 0;
>>>>>   }
>>>>>
>>>>> -static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
>>>>> +static int isc_validate(struct isc_device *isc)
>>>>>   {
>>>>> +     int ret;
>>>>> +     int i;
>>>>> +     struct isc_format *sd_fmt = NULL;
>>>>> +     struct v4l2_pix_format *pixfmt = &isc->fmt.fmt.pix;
>>>>>        struct v4l2_subdev_format format = {
>>>>>                .which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>>>> +             .pad = isc->remote_pad,
>>>>> +     };
>>>>> +     struct v4l2_subdev_pad_config pad_cfg = {};
>>>>> +     struct v4l2_subdev_state pad_state = {
>>>>> +             .pads = &pad_cfg,
>>>>>        };
>>>>> -     u32 mbus_code = 0;
>>>>> -     int ret;
>>>>>
>>>>> -     ret = isc_try_fmt(isc, f, &mbus_code);
>>>>> +     /* Get current format from subdev */
>>>>> +     ret = v4l2_subdev_call(isc->current_subdev->sd, pad, get_fmt, NULL,
>>>>> +                            &format);
>>>>>        if (ret)
>>>>>                return ret;
>>>>>
>>>>> -     v4l2_fill_mbus_format(&format.format, &f->fmt.pix, mbus_code);
>>>>> -     ret = v4l2_subdev_call(isc->current_subdev->sd, pad,
>>>>> -                            set_fmt, NULL, &format);
>>>>> -     if (ret < 0)
>>>>> -             return ret;
>>>>> +     /* Identify the subdev's format configuration */
>>>>> +     for (i = 0; i < isc->formats_list_size; i++)
>>>>> +             if (isc->formats_list[i].mbus_code == format.format.code) {
>>>>> +                     sd_fmt = &isc->formats_list[i];
>>>>> +                     break;
>>>>> +             }
>>>>> +
>>>>> +     /* Check if the format is not supported */
>>>>> +     if (!sd_fmt) {
>>>>> +             v4l2_err(&isc->v4l2_dev,
>>>>> +                      "Current subdevice is streaming a media bus code that is not supported 0x%x\n",
>>>>> +                      format.format.code);
>>>>> +             return -EPIPE;
>>>>> +     }
>>>>> +
>>>>> +     /* At this moment we know which format the subdev will use */
>>>>> +     isc->try_config.sd_format = sd_fmt;
>>>>> +
>>>>> +     /* If the sensor is not RAW, we can only do a direct dump */
>>>>> +     if (!ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
>>>>> +             isc_try_configure_rlp_dma(isc, true);
>>>>>
>>>>>        /* Limit to Atmel ISC hardware capabilities */
>>>>> -     if (f->fmt.pix.width > isc->max_width)
>>>>> -             f->fmt.pix.width = isc->max_width;
>>>>> -     if (f->fmt.pix.height > isc->max_height)
>>>>> -             f->fmt.pix.height = isc->max_height;
>>>>> +     v4l_bound_align_image(&format.format.width, 16, isc->max_width, 0,
>>>>> +                           &format.format.height, 16, isc->max_height, 0, 0);
>>>>>
>>>>> -     isc->fmt = *f;
>>>>> +     /* Check if the frame size is the same. Otherwise we may overflow */
>>>>> +     if (pixfmt->height != format.format.height ||
>>>>> +         pixfmt->width != format.format.width) {
>>>>> +             v4l2_err(&isc->v4l2_dev,
>>>>> +                      "ISC not configured with the proper frame size: %dx%d\n",
>>>>> +                      format.format.width, format.format.height);
>>>>> +             return -EPIPE;
>>>>> +     }
>>>>>
>>>>> +     v4l2_dbg(1, debug, &isc->v4l2_dev,
>>>>> +              "Identified subdev using format %.4s with %dx%d %d bpp\n",
>>>>> +              (char *)&sd_fmt->fourcc, pixfmt->width, pixfmt->height,
>>>>> +              isc->try_config.bpp);
>>>>> +
>>>>> +     /* Reset and restart AWB if the subdevice changed the format */
>>>>>        if (isc->try_config.sd_format && isc->config.sd_format &&
>>>>>            isc->try_config.sd_format != isc->config.sd_format) {
>>>>>                isc->ctrls.hist_stat = HIST_INIT;
>>>>>                isc_reset_awb_ctrls(isc);
>>>>>                isc_update_v4l2_ctrls(isc);
>>>>>        }
>>>>> -     /* make the try configuration active */
>>>>> +
>>>>> +     /* Validate formats */
>>>>> +     ret = isc_try_validate_formats(isc);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     /* Obtain frame sizes if possible to have crop requirements ready */
>>>>> +     isc_try_fse(isc, &pad_state);
>>>>> +
>>>>> +     /* Configure ISC pipeline for the config */
>>>>> +     ret = isc_try_configure_pipeline(isc);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>>        isc->config = isc->try_config;
>>>>>
>>>>>        v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
>>>>> @@ -1043,7 +1036,7 @@ static int isc_try_fmt_vid_cap(struct file *file, void *priv,
>>>>>   {
>>>>>        struct isc_device *isc = video_drvdata(file);
>>>>>
>>>>> -     return isc_try_fmt(isc, f, NULL);
>>>>> +     return isc_try_fmt(isc, f);
>>>>>   }
>>>>>
>>>>>   static int isc_enum_input(struct file *file, void *priv,
>>>>> @@ -1098,10 +1091,6 @@ static int isc_enum_framesizes(struct file *file, void *fh,
>>>>>        if (fsize->index)
>>>>>                return -EINVAL;
>>>>>
>>>>> -     for (i = 0; i < isc->num_user_formats; i++)
>>>>> -             if (isc->user_formats[i]->fourcc == fsize->pixel_format)
>>>>> -                     ret = 0;
>>>>> -
>>>>>        for (i = 0; i < isc->controller_formats_size; i++)
>>>>>                if (isc->controller_formats[i].fourcc == fsize->pixel_format)
>>>>>                        ret = 0;
>>>>> @@ -1782,52 +1771,6 @@ struct isc_format *isc_find_format_by_code(struct isc_device *isc,
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(isc_find_format_by_code);
>>>>>
>>>>> -static int isc_formats_init(struct isc_device *isc)
>>>>> -{
>>>>> -     struct isc_format *fmt;
>>>>> -     struct v4l2_subdev *subdev = isc->current_subdev->sd;
>>>>> -     unsigned int num_fmts, i, j;
>>>>> -     u32 list_size = isc->formats_list_size;
>>>>> -     struct v4l2_subdev_mbus_code_enum mbus_code = {
>>>>> -             .which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>>>> -     };
>>>>> -
>>>>> -     num_fmts = 0;
>>>>> -     while (!v4l2_subdev_call(subdev, pad, enum_mbus_code,
>>>>> -            NULL, &mbus_code)) {
>>>>> -             mbus_code.index++;
>>>>> -
>>>>> -             fmt = isc_find_format_by_code(isc, mbus_code.code, &i);
>>>>> -             if (!fmt) {
>>>>> -                     v4l2_warn(&isc->v4l2_dev, "Mbus code %x not supported\n",
>>>>> -                               mbus_code.code);
>>>>> -                     continue;
>>>>> -             }
>>>>> -
>>>>> -             fmt->sd_support = true;
>>>>> -             num_fmts++;
>>>>> -     }
>>>>> -
>>>>> -     if (!num_fmts)
>>>>> -             return -ENXIO;
>>>>> -
>>>>> -     isc->num_user_formats = num_fmts;
>>>>> -     isc->user_formats = devm_kcalloc(isc->dev,
>>>>> -                                      num_fmts, sizeof(*isc->user_formats),
>>>>> -                                      GFP_KERNEL);
>>>>> -     if (!isc->user_formats)
>>>>> -             return -ENOMEM;
>>>>> -
>>>>> -     fmt = &isc->formats_list[0];
>>>>> -     for (i = 0, j = 0; i < list_size; i++) {
>>>>> -             if (fmt->sd_support)
>>>>> -                     isc->user_formats[j++] = fmt;
>>>>> -             fmt++;
>>>>> -     }
>>>>> -
>>>>> -     return 0;
>>>>> -}
>>>>> -
>>>>>   static int isc_set_default_fmt(struct isc_device *isc)
>>>>>   {
>>>>>        struct v4l2_format f = {
>>>>> @@ -1836,12 +1779,12 @@ static int isc_set_default_fmt(struct isc_device *isc)
>>>>>                        .width          = VGA_WIDTH,
>>>>>                        .height         = VGA_HEIGHT,
>>>>>                        .field          = V4L2_FIELD_NONE,
>>>>> -                     .pixelformat    = isc->user_formats[0]->fourcc,
>>>>> +                     .pixelformat    = isc->controller_formats[0].fourcc,
>>>>>                },
>>>>>        };
>>>>>        int ret;
>>>>>
>>>>> -     ret = isc_try_fmt(isc, &f, NULL);
>>>>> +     ret = isc_try_fmt(isc, &f);
>>>>>        if (ret)
>>>>>                return ret;
>>>>>
>>>>> @@ -1896,13 +1839,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>>>>>        spin_lock_init(&isc->dma_queue_lock);
>>>>>        spin_lock_init(&isc->awb_lock);
>>>>>
>>>>> -     ret = isc_formats_init(isc);
>>>>> -     if (ret < 0) {
>>>>> -             v4l2_err(&isc->v4l2_dev,
>>>>> -                      "Init format failed: %d\n", ret);
>>>>> -             goto isc_async_complete_err;
>>>>> -     }
>>>>> -
>>>>>        ret = isc_set_default_fmt(isc);
>>>>>        if (ret) {
>>>>>                v4l2_err(&isc->v4l2_dev, "Could not set default format\n");
>>>>> @@ -2016,6 +1952,24 @@ int isc_pipeline_init(struct isc_device *isc)
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(isc_pipeline_init);
>>>>>
>>>>> +static int isc_link_validate(struct media_link *link)
>>>>> +{
>>>>> +     struct video_device *vdev =
>>>>> +             media_entity_to_video_device(link->sink->entity);
>>>>> +     struct isc_device *isc = video_get_drvdata(vdev);
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = v4l2_subdev_link_validate(link);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     return isc_validate(isc);
>>>>> +}
>>>>> +
>>>>> +static const struct media_entity_operations isc_entity_operations = {
>>>>> +     .link_validate = isc_link_validate,
>>>>> +};
>>>>> +
>>>>>   int isc_mc_init(struct isc_device *isc, u32 ver)
>>>>>   {
>>>>>        const struct of_device_id *match;
>>>>> @@ -2023,6 +1977,8 @@ int isc_mc_init(struct isc_device *isc, u32 ver)
>>>>>
>>>>>        isc->video_dev.entity.function = MEDIA_ENT_F_IO_V4L;
>>>>>        isc->video_dev.entity.flags = MEDIA_ENT_FL_DEFAULT;
>>>>> +     isc->video_dev.entity.ops = &isc_entity_operations;
>>>>> +
>>>>>        isc->pads[ISC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
>>>>>
>>>>>        ret = media_entity_pads_init(&isc->video_dev.entity, ISC_PADS_NUM,
>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc-scaler.c b/drivers/media/platform/atmel/atmel-isc-scaler.c
>>>>> index a1ca4633787c..2b0621297dfe 100644
>>>>> --- a/drivers/media/platform/atmel/atmel-isc-scaler.c
>>>>> +++ b/drivers/media/platform/atmel/atmel-isc-scaler.c
>>>>> @@ -173,6 +173,10 @@ static const struct v4l2_subdev_pad_ops isc_scaler_pad_ops = {
>>>>>        .init_cfg = isc_scaler_init_cfg,
>>>>>   };
>>>>>
>>>>> +static const struct media_entity_operations isc_scaler_entity_ops = {
>>>>> +     .link_validate = v4l2_subdev_link_validate,
>>>>> +};
>>>>> +
>>>>>   static const struct v4l2_subdev_ops xisc_scaler_subdev_ops = {
>>>>>        .pad = &isc_scaler_pad_ops,
>>>>>   };
>>>>> @@ -190,6 +194,7 @@ int isc_scaler_init(struct isc_device *isc)
>>>>>
>>>>>        isc->scaler_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>>>>>        isc->scaler_sd.entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
>>>>> +     isc->scaler_sd.entity.ops = &isc_scaler_entity_ops;
>>>>>        isc->scaler_pads[ISC_SCALER_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
>>>>>        isc->scaler_pads[ISC_SCALER_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
>>>>>
>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
>>>>> index f98f25a55e73..5b0100c8c245 100644
>>>>> --- a/drivers/media/platform/atmel/atmel-isc.h
>>>>> +++ b/drivers/media/platform/atmel/atmel-isc.h
>>>>> @@ -63,15 +63,16 @@ struct isc_subdev_entity {
>>>>>    * @cfa_baycfg:              If this format is RAW BAYER, indicate the type of bayer.
>>>>>                        this is either BGBG, RGRG, etc.
>>>>>    * @pfe_cfg0_bps:    Number of hardware data lines connected to the ISC
>>>>> + * @raw:             If the format is raw bayer.
>>>>>    */
>>>>>
>>>>>   struct isc_format {
>>>>>        u32     fourcc;
>>>>>        u32     mbus_code;
>>>>>        u32     cfa_baycfg;
>>>>> -
>>>>> -     bool    sd_support;
>>>>>        u32     pfe_cfg0_bps;
>>>>> +
>>>>> +     bool    raw;
>>>>>   };
>>>>>
>>>>>   /* Pipeline bitmap */
>>>>> @@ -216,8 +217,7 @@ enum isc_scaler_pads {
>>>>>    * @comp:            completion reference that signals frame completion
>>>>>    *
>>>>>    * @fmt:             current v42l format
>>>>> - * @user_formats:    list of formats that are supported and agreed with sd
>>>>> - * @num_user_formats:        how many formats are in user_formats
>>>>> + * @try_fmt:         current v4l2 try format
>>>>>    *
>>>>>    * @config:          current ISC format configuration
>>>>>    * @try_config:              the current ISC try format , not yet activated
>>>>> @@ -272,6 +272,7 @@ enum isc_scaler_pads {
>>>>>    * @formats_list_size:       size of formats_list array
>>>>>    * @pads:            media controller pads for isc video entity
>>>>>    * @mdev:            media device that is registered by the isc
>>>>> + * @mpipe:           media device pipeline used by the isc
>>>>>    * @remote_pad:              remote pad on the connected subdevice
>>>>>    * @scaler_sd:               subdevice for the scaler that isc registers
>>>>>    * @scaler_pads:     media controller pads for the scaler subdevice
>>>>> @@ -298,8 +299,7 @@ struct isc_device {
>>>>>        struct completion       comp;
>>>>>
>>>>>        struct v4l2_format      fmt;
>>>>> -     struct isc_format       **user_formats;
>>>>> -     unsigned int            num_user_formats;
>>>>> +     struct v4l2_format      try_fmt;
>>>>>
>>>>>        struct fmt_config       config;
>>>>>        struct fmt_config       try_config;
>>>>> @@ -369,6 +369,7 @@ struct isc_device {
>>>>>        struct {
>>>>>                struct media_pad                pads[ISC_PADS_NUM];
>>>>>                struct media_device             mdev;
>>>>> +             struct media_pipeline           mpipe;
>>>>>
>>>>>                u32                             remote_pad;
>>>>>        };
>>>>> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
>>>>> index d96ee3373889..2a651e237193 100644
>>>>> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
>>>>> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
>>>>> @@ -80,20 +80,40 @@ static const struct isc_format sama5d2_controller_formats[] = {
>>>>>                .fourcc         = V4L2_PIX_FMT_Y10,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SBGGR8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGBRG8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGRBG8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SRGGB8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SBGGR10,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGBRG10,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGRBG10,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SRGGB10,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SBGGR12,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SGBRG12,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SGRBG12,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SRGGB12,
>>>>> +             .raw            = true,
>>>>>        },
>>>>>   };
>>>>>
>>>>> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
>>>>> index e07ae188c15f..a0d60cfdba7b 100644
>>>>> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
>>>>> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
>>>>> @@ -89,20 +89,40 @@ static const struct isc_format sama7g5_controller_formats[] = {
>>>>>                .fourcc         = V4L2_PIX_FMT_Y16,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SBGGR8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGBRG8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGRBG8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SRGGB8,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SBGGR10,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGBRG10,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SGRBG10,
>>>>> +             .raw            = true,
>>>>>        }, {
>>>>>                .fourcc         = V4L2_PIX_FMT_SRGGB10,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SBGGR12,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SGBRG12,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SGRBG12,
>>>>> +             .raw            = true,
>>>>> +     }, {
>>>>> +             .fourcc         = V4L2_PIX_FMT_SRGGB12,
>>>>> +             .raw            = true,
>>>>>        },
>>>>>   };
>>>>>
>>>>
>>>
>>

