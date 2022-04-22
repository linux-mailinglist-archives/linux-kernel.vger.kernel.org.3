Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAC50B0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444415AbiDVGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349067AbiDVGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:34:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779B50B2A;
        Thu, 21 Apr 2022 23:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8488DB82936;
        Fri, 22 Apr 2022 06:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA1C385A0;
        Fri, 22 Apr 2022 06:31:52 +0000 (UTC)
Message-ID: <59750798-300a-9b90-f257-3a97bcd4bfb5@xs4all.nl>
Date:   Fri, 22 Apr 2022 08:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 01/24] media: doc: Document dual use of H.264
 pic_num/frame_num
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-2-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220405204426.259074-2-nicolas.dufresne@collabora.com>
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

On 05/04/2022 22:44, Nicolas Dufresne wrote:
> These two fields need documentation as they have dual meaning. It is also
> confusing since pic_num is a derived value from frame_num, so this should
> help application developers. If we ever need to make a V2 of this API, I
> would suggest to remove pic_num entirely.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  .../media/v4l/ext-ctrls-codec-stateless.rst            | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> index 6541e4c32b26..49f89b702068 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> @@ -649,10 +649,16 @@ Stateless Codec Control ID
>          :c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
>      * - __u32
>        - ``pic_num``
> -      -
> +      - For short term references, this should match the derived value PicNum

shouldn't 'should' be 'must'? Same elsewhere below.

> +	(8-28) and for long term references it should match the derived value
> +	LongTermPicNum (8-29). Note that pic_num is the same as FrameNumWrap
> +	for frame decoding.

I think this last sentence is a bit confusing. How about:

"When decoding frames (as opposed to fields) pic_num is the same as FrameNumWrap."

>      * - __u16
>        - ``frame_num``
> -      -
> +      - For short term references, this should match the frame_num value from
> +	the slice header syntax (the driver will wrap the value if neeeded). For

neeeded -> needed

> +	long term references, this should be set to the value of
> +	long_term_frame_idx described in the dec_ref_pic_marking() syntax.
>      * - __u8
>        - ``fields``
>        - Specifies how the DPB entry is referenced. See :ref:`Reference Fields <h264_ref_fields>`

Regards,

	Hans
