Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3657B148
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGTG6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiGTG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:57:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970E2E9DE;
        Tue, 19 Jul 2022 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ezIIZCU4EFhKuDAwp8CxrD6gg3vQSd6pReh1trZRbPE=; b=TX7uWhY7SglTlzuqrHNvq/dWkt
        JKDrshvsS3Q/z8E1BQdM2SVJKalWOWtNHp/PLQb8+uya3kd4r4wyzNpeJKIHHYz1iV5g8RIXMu+ik
        l3Vdw69yGW0yCcv0Q8LSQCEmV3SS9VB0QHgs/6kZvj2VTXTb6Dchn/af3J8MsITG71gWz6QHuhEE1
        UJ5Obha3EVORASfMcghE4ABfuCdRDPwAEBiFCW3+d2ZfaUzHTgWyeX4TTQQRVwqtF2Ip6UkhgSuUP
        qkEFhI/dyKELtTnx0Im0HgHP6+osLqtxisU5Pf8otKHYK13zsl4ksxhpn2Lp9CpE68lnu2lIZFa5Q
        JWTmfIIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oE3eT-00E0u4-CO;
        Wed, 20 Jul 2022 06:57:45 +0000
Date:   Wed, 20 Jul 2022 07:57:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     zengjx95@gmail.com
Cc:     reiserfs-devel@vger.kernel.org, willy@infradead.org,
        jlayton@kernel.org, damien.lemoal@opensource.wdc.com, jack@suse.cz,
        edward.shishkin@gmail.com, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [PATCH] fs/reiserfs/inode: remove dead code in
 _get_block_create_0()
Message-ID: <YtenaY4hDx7J746Y@ZenIV>
References: <20220720063310.992149-1-zengjx95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720063310.992149-1-zengjx95@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 02:33:10PM +0800, zengjx95@gmail.com wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Fix "control flow" issues found by Coverity
> Logically dead code (DEADCODE)
> Execution cannot reach this statement.
> 
> Assigned_value: Assigning value NULL to p here
> 293	char *p = NULL;
> In the following conditional expression, the value of p is always NULL,
> as a result, the kunmap() cannot be executed.
> 308	if (p)
> 309		kunmap(bh_result->b_page);
> 
> 355	if (p)
> 356		kunmap(bh_result->b_page);
> 
> 366	if (p)
> 367		kunmap(bh_result->b_page);
> 
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>

First of all, if you find something like that, it might be a good idea to
find _when_ had that appeared.  If nothing else, transformation might
very well turn out to be obfuscating a preexisting bug.

In this case, it's not hard to find: 27b3a5c51b50 "kill-the-bkl/reiserfs:
drop the fs race watchdog from _get_block_create_0()", which had
removed a label upstream of these tests and a branch to it from
downstream of assignment to p.

Assignment survives, BTW, in the following form:
        if (!p)
		p = (char *)kmap(bh_result->b_page);
and this test is just as constant as the ones you'd removed.  Unlike
them it's constantly true, of course, but just as inexplicable by
the current form of function.

If anything, I would suggest losing initialization of p to NULL
and making the assignment quoted above unconditional.



> ---
>  fs/reiserfs/inode.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 0cffe054b78e..d1b0c7645fcb 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -305,8 +305,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  	result = search_for_position_by_key(inode->i_sb, &key, &path);
>  	if (result != POSITION_FOUND) {
>  		pathrelse(&path);
> -		if (p)
> -			kunmap(bh_result->b_page);
>  		if (result == IO_ERROR)
>  			return -EIO;
>  		/*
> @@ -352,8 +350,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  		}
>  
>  		pathrelse(&path);
> -		if (p)
> -			kunmap(bh_result->b_page);
>  		return ret;
>  	}
>  	/* requested data are in direct item(s) */
> @@ -363,8 +359,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  		 * when it is stored in direct item(s)
>  		 */
>  		pathrelse(&path);
> -		if (p)
> -			kunmap(bh_result->b_page);
>  		return -ENOENT;
>  	}
>  
> -- 
> 2.27.0
> 
