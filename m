Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5F531783
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiEWSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiEWS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5768EAB89
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36A0FB81210
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D1C385AA;
        Mon, 23 May 2022 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653329019;
        bh=Yb/JkZM658Z6MLcMI0IHk5BK/rh9v+MSZ1PRr3wJnv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AclNuXReOE8lhJhX5Dnq4OBTo2fIHyceusJLNbQJoawzNKkkQJX5Z/+IM+tJPUFvx
         SEFLwnTws/41SkR3rMU4AdsJT3SUpn1y+PAH3XdSz+ED1eYUQa69pGT0ExB7upg5rm
         oIjb6TqjhoNhYtm6ajCT0e/ZsLxQxWkQBRu2Ly4yU3cPHuOm9Hpeoh9IWqlWb3ZC3i
         r8NYYVzR/Mh03nUuRWarCd9Lt41leQNQyWGcPPlEgMEUqWwa4DaDI9BQC0weohk4pQ
         0mS8x141JZWY9n382fP4gxblQ6gten/fcv74HX9WIbJLVJAQY8/NLR9uE0O0mN8oww
         TEc8BylmI7yFA==
Date:   Mon, 23 May 2022 11:03:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change the current atomic write way
Message-ID: <YovMeQO2n0XAxMhe@google.com>
References: <20220428181809.2352352-1-daeho43@gmail.com>
 <dd1ea728-4cb6-e35d-dc76-a1d62bead69a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd1ea728-4cb6-e35d-dc76-a1d62bead69a@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22, Chao Yu wrote:
> On 2022/4/29 2:18, Daeho Jeong wrote:> +		*old_addr = dn.data_blkaddr;
> > +		f2fs_truncate_data_blocks_range(&dn, 1);
> > +		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
> > +		inc_valid_block_count(sbi, inode, &count);
> > +		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
> > +					ni.version, true, false);
> 
> My concern is, if cow_inode's data was persisted into previous checkpoint,
> and then f2fs_replace_block() will update SSA from cow_inode to inode?

SSA for original file is intact, so we'll see the orignal file's block addresses
and SSA, if we flush cow_inode's SSA after committing the atomic writes?
It'd be good to flush any SSA for cow_inode, since we'll truncate
cow_inode after powercut by the ohphan recovery?

> it will cause inconsistent status of last valid checkpoint? Or am I mssing
> something?
> 
> > -		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
> > +			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
> > +							true, NULL);
> > +			if (!new) {
> > +				f2fs_put_dnode(&dn);
> > +				ret = -ENOMEM;
> > +				goto out;
> 
> It doesn't need to handle failure of f2fs_kmem_cache_alloc()
> due to nofail parameter is true.
> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
