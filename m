Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9138048AA49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbiAKJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:16:42 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167]:13966 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbiAKJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:16:41 -0500
X-KPN-MessageId: 18605330-72bf-11ec-9a2e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 18605330-72bf-11ec-9a2e-005056abbe64;
        Tue, 11 Jan 2022 10:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:to:subject:from:mime-version:date:message-id;
        bh=7sMnICIvN+Dgs1egxxA2KorGhnbnx8+H8ysgISZGjBM=;
        b=O+VWJ3fydQKr/WgCwUUWXqnzQFTBFgG0EkTTMJdLmewLsT7CZ9ZmNi0fzC2sjZH8qofQDk8eHZOIO
         nluQUA6GemGvglSxLCKhGbeDxd2ESFKRdmPi3okyQpmYBPi4K0uaAVCn8zxWCjOp0tk3puIezD7PUa
         anmqUQEQoXK9oRFTwq1DVA0NHAz5zbXWeVYHEd7u0ld6iqzwvx1tggBoprZ15A4nRiVReO1aLLUyV5
         vzY39+LOROlWjCUvbkKPKMmEtkraXwY+iSaxL4MQ01zm1MFEit8WoqepKUz37CR3iAxv3QM4I+XnAv
         VV7GAtjvHB2HPpDVdhAujnXiTVfmYMg==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|yDCXCyXpplCIeGif+s2ZnTO+p3G+Zr6ynyRziGuFOJP6KoBiLoJbafN8cEzivH+
 cB1dtil5/MYuCW00gRos5CA==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 2dbeb6da-72bf-11ec-b76f-005056ab7584;
        Tue, 11 Jan 2022 10:16:38 +0100 (CET)
Message-ID: <368bc1b7-ff86-beaa-6749-afbe5960eaeb@xs4all.nl>
Date:   Tue, 11 Jan 2022 10:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v3] media: meson: vdec: Fix a NULL pointer dereference in
 amvdec_add_ts()
To:     Zhou Qingyang <zhou1615@umn.edu>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211214144613.35fec82a@coco.lan>
 <20211215033535.40422-1-zhou1615@umn.edu>
Content-Language: en-US
In-Reply-To: <20211215033535.40422-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhou Qingyang, this is exactly the patch Neil wrote, except you just stuck your
name on it. Not nice.

Neil, can you post your patch with your own Signed-off-by, then I'll take that one.

Regards,

	Hans

On 15/12/2021 04:35, Zhou Qingyang wrote:
> In amvdec_add_ts(), there is a dereference of kzalloc(), which could lead
> to a NULL pointer dereference on failure of kzalloc().
> 
> Fix this bug by adding a NULL check of new_ts.
> 
> This bug was found by a static analyzer[1].
> 
> Builds with CONFIG_VIDEO_MESON_VDEC=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> 
> [1] The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths and
> confirms that the inconsistent operations are not recovered in the 
> current function or the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Changes in v3:
>   -  Change the description of patch
>   -  Turn the return type from 'void' to 'int'
>   -  Check the return value in the caller 'esparser_queue()'
> 
> Changes in v2:
>   -  Delete dev_err() message
> 
>  drivers/staging/media/meson/vdec/esparser.c     | 7 ++++++-
>  drivers/staging/media/meson/vdec/vdec_helpers.c | 8 ++++++--
>  drivers/staging/media/meson/vdec/vdec_helpers.h | 4 ++--
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
> index db7022707ff8..095100a50da8 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -328,7 +328,12 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>  
>  	offset = esparser_get_offset(sess);
>  
> -	amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
> +	ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
> +	if (!ret) {
> +		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +		return ret;
> +	}
> +
>  	dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
>  		vb->timestamp, payload_size, offset, vbuf->flags);
>  
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index b9125c295d1d..06fd66539797 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -227,13 +227,16 @@ int amvdec_set_canvases(struct amvdec_session *sess,
>  }
>  EXPORT_SYMBOL_GPL(amvdec_set_canvases);
>  
> -void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> -		   struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
> +int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> +		  struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
>  {
>  	struct amvdec_timestamp *new_ts;
>  	unsigned long flags;
>  
>  	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts)
> +		return -ENOMEM;
> +
>  	new_ts->ts = ts;
>  	new_ts->tc = tc;
>  	new_ts->offset = offset;
> @@ -242,6 +245,7 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>  	spin_lock_irqsave(&sess->ts_spinlock, flags);
>  	list_add_tail(&new_ts->list, &sess->timestamps);
>  	spin_unlock_irqrestore(&sess->ts_spinlock, flags);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(amvdec_add_ts);
>  
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
> index 88137d15aa3a..4bf3e61d081b 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.h
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
> @@ -56,8 +56,8 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
>   * @offset: offset in the VIFIFO where the associated packet was written
>   * @flags: the vb2_v4l2_buffer flags
>   */
> -void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> -		   struct v4l2_timecode tc, u32 offset, u32 flags);
> +int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
> +		  struct v4l2_timecode tc, u32 offset, u32 flags);
>  void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
>  
>  /**

