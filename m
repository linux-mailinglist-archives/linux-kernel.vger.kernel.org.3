Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A652B7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiERKod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiERKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:44:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915FE527E1;
        Wed, 18 May 2022 03:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D5E2B81F06;
        Wed, 18 May 2022 10:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BABC385A5;
        Wed, 18 May 2022 10:44:21 +0000 (UTC)
Message-ID: <32fac87b-0e57-8cf1-ac1e-38e2bee82af2@xs4all.nl>
Date:   Wed, 18 May 2022 12:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: dvb_vb2: fix possible out of bound access
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, mchehab@kernel.org,
        senozhatsky@chromium.org, caihuoqing@baidu.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220324080119.40133-1-hbh25y@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220324080119.40133-1-hbh25y@gmail.com>
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

Hi Hangyu,

It appears this patch fell through the cracks. It's certainly useful to
have.

On 3/24/22 09:01, Hangyu Hua wrote:
> vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
> controlled by the user.
> 
> Fix this by adding range checking code before using them.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/media/dvb-core/dvb_vb2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
> index a1bd6d9c9223..f410800b92e7 100644
> --- a/drivers/media/dvb-core/dvb_vb2.c
> +++ b/drivers/media/dvb-core/dvb_vb2.c
> @@ -354,6 +354,12 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
>  
>  int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>  {
> +	struct vb2_queue *q = &ctx->vb_q;
> +
> +	if (b->index >= q->num_buffers) {
> +		dprintk(q, 1, "buffer index out of range\n");

However, this patch doesn't compile: dprintk in this source doesn't
have a 'q' argument!

> +		return -EINVAL;
> +	}
>  	vb2_core_querybuf(&ctx->vb_q, b->index, b);
>  	dprintk(3, "[%s] index=%d\n", ctx->name, b->index);

Also, to help debugging it prefixes the warnings with the ctx-name.

Can you post a v2 of this patch?

Regards,

	Hans

>  	return 0;
> @@ -378,8 +384,13 @@ int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
>  
>  int dvb_vb2_qbuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>  {
> +	struct vb2_queue *q = &ctx->vb_q;
>  	int ret;
>  
> +	if (b->index >= q->num_buffers) {
> +		dprintk(q, 1, "buffer index out of range\n");
> +		return -EINVAL;
> +	}
>  	ret = vb2_core_qbuf(&ctx->vb_q, b->index, b, NULL);
>  	if (ret) {
>  		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,
