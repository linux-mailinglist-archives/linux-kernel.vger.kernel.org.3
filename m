Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810D647F9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhL0CJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 21:09:15 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56692 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0CJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:09:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E564CE0B77
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B79CC36AE8;
        Mon, 27 Dec 2021 02:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640570947;
        bh=SGQJZNEvEetOE2tY3kO+E4p0kZRezP16jB+ueVUG3T4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=arPWzowRJ5DzpDd3zNPHOE+VVCKpAsG4RO9/yo9D1a9i0+bYRtX5v5AvgNhotV/iS
         1dXKd6eSoJhkk0c4Sy2/Gd8V/Sn6lxzP0rq9mCOw3IZxCrXZ3iFcsmi0UTpEebL5Iv
         ReUR9XvnmlobF7SO54+gWlxY99eV33RRUCeF6jg7NqD44lY5oBThLa2CbaeOD5TgQx
         /yDZultndaa/Fea6sBhvuxnBuWUUWwdHBwNfF6CuJao2gMw7Cij8ygnBcTVDkUm5Da
         KlMEhuOX1qNKslZ/haCENK0XU+Uc0xQIAtu2dr4BjNUcB92YtQSwVnqa3F+GEXhL2b
         tQxAUfN4g42Lw==
Message-ID: <c3fd4833-2483-f77e-fb79-42871e2d4219@kernel.org>
Date:   Mon, 27 Dec 2021 10:08:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/5] erofs: tidy up z_erofs_lz4_decompress
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211225070626.74080-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/25 15:06, Gao Xiang wrote:
> To prepare for the upcoming ztailpacking feature and further
> cleanups, introduce a unique z_erofs_lz4_decompress_ctx to keep
> the context, including inpages, outpages and oend, which are
> frequently used by the lz4 decompressor.
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/decompressor.c | 80 +++++++++++++++++++++--------------------
>   1 file changed, 41 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c373a199c407..d1282a8b709e 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -16,6 +16,11 @@
>   #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
>   #endif
>   
> +struct z_erofs_lz4_decompress_ctx {
> +	struct z_erofs_decompress_req *rq;
> +	unsigned int inpages, outpages, oend;
> +};
> +

Could you please comment a bit about fields of structure 
z_erofs_lz4_decompress_ctx?

Otherwise, the patch looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
