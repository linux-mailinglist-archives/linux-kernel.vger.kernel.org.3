Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949C47034A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhLJPDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:03:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42486 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhLJPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:03:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 428ACCE2B7F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6210CC00446;
        Fri, 10 Dec 2021 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148382;
        bh=PdbfVC9mP6F4V4P5AhVme4cHoFX8hGaC2COLxZT+mek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pbCIj0pVv7KJ4MtXlVCG0xTc5YEHB4HRRTIsiN5hMHDtq+Vp5Kp9QxArEAAU4f8zW
         nnpeiBbnZl6Mi7zBlTlVZx+FbAm5ghKAQuDCK8McngaMoMc80RWe3T7wvhO1fSzb/J
         5w+rnJvVfR9B3f2VfkATqGXNQ4YnVqzyp5IEKSjhjgu7TeP9IVwnde7dIGItVVThCI
         UBQOdc48Y5sLxs5z+cjN8uIHY9SOXZhQ6Ym1glDDIFOvEtBlZ/Cpg5Sg4YX+yeynOi
         b/GBga8Ngu6vZLz7gl+6DPf0a8XhqsNqGm5ZtDH/FJMCuqb+x4Xn3TSKjdOK9RykoB
         J/GK/XjGQBzQQ==
Message-ID: <139522fa-ad23-ccce-52cb-e7fa9caf2394@kernel.org>
Date:   Fri, 10 Dec 2021 22:59:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] f2fs: compress: fix potential deadlock of compress file
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Fengnan Chang <changfengnan@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        Youngjin Gil <youngjin.gil@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211210043017epcas1p38cc53389a50e33752e97618498b18f33@epcas1p3.samsung.com>
 <20211210043012.180588-1-hj514.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211210043012.180588-1-hj514.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/10 12:30, Hyeong-Jun Kim wrote:
> There is a potential deadlock between writeback process and a process
> performing write_begin() or write_cache_pages() while trying to write
> same compress file, but not compressable, as below:
> 
> [Process A] - doing checkpoint
> [Process B]                     [Process C]
> f2fs_write_cache_pages()
> - lock_page() [all pages in cluster, 0-31]
> - f2fs_write_multi_pages()
>   - f2fs_write_raw_pages()
>    - f2fs_write_single_data_page()
>     - f2fs_do_write_data_page()
>       - return -EAGAIN [f2fs_trylock_op() failed]
>     - unlock_page(page) [e.g., page 0]
>                                  - generic_perform_write()
>                                   - f2fs_write_begin()
>                                    - f2fs_prepare_compress_overwrite()
>                                     - prepare_compress_overwrite()
>                                      - lock_page() [e.g., page 0]
>                                      - lock_page() [e.g., page 1]
>     - lock_page(page) [e.g., page 0]
> 
> Since there is no compress process, it is no longer necessary to hold
> locks on every pages in cluster within f2fs_write_raw_pages().
> 
> This patch changes f2fs_write_raw_pages() to release all locks first
> and then perform write same as the non-compress file in
> f2fs_write_cache_pages().
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>

Looks good to me, thanks for Fengnan and Hyeong-Jun's report and Hyeong-Jun's
fixing. :)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
