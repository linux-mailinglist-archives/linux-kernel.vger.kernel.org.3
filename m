Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD457557D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiGNS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbiGNS4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:56:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B552FDE;
        Thu, 14 Jul 2022 11:56:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bx13so3253316ljb.1;
        Thu, 14 Jul 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I+jRCsbhWxs4TKxqJzQgQaeI3aEXSHWJMTuLT4iRT3Q=;
        b=czNASMqeU+srNnAAhlHPGcffIbPDqRFnLihGD0XFSNfr8kR5CH1Ky3lN+XYSxsHROM
         lQicd2XY4af6mwvtng/Tew/YAoPI0XFKCoy6y77Uv+QxvJE72PIUPA7ECnlLW4U/fL83
         tEZwG9x9nIxYYKveeDTXicPDjd+US3yrSONZAF1FIjXhUN7ZzwTPQpQ7lBwHkDOssdq0
         hFgrx9gH/2SB/Zgv1F9NK0j7x3pfpWLnVy6L2y76T5++DuaDg5a0JnUUNVLZNaQeg4DZ
         5wFjRemKVGgwWzjDC65UKYvDC5cty25kA5+0sng0BqxcqE2TjFVpbSCIkleouf/RhvLq
         8Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I+jRCsbhWxs4TKxqJzQgQaeI3aEXSHWJMTuLT4iRT3Q=;
        b=FfBxvs8VtP7VAVjtJPNZ7tw63J+tIrTejkO7pkXImuIl3mG7PlQMxBgaqS2msSu/s3
         opjSNvVNxAo2Z8vsG0db+GXSfelDv32LV3dps6uxKk4SvKuUrOfckeVAN9V7UQW9IdPd
         PK4M/KZ4EJGLr55oGwVceIH1dXM0+HRIIih5AiXDEasR6Nppb5SmAEotpmXMsXg9xhFR
         ugLqEIgAg6xWNeg6lBHLHnraqX7Vd6vlbkYOhf3b8+pnm0VVpG8LhwQyLc7ZVz3qf7Nm
         xbxHvy8MOOji55q1YhvuoY6Ve3hhmCIpxYIGweicS7S+oqm8hmV+GmIasJts+yIYLHfD
         YTlg==
X-Gm-Message-State: AJIora9LFYExt7DgpohqKgWo9RERd2i+BZ3rGatn6+YCcrEaQHKIlEIh
        h97ySQ9W8yg/W9T8D8HDN9A=
X-Google-Smtp-Source: AGRyM1vNpkQa0X3eFgXBGerGcc6TjM+Mj1qmUj55J5sTQRxev4jQsb4jj+WwgZdck8Km05bMmlxcHg==
X-Received: by 2002:a2e:a608:0:b0:25d:5363:35a4 with SMTP id v8-20020a2ea608000000b0025d536335a4mr5384558ljp.132.1657824997544;
        Thu, 14 Jul 2022 11:56:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru. [109.252.119.232])
        by smtp.googlemail.com with ESMTPSA id k1-20020a2eb741000000b0025d542731ffsm401246ljo.5.2022.07.14.11.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 11:56:36 -0700 (PDT)
Message-ID: <0d4f6b3a-16ab-6289-0b56-490cf8667a65@gmail.com>
Date:   Thu, 14 Jul 2022 21:56:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/8] tegra-vde: Use vb2_find_buffer
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
 <20220711211141.349902-4-ezequiel@vanguardiasur.com.ar>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220711211141.349902-4-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.07.2022 00:11, Ezequiel Garcia пишет:
> Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> given a buffer timestamp.
> 
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Acked-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/media/platform/nvidia/tegra-vde/h264.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/nvidia/tegra-vde/h264.c b/drivers/media/platform/nvidia/tegra-vde/h264.c
> index 88f81a134ba0..204e474d57f7 100644
> --- a/drivers/media/platform/nvidia/tegra-vde/h264.c
> +++ b/drivers/media/platform/nvidia/tegra-vde/h264.c
> @@ -659,20 +659,19 @@ static struct vb2_buffer *get_ref_buf(struct tegra_ctx *ctx,
>  {
>  	const struct v4l2_h264_dpb_entry *dpb = ctx->h264.decode_params->dpb;
>  	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
> -	int buf_idx = -1;
> +	struct vb2_buffer *vb = NULL;
>  
>  	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> -		buf_idx = vb2_find_timestamp(cap_q,
> -					     dpb[dpb_idx].reference_ts, 0);
> +		vb = vb2_find_buffer(cap_q, dpb[dpb_idx].reference_ts);
>  
>  	/*
>  	 * If a DPB entry is unused or invalid, address of current destination
>  	 * buffer is returned.
>  	 */
> -	if (buf_idx < 0)
> +	if (!vb)
>  		return &dst->vb2_buf;
>  
> -	return vb2_get_buffer(cap_q, buf_idx);
> +	return vb;
>  }
>  
>  static int tegra_vde_validate_vb_size(struct tegra_ctx *ctx,

Acked-by: Dmitry Osipenko <digetx@gmail.com>
