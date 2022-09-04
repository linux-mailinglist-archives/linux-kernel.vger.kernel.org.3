Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817CD5AC570
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiIDQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIDQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:31:19 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0D2E6B3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=vmMX29tPh/NH4P7ezbbad6kpxdk9LRYNKFDT/DUOtT8=; b=SLWzikcmV3SC2D2WeYjbroHM5e
        sJbz9FMw5KZgxHO3RIcqARU5jNQXgDgikS3meEmjyP5rZx6eSbWCfGR3KCfKA3AXIQW9zKHNa/GkW
        cnueVeyK9digO19gW+rBlOVxCKcPr58jo2323eG0pJpyJ1FsBvleL0ujbrfieSyEPpQcdQRVLYDeX
        wIuQC5Mi74i9UJyuBCfxvU4lqg/ki3lZoNBiaSzTUisEcMf9BiK6KqoKDtft+b1+ZFj62hKQna7qP
        2Grk55Tgk4OplwFSjtam2oFKH/UcHsbJnAnYRsPTmwXkzyVqKbWn4KQKgzqKR7WVsVLqGSvgQcPxC
        YEqXnNkxRHrvyyt8zqJL8ltnOEpsKSpOYVa6T3zup9JOMR0QlwTcHtYmqeKgX0MfFsFHC/7QMK8aq
        ANqi0ZxlR7CkzkJ8ob2z/U9c08T9qIcGiYIe2H/ymFYu+VfpSvKR5uDua+hiXzdKByXQ1L0PG1tRa
        7+WY4WbH7pP6iVCHBYHX7DV4lVavfbgkBe+CD44nTqAfRd15dtjYd6aFz9IX3oEeT9d3Rm+ACx2ns
        NnlnLkb7+GE4kxGH921GecMddB5XSmz6O3+3RpPmtokVwIlVkf5tdulZf5xoBsAcILHi4I+WNiaJM
        67rA3iZ0A9zGKULtVd9+EPyPITd4t8BZa9bAxM03o=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+de52531662ebb8823b26@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] 9p: p9_client_create: use p9_client_destroy on failure
Date:   Sun, 04 Sep 2022 18:31:12 +0200
Message-ID: <7389539.FyhnmifhmU@silver>
In-Reply-To: <20220904063936.1305139-1-asmadeus@codewreck.org>
References: <0000000000001c3efc05e6693f06@google.com>
 <20220904063936.1305139-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 4. September 2022 08:39:36 CEST Dominique Martinet wrote:
> If trans was connected it's somehow possible to fail with requests in
> flight that could still be accessed after free if we just free the clnt
> on failure.
> Just use p9_client_destroy instead that has proper safeguards.
> 
> Reported-by: syzbot+de52531662ebb8823b26@syzkaller.appspotmail.com
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  net/9p/client.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 0a6110e15d0f..d340dbbd2ace 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -931,14 +931,10 @@ struct p9_client *p9_client_create(const char
> *dev_name, char *options) char *client_id;
> 
>  	err = 0;
> -	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
> +	clnt = kzalloc(sizeof(*clnt), GFP_KERNEL);
>  	if (!clnt)
>  		return ERR_PTR(-ENOMEM);
> 
> -	clnt->trans_mod = NULL;
> -	clnt->trans = NULL;
> -	clnt->fcall_cache = NULL;
> -
>  	client_id = utsname()->nodename;
>  	memcpy(clnt->name, client_id, strlen(client_id) + 1);
> 
> @@ -948,7 +944,7 @@ struct p9_client *p9_client_create(const char *dev_name,
> char *options)
> 
>  	err = parse_opts(options, clnt);
>  	if (err < 0)
> -		goto free_client;
> +		goto out;
> 
>  	if (!clnt->trans_mod)
>  		clnt->trans_mod = v9fs_get_default_trans();
> @@ -957,7 +953,7 @@ struct p9_client *p9_client_create(const char *dev_name,
> char *options) err = -EPROTONOSUPPORT;
>  		p9_debug(P9_DEBUG_ERROR,
>  			 "No transport defined or default transport\n");
> -		goto free_client;
> +		goto out;
>  	}
> 
>  	p9_debug(P9_DEBUG_MUX, "clnt %p trans %p msize %d protocol %d\n",
> @@ -965,7 +961,7 @@ struct p9_client *p9_client_create(const char *dev_name,
> char *options)
> 
>  	err = clnt->trans_mod->create(clnt, dev_name, options);
>  	if (err)
> -		goto put_trans;
> +		goto out;
> 
>  	if (clnt->msize > clnt->trans_mod->maxsize) {
>  		clnt->msize = clnt->trans_mod->maxsize;
> @@ -979,12 +975,12 @@ struct p9_client *p9_client_create(const char
> *dev_name, char *options) p9_debug(P9_DEBUG_ERROR,
>  			 "Please specify a msize of at least 4k\n");
>  		err = -EINVAL;
> -		goto close_trans;
> +		goto out;
>  	}
> 
>  	err = p9_client_version(clnt);
>  	if (err)
> -		goto close_trans;
> +		goto out;
> 
>  	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
>  	 * followed by data accessed from userspace by read
> @@ -997,12 +993,8 @@ struct p9_client *p9_client_create(const char
> *dev_name, char *options)
> 
>  	return clnt;
> 
> -close_trans:
> -	clnt->trans_mod->close(clnt);
> -put_trans:
> -	v9fs_put_trans(clnt->trans_mod);
> -free_client:
> -	kfree(clnt);
> +out:
> +	p9_client_destroy(clnt);
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(p9_client_create);




