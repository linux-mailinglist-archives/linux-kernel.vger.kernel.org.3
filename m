Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5456481A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhL3H0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:26:46 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41212 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233577AbhL3H0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:26:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V0KGD0U_1640849191;
Received: from 30.240.101.130(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V0KGD0U_1640849191)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 15:26:32 +0800
Message-ID: <ca006060-10d8-bdd4-0824-943750542f61@linux.alibaba.com>
Date:   Thu, 30 Dec 2021 15:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] lib/mpi: Add the return value check of kcalloc()
Content-Language: en-US
To:     Zizhuang Deng <sunsetdzz@gmail.com>, herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20211230070331.1046343-1-sunsetdzz@gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211230070331.1046343-1-sunsetdzz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/21 3:03 PM, Zizhuang Deng wrote:
> Add the return value check of kcalloc() to avoid potential
> NULL ptr dereference.
> 
> Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
> ---

Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Best regards,
Tianjia

>   lib/mpi/mpi-mod.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
> index 47bc59edd4ff..54fcc01564d9 100644
> --- a/lib/mpi/mpi-mod.c
> +++ b/lib/mpi/mpi-mod.c
> @@ -40,6 +40,8 @@ mpi_barrett_t mpi_barrett_init(MPI m, int copy)
>   
>   	mpi_normalize(m);
>   	ctx = kcalloc(1, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
>   
>   	if (copy) {
>   		ctx->m = mpi_copy(m);
