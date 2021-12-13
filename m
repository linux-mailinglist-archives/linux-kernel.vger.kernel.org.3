Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563AE473438
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhLMSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:42:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34454 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhLMSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:41:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 146E8611C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D5CC34602;
        Mon, 13 Dec 2021 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639420917;
        bh=W4wGvtyRwboEin4P8FY5K8Ueic9aEys2sjuTqPMHJLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN3RDOH4dVWF7OvndsCx9rLfvkqlXlM7IwzkNthOJPvGzK+wjz+eNp7BDd3EdgmwM
         ZbLbbqSKRxy9xy6cCKbfiyKzFU6lQdbT1e7pSsmeoZABNkLWD+nBN2VJFoT27uFx2U
         XIrKHwkUdmSb/SZCW+/S8BUPGG1aZ1mw9DBbBW5OU5Nq+XddEAUsqw+4iB85nqvLKk
         0nMsFhxFqeOu4pQKVpVapMG/MVC4U+9ce2vpWK3FPtoUkprPUmof6yWvdVYvPP868M
         5vduILNjxqD9NK8inEBVVj1/IfUg8ey22IhZqlmZDEnru1ZONVlhbpame1bSM0+CUt
         SIS4h3a2FdB8Q==
Date:   Mon, 13 Dec 2021 18:41:52 +0000
From:   Will Deacon <will@kernel.org>
To:     davidcomponentone@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] locking/ww-mutex: use swap() to make code cleaner
Message-ID: <20211213184152.GE12405@willie-the-truck>
References: <20211104001847.694982-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104001847.694982-1-yang.guang5@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 08:18:46AM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> ---
>  kernel/locking/test-ww_mutex.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 353004155d65..daad819fcd16 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -389,7 +389,7 @@ struct stress {
>  static int *get_random_order(int count)
>  {
>  	int *order;
> -	int n, r, tmp;
> +	int n, r;
>  
>  	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
>  	if (!order)
> @@ -401,9 +401,7 @@ static int *get_random_order(int count)
>  	for (n = count - 1; n > 1; n--) {
>  		r = get_random_int() % (n + 1);
>  		if (r != n) {
> -			tmp = order[n];
> -			order[n] = order[r];
> -			order[r] = tmp;
> +			swap(order[n], order[r]);

Looks correct to me:

Acked-by: Will Deacon <will@kernel.org>

Will
