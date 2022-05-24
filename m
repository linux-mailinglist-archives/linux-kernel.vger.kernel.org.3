Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE59532D65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiEXP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiEXP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939C2E9CC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E8D61716
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBCAC34113;
        Tue, 24 May 2022 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653405992;
        bh=lXzHpD73ZNq/mGAnzxwqk68q+3cpJPWaCAtRV53tatI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQBRLUIB+CzIv9geGx/fXV1J6eBqxc8uSBz22ga34tMA74Tt6sznwf8zUq/13AD3g
         pdGVCep8TGTDLVFsFsup31isXOho6wgY/+Q7cecYJW4bfL8ItsMkFwlpgkQ3ZMq4oG
         5tVMDxUuYnY2Akhqw//Z6OkkPHiPqOs+3hdTszjVtvIuCh875iDjkFjTjaujORqKdG
         KTofWputI5KayJewQ7P0ObQiZQIRQhM5kWEAxlEZA+yp/AoDk/Xa3+MKWg25TPAdxg
         WI01dlqWihXad0nm824+pzM/hhnXzEElVIjFBQbYNo1TDOsFT2LGR59Ui0zVuhcVI5
         08TvHm8JXTg2Q==
Date:   Tue, 24 May 2022 08:26:30 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change the current atomic write way
Message-ID: <Yoz5JteVWWfZmOBp@google.com>
References: <20220428181809.2352352-1-daeho43@gmail.com>
 <dd1ea728-4cb6-e35d-dc76-a1d62bead69a@kernel.org>
 <YovMeQO2n0XAxMhe@google.com>
 <227d10d5-2afe-acfa-7cfc-3a2f45331c6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227d10d5-2afe-acfa-7cfc-3a2f45331c6f@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24, Chao Yu wrote:
> On 2022/5/24 2:03, Jaegeuk Kim wrote:
> > On 05/22, Chao Yu wrote:
> > > On 2022/4/29 2:18, Daeho Jeong wrote:> +		*old_addr = dn.data_blkaddr;
> > > > +		f2fs_truncate_data_blocks_range(&dn, 1);
> > > > +		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
> > > > +		inc_valid_block_count(sbi, inode, &count);
> > > > +		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
> > > > +					ni.version, true, false);
> > > 
> > > My concern is, if cow_inode's data was persisted into previous checkpoint,
> > > and then f2fs_replace_block() will update SSA from cow_inode to inode?
> > 
> > SSA for original file is intact, so we'll see the orignal file's block addresses
> > and SSA, if we flush cow_inode's SSA after committing the atomic writes?
> > It'd be good to flush any SSA for cow_inode, since we'll truncate
> > cow_inode after powercut by the ohphan recovery?
> 
> I think it's safe for recovery flow, but before that, fsck will report inconsistent
> status during checking orphan atomic_write inode.

That should be fine as well, since it'll just drop that cow_inode.

> 
> Thanks,
> 
> > 
> > > it will cause inconsistent status of last valid checkpoint? Or am I mssing
> > > something?
> > > 
> > > > -		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
> > > > +			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
> > > > +							true, NULL);
> > > > +			if (!new) {
> > > > +				f2fs_put_dnode(&dn);
> > > > +				ret = -ENOMEM;
> > > > +				goto out;
> > > 
> > > It doesn't need to handle failure of f2fs_kmem_cache_alloc()
> > > due to nofail parameter is true.

Let's get this by another patch. Could you please send one?

> > > 
> > > Thanks,
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
