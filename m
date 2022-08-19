Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35059986B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiHSJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347388AbiHSJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:07:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE57EF9C7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:07:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A09AC20A6C;
        Fri, 19 Aug 2022 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660900022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUQ3/h3omkARPlhf81Fsb7OA1SEZVUF7gaAsfgO5nsQ=;
        b=cBQLtYP69pB1oElgiRDo2h4HQUSvKOT/WnMlLgKXJcTrPwHb+OSaZUJfz7/BeAXxZJj8KD
        D/TFaaqhBa0UVSmOXUtlvFTNCuRFpIksNJ85GeNgYdoJhCyqBwxG0O+1rAox6bGlgM/oos
        vjYxcY2gOsSnIIf7G0KQ2JG+ZZZuiQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660900022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUQ3/h3omkARPlhf81Fsb7OA1SEZVUF7gaAsfgO5nsQ=;
        b=DOQrjz1mOyczvH19PvTYT2P02ZoxW3jgn8Kw5tdCZy9AWP3ZZJndMd4eoH4y4BN2mJxxNR
        u4p6GXW1irXJR0Dw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67C6B2C142;
        Fri, 19 Aug 2022 09:07:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F43DA0635; Fri, 19 Aug 2022 11:07:01 +0200 (CEST)
Date:   Fri, 19 Aug 2022 11:07:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     cgel.zte@gmail.com
Cc:     roman.gushchin@linux.dev, songmuchun@bytedance.com, tytso@mit.edu,
        jack@suse.cz, willy@infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] isofs: delete unnecessary checks before brelse()
Message-ID: <20220819090701.xvldajjh4gqwa6us@quack3>
References: <20220819081420.96209-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819081420.96209-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-08-22 08:14:20, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus remove the tests which are not needed around the shown calls.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Thanks for the cleanup. I have added the patch to my tree.

								Honza

> ---
>  fs/isofs/inode.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 88bf20303466..df9d70588b60 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1277,13 +1277,11 @@ static int isofs_read_level3_size(struct inode *inode)
>  	} while (more_entries);
>  out:
>  	kfree(tmpde);
> -	if (bh)
> -		brelse(bh);
> +	brelse(bh);
>  	return 0;
>  
>  out_nomem:
> -	if (bh)
> -		brelse(bh);
> +	brelse(bh);
>  	return -ENOMEM;
>  
>  out_noread:
> @@ -1486,8 +1484,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
>  	ret = 0;
>  out:
>  	kfree(tmpde);
> -	if (bh)
> -		brelse(bh);
> +	brelse(bh);
>  	return ret;
>  
>  out_badread:
> -- 
> 2.25.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
