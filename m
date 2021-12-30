Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352534820C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbhL3W5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:57:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33996 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL3W5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:57:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1166176B;
        Thu, 30 Dec 2021 22:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C8C36AE7;
        Thu, 30 Dec 2021 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640905066;
        bh=1S5kx5c+OcaMPs3JdmJIum8l72T4//FhgRs0NM+GQgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yqn9aOjrf2W41bLwOIeGia/mHPThVBDPkamdpILrn3y1LWtZgnrHtIP/3iTRdaG/q
         2blFwXjdDw5snwNRxxfEgIVQlv7zqj4m3ooJGFbuFVOHctsHfXJG9SzHT9sxg5kPbM
         4LlhkVnb7MyazK1JwTGCHiYsrQDd+4JGWonZDwT+SqHrzU5ljfARR79AyibZsabicN
         otEGcGJjp2IE8BhHKVOp3PU5gFHqYcKAajK4JVo5H7p4K1274Yuqvj1Oktbz8yNDI6
         RUVlJB/RdVcwhe02EZ6+TdhHvwdP0OnKzZ8khT0lg4gByzurUv7K4JzaPbjBh91XjB
         Ic9+NeA3K3Vuw==
Date:   Thu, 30 Dec 2021 16:57:40 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - check possible NULL pointer
Message-ID: <Yc45ZPItDFcDaCNv@quark>
References: <20211229093216.1753083-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229093216.1753083-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 05:32:16PM +0800, Jiasheng Jiang wrote:
> And then it will cause the BUG_ON() in sg_assign_page().

That's not true.  The two BUG_ON()'s in sg_assign_page() are:

        BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
#ifdef CONFIG_DEBUG_SG
        BUG_ON(sg_is_chain(sg));
#endif

Neither will trigger due to page == NULL.

>  		do {
> +			struct page *pg;
>  			unsigned int i = sgl->cur;
>  
>  			plen = min_t(size_t, len, PAGE_SIZE);
>  
> -			sg_assign_page(sg + i, alloc_page(GFP_KERNEL));
> +			pg = alloc_page(GFP_KERNEL);
> +			if (!pg) {
> +				err = -ENOMEM;
> +				goto unlock;
> +			}
> +
> +			sg_assign_page(sg + i, pg);
>  			if (!sg_page(sg + i)) {
>  				err = -ENOMEM;
>  				goto unlock;

The NULL check is already done, just below the redundant one you're adding.

I do think it would be more logical to do the NULL check before
sg_assign_page().  So you could send a patch that moves it there.  But it would
be a cleanup, not a fix.

- Eric
