Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E7500946
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiDNJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiDNJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:09:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29086C49E;
        Thu, 14 Apr 2022 02:06:43 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:aefc:13d9:b947:5c76] (unknown [IPv6:2a01:e0a:120:3210:aefc:13d9:b947:5c76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BB3791F401D3;
        Thu, 14 Apr 2022 10:06:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649927202;
        bh=xSwiJdR9H1GkemybcSFzfO6oTRwZpO+ePP5cbEY0jU8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oI3izQUAkCdzA4+jKP3zVRxx8Ms2GpghQckdh3wBPjZePBIjooW2Axvd+6OMX/hxv
         PG2nQOjeNb1x5YnrqEcTe8K9Lj3w16evi5kqjloRixZydS7HTMVDRGl1qdKBSCSWkz
         FizamigRFsSabugHYebGV+/uU4rnzpxLP4I/Muf2kgx6NgOXhWTC2b87FeWtu7mC2n
         lKsSPF2EVF6nDE2Fu5ZIrhna4Pn3j/webgFXJoXTXXiAReSijghjgNSYRaEDShBMlQ
         GWcggqYZjmtSTUIwim6zCJuJnE9Kt/b0W+9UUjcmGHNmpUoUgG5sbXmrqGFvXMaZnK
         jXklgjCMndujg==
Message-ID: <8c13a489-323b-79cf-2bb0-920e5a4e99e0@collabora.com>
Date:   Thu, 14 Apr 2022 11:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 09/17] media: uapi: HEVC: Define
 V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        sebastian.fricke@collabora.com
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
 <20220407152940.738159-10-benjamin.gaignard@collabora.com>
 <3179e400d52704d11dd150bf4270dab4c1064cad.camel@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <3179e400d52704d11dd150bf4270dab4c1064cad.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/04/2022 à 20:53, Nicolas Dufresne a écrit :
> Le jeudi 07 avril 2022 à 17:29 +0200, Benjamin Gaignard a écrit :
>> Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
>> a dynamic array control type.
>> Some drivers may be able to receive multiple slices in one control
>> to improve decoding performance.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>>   include/media/hevc-ctrls.h                                | 3 +++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index 7fcc6c2bac4c..1aaf3b84b584 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -2964,6 +2964,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>       These bitstream parameters are defined according to :ref:`hevc`.
>>       They are described in section 7.4.7 "General slice segment header
>>       semantics" of the specification.
>> +    This control is a dynamically sized 1-dimensional array,
>> +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>>   
>>   .. c:type:: v4l2_ctrl_hevc_slice_params
>>   
>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>> index 96a9b71d1def..28049e1a8a07 100644
>> --- a/include/media/hevc-ctrls.h
>> +++ b/include/media/hevc-ctrls.h
>> @@ -314,6 +314,9 @@ struct v4l2_hevc_pred_weight_table {
>>   /**
>>    * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
>>    *
>> + * This control is a dynamically sized 1-dimensional array,
>> + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>> + *
> I'm not sure about this comment, but I'm sure you forgot:
>
>
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1505,6 +1505,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum
> v4l2_ctrl_type *type,
>                  break;
>          case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>                  *type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
> +               *flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>                  break;
>          case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>                  *type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
>
> Also, in AV1 we have V4L2_AV1_MAX_TILE_COUNT, which can be used in cfg.dims,
> something the driver will actually set. We could have
>
> #define V4L2_HEVC_MAX_TILE_COUNT 600
>
> And drives can set:
>
>     .dims = { V4L2_HEVC_MAX_TILE_COUNT },
>
> In the control config.

Ok that will be in v6

>
>>    * @bit_size: size (in bits) of the current slice data
>>    * @data_bit_offset: offset (in bits) to the video data in the current slice data
>>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
