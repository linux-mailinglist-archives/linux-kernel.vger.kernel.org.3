Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975B52B71E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiERJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiERJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:54:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC956239;
        Wed, 18 May 2022 02:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6D9BB81EF2;
        Wed, 18 May 2022 09:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020A0C385A5;
        Wed, 18 May 2022 09:54:18 +0000 (UTC)
Message-ID: <1761ab1a-68ce-4946-24d4-8f4f9575e735@xs4all.nl>
Date:   Wed, 18 May 2022 11:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: platform: replace ternary operator with max()
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "moderated list:ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220513133255.58600-1-guozhengkui@vivo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220513133255.58600-1-guozhengkui@vivo.com>
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

Hi Guo Zhengkui,

Please mention the driver in the subject line! Saying 'media: platform:' suggests
changes throughout many media/platform drivers, but this is just for a single
driver.

Regards,

	Hans

On 5/13/22 15:32, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1712:24-25:
> WARNING opportunity for max()
> 
> max() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> index 456287186ad8..55814041b8d8 100644
> --- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> @@ -1709,7 +1709,7 @@ static int exynos3250_jpeg_try_downscale(struct s5p_jpeg_ctx *ctx,
>  	w_ratio = ctx->out_q.w / r->width;
>  	h_ratio = ctx->out_q.h / r->height;
>  
> -	scale_factor = w_ratio > h_ratio ? w_ratio : h_ratio;
> +	scale_factor = max(w_ratio, h_ratio);
>  	scale_factor = clamp_val(scale_factor, 1, 8);
>  
>  	/* Align scale ratio to the nearest power of 2 */
