Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21E4B7278
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbiBOPbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:31:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiBOPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:30:43 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7281C1151
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:28:58 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b35so17575496qkp.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=f9H0svHPKw+hnD0cD7XsmllGNTwpLTUKEtyrj/3wtLI=;
        b=GPOZKgDSA400flay/HIWB7L3DGdLyz5YurXxhd5n383IxxkViAXaPF9S3uWIAdFmIT
         L8sUT0U2DP3df0GsPLmQh9YpfZ/mTE8mMUuAAvDiqitaRoMSsOpX/XTqUg20DiHP7CLI
         ZWlxLv3w2ee1YqFexfbH/9byVSl68ivYuCsAWhO/cfzxz/UY3QMV0lja5x/Qn5qiq5mz
         hcpZrnM5nxD7ZmZl7P+YoQwjI4Jobo9HF3sq5MqMWbnOVIHCe8m06Q4DBnkWMNWoNG1I
         b43fy1yoAgi9p9hh+91tztEq+1XvD++H0aWpCsU91eoYbV20tT2oebqTnCo30xCmiTmA
         hyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=f9H0svHPKw+hnD0cD7XsmllGNTwpLTUKEtyrj/3wtLI=;
        b=nD+hrA16bS5g7/KVq/XnmLe7EL1IJHDk2DRY0KP2dXh/h7xYCi09yJrlemEMkO2RvD
         dU3napWS+GtbGzBh4oU+8vOoKw4/vtPdBW4BnH/wVhyrZQR7691VvpiW/F22uGMPSnMk
         ppimhNakyAQb19McKDo6GN8/QfZhuotARayms/WjQXwSlCjrdgxwoW590sv631Jqcka/
         9Ku8Pu8N7dH+eohMiLLZ7iCl03z6vWZUZEmK1HgMlP3WlGp3odu6EjJnFWzofWlMi3eE
         F40s991tqH+tqnmkvmrHCvj9MGel71T7fZZLPZNrjmqiZvpc4hluSgzBxLGUsZOb2woi
         zd6w==
X-Gm-Message-State: AOAM532kt8crKowBYrOGn6Y3xzXZWUN0Z/cvgCTRbshgOABLFB9Jsdf1
        pnJgdJf4HBNO+1jsurfkXjqgeA==
X-Google-Smtp-Source: ABdhPJz6JEvNWkFwG2hdwgsJcBSXvUwEUXwIn5fmdW14e1k3pg4RbrhlPyT+Awb/d4Oe/D1m7S9+jg==
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr2197511qka.523.1644938937515;
        Tue, 15 Feb 2022 07:28:57 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id y15sm17470991qko.133.2022.02.15.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:28:56 -0800 (PST)
Message-ID: <9a78eb88f8690d43d34d8140420dae3f5f043637.camel@ndufresne.ca>
Subject: Re: [RFC v2 6/8] media: uapi: Remove bit_size field from
 v4l2_ctrl_hevc_slice_params
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     John Cox <jc@kynesim.co.uk>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
Date:   Tue, 15 Feb 2022 10:28:55 -0500
In-Reply-To: <mqen0ht146rbtukbd47tbtbiqvsmfta8oa@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
         <20220215110103.241297-7-benjamin.gaignard@collabora.com>
         <t2dn0hddgq22nt6a7sr6kl44irm3c2lj1j@4ax.com>
         <99062279-a3c4-96f7-4c4b-f39e7f812e68@collabora.com>
         <mqen0ht146rbtukbd47tbtbiqvsmfta8oa@4ax.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 15 février 2022 à 14:50 +0000, John Cox a écrit :
> On Tue, 15 Feb 2022 15:35:12 +0100, you wrote:
> 
> > 
> > Le 15/02/2022 à 15:17, John Cox a écrit :
> > > Hi
> > > 
> > > > The bit size of the slice could be deduced from the buffer payload
> > > > so remove bit_size field to avoid duplicated the information.
> > > I think this is a bad idea. In the future we are (I hope) going to want
> > > to have an array (variable) of slice headers all referring to the same
> > > bit buffer.  When we do that we will need this field.
> > 
> > I wonder if that could be considering like another decode mode and so
> > use an other control ?
> 
> I, personally, would be in favour of making the slice header control a
> variable array just as it is.  If userland can't cope with multiple
> entries then just send them one at a time and the code looks exactly
> like it does at the moment and if the driver can't then set max array
> entries to 1.
> 
> Having implemented this in rpi port of ffmpeg and the RPi V4L2 driver I
> can say with experience that the code and effort overhead is very low.
> 
> Either way having a multiple slice header control in the UAPI is
> important for efficiency.

Just to clarify the idea, we would have a single slice controls, always dynamic:

1. For sliced based decoder

The dynamic array slice control is implemented by the driver and its size must
be 1.

2. For frame based decoder that don't care for slices

The dynamic array slice controls is not implement. Userland detects that at
runtime, similar to the VP9 compressed headers.

3. For frame based decoders that needs slices (or driver that supports offset
and can gain performance with such mode)

The dynamic array slice controls is implemented, and should contain all the
slices found in the OUTPUT buffer.

So the reason for this bit_size (not sure why its bits though, perhaps someone
can educate me ?) Would be to let the driver offset inside the the single
OUTPUT/bitstream buffer in case this is not automatically found by the driver
(or that no start-code is needed). Is that last bit correct ? If so, should we
change it to an offset rather then a size ? Shall we allow using offesets inside
larger buffer (e.g. to avoid some memory copies) for the Sliced Base cases ?

> 
> Regards
> 
> John Cox
> 
> > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > > ---
> > > > .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
> > > > drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 ++++-------
> > > > include/uapi/linux/v4l2-controls.h                    |  3 +--
> > > > 3 files changed, 5 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > index 3296ac3b9fca..c3ae97657fa7 100644
> > > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > @@ -2965,9 +2965,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> > > >      :stub-columns: 0
> > > >      :widths:       1 1 2
> > > > 
> > > > -    * - __u32
> > > > -      - ``bit_size``
> > > > -      - Size (in bits) of the current slice data.
> > > >      * - __u32
> > > >        - ``data_bit_offset``
> > > >        - Offset (in bits) to the video data in the current slice data.
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > index 8ab2d9c6f048..db8c7475eeb8 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > @@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
> > > > 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
> > > > 	unsigned int width_in_ctb_luma, ctb_size_luma;
> > > > 	unsigned int log2_max_luma_coding_block_size;
> > > > +	size_t slice_bytes;
> > > > 	dma_addr_t src_buf_addr;
> > > > -	dma_addr_t src_buf_end_addr;
> > > > 	u32 chroma_log2_weight_denom;
> > > > 	u32 output_pic_list_index;
> > > > 	u32 pic_order_cnt[2];
> > > > @@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
> > > > 
> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
> > > > 
> > > > -	reg = slice_params->bit_size;
> > > > -	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
> > > > +	slice_bytes = vb2_get_plane_payload(&run->src->vb2_buf, 0);
> > > > +	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);
> > > I think one of these must be wrong. bit_size is in bits,
> > > vb2_get_plane_payload is in bytes?
> > 
> > You are right it should be vb2_get_plane_payload() * 8 to get the size in bits.
> > 
> > I will change that in v3.
> > 
> > > 
> > > Regards
> > > 
> > > John Cox
> > >   
> > > > 	/* Source beginning and end addresses. */
> > > > 
> > > > @@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
> > > > 
> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
> > > > 
> > > > -	src_buf_end_addr = src_buf_addr +
> > > > -			   DIV_ROUND_UP(slice_params->bit_size, 8);
> > > > -
> > > > -	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
> > > > +	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
> > > > 
> > > > 	/* Coding tree block address */
> > > > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> > > > index b1a3dc05f02f..27f5d272dc43 100644
> > > > --- a/include/uapi/linux/v4l2-controls.h
> > > > +++ b/include/uapi/linux/v4l2-controls.h
> > > > @@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
> > > > #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
> > > > 
> > > > struct v4l2_ctrl_hevc_slice_params {
> > > > -	__u32	bit_size;
> > > > 	__u32	data_bit_offset;
> > > > 
> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> > > > @@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
> > > > 	__u8	pic_struct;
> > > > 
> > > > -	__u8	reserved;
> > > > +	__u8	reserved[5];
> > > > 
> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
> > > > 	__u32	slice_segment_addr;

