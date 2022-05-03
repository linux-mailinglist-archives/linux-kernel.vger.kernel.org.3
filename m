Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43F51872C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiECOwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiECOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:52:17 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079763EA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:48:44 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e656032735so17444830fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BV1kdgg88h2dApOYl3eT3CssciiSPlxmubonwKG/mW4=;
        b=Vx/Eytelo3ZiPPIy6BcMf32X6UZdSEmR2nLRg7aKVjYWa7pjN6x+UjOE23jnBGqj9p
         FfpfY/XBM2izLWMN0zBVjzfA1nOFDXyofVQlbQQJPYLs37IFoQgPFvTmSB5CDRmtClm1
         pOUI23aiupAropgM3Gl6CubKEvmi+klBwX9WT/1/4FpSMSSeWyGTYO6Y335hCKOvxLWz
         Ez5GYoCEp90H2hIEn7+7gw1w8Dg9eqdYPK0LCWpq4IL2h7oK67NZMxxVCeLPWyvBBtmE
         L0+ootPlnamYUz5j9A//vbWoR2OGnh8whYJOFapzsjAQsN52HkmzMegDRaB4xKM6qZee
         2uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BV1kdgg88h2dApOYl3eT3CssciiSPlxmubonwKG/mW4=;
        b=vKOrpgL87JBv/0NubTHogc0+r+GE2i3FZBMDREQxsNwBg20riYRA/PqPgmL40saPdq
         weAMQVDfJ4IbUisvmFPrmOZOUnnhk02D31iEdl7yKh9ShAaQvWXXHrFKDI464oqLHXjh
         JPKlhcPSIQvqRe+S/Fjftgij8q4yko6JIheZDkoQU5cPn9Yvaix/SUPHCZnB6y2f2dnA
         xlplK8jezIJj7PcHB7Ji8cuiqZ084Us1j6+nmiJ5YfRd264vzfdkbeIZP/spU/x/wdRT
         pF7CacKiKW23EEDqZCjt9WGOrMtZiHXMbSGRQVgPMZlJda5s7Q+6cjCH53rJIa0yQv7P
         TyTQ==
X-Gm-Message-State: AOAM5314ocLM1/ViAaWp4HQ7wwcufHgWdqm/1XR74gtObgvcO1NUr8TN
        0SJQ59/+G8vtzX6/Z6kWh/feeFb+2pVDqg==
X-Google-Smtp-Source: ABdhPJygheLeJdTY7mT0oFr+XZcbBbO/9r9tZYoCSHRNY4qLm/p0Vf9K92aaEDaOY9HSjhTd/4OnKA==
X-Received: by 2002:a05:6870:d186:b0:ed:a737:8ae4 with SMTP id a6-20020a056870d18600b000eda7378ae4mr1832370oac.25.1651589324016;
        Tue, 03 May 2022 07:48:44 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id d11-20020a0568301b6b00b0060603221265sm4045559ote.53.2022.05.03.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:48:43 -0700 (PDT)
Date:   Tue, 3 May 2022 11:48:37 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, jon@nanocrew.net, aford173@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v3] media: hantro: HEVC: unconditionnaly set
 pps_{cb/cr}_qp_offset values
Message-ID: <YnFAxRFWXT6oHywm@eze-laptop>
References: <20220503135529.683474-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503135529.683474-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:55:29PM +0200, Benjamin Gaignard wrote:
> Always set pps_cb_qp_offset and pps_cr_qp_offset values in Hantro/G2
> register whatever is V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT
> flag value.
> The vendor code does the case to set these values.

s/case/same

> This fix conformance test CAINIT_G_SHARP_3.
> 
> Fluster HEVC score is increase by one with this patch.
> 

Saying "score is increased by one" is not all that useful.

I still believe seeing the Fluster score would be adding real
information.

The score you have without this patch, and using upstream GStreamer
is the "current" score. Then the score you get with the patch applied,
is the score you get after the fix.

And this is actually good as you would also give more information
by clarifying the score is the result of GStreamer (commit $sha)
plus Linux.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Patch looks fine, but I believe you still have some challenges on the commit
descriptions, and so we iterate a lot on them.

How about you proof-read them first (or you ask colleagues to proof-read
them)?

A useful tip I've profit from is to let patches sit for a few days,
then re-read and amend the commit before sending them.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!
Ezequiel

> ---
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index 6deb31b7b993..503f4b028bc5 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -194,13 +194,8 @@ static void set_params(struct hantro_ctx *ctx)
>  		hantro_reg_write(vpu, &g2_max_cu_qpd_depth, 0);
>  	}
>  
> -	if (pps->flags & V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT) {
> -		hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
> -		hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
> -	} else {
> -		hantro_reg_write(vpu, &g2_cb_qp_offset, 0);
> -		hantro_reg_write(vpu, &g2_cr_qp_offset, 0);
> -	}
> +	hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
> +	hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
>  
>  	hantro_reg_write(vpu, &g2_filt_offset_beta, pps->pps_beta_offset_div2);
>  	hantro_reg_write(vpu, &g2_filt_offset_tc, pps->pps_tc_offset_div2);
> -- 
> 2.32.0
> 
