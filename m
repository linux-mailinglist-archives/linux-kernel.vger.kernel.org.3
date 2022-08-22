Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C759BC02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiHVIvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiHVIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:50:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9012E681
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:50:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B21934061;
        Mon, 22 Aug 2022 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661158251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SZ0mZe3MzFvJr/cNp8TMyuZqwMYPabbtk/rywqpBHw=;
        b=NJkapjOPJgsts9AXcO0qbL7GBTkS+KR9fFBu2IJTniOQn9WFIX/3MIWeb/sSY33frzXSUg
        tvBlF4Scfc7LERdI2ZbvryWnEU/vxNRl3drD+342IULMRahpYh+O4RsrsbUnYAevOrw6BP
        HIyrOXN0eoMvYNDTC08avNHhiaLSiLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661158251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SZ0mZe3MzFvJr/cNp8TMyuZqwMYPabbtk/rywqpBHw=;
        b=wg0PExrWXWEnVb6i2Yi8UaI8OUfUEwqk4ToZCyVsXzxr8Ngngh2t42edBhjR/oVDyi/OiB
        MuIEY0PC5XmVYUBw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D13052C141;
        Mon, 22 Aug 2022 08:50:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 580C6A066D; Mon, 22 Aug 2022 10:50:50 +0200 (CEST)
Date:   Mon, 22 Aug 2022 10:50:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, mszeredi@redhat.com,
        jack@suse.cz, amir73il@gmail.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] audit: fix potential double free on error path from
 fsnotify_add_inode_mark
Message-ID: <20220822085050.hxj6qmgj2x2tj6uv@quack3>
References: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-08-22 10:29:05, Gaosheng Cui wrote:
> Audit_alloc_mark() assign pathname to audit_mark->path, on error path
> from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
> of audit_mark->path, but the caller of audit_alloc_mark will free
> the pathname again, so there will be double free problem.
> 
> Fix this by resetting audit_mark->path to NULL pointer on error path
> from fsnotify_add_inode_mark().
> 
> Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Good spotting! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/audit_fsnotify.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 6432a37ac1c9..c565fbf66ac8 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>  
>  	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
>  	if (ret < 0) {
> +		audit_mark->path = NULL;
>  		fsnotify_put_mark(&audit_mark->mark);
>  		audit_mark = ERR_PTR(ret);
>  	}
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
