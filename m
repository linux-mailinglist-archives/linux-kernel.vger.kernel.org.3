Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2094DD19B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiCRAIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCRAIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:08:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [142.44.231.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4EF2AA18A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:07:26 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nV09J-00D5Fg-Ih; Fri, 18 Mar 2022 00:07:21 +0000
Date:   Fri, 18 Mar 2022 00:07:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317072612.163143-8-imran.f.khan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 06:26:11PM +1100, Imran Khan wrote:

> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
> index 9d4103602554..cbdd1be5f0a8 100644
> --- a/fs/kernfs/symlink.c
> +++ b/fs/kernfs/symlink.c
> @@ -113,12 +113,19 @@ static int kernfs_getlink(struct inode *inode, char *path)
>  	struct kernfs_node *kn = inode->i_private;
>  	struct kernfs_node *parent = kn->parent;
>  	struct kernfs_node *target = kn->symlink.target_kn;
> -	struct rw_semaphore *rwsem;
> +	struct kernfs_rwsem_token token;
>  	int error;
>  
> -	rwsem = kernfs_down_read(parent);
> +	/**
> +	 * Lock both parent and target, to avoid their movement
> +	 * or removal in the middle of path construction.
> +	 * If a competing remove or rename for parent or target
> +	 * wins, it will be reflected in result returned from
> +	 * kernfs_get_target_path.
> +	 */
> +	kernfs_down_read_double_nodes(target, parent, &token);
>  	error = kernfs_get_target_path(parent, target, path);
> -	kernfs_up_read(rwsem);
> +	kernfs_up_read_double_nodes(target, parent, &token);
>  
>  	return error;
>  }

No.  Read through the kernfs_get_target_path().  Why would locking these
two specific nodes be sufficient for anything useful?  That code relies
upon ->parent of *many* nodes being stable.  Which is not going to be
guaranteed by anything of that sort.

And it's not just "we might get garbage if we race" - it's "we might
walk into kfree'd object and proceed to walk the pointer chain".

Or have this loop
	kn = target;
	while (kn->parent && kn != base) {
		len += strlen(kn->name) + 1;
		kn = kn->parent;
	}
see the names that are not identical to what we see in
	kn = target;
	while (kn->parent && kn != base) {
		int slen = strlen(kn->name);

		len -= slen;
		memcpy(s + len, kn->name, slen);
		if (len)
			s[--len] = '/';

		kn = kn->parent;
	}
done later in the same function.  With obvious unpleasant effects.
Or a different set of nodes, for that matter.

This code really depends upon the tree being stable.  No renames of
any sort allowed during that thing.
