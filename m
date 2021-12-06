Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54E469615
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbhLFNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:00:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53146 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbhLFNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:00:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95069B810AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD260C341C5;
        Mon,  6 Dec 2021 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638795431;
        bh=iWcUSdfMi/yZYvDDPgFhXATx0z6jQgrGR+qiCes0fK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=hojjVnJQAhKABdFEd6m8jGpjFA3yZZvmkf1eQ/qqflPuqvM+K2uD61xv42VC35Oku
         z9TIeCxPnIA/06lCMjLAfHt3s59WfNwTVpcJXXDlW9u2OrDQ4qCaivJI+tnCqMXZHp
         RvIuS1ko/Qtgycrh2v0+czMydlVIIao+FVrafq7cBKfHi3feNeI/T9iTjbQ7oIIAWu
         PrK4w95ykrVQ4VH+gdOx4M//XhbdBD2N4bRom3HDFp3NEqYAqfKVaLp3j/vlvIjPEc
         xbmYxZcCKAtzxizG5ox6kUdt74d/OQSRIKCmbMF0YB+AbIg+s947ZpkKGEsH+z1Ndy
         9Gj888RYBFeMg==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon: Modify damon_rand() macro to static inline function
Date:   Mon,  6 Dec 2021 12:57:08 +0000
Message-Id: <20211206125708.6443-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <110ffcd4e420c86c42b41ce2bc9f0fe6a4f32cd3.1638795127.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 20:52:43 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> The damon_rand() func can not be implemented as a macro.
> Example:
> 	damon_rand(a++, b);
> The value of 'a' will be incremented twice, This is obviously
> unreasonable, So there fix it.
> 
> Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c6df025d8704..a58046cd45e6 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -19,7 +19,10 @@
>  #define DAMOS_MAX_SCORE		(99)
> 
>  /* Get a random number in [l, r) */
> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
> +static inline unsigned long damon_rand(unsigned long l, unsigned long r)
> +{
> +	return l + prandom_u32_max(r - l);
> +}
> 
>  /**
>   * struct damon_addr_range - Represents an address region of [@start, @end).
> --
> 2.31.0
> 
> 
