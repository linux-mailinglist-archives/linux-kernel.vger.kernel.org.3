Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F75A6704
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH3PMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3PMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3C0122BD3;
        Tue, 30 Aug 2022 08:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44645615AE;
        Tue, 30 Aug 2022 15:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EBCC433C1;
        Tue, 30 Aug 2022 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661872367;
        bh=GVovB5ughtpp8DMMikXepA1SW5sxU5d03vidqk/2iPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGnXhRDK/2qQC5fi6PX/EnoYnr19wpX+OpopnKR8vvH5mPaP6T2hRgqEgZsKoL+LP
         6VEAMh4oG7NwcKVFgd+6omkfdLERxobWWcmtbYDrLl1Yl8Wa5djES/1skJXoNH5r3v
         gTGjf+hQtkORLy2+UmhJ8t+8UcZjvYnNJqucECpQilxkYZeaNLOD50ghvhyoGm9ASK
         LJA/IhGahPI2FbRXqDN3aUikmL0afZBFIOY2Uem2VXt7jGWRoBn1qiZ5hH6bjnniM6
         tGuRImNgYflGAob8J1shoxNgAzaTvJMqOhjvjBmkBhgIIBVX22GCg2Hwz6H5fUlBxO
         MzsetNoBGwtvg==
Date:   Tue, 30 Aug 2022 08:12:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] xfs: simplify if-else condition in
 xfs_reflink_trim_around_shared
Message-ID: <Yw4o7yug91RORMD3@magnolia>
References: <20220830133939.2726749-1-zengheng4@huawei.com>
 <20220830133939.2726749-3-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830133939.2726749-3-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:39:39PM +0800, Zeng Heng wrote:
> "else" is not generally useful after a return,
> so remove it for clean code.
> 
> There is no logical changes.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Looks correct to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_reflink.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 251f20ddd368..93bdd25680bc 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -200,7 +200,9 @@ xfs_reflink_trim_around_shared(
>  	if (fbno == NULLAGBLOCK) {
>  		/* No shared blocks at all. */
>  		return 0;
> -	} else if (fbno == agbno) {
> +	}
> +
> +	if (fbno == agbno) {
>  		/*
>  		 * The start of this extent is shared.  Truncate the
>  		 * mapping at the end of the shared region so that a
> @@ -210,16 +212,16 @@ xfs_reflink_trim_around_shared(
>  		irec->br_blockcount = flen;
>  		*shared = true;
>  		return 0;
> -	} else {
> -		/*
> -		 * There's a shared extent midway through this extent.
> -		 * Truncate the mapping at the start of the shared
> -		 * extent so that a subsequent iteration starts at the
> -		 * start of the shared region.
> -		 */
> -		irec->br_blockcount = fbno - agbno;
> -		return 0;
>  	}
> +
> +	/*
> +	 * There's a shared extent midway through this extent.
> +	 * Truncate the mapping at the start of the shared
> +	 * extent so that a subsequent iteration starts at the
> +	 * start of the shared region.
> +	 */
> +	irec->br_blockcount = fbno - agbno;
> +	return 0;
>  }
>  
>  int
> -- 
> 2.25.1
> 
