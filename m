Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1459382D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbiHOStq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiHOSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:44:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC632FFC3;
        Mon, 15 Aug 2022 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pQgnV2W+m6IHyd1sfXNyPuGcZpvyoD3dq7ndy9+1QWY=; b=nOms3/1Uq5YOF1bwlhQz39B/xq
        lhJn4Xz+bgO4S+tzCDXYpLB8VrlkUqBdIrbUt95mBrUHdr683sUAqzaa2EL8z+RDmYP2StzlwdOJ2
        dlu4xtB6GtZ7UapVk2WD/TlGptwIfUv0tciWlGulljYY9+Fcpo2ICJpMpb0BJvuXzzX0zDUpw9zyU
        KyGPgpkB3lZyjCE3mM8iw+OX+wUW/BWlIlrIvAWaQoFKHxiKHBkFWxJrLM4RNSV+3QMORX/AlleaD
        vpDR4/Jp7QyIvjl5gi8PPa6yPcN0ObjLRunLjv/8GqjUnNkTYLzal4MQ7zci7VkeymEdMAPpsPy07
        le8oCyVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNent-004kaQ-Ps;
        Mon, 15 Aug 2022 18:27:10 +0000
Date:   Mon, 15 Aug 2022 19:27:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiacheng Xu <stitch@zju.edu.cn>,
        Mudong Liang <mudongliangabcd@gmail.com>
Subject: Re: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
Message-ID: <YvqP/f2P2YgIIO9U@ZenIV>
References: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 02:51:14AM +0900, Ryusuke Konishi wrote:
> In alloc_inode(), inode_init_always() could return -ENOMEM if
> security_inode_alloc() fails.  If this happens for nilfs2,
> nilfs_free_inode() is called without initializing inode->i_private and
> nilfs_free_inode() wrongly calls nilfs_mdt_destroy(), which frees
> uninitialized inode->i_private and can trigger a crash.
> 
> Fix this bug by initializing inode->i_private in nilfs_alloc_inode().
> 
> Link: https://lkml.kernel.org/r/CAFcO6XOcf1Jj2SeGt=jJV59wmhESeSKpfR0omdFRq+J9nD1vfQ@mail.gmail.com
> Link: https://lkml.kernel.org/r/20211011030956.2459172-1-mudongliangabcd@gmail.com
> Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Reported-by: Jiacheng Xu <stitch@zju.edu.cn>
> Reported-by: Mudong Liang <mudongliangabcd@gmail.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/nilfs2/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index ba108f915391..aca5614f1b44 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -159,6 +159,7 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
>  	ii->i_cno = 0;
>  	ii->i_assoc_inode = NULL;
>  	ii->i_bmap = &ii->i_bmap_data;
> +	ii->vfs_inode.i_private = NULL;
>  	return &ii->vfs_inode;
>  }

FWIW, I think it's better to deal with that in inode_init_always(), but
not just moving ->i_private initialization up - we ought to move
security_inode_alloc() to the very end.  No sense playing whack-a-mole
with further possible bugs of that sort...
