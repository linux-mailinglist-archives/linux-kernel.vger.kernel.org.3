Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2827A48187E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhL3C2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:28:35 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:43105 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233070AbhL3C2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:28:33 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPXJJ5szMz1RvlV
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 18:28:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640831312; x=1643423313; bh=Kr7L88VPkC+kLwXhuVnFqsMu3F4AU4CQPbs
        zTpzNGxM=; b=CtGXYfwCe2nVF0poLJ9LgREcsKqsQAHoHt2NBYCYfKblE7aoKNi
        bJIivQzvgN6piZU3EBkvRmlzj1gqqRuBhY2N06cgz3RhdEzEa8DoH8NTIug6pD2C
        PpsfOgpCEjXYCLXmwGzA3JnJzL/pCDlzKhAB3GIaFqLlK6nYS210XRGtdCqUpNaw
        g9WFhWmraYzYw9UC50JUEhAm0JEm/T9enO/cSpmPfuLmqCoSgBNNcoEXLiOYkitk
        U74CobODbSmBbPxoqsqTR+b4nRnHq7iXrTXIY7loDNWtmG3NWs0B6P3Slpc0I1dv
        rsWzvUVaMnFVjiz33hXBBBkUVUvGFqdS63Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a2nngnrN9408 for <linux-kernel@vger.kernel.org>;
        Wed, 29 Dec 2021 18:28:32 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPXJG2kp0z1RtVG;
        Wed, 29 Dec 2021 18:28:30 -0800 (PST)
Message-ID: <c60a1750-ccbb-1f7a-12be-ac331393be80@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 11:28:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] null_blk: Use bitmap_zalloc() when applicable
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        ming.lei@redhat.com, Johannes.Thumshirn@wdc.com,
        shinichiro.kawasaki@wdc.com, jiangguoqing@kylinos.cn
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <3e68598defed010efb864ea55887d88ed0da02cc.1640296433.git.christophe.jaillet@wanadoo.fr>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3e68598defed010efb864ea55887d88ed0da02cc.1640296433.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/21 06:55, Christophe JAILLET wrote:
> 'nq->tag_map' is a bitmap. So use bitmap_zalloc() to simplify code and
> improve the semantic.
> 
> Also change the corresponding kfree() into bitmap_free() to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/block/null_blk/main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 6be6ccd4a28f..9e058e0aa668 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1661,7 +1661,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  static void cleanup_queue(struct nullb_queue *nq)
>  {
> -	kfree(nq->tag_map);
> +	bitmap_free(nq->tag_map);
>  	kfree(nq->cmds);
>  }
>  
> @@ -1790,14 +1790,13 @@ static const struct block_device_operations null_rq_ops = {
>  static int setup_commands(struct nullb_queue *nq)
>  {
>  	struct nullb_cmd *cmd;
> -	int i, tag_size;
> +	int i;
>  
>  	nq->cmds = kcalloc(nq->queue_depth, sizeof(*cmd), GFP_KERNEL);
>  	if (!nq->cmds)
>  		return -ENOMEM;
>  
> -	tag_size = ALIGN(nq->queue_depth, BITS_PER_LONG) / BITS_PER_LONG;
> -	nq->tag_map = kcalloc(tag_size, sizeof(unsigned long), GFP_KERNEL);
> +	nq->tag_map = bitmap_zalloc(nq->queue_depth, GFP_KERNEL);
>  	if (!nq->tag_map) {
>  		kfree(nq->cmds);
>  		return -ENOMEM;

Before this patch, tag_size would always be a multiple of BITS_PER_LONG.
Using bitmap_zalloc(), that alignment goes away, but I think this is OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
