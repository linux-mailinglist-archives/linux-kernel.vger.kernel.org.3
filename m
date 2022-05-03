Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1F5186FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiECOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiECOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:44:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393622F02D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:40:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a10so18349357oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=viN1JYge3+LHciwoVBbOpqiLqa/EK2bPoOneumYYZLg=;
        b=b50ZOtv06fY2ONdrxcFWf5Z0AFhe0E8sPjWlPc2xcHNe+ho1Wa8O8HfHI9hkthqr5s
         4qqs1/GvXQFR4ml032gxWR9Tkknovy0PW5jebzxJbNjpIHXhorpY3dEa86pD0bwGmXxd
         gQXPtCU2diExYL9iZgBEgC7vE0uBL3YqHSYA1f0uyRE2ADJZ4f6ZaClA5lQxToA7RZLO
         EfP+PFqTsWfY1D7v9R/5xQyZd2ENdUzzWIKYWlrAYMfWf3oqr6XdV1pPNrpxjJN5fpUR
         fTAl1C+sQsIkoKN++lVkAfccK0vcbmoIiqQgyC5vVDXkLl2f5QW/TTnehL2uQGZvpRHa
         t9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=viN1JYge3+LHciwoVBbOpqiLqa/EK2bPoOneumYYZLg=;
        b=qcktdThrGmatl6HV0VMn8StxDsrr08GNpaSJcTFVHl+EckcgB6W9GrvKiPzqG6QYFj
         5FBI5ZUZ0bd0ljT5nCgJLcFYNOMWd9ZNgryOCHsQUUdEWvm5Z53f8o8O9xZ8USY9kQFG
         73VYIbwpjW2ecIGtWX4bx/3e4mS0Vh/R5AjoSwBS64jvyjQHU30SDlvc/gkI7aB7fbRa
         iOqQpx63z0WqXqWF3/Hxow2r4rGhiluyjk9x63Cm6temBls5uIyPAH15sntj0kV+FSlp
         lorqBVqkekDJ9rnx/yvmWhU8NXY6EKXeYjhuSB55lkXIIfQ0THAK+2mArV/TVR8p0qSQ
         d7xg==
X-Gm-Message-State: AOAM531fpgkouxZhcTocPyYkzCDfz5AiRwEpMfQ8uPzlMEPOsAJc2tvd
        8lWquepit2xBJbOEeXoQuOEYzl46qgmBNw==
X-Google-Smtp-Source: ABdhPJxsY5i8IkdgwMEIWLtrRmICgIPPpYv3zOcomHxIHyRk5iJSqb0tgtnLbyk9Hfosv2RiIv0gkw==
X-Received: by 2002:a05:6808:1a22:b0:325:be76:f246 with SMTP id bk34-20020a0568081a2200b00325be76f246mr1904502oib.74.1651588828558;
        Tue, 03 May 2022 07:40:28 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id x6-20020a4ae786000000b0035eb4e5a6c1sm4980824oov.23.2022.05.03.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:40:27 -0700 (PDT)
Date:   Tue, 3 May 2022 11:40:22 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, jon@nanocrew.net, aford173@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v2] media: hantro: HEVC: Fix reference frames management
Message-ID: <YnE+1mgOnWxaVpfg@eze-laptop>
References: <20220503135138.678677-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503135138.678677-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:51:38PM +0200, Benjamin Gaignard wrote:
> PoC shall be int the range of -2^31 to 2^31 -1
> (HEVC spec section 8.3.1 Decoding process for picture order count).
> The current way to know if an entry in reference picture array is free
> is to test if PoC = UNUSED_REF. Since UNUSED_REF is defined as '-1' that
> could lead to decode issue if one PoC also equal '-1'.
> PoC with value = '-1' exists in conformance test SLIST_B_Sony_9.
> 
> Change the way unused entries are managed in reference pictures array to
> avoid using PoC to detect then.
> 
> This patch doesn't change fluster HEVC score.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Good catch!

Thanks,

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  .../staging/media/hantro/hantro_g2_hevc_dec.c |  6 ++---
>  drivers/staging/media/hantro/hantro_hevc.c    | 27 +++----------------
>  drivers/staging/media/hantro/hantro_hw.h      |  2 +-
>  3 files changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index 0a8c01ff2fa7..b7835bbf5e98 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -473,8 +473,8 @@ static int set_ref(struct hantro_ctx *ctx)
>  
>  	set_ref_pic_list(ctx);
>  
> -	/* We will only keep the references picture that are still used */
> -	ctx->hevc_dec.ref_bufs_used = 0;
> +	/* We will only keep the references pictures that are still used */
> +	hantro_hevc_ref_init(ctx);
>  
>  	/* Set up addresses of DPB buffers */
>  	dpb_longterm_e = 0;
> @@ -515,8 +515,6 @@ static int set_ref(struct hantro_ctx *ctx)
>  	hantro_write_addr(vpu, G2_OUT_CHROMA_ADDR, chroma_addr);
>  	hantro_write_addr(vpu, G2_OUT_MV_ADDR, mv_addr);
>  
> -	hantro_hevc_ref_remove_unused(ctx);
> -
>  	for (; i < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; i++) {
>  		hantro_write_addr(vpu, G2_REF_LUMA_ADDR(i), 0);
>  		hantro_write_addr(vpu, G2_REF_CHROMA_ADDR(i), 0);
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
> index 7d4b1d72255c..7fdec50dc853 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -25,15 +25,11 @@
>  #define MAX_TILE_COLS 20
>  #define MAX_TILE_ROWS 22
>  
> -#define UNUSED_REF	-1
> -
> -static void hantro_hevc_ref_init(struct hantro_ctx *ctx)
> +void hantro_hevc_ref_init(struct hantro_ctx *ctx)
>  {
>  	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
> -	int i;
>  
> -	for (i = 0;  i < NUM_REF_PICTURES; i++)
> -		hevc_dec->ref_bufs_poc[i] = UNUSED_REF;
> +	hevc_dec->ref_bufs_used = 0;
>  }
>  
>  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
> @@ -60,7 +56,7 @@ int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr)
>  
>  	/* Add a new reference buffer */
>  	for (i = 0; i < NUM_REF_PICTURES; i++) {
> -		if (hevc_dec->ref_bufs_poc[i] == UNUSED_REF) {
> +		if (!(hevc_dec->ref_bufs_used & 1 << i)) {
>  			hevc_dec->ref_bufs_used |= 1 << i;
>  			hevc_dec->ref_bufs_poc[i] = poc;
>  			hevc_dec->ref_bufs[i].dma = addr;
> @@ -71,23 +67,6 @@ int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr)
>  	return -EINVAL;
>  }
>  
> -void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx)
> -{
> -	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
> -	int i;
> -
> -	/* Just tag buffer as unused, do not free them */
> -	for (i = 0;  i < NUM_REF_PICTURES; i++) {
> -		if (hevc_dec->ref_bufs_poc[i] == UNUSED_REF)
> -			continue;
> -
> -		if (hevc_dec->ref_bufs_used & (1 << i))
> -			continue;
> -
> -		hevc_dec->ref_bufs_poc[i] = UNUSED_REF;
> -	}
> -}
> -
>  static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>  {
>  	struct hantro_dev *vpu = ctx->dev;
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index 9f31cce609d6..5de558386179 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -337,9 +337,9 @@ int hantro_hevc_dec_init(struct hantro_ctx *ctx);
>  void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
>  int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
>  int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
> +void hantro_hevc_ref_init(struct hantro_ctx *ctx);
>  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
>  int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
> -void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
>  
>  static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
>  {
> -- 
> 2.32.0
> 
