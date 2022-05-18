Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED91952B716
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiERJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiERJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D78F2C138;
        Wed, 18 May 2022 02:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51975B81EFB;
        Wed, 18 May 2022 09:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28623C34113;
        Wed, 18 May 2022 09:50:44 +0000 (UTC)
Message-ID: <a08d95f2-1861-98fc-5a6a-d9400e5dca30@xs4all.nl>
Date:   Wed, 18 May 2022 11:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 11/20] media: s5p-mfc: Add support for UHD encoding.
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, linux-fsd@tesla.com
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125625epcas5p3a5d6e217570e2e2f4e11b4c099d45767@epcas5p3.samsung.com>
 <20220517125548.14746-12-smitha.t@samsung.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220517125548.14746-12-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Smitha,

On 5/17/22 14:55, Smitha T Murthy wrote:
> MFC driver had restriction on max resolution of 1080p,
> updated it for UHD. Added corresponding support to
> set recommended profile and level for H264 in UHD scenario.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c |  4 ++--
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index 456edcfebba7..9b624f17e32b 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> @@ -1630,8 +1630,8 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  			return -EINVAL;
>  		}
>  
> -		v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
> -			&pix_fmt_mp->height, 4, 1080, 1, 0);
> +		v4l_bound_align_image(&pix_fmt_mp->width, 8, 3840, 1,
> +			&pix_fmt_mp->height, 4, 2160, 1, 0);

Is this supported by older MFC versions as well? This seems to enable UHD support
for all MFC versions.

Regards,

	Hans

>  	} else {
>  		mfc_err("invalid buf type\n");
>  		return -EINVAL;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 7db7945ea80f..2b6d6259a209 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -1127,6 +1127,18 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
>  	reg |= ((p->num_b_frame & 0x3) << 16);
>  	writel(reg, mfc_regs->e_gop_config);
>  
> +	/* UHD encoding case */
> +	if ((ctx->img_width == 3840) && ctx->img_height == 2160) {
> +		if (p_h264->level < 51) {
> +			mfc_debug(2, "Set Level 5.1 for UHD\n");
> +			p_h264->level = 51;
> +		}
> +		if (p_h264->profile != 0x2) {
> +			mfc_debug(2, "Set High profile for UHD\n");
> +			p_h264->profile = 0x2;
> +		}
> +	}
> +
>  	/* profile & level */
>  	reg = 0;
>  	/** level */
