Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34A59F169
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiHXC06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHXC0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:26:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5986B64
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB0E4B821B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43180C433D6;
        Wed, 24 Aug 2022 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661308012;
        bh=Nav42ddGiLpWaB9oN10SoZfmDlr6BuD4LK5Oxn/MhMk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=TufyI7wCRgTbbSTpo0Xi9ntkhTHjjIHMm0BlDkJNCellUCpmOADVv4YNAxiWP1WTj
         lhFKaDHoQsU4hgOYluZw75GL15EHQi11t4Gk9gtpqcoHO2Jow8Oe01n6GSfEOVHGYz
         MaiKnvomYv9mcrklaBK+ccnSqrIvXCikC9y0oiyM3iAG4SDlz0VmX0TjfXgWQiqgnH
         sqKuDmmiuzR81xUhIaFPNK+XXYCtp5VXJLkDKKZksRWQHiRfkWm7eK7llBTPDE0/+Q
         f/qWfjI7zzoVLgEOF4pioTCxE5OIfmYKCvTqADcDbdu7JJJrySfqR4D44SI9ylxkJU
         B3OwxRpYC9R4g==
Date:   Tue, 23 Aug 2022 19:26:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: increase the limit for reserve_root
Message-ID: <YwWMavPwLhAcUklv@google.com>
References: <20220823172124.2285995-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823172124.2285995-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23, Jaegeuk Kim wrote:
> This patch increases the threshold that limits the reserved root space from 0.2%
> to 12.5% by using simple shift operation.
> 
> Typically Android sets 128MB, but if the storage capacity is 32GB, 0.2% which is
> around 64MB becomes too small. Let's relax it.
> 

Added:

Reported-by: Aran Dalton <arda@allwinnertech.com>

Thanks,

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 09972b709cdd..d1b4de5b4083 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -301,10 +301,10 @@ static void f2fs_destroy_casefold_cache(void) { }
>  
>  static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
>  {
> -	block_t limit = min((sbi->user_block_count << 1) / 1000,
> +	block_t limit = min((sbi->user_block_count >> 3),
>  			sbi->user_block_count - sbi->reserved_blocks);
>  
> -	/* limit is 0.2% */
> +	/* limit is 12.5% */
>  	if (test_opt(sbi, RESERVE_ROOT) &&
>  			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
>  		F2FS_OPTION(sbi).root_reserved_blocks = limit;
> -- 
> 2.37.1.595.g718a3a8f04-goog
