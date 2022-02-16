Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255184B8F08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiBPRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:19:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiBPRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:19:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C0C3303;
        Wed, 16 Feb 2022 09:19:13 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:fdd4:c171:8e0a:65c9] (unknown [IPv6:2a01:e0a:120:3210:fdd4:c171:8e0a:65c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C29C41F45037;
        Wed, 16 Feb 2022 17:19:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645031952;
        bh=dzkulLdCFvxMIGqB0cCUzdXbRStr5SMvEoD5ovPIHCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ponvm8a/9gskHDy3/EClyJ6uwXSBDpglsnUBVIr09VOEiwq15KG7KcwaSTGjFHbou
         TTa1TCK88youuVYdt6m2AHeAZzuTNXn0qo1QeE3V9Y7i9Z5dBd5nKBbjMVaLkEZHYS
         RZMq8CJ71++B28hHKPw6sglKFeJi6JeJMgg+K+tUcatIoG+Or4g4PCXymdHvs07Tin
         UsPxO5V7/CtLy1m6aKTkAT6cm5L68gPKpF95UfEF6h/Lb3LJ1nIgpXuICq+k939OH+
         qEQ5eNP+WAN22k5Mwqj8CVz2WjgduozZyUjZvKYosNJTG4qL7W1c9aECWC6vFvdecs
         SF0SjBEUoM7+A==
Message-ID: <846370ec-5c9e-e4cb-eccf-0b0c6bdbc847@collabora.com>
Date:   Wed, 16 Feb 2022 18:19:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v2 7/8] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Content-Language: en-US
To:     John Cox <jc@kynesim.co.uk>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
 <20220215110103.241297-8-benjamin.gaignard@collabora.com>
 <a8lp0h15oaibdu1pqrkhsu8nh32v423tur@4ax.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <a8lp0h15oaibdu1pqrkhsu8nh32v423tur@4ax.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 16/02/2022 à 11:54, John Cox a écrit :
> On Tue, 15 Feb 2022 12:01:02 +0100, you wrote:
>
>> The number of 'entry point offset' could be very variable.
>> Rather than use a large static array define a v4l2 dynamic array
>> of integer control.
>> The number of entry point offsets is reported by the elems field.
> If we are going to support multiple slice headers in a single control
> then we are going to need to know how to split these entries between
> them as I assume that the entry point offset entries for all slice
> headers would just be catenated here.  You could add extra elements here
> or generate a completely new control but I think it would be easier to
> reinstate the num_entry_point_offsets field in the slice_params
> structure (its a field that userpace has in its hand anyway so its no
> effort for it to fill in).  num_entry_point_offsets is a field that RPi
> wants (without needing the entry points themselves) so that would help
> me.

Would that means num_entry_point_offsets field in slice parameter control
+ one control for the entry points themselves ?
or the both on slice parameter control (like now) ?

Regards
Benjamin

>
> Regards
>
> John Cox
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> version 2:
>> - Define a new CID for entry point offsets parameters
>> .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++++
>> include/uapi/linux/v4l2-controls.h                       | 1 +
>> 2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index c3ae97657fa7..679595e94643 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -3101,6 +3101,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>
>>      \normalsize
>>
>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>> +    Specifies the i-th entry point offset in bytes and is represented by
>> +    offset_len_minus1 plus 1 bits.
>> +    This control is a dynamically sized array. The number of entry point
>> +    offsets is reported by the ``elems`` field.
>> +    This bitstream parameter is defined according to :ref:`hevc`.
>> +    They are described in section 7.4.7.1 "General slice segment header
>> +    semantics" of the specification.
>> +
>> ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>      Specifies the HEVC scaling matrix parameters used for the scaling process
>>      for transform coefficients.
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 27f5d272dc43..700e6cce958c 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -2314,6 +2314,7 @@ struct v4l2_ctrl_vp9_compressed_hdr {
>> #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 404)
>> #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_STATELESS_BASE + 405)
>> #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_STATELESS_BASE + 406)
>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET	(V4L2_CID_CODEC_STATELESS_BASE + 407)
>>
>> enum v4l2_stateless_hevc_decode_mode {
>> 	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
