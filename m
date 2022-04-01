Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A994EECA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbiDAL6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiDAL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:58:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4C22F3E6;
        Fri,  1 Apr 2022 04:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDD61B824B1;
        Fri,  1 Apr 2022 11:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92E2C34111;
        Fri,  1 Apr 2022 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648814185;
        bh=7wIcQSZqoF9yzXMmd3t7mD89xfVOVwiy5PT1j+hxDtc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eOn24kv2RmHAL1Mjy1+rOyDlCLrJylnwNe4U0BO+dtFwuhJ+WXBv5CSJ/VDLFOsSw
         QAyc8DI1/sqSQiFisk2b1rgQQ3mdcmDnzqiysdRJwhthuZj2EO4I7HqmL2I0z/4bTp
         DAWc3+WdfRcFSzLdF3dXxd8d0hsXDdWwZGj1e80B6XYU5e5dWEaWPIrGvStrlyXES9
         DvCbNq+cmesn/bfzHNnqEObEOIhf6zn3ALScCa63zJWqA3RVO4fxhgbU57rvuJZJvi
         SOQwZ2LxPk37U4Uaz+SldjQr54u3i1f+1UpqYh5LYPKB0BA7aHBabgg8cnsnsemUYp
         2jRWNTfPtLXlw==
Message-ID: <0f781fa1b2bec48d40729d8306a2ed8b19209734.camel@kernel.org>
Subject: Re: [PATCH] ceph: truncate page cache when doing DIO in encrypted
 inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Apr 2022 07:56:23 -0400
In-Reply-To: <20220401113822.32545-1-lhenriques@suse.de>
References: <20220401113822.32545-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-01 at 12:38 +0100, Luís Henriques wrote:
> When doing DIO on an encrypted node, we need to truncate the page cache in
> the range being written to, otherwise the cache will include invalid data.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> This patch should fix generic/647 fstest when run with test_dummy_encryption.
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5072570c2203..0f31c4d352a4 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1895,6 +1895,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>  		req->r_inode = inode;
>  		req->r_mtime = mtime;
>  
> +		if (IS_ENCRYPTED(inode) && (iocb->ki_flags & IOCB_DIRECT))
> +			truncate_inode_pages_range(
> +				inode->i_mapping, write_pos,
> +				PAGE_ALIGN(write_pos + write_len) - 1);
> +
>  		/* Set up the assertion */
>  		if (rmw) {
>  			/*

Truncating the pagecache like this could cause dirty data to be
discarded. I know we're planning to overwrite this range, but you are
having to invalidate more than the written range here. We could
potentially lose a write to that region.

Have you tried using something like invalidate_inode_pages2_range ?
That's more of what we'd want here, as it's a bit more cautious about
tossing out dirty pages. I see too that that is what
ceph_direct_read_write calls in the write case as well.
-- 
Jeff Layton <jlayton@kernel.org>
