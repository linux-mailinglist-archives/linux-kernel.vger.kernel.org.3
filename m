Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A154F289
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380803AbiFQILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380600AbiFQILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:11:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5515167D3F;
        Fri, 17 Jun 2022 01:11:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E527C12FC;
        Fri, 17 Jun 2022 01:11:04 -0700 (PDT)
Received: from [10.57.84.65] (unknown [10.57.84.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49FC63F792;
        Fri, 17 Jun 2022 01:11:03 -0700 (PDT)
Message-ID: <107f5083-3545-770d-4d63-57c6829ef95a@arm.com>
Date:   Fri, 17 Jun 2022 09:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] media: rkvdec: Fix memset size error
Content-Language: en-GB
To:     Zhang Zekun <zhangzekun11@huawei.com>,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, andrzej.p@collabora.com,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220617073101.101234-1-zhangzekun11@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220617073101.101234-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 08:31, Zhang Zekun wrote:
> 'dma_alloc_coherent()' alloc a 'RKVDEC_VP9_COUNT_SIZE' size area to
> 'unsigned char *count_tbl', however, the memset() bellow only set
> 'sizeof(*count_tbl)', which equals to 1, bytes to zero. This can
>   cause unexpected error.

Have you observed an error in practice? Given that it's been part of the 
dma_alloc_coherent() API to return a zeroed buffer for several years now 
- see 750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()") - 
this memset shouldn't be needed either way.

Robin.

> Fixes: f25709c4ff15 ("media: rkvdec: Add the VP9 backend")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   drivers/staging/media/rkvdec/rkvdec-vp9.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> index 311a12656072..3ad303a3de48 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> @@ -1026,7 +1026,7 @@ static int rkvdec_vp9_start(struct rkvdec_ctx *ctx)
>   
>   	vp9_ctx->count_tbl.size = RKVDEC_VP9_COUNT_SIZE;
>   	vp9_ctx->count_tbl.cpu = count_tbl;
> -	memset(count_tbl, 0, sizeof(*count_tbl));
> +	memset(count_tbl, 0, RKVDEC_VP9_COUNT_SIZE);
>   	rkvdec_init_v4l2_vp9_count_tbl(ctx);
>   
>   	return 0;
