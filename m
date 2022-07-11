Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29A570CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiGKVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiGKVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:35:53 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08ED80502
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:35:47 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id d22-20020a4a5216000000b004329a2f9195so1190634oob.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jZ6/mXUs3oGj5vCmYXuF6klL3B3NB7ms0SX6lE5t8E=;
        b=iz9U5u5B1yJwA1KvdhbtiZzYX+Sk497a6ZP9IiekQQUJmU2D20eBWtbMFQ8QbQegLK
         cCr4mCkMExokKf8YQyjUshLSZkd1iu11tW73cDLrfFHX9T/o9aff6j4j75LbLTqKAdLM
         PEse1RmFxhrzh1O6ke19Jm7IG21uIfThHWpWsSv5DcTb5vYAsv9lmocL5rAfEhSZV3JL
         GVTz/KTyAoSBX9az8VDVj7Zyr7X78LN4kuHCtW3gmfVFlN+rQDkUPLxptrpq1mrQc4mq
         otUi23Zv5uabN3MAOPSrJsUjud3n77+hX9LOhyYLG2S+Xu6dDR1RJhVAhFDlWP4sPZdE
         KJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jZ6/mXUs3oGj5vCmYXuF6klL3B3NB7ms0SX6lE5t8E=;
        b=ChtW2PIqXx/rtfOH1rWNjXz4ongVMWd7N/oZ8gljdZLKKtfMLUyL63LgKYy97WOAih
         mdkRx6l34S+iWCubrfgukiWe/66A01oqKT1JQQa3VS693E2h0Wi7gvk++2jjrZjduwpL
         KhWkWIfMpMec4eLeEyiHoDn4SdQxFa//qeQ6dPeOp/WUudLno2pzmDQg8BRqjR/7+g4S
         WhE14+AZL69SJ6k+f/BRQMh4D46Faa9fQ+gIJNWo2rgWRbWAa43jKDJYTSYxoL0HHm6j
         Bob9kMcyvADQr8poFBhu8EJF4RJp0heDhugEFbYjbggENcwNfV1WXlfaKnXEnK1o2Jkm
         fFCA==
X-Gm-Message-State: AJIora8qK1DkjKUb602bxQqz+xKHM6QuYz88CfkglSQSRrJ+HTrtuAfj
        pS8Q8fnYj0q/1BKfE0JxCKW5Xw==
X-Google-Smtp-Source: AGRyM1tAnze5Z/cPxlu8wR0AxcpNqBITgN2Oh8PaM8XO15TGC5Hl82yTXDAM9iJo+ihwZ25tK/pYOQ==
X-Received: by 2002:a4a:b306:0:b0:425:8afc:a3d8 with SMTP id m6-20020a4ab306000000b004258afca3d8mr7403721ooo.47.1657575346922;
        Mon, 11 Jul 2022 14:35:46 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id o9-20020a056870524900b00101c9597c6fsm3724251oai.28.2022.07.11.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:35:46 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:35:40 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, mchehab@kernel.org,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] media: cedrus: Add helper for determining number of
 elements
Message-ID: <YsyXrJhx7XtpdBVt@eze-laptop>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
 <20220620175517.648767-7-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620175517.648767-7-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 07:55:16PM +0200, Jernej Skrabec wrote:
> Now that controls can be dynamic arrays, we need to know how many
> elements are in such array. Add a helper for that.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 11 +++++++++++
>  drivers/staging/media/sunxi/cedrus/cedrus.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index 99c87319d2b4..b855e608885c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -232,6 +232,17 @@ void *cedrus_find_control_data(struct cedrus_ctx *ctx, u32 id)
>  	return NULL;
>  }
>  
> +u32 cedrus_get_num_of_controls(struct cedrus_ctx *ctx, u32 id)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; ctx->ctrls[i]; i++)
> +		if (ctx->ctrls[i]->id == id)
> +			return ctx->ctrls[i]->elems;
> +
> +	return 0;
> +}
> +
>  static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
>  {
>  	struct v4l2_ctrl_handler *hdl = &ctx->hdl;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
> index d2b697a9ded2..15a1bdbf6a1f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -261,5 +261,6 @@ vb2_to_cedrus_buffer(const struct vb2_buffer *p)
>  }
>  
>  void *cedrus_find_control_data(struct cedrus_ctx *ctx, u32 id);
> +u32 cedrus_get_num_of_controls(struct cedrus_ctx *ctx, u32 id);
>  
>  #endif
> -- 
> 2.36.1
> 
