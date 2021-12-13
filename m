Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C3473858
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbhLMXUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:20:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47386 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhLMXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:20:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ADF0B8113F;
        Mon, 13 Dec 2021 23:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0534CC34601;
        Mon, 13 Dec 2021 23:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639437600;
        bh=LXBAgXWC4CE1LuoXiQe0EXbBe+2RLdZAmgUgAX2atR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6R0gUaFiE+qp5gGl3FeH55cOVEEacDVrDhO7LK8470B9iPNq8VIDfCQ4zoRBVKVK
         LFU1Vml15yxFl62xT1DpemS4JOLAcW2VeWDqBBGrkUcEmHZcU8iJT7c3pBVdqLpP91
         QO1Si2WiwszPgFWg5lQ3OwDgI+U/92f1uu55O3tHriZrmvzFItZIoDJuIdKrhyiVki
         sb0+hSy/gY7/aiwU3NKExdRt8Fpkf551Z8G96YHFhsZutGHvWno/HPelVx3N1rZxrx
         VPm6xA8IdzO8yT8H+r+lfiUlCy5VtLe+ZUp6vZfJHr7Jrw8gZg7HHUHQ9xdT7bCi+S
         sDTlF2DcYVcVA==
Date:   Mon, 13 Dec 2021 17:25:38 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-hardening@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm integrity: Use struct_group() to zero
 struct journal_sector
Message-ID: <20211213232538.GB60133@embeddedor>
References: <20211118203640.1288585-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118203640.1288585-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:36:40PM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add struct_group() to mark region of struct journal_sector that should be
> initialized to zero.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/md/dm-integrity.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 6319deccbe09..163c94ca4e5c 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -121,8 +121,10 @@ struct journal_entry {
>  #define JOURNAL_MAC_SIZE		(JOURNAL_MAC_PER_SECTOR * JOURNAL_BLOCK_SECTORS)
>  
>  struct journal_sector {
> -	__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
> -	__u8 mac[JOURNAL_MAC_PER_SECTOR];
> +	struct_group(sectors,
> +		__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
> +		__u8 mac[JOURNAL_MAC_PER_SECTOR];
> +	);
>  	commit_id_t commit_id;
>  };
>  
> @@ -2870,7 +2872,8 @@ static void init_journal(struct dm_integrity_c *ic, unsigned start_section,
>  		wraparound_section(ic, &i);
>  		for (j = 0; j < ic->journal_section_sectors; j++) {
>  			struct journal_sector *js = access_journal(ic, i, j);
> -			memset(&js->entries, 0, JOURNAL_SECTOR_DATA);
> +			BUILD_BUG_ON(sizeof(js->sectors) != JOURNAL_SECTOR_DATA);
> +			memset(&js->sectors, 0, sizeof(js->sectors));
>  			js->commit_id = dm_integrity_commit_id(ic, i, j, commit_seq);
>  		}
>  		for (j = 0; j < ic->journal_section_entries; j++) {
> -- 
> 2.30.2
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
> 
> 
> 
