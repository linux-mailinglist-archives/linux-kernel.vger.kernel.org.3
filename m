Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26590481A05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhL3Gl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:41:59 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55118 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhL3Gl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:41:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0V0Jrcgi_1640846516;
Received: from 30.240.101.130(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V0Jrcgi_1640846516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 14:41:56 +0800
Message-ID: <c7817afe-b1ed-0967-5a57-0a6bdf2aec4e@linux.alibaba.com>
Date:   Thu, 30 Dec 2021 14:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] lib/mpi: add the return value check of kcalloc
Content-Language: en-US
To:     Zizhuang Deng <sunsetdzz@gmail.com>, linux-kernel@vger.kernel.org
References: <20211230025159.460218-1-sunsetdzz@gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211230025159.460218-1-sunsetdzz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zizhuang,

On 12/30/21 10:51 AM, Zizhuang Deng wrote:
> Add the return value check of kcalloc to avoid potential
> NULL ptr dereference.
> 
> Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
> ---
>   lib/mpi/mpi-mod.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
> index 47bc59edd4ff..6fd6900f0798 100644
> --- a/lib/mpi/mpi-mod.c
> +++ b/lib/mpi/mpi-mod.c
> @@ -41,6 +41,10 @@ mpi_barrett_t mpi_barrett_init(MPI m, int copy)
>   	mpi_normalize(m);
>   	ctx = kcalloc(1, sizeof(*ctx), GFP_KERNEL);
>   

Remove this empty line.

> +	if (!ctx) {
> +		return NULL;
> +	}
> +
>   	if (copy) {
>   		ctx->m = mpi_copy(m);
>   		ctx->m_copied = 1;


Thanks for pointing it out. Please send a copy to linux-crypto and 
Herbert Xu.

Best regards,
Tianjia
