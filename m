Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB144614BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhK2MMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:12:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47854 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhK2MKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE87CB80F4B;
        Mon, 29 Nov 2021 12:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D414EC004E1;
        Mon, 29 Nov 2021 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638187624;
        bh=EWMYjNgMHCp0eROVow1StTt9tqAPUUbN9NbYCcwS4dQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T7SyOLNOcFSVa1U6ZcvE5ZzkC89w8fJT2YUUWHGZoSYVlLO6xnYjq7EERwcIkh6xk
         e7+YC4h0fgIE6zIKZm+c8OFQRUF5024W1VOlritZiyS2nmyrdUGpq8T6AF9hi/4hmI
         3K8TLg0bMS9o2nGFp9q+HgbQXbLeKjSKur7cg2p1qGOwMCtr1qzqaPwhDU0t9SAF2z
         tpvhrMaoBJA597zYC1s6VdD9eWmIq1+T0iOseMlfQhPY2eJToL+S3lGicRsvHJaV0c
         5JAwT7KwCJfRYxxssQUxg7fVMMibfJ5gCeurI3nfwk58WrYFPtMIOteMr5AZr+M85A
         1HTMK5D10CJjw==
Message-ID: <045052dc02ce7bbf01dc73bdcd9809cac36b5e51.camel@kernel.org>
Subject: Re: [PATCH] rbd: make const pointer speaces a static const array
From:   Jeff Layton <jlayton@kernel.org>
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 07:07:02 -0500
In-Reply-To: <20211127172104.102994-1-colin.i.king@gmail.com>
References: <20211127172104.102994-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-27 at 17:21 +0000, Colin Ian King wrote:
> Don't populate the const array spaces on the stack but make it static
> const and make the pointer an array to remove a dereference. Shrinks
> object code a little too.  Also clean up intent, currently it is spaces
> and should be a tab.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8f140da1efe3..de7ede6aa95a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6189,7 +6189,7 @@ static inline size_t next_token(const char **buf)
>          * These are the characters that produce nonzero for
>          * isspace() in the "C" and "POSIX" locales.
>          */
> -        const char *spaces = " \f\n\r\t\v";
> +	static const char spaces[] = " \f\n\r\t\v";
>  
>          *buf += strspn(*buf, spaces);	/* Find start of token */
>  

Thanks, Colin. Merged into our "testing" branch. It should make v5.17.
-- 
Jeff Layton <jlayton@kernel.org>
