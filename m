Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1404BB90E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiBRMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:22:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiBRMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:22:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7420299249;
        Fri, 18 Feb 2022 04:22:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBD161F78;
        Fri, 18 Feb 2022 12:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0EEC340E9;
        Fri, 18 Feb 2022 12:22:22 +0000 (UTC)
Message-ID: <ee02bf52-b738-95f7-a4a8-f7d7f2e029ef@xs4all.nl>
Date:   Fri, 18 Feb 2022 13:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC v2 5/8] media: uapi: Add fields needed for RKVDEC driver
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
 <20220215110103.241297-6-benjamin.gaignard@collabora.com>
 <b41ea0ec-b5c0-4ea5-9866-35a952c6a8b9@xs4all.nl>
 <3973e1f8-665a-c2d1-d493-19f66d307b88@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <3973e1f8-665a-c2d1-d493-19f66d307b88@collabora.com>
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

On 18/02/2022 13:19, Benjamin Gaignard wrote:
> 
> Le 18/02/2022 à 12:32, Hans Verkuil a écrit :
>> On 15/02/2022 12:01, Benjamin Gaignard wrote:
>>> RKVDEC driver requires additional fields to perform HEVC decoding.
>>> Even if the driver isn't mainlined yet WIP patches could be find here:
>>> https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch
>>>
>>> This patch only include the change in HEVC uAPI.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   .../userspace-api/media/v4l/ext-ctrls-codec.rst  | 16 ++++++++++++++++
>>>   include/uapi/linux/v4l2-controls.h               |  5 +++++
>>>   2 files changed, 21 insertions(+)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index 4f3b3ba8319f..3296ac3b9fca 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -2661,6 +2661,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>       :stub-columns: 0
>>>       :widths:       1 1 2
>>>   +    * - __u8
>>> +      - ``video_parameter_set_id``
>>> +      - Identifies the VPS for reference by other syntax elements.
>>> +    * - __u8
>>> +      - ``seq_parameter_set_id``
>>> +      - Provides an identifier for the SPS for reference by other syntax
>>> +        elements.
>>>       * - __u16
>>>         - ``pic_width_in_luma_samples``
>>>         -
>>> @@ -2800,6 +2807,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>       :stub-columns: 0
>>>       :widths:       1 1 2
>>>   +    * - __u8
>>> +      - ``pic_parameter_set_id``
>>> +      - Identifies the PPS for reference by other syntax elements.
>>>       * - __u8
>>>         - ``num_extra_slice_header_bits``
>>>         -
>>> @@ -3026,6 +3036,12 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>       * - __u8
>>>         - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>>>         - The list of L1 reference elements as indices in the DPB.
>>> +    * - __u16
>>> +      - ``short_term_ref_pic_set_size``
>>> +      -
>>> +    * - __u16
>>> +      - ``long_term_ref_pic_set_size``
>>> +      -
>>>       * - __u8
>>>         - ``padding``
>>>         - Applications and drivers must set this to zero.
>> Just to confirm: these additional fields are all from the H.265 spec, right?
>> They are not rkvdec specific.
> 
> They are in H.265 spec section "7.4.3.2.2 Sequence parameter set range extension semantics":
> - num_short_term_ref_pic_sets specifies the number of st_ref_pic_set( ) syntax structures included in the SPS. The value
> of num_short_term_ref_pic_sets shall be in the range of 0 to 64, inclusive.
> 
> - num_long_term_ref_pics_sps specifies the number of candidate long-term reference pictures that are specified in the
> SPS. The value of num_long_term_ref_pics_sps shall be in the range of 0 to 32, inclusive.

And what about video/seq/pic_parameter_set_id?

Regards,

	Hans

> 
> I mention rkvdec because that it is the only driver to use they (as far I knows)
> 
> Regards,
> Benjamin
> 
>>
>> Regards,
>>
>>     Hans
>>
>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>>> index 0e0ec2c61b80..b1a3dc05f02f 100644
>>> --- a/include/uapi/linux/v4l2-controls.h
>>> +++ b/include/uapi/linux/v4l2-controls.h
>>> @@ -2341,6 +2341,8 @@ enum v4l2_stateless_hevc_start_code {
>>>     struct v4l2_ctrl_hevc_sps {
>>>       /* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
>>> +    __u8    video_parameter_set_id;
>>> +    __u8    seq_parameter_set_id;
>>>       __u16    pic_width_in_luma_samples;
>>>       __u16    pic_height_in_luma_samples;
>>>       __u8    bit_depth_luma_minus8;
>>> @@ -2393,6 +2395,7 @@ struct v4l2_ctrl_hevc_sps {
>>>     struct v4l2_ctrl_hevc_pps {
>>>       /* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
>>> +    __u8    pic_parameter_set_id;
>>>       __u8    num_extra_slice_header_bits;
>>>       __u8    num_ref_idx_l0_default_active_minus1;
>>>       __u8    num_ref_idx_l1_default_active_minus1;
>>> @@ -2487,6 +2490,8 @@ struct v4l2_ctrl_hevc_slice_params {
>>>       __u32    slice_segment_addr;
>>>       __u8    ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>>>       __u8    ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>>> +    __u16    short_term_ref_pic_set_size;
>>> +    __u16    long_term_ref_pic_set_size;
>>>         /* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
>>>       struct v4l2_hevc_pred_weight_table pred_weight_table;

