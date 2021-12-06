Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B3B4695ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbhLFMs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:48:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56962 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhLFMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:48:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD2E6125E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2837EC341C2;
        Mon,  6 Dec 2021 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638794726;
        bh=GSABlPFm0T2h43gikjVwJWjVzcYXiMcZUh9QxU8U/pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=phNT5Zuwo3JsijnInN5uqiAtsRQrRqZnEyNU6kOP8FYuotBIi0aoRLolW7RC8WOoE
         FQqQEGvD+Fl/KynQw0F2BBh6rdBx+3NItt8WMffkR/t5cqJluzPkJD+R3vZ5I6bE2b
         a8zeV0SfJU/i5/f8z8R/wkaoGL+cawiMbLdPE2Hk0OBeVWf21llrDgXko3j+SEo+b3
         00dBhlvHDNyEphFjxDgh4Y0aGk7b8QEsNKFni8/YIBYFQ13FTgd+PryZevM8rzYGSj
         aSJVtBXENDvS5HrNCM7lIQXEPmt+FnQ5eiTfj6eZ1pF39eXS4blP5S+/k6FGh631xI
         /Tv9ptByc8a1w==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] mm/damon: Modify damon_rand() macro to static inline function
Date:   Mon,  6 Dec 2021 12:45:23 +0000
Message-Id: <20211206124523.6259-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7066b07ba4f89e32c5264ed1f7d71260bea8812e.1638794380.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 20:41:29 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> The damon_rand() func can not be implemented as a macro.
> Example:
> 	damon_rand(a++, b);
> The value of 'a' will be incremented twice, This is obviously
> unreasonable, So there fix it.
> 
> Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c6df025d8704..bc9c8932b1e8 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -19,7 +19,10 @@
>  #define DAMOS_MAX_SCORE		(99)
> 
>  /* Get a random number in [l, r) */
> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
> +static inline unsigned long damon_rand(unsigned long l, unsigned long r)
> +{
> +	return l + (r - l);

Seems prandom_u32_max() is missed?


Thanks,
SJ

> +}
> 
>  /**
>   * struct damon_addr_range - Represents an address region of [@start, @end).
> --
> 2.31.0
