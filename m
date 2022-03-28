Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1EF4EA07A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbiC1TwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbiC1TsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:48:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177086A07E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:44:14 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id c18-20020a056e02059200b002c9b854c3a3so2037846ils.22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=7zWKMtEbwuwT1uZBUdUYkt9pkOkuqW/DKM2dz5jslsE=;
        b=Hz7/bQx8LZ6E0wVRyjqeeYjRxK8LAYLv7R73n4qSjpL8DNdT8wqsaTbmMQcTaNl7UN
         N4fIAxNQQtoXSOq1F4+44n/BuVSoBKV2FCdOHENQpWY/EtDc7KqhlsrcbQa42yoSEg+G
         pjA/YidEt/amu2IMt0GGRDYQYITkX67ENKyFGLLEi8ehZdKpVlx9Xfq/KpsBcb8d4TTU
         KzhjmCHY86cK6OBNEm4I3e7UXhRl1k3TuZ8MVVGCNyFq16etgJDxkAuQZUAXNWQyWcgW
         aawiKWCfV0YldOmsInFF7UzAnkpyji9LAB9B64jQ2KU5jUCc2YGcGSusZABT51j9cZeD
         gPFw==
X-Gm-Message-State: AOAM532Qp2WTxU0u+KrfYDwU7QiwIz8vLSEATsp7v1tOnHTZP9beEGKv
        vF0M4SjlbWXcUa3921IcRbSJYUiMr60IOJZTOqghmr0uPEXB
X-Google-Smtp-Source: ABdhPJwSo6uMATs/DQ2Fc55S2LjOSy42ARyrpKQkFU3C8gQeLy+XP3OtwDMB6jlamFcEK/Qg2DAyBePXjwGnAwFwPb/BJiOWYNxf
MIME-Version: 1.0
X-Received: by 2002:a5d:9d44:0:b0:645:b6e9:4bbb with SMTP id
 k4-20020a5d9d44000000b00645b6e94bbbmr7394506iok.77.1648496632312; Mon, 28 Mar
 2022 12:43:52 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:43:52 -0700
In-Reply-To: <20220328194347.1586667-1-sashal@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002eb7e505db4c88b1@google.com>
Subject: Re: [PATCH AUTOSEL 4.9 1/2] ext4: don't BUG if someone dirty pages
 without asking ext4 first
From:   syzbot 
        <syzbot+d59332e2db681cf18f0318a06e994ebbb529a8db@syzkaller.appspotmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     adilger.kernel@dilger.ca, lee.jones@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, stable@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Theodore Ts'o <tytso@mit.edu>
>
> [ Upstream commit cc5095747edfb054ca2068d01af20be3fcc3634f ]
>
> [un]pin_user_pages_remote is dirtying pages without properly warning
> the file system in advance.  A related race was noted by Jan Kara in
> 2018[1]; however, more recently instead of it being a very hard-to-hit
> race, it could be reliably triggered by process_vm_writev(2) which was
> discovered by Syzbot[2].
>
> This is technically a bug in mm/gup.c, but arguably ext4 is fragile in
> that if some other kernel subsystem dirty pages without properly
> notifying the file system using page_mkwrite(), ext4 will BUG, while
> other file systems will not BUG (although data will still be lost).
>
> So instead of crashing with a BUG, issue a warning (since there may be
> potential data loss) and just mark the page as clean to avoid
> unprivileged denial of service attacks until the problem can be
> properly fixed.  More discussion and background can be found in the
> thread starting at [2].
>
> [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> [2] https://lore.kernel.org/r/Yg0m6IjcNmfaSokM@google.com
>
> Reported-by: syzbot+d59332e2db681cf18f0318a06e994ebbb529a8db@syzkaller.appspotmail.com
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lore.kernel.org/r/YiDS9wVfq4mM2jGK@mit.edu
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ext4/inode.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 79c067f74253..e66aa8918dee 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2048,6 +2048,15 @@ static int ext4_writepage(struct page *page,
>  	else
>  		len = PAGE_SIZE;
>  
> +	/* Should never happen but for bugs in other kernel subsystems */
> +	if (!page_has_buffers(page)) {
> +		ext4_warning_inode(inode,
> +		   "page %lu does not have buffers attached", page->index);
> +		ClearPageDirty(page);
> +		unlock_page(page);
> +		return 0;
> +	}
> +
>  	page_bufs = page_buffers(page);
>  	/*
>  	 * We cannot do block allocation or other extent handling in this
> @@ -2608,6 +2617,22 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  			wait_on_page_writeback(page);
>  			BUG_ON(PageWriteback(page));
>  
> +			/*
> +			 * Should never happen but for buggy code in
> +			 * other subsystems that call
> +			 * set_page_dirty() without properly warning
> +			 * the file system first.  See [1] for more
> +			 * information.
> +			 *
> +			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> +			 */
> +			if (!page_has_buffers(page)) {
> +				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
> +				ClearPageDirty(page);
> +				unlock_page(page);
> +				continue;
> +			}
> +
>  			if (mpd->map.m_len == 0)
>  				mpd->first_page = page->index;
>  			mpd->next_page = page->index + 1;
> -- 
> 2.34.1
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

