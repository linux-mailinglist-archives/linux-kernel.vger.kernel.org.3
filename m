Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E600E4F0120
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354684AbiDBLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbiDBLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:35:52 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB2A6586
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:34:01 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d39f741ba0so5370476fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V3U+5UMiJybq7zY98DwsaSNVhzwSmjvGiJkV3X+RFBM=;
        b=24BPX8VpvHlBMEx6hIWdtAG/9S/+iyZLlr/QAmp0Z+5yWJiGHzFhq/uIQdxSKyVYCP
         enPRmYoZkbFQcW1HpQH8zrb3IRM4d0hYNTbwxbVgEBdL6AG2jt0/HSVAt9robgILFabJ
         hPkLvUch+hB8OPL87o/mqnhm3QiZhrMUfdzGNvgyVWrVhnz/AJhfBVlruRn8eWEQNGCu
         c4w8zQ0s4CUgcN34kZe+uGnqzOnVLeqA0YDWuGn26R8g+72dBvLyMw/s+cjtb5JCtN0k
         NvTn7x2fWQ5Jv/xStKL7yXif078NOV/iO9/fHaI5S9fhUpkKVvCwnsGEVqWwzqQuIz4I
         iIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3U+5UMiJybq7zY98DwsaSNVhzwSmjvGiJkV3X+RFBM=;
        b=xPATOYy1SF6UlgGQfxxqYFLfBIGu+W5lRcG2f3ZqunOPdBhsOkZBRtKS7/zXRU6fHl
         vsCtxt2ZPZcE5vPF/tny9a4wUJ3aeAgwUKjRRzQULpa9912AjuKNj6lXhhR3s6KCGO97
         YnrJn6rtJ9HYnkvKaOEPleISeUgueeXLbX7/F/+VIMV4b+bSmvfybqSNwU5J6mm79d20
         T+cCteVoXy+VfLM8sjDp0TiU8FnMsCL7t2mP3bUdeG8mUrPBbRqPBugmnx827vZLrTDy
         Dg6SMzYg2JzAy6uwKGJwigiMA3Q6sKH0SkjNmrbIElKpyYlxWg3VY5Gy6ZH0pg+kc6Wk
         0Nfw==
X-Gm-Message-State: AOAM532V1evxpgZHyQvO8+H6jI/IhlL0CWytTTeEtUQAw9vyhvIij8Ta
        CUWOAXZoPIGM84KiGcAfdT43NdNpfPmv6Q==
X-Google-Smtp-Source: ABdhPJy3rMJldwi8Tb/ncmzg6WyZ80EFa7bQd46QO9bii8Cw9gw35Jy6JhWEPjRky3sVVbphVckt4w==
X-Received: by 2002:a05:6870:3488:b0:de:eaa5:260b with SMTP id n8-20020a056870348800b000deeaa5260bmr6754153oah.281.1648899240576;
        Sat, 02 Apr 2022 04:34:00 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm2098566oiv.21.2022.04.02.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:34:00 -0700 (PDT)
Date:   Sat, 2 Apr 2022 08:33:54 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/23] media: rkvdec: h264: Fix reference frame_num
 wrap for second field
Message-ID: <Ykg0oqJOb/ExafB3@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-17-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-17-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Thu, Mar 31, 2022 at 03:37:18PM -0400, Nicolas Dufresne wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> When decoding the second field in a complementary field pair the second
> field is sharing the same frame_num with the first field.
> 
> Currently the frame_num for the first field is wrapped when it matches the
> field being decoded, this cause issues to decode the second field in a
> complementary field pair.
> 
> Fix this by using inclusive comparison, less than or equal.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

To complete the Signed-off-by chain, can you add your Signed-off-by: at
the bottom?

Thanks,
Ezequiel

> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index a42cf19bcc6d..730f8ebf7f58 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -773,7 +773,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>  			continue;
>  
>  		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
> -		    dpb[i].frame_num < dec_params->frame_num) {
> +		    dpb[i].frame_num <= dec_params->frame_num) {
>  			p[i] = dpb[i].frame_num;
>  			continue;
>  		}
> -- 
> 2.34.1
> 
