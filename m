Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA0F5A25E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiHZKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiHZKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:31:18 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BBD276A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:31:17 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RWcNoqoK9BDYDRWcNop5xv; Fri, 26 Aug 2022 12:31:15 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Aug 2022 12:31:15 +0200
X-ME-IP: 90.11.190.129
Message-ID: <50bfdb3f-f6fe-b0ef-4214-5d533d45e89c@wanadoo.fr>
Date:   Fri, 26 Aug 2022 12:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] intel_th: Fix dma_map_sg error check
Content-Language: fr
To:     Jack Wang <jinpu.wang@ionos.com>,
        alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20220826101523.79502-1-jinpu.wang@ionos.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220826101523.79502-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/08/2022 à 12:15, Jack Wang a écrit :
> dma_map_sg return 0 on error.
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>   drivers/hwtracing/intel_th/msu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
> index 6c8215a47a60..b49237d56a60 100644
> --- a/drivers/hwtracing/intel_th/msu.c
> +++ b/drivers/hwtracing/intel_th/msu.c
> @@ -931,7 +931,7 @@ static int msc_buffer_contig_alloc(struct msc *msc, unsigned long size)
>   
>   	ret = dma_map_sg(msc_dev(msc)->parent->parent, msc->single_sgt.sgl, 1,
>   			 DMA_FROM_DEVICE);
> -	if (ret < 0)
> +	if (!ret)

Missing ret = -EIO?
like in other patches?

CJ

>   		goto err_free_pages;
>   
>   	msc->nr_pages = nr_pages;

