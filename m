Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0199C48AA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349247AbiAKJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:22:05 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167]:18427 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349241AbiAKJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:22:04 -0500
X-KPN-MessageId: d8a489b8-72bf-11ec-9a2e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id d8a489b8-72bf-11ec-9a2e-005056abbe64;
        Tue, 11 Jan 2022 10:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=5Sh28daInKdSrTtTbo1IllF4LAspOVNfmE0WTw8SsuY=;
        b=k8Hwk2yhwyDOfys9oOd7vUMlstyMIPld0IcBSbmMe7hV0UWUtf8JKGDLFKCR17KQ88/J5MBZtvk5a
         E8swFAcCwZ+iFGUDgrkF96S2WOQY6rcwR8xm/4OMttImPezRrj+NoAYaMhBnZL8B+G939SE43kjgux
         t+cn0Nwh9WDCuCGR1fOm0BgrN6gY8yRfBZm1cLzYkBSq7eeTFYeyg7YM7uvI363HZThnEPodO87m0u
         86oGj0+OE6CJCjd0MAuH++/sLVhmjOTHbMCXaAMmTAtmzUI8pVJfhTqhjlloFnpbYaSqqe33MD0fbf
         Hr0FXllOnvg9DKcjtZ+fdwNpe6K9Klg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|U8cdX9RsavCbkQ3kMX9Mu2MjmqZw1w5tLJ0A3sY+zAvKFHwpE0XEEUuu7hzPmlg
 TYwqXS0jv+xJ2qM2JRoT2ng==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id ee04d578-72bf-11ec-83ab-005056ab1411;
        Tue, 11 Jan 2022 10:22:00 +0100 (CET)
Message-ID: <03dbdbe8-ea08-ef62-c09d-67b3baab6401@xs4all.nl>
Date:   Tue, 11 Jan 2022 10:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2] media: meson: vdec: potential dereference of null
 pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, narmstrong@baylibre.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211210015620.2143555-1-jiasheng@iscas.ac.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211210015620.2143555-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 02:56, Jiasheng Jiang wrote:
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.

Same issue as with Zhou's patch: this is almost identical to Neil's patch,
but without any mention of his name.

I very much prefer it if Neil just posts his patch so I can pick that up.

Regards,

	Hans

> 
> Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2
> 
> *Change 1. Change the return type of amvdec_add_ts from void to int.
> *Change 2. Return -ENOMEN if alloc fail and return 0 if not.
> *Change 3. Modify the caller to deal with the error.
> ---
>  drivers/staging/media/meson/vdec/esparser.c     | 6 +++++-
>  drivers/staging/media/meson/vdec/vdec_helpers.c | 5 ++++-
>  drivers/staging/media/meson/vdec/vdec_helpers.h | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
> index db7022707ff8..7e78288cc551 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -328,9 +328,13 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>  
>  	offset = esparser_get_offset(sess);
>  
> -	amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
> +	ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
>  	dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
>  		vb->timestamp, payload_size, offset, vbuf->flags);
> +	if (ret) {
> +		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +		return ret;
> +	}
>  
>  	vbuf->flags = 0;
>  	vbuf->field = V4L2_FIELD_NONE;
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index 7f07a9175815..972a1d1a12a5 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -227,13 +227,15 @@ int amvdec_set_canvases(struct amvdec_session *sess,
>  }
>  EXPORT_SYMBOL_GPL(amvdec_set_canvases);
>  
> -void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> +int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> +		  struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
>  {
>  	struct amvdec_timestamp *new_ts;
>  	unsigned long flags;
>  
>  	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts)
> +		return -ENOMEM;
>  	new_ts->ts = ts;
>  	new_ts->tc = tc;
>  	new_ts->offset = offset;
> @@ -242,6 +244,7 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>  	spin_lock_irqsave(&sess->ts_spinlock, flags);
>  	list_add_tail(&new_ts->list, &sess->timestamps);
>  	spin_unlock_irqrestore(&sess->ts_spinlock, flags);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(amvdec_add_ts);
>  
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
> index cfaed52ab526..1bcb697290de 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.h
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
> @@ -55,7 +55,7 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
>   * @offset: offset in the VIFIFO where the associated packet was written
>   * @flags the vb2_v4l2_buffer flags
>   */
> -void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> +int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> +		  struct v4l2_timecode tc, u32 offset, u32 flags);
>  void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
>  

