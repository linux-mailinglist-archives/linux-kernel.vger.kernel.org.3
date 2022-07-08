Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E056B5F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiGHJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbiGHJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:54:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE3F823BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:54:23 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i126so26438303oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vEaJ5po9Za//FEsrnkPxw8yZtxSE9rhk4WCBsPOWM7o=;
        b=IKPynV5CRGV7vLXVINTPyxkKjJie+puMmQK+dPjIBcPew6KRz2RR05MmLQG9MQGwK6
         4lhKjJMDx0RhUt1VGaTH/NQvXq0/hjYiY6MaLRdMInpaOH3E8VXCXBbupYvOBIXXvfcX
         rdHsJPLSGFljCjcLKPVLBv9pO/Vj64ltNtjPloOoU0OT35mWSxBaN4rKPhcT8actbOiI
         H9G2S4h3fz0vfo/q1kc9d/xmS5Bs1U1RHp6iOmFpatIy4ZTpgvXV4LG6mhATxYpO5Zfa
         R4q1vFDGI1WVz6fOL3ckOwlc7NzapmEGuUv67cmI+GSYJIv6CcNcAPdZG/q41zI06Vwf
         59ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vEaJ5po9Za//FEsrnkPxw8yZtxSE9rhk4WCBsPOWM7o=;
        b=jAkLpOb20WcaHR8jt9X63M8eU0unnh72irfRxpGCefIh8PG+Y77xLqccdd8Oxe5wNq
         CWq8PXoeAfM2s8Zo7HU31O3c6fAMLHAdI50eSs2bqiihNpzmrP/36pGHFriezggEanu6
         L0Qtm1blm8hk9F4+LUZvACV/K6VXfFTHRQorZWnhIa6uYHWWbgwZhRlVCLq/Gxpf3WSN
         xCmYUG1LoPYKE4FPNLtLMU/Z7C1vm866uEfYmRwj99kJRnzAikXzY7my868T8UFtRreT
         pH0K8nGxnNOosGluZGi2Q3WiiLXJHi4GMhm9Pzz3Ydca9ZiArNozPwWK82OkgAed5QaY
         zKFA==
X-Gm-Message-State: AJIora9YO1YqD27lSjgNviDWORmCKqq3YdZNtq8RF8DNfVj6tmmUJwt/
        4HCLvChLnhVwOQHU8v54WOl5TQ==
X-Google-Smtp-Source: AGRyM1v4wJ7JVr6gpnAq37NLXMjnCZVAR1q0WYYm/dBK+pZJG0d6tLmmRs6CSDsDhSuogKiYR+xGfw==
X-Received: by 2002:a05:6808:eca:b0:2f9:c581:3f76 with SMTP id q10-20020a0568080eca00b002f9c5813f76mr1328601oiv.138.1657274062762;
        Fri, 08 Jul 2022 02:54:22 -0700 (PDT)
Received: from eze-laptop ([186.13.97.246])
        by smtp.gmail.com with ESMTPSA id b11-20020a9d60cb000000b00616dfd2c859sm11916643otk.59.2022.07.08.02.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:54:21 -0700 (PDT)
Date:   Fri, 8 Jul 2022 06:54:13 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v11 13/17] media: controls: Log HEVC stateless control in
 .std_log
Message-ID: <Ysf+xcbuIyYy7HIn@eze-laptop>
References: <20220706093803.158810-1-benjamin.gaignard@collabora.com>
 <20220706093803.158810-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706093803.158810-14-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:37:59AM +0200, Benjamin Gaignard wrote:
> Simply print the type of the control.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/media/v4l2-core/v4l2-ctrls-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> index ff8a61f24d0a..c5c5407584ff 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -307,6 +307,21 @@ static void std_log(const struct v4l2_ctrl *ctrl)
>  	case V4L2_CTRL_TYPE_VP9_FRAME:
>  		pr_cont("VP9_FRAME");
>  		break;
> +	case V4L2_CTRL_TYPE_HEVC_SPS:
> +		pr_cont("HEVC_SPS");
> +		break;
> +	case V4L2_CTRL_TYPE_HEVC_PPS:
> +		pr_cont("HEVC_PPS");
> +		break;
> +	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> +		pr_cont("HEVC_SLICE_PARAMS");
> +		break;
> +	case V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX:
> +		pr_cont("HEVC_SCALING_MATRIX");
> +		break;
> +	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
> +		pr_cont("HEVC_DECODE_PARAMS");
> +		break;
>  	default:
>  		pr_cont("unknown type %d", ctrl->type);
>  		break;
> -- 
> 2.32.0
> 
