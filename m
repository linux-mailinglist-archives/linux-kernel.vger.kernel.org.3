Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6174F8214
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiDGOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344192AbiDGOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:45:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093FE9B;
        Thu,  7 Apr 2022 07:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30DA2B81D07;
        Thu,  7 Apr 2022 14:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA35C385A0;
        Thu,  7 Apr 2022 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649342579;
        bh=MBOJXf3iG0OF4r/zC3Hvr0kP73zPBPUMWPKN3AlyNfE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cppC84rQQ/Ih5J6TuGWd9/cxhE0YJiSAO4pNT+Syse4TsRcpmYlnqaJiZyPphlosi
         VcvsX73zSPCy/2FH6TxeTlVfpjc/PT8rfl7IRsOsykEndxABjGAmUGp0El2GkDqk8P
         6gjkP4AWW1Naz05sW8q24L1+HJ+OMAJgLTq2CwksvKNrj+BM7VA20Qs3iqrWGplyPK
         9OpbnqG8F18z4wjTJeM+jXYIAyHO3EHqwbaTmOFoH8ZIDwNqaNW8K70QgiRVovMMCQ
         SdkU6Z/3u8otGAAdBJ4BWqPWIg94FiiqadGhegh10FsixBNGyBCOuZl/xLO1L0aI1s
         7zg/isiP9sm+g==
Message-ID: <96a44a4224b67b9ec36198bc0586064df5c4ad2a.camel@kernel.org>
Subject: Re: [PATCH v3] ceph: invalidate pages when doing direct/sync writes
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 10:42:57 -0400
In-Reply-To: <20220407143834.7516-1-lhenriques@suse.de>
References: <20220407143834.7516-1-lhenriques@suse.de>
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

On Thu, 2022-04-07 at 15:38 +0100, Luís Henriques wrote:
> When doing a direct/sync write, we need to invalidate the page cache in
> the range being written to.  If we don't do this, the cache will include
> invalid data as we just did a write that avoided the page cache.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Ok, here's a new attempt.  After discussion in this thread and on IRC, I
> think this is the right fix.  generic/647 now passes with and without
> encryption.  Thanks!
> 
> Changes since v2:
> - Invalidation needs to be done after a write
> 
> Changes since v1:
> - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5072570c2203..63e67eb60310 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1938,6 +1938,15 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>  			break;
>  		}
>  		ceph_clear_error_write(ci);
> +		ret = invalidate_inode_pages2_range(
> +				inode->i_mapping,
> +				pos >> PAGE_SHIFT,
> +				(pos + len - 1) >> PAGE_SHIFT);
> +		if (ret < 0) {
> +			dout("invalidate_inode_pages2_range returned %d\n",
> +			     ret);
> +			ret = 0;
> +		}
>  		pos += len;
>  		written += len;
>  		dout("sync_write written %d\n", written);

Looks good. I suspect we can also remove the
invalidate_indode_pages2_range call earlier in this function too. I may
roll that into this patch.

I'll give this an xfstests run with fscrypt enabled and see how it does.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
