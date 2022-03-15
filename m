Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E014F4D9A52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347876AbiCOL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiCOL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:26:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE64ECFC;
        Tue, 15 Mar 2022 04:25:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 266CD21900;
        Tue, 15 Mar 2022 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647343514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKrRwVuw72BzaglAlmSnLaAKxBvpnYrC6+CTmMlmAIY=;
        b=EyGdUI6H6HT3KSpuL20Nz2Xq2T3sTqiyHr3cEFJNr+TV5qrRUeuKiB3CW6pu25G57HuXJ/
        f9irrfuh4q8+vHogrUkg4ftkzUvhIilHewfS96GI8dY6ZKr20CS9jtB3DXUHIMq/y/Z2mL
        j0LQPboP5xGY3WEhRy2GzovrYV6bDPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647343514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKrRwVuw72BzaglAlmSnLaAKxBvpnYrC6+CTmMlmAIY=;
        b=rl1NWrhB7QGS7mg42YkFQ6lFLwSaqN4v4kXcpeh2QOTClGCUsqoXHAM/NA1lq8qcftsV/4
        gE00On8d2rk7UqAQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 18941A3B87;
        Tue, 15 Mar 2022 11:25:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 87835A0615; Tue, 15 Mar 2022 12:25:12 +0100 (CET)
Date:   Tue, 15 Mar 2022 12:25:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio tree with the ext4 tree
Message-ID: <20220315112512.yl7dewzglimjurh5@quack3.lan>
References: <20220315204007.05ad4817@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315204007.05ad4817@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-03-22 20:40:07, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the folio tree got a conflict in:
> 
>   fs/ext4/inode.c
> 
> between commit:
> 
>   2bb8dd401a4f ("ext4: warn when dirtying page w/o buffers in data=journal mode")
> 
> from the ext4 tree and commit:
> 
>   821405cf3ebb ("fs: Convert trivial uses of __set_page_dirty_nobuffers to filemap_dirty_folio")
> 
> from the folio tree.
> 
> I didn't know how to complete this fix up ans so just commented out the
> new WARN_ON().

Thanks for the notice Stephen! The resolution should be like:

- 	WARN_ON_ONCE(!page_has_buffers(page));
+ 	WARN_ON_ONCE(!folio_buffers(folio));

How are we going to handle this conflict Ted? Just tell Linus about the
conflict and resolution?

								Honza

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/ext4/inode.c
> index 3d0ca48d20c8,436efd31cc27..000000000000
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@@ -3573,31 -3541,30 +3573,32 @@@ const struct iomap_ops ext4_iomap_repor
>   };
>   
>   /*
> -  * Whenever the page is being dirtied, corresponding buffers should already be
>  - * Folios can be marked dirty completely asynchronously from ext4's
>  - * journalling activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.
>  - * We cannot do much here because ->dirty_folio may be called with the
>  - * page table lock held.  The folio is not necessarily locked.
> ++ * Whenever the folio is being dirtied, corresponding buffers should already be
>  + * attached to the transaction (we take care of this in ext4_page_mkwrite() and
>  + * ext4_write_begin()). However we cannot move buffers to dirty transaction
> -  * lists here because ->set_page_dirty is called under VFS locks and the page
> ++ * lists here because ->dirty_folio is called under VFS locks and the folio
>  + * is not necessarily locked.
>    *
> -  * We cannot just dirty the page and leave attached buffers clean, because the
> +  * We cannot just dirty the folio and leave attached buffers clean, because the
>    * buffers' dirty state is "definitive".  We cannot just set the buffers dirty
>    * or jbddirty because all the journalling code will explode.
>    *
> -  * So what we do is to mark the page "pending dirty" and next time writepage
> +  * So what we do is to mark the folio "pending dirty" and next time writepage
>    * is called, propagate that into the buffers appropriately.
>    */
> - static int ext4_journalled_set_page_dirty(struct page *page)
> + static bool ext4_journalled_dirty_folio(struct address_space *mapping,
> + 		struct folio *folio)
>   {
> - 	WARN_ON_ONCE(!page_has_buffers(page));
> - 	SetPageChecked(page);
> - 	return __set_page_dirty_nobuffers(page);
> ++/*	WARN_ON_ONCE(!page_has_buffers(page)); */
> + 	folio_set_checked(folio);
> + 	return filemap_dirty_folio(mapping, folio);
>   }
>   
> - static int ext4_set_page_dirty(struct page *page)
> + static bool ext4_dirty_folio(struct address_space *mapping, struct folio *folio)
>   {
> - 	WARN_ON_ONCE(!PageLocked(page) && !PageDirty(page));
> - 	WARN_ON_ONCE(!page_has_buffers(page));
> - 	return __set_page_dirty_buffers(page);
> + 	WARN_ON_ONCE(!folio_test_locked(folio) && !folio_test_dirty(folio));
> + 	WARN_ON_ONCE(!folio_buffers(folio));
> + 	return block_dirty_folio(mapping, folio);
>   }
>   
>   static int ext4_iomap_swap_activate(struct swap_info_struct *sis,


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
