Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB85155B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380792AbiD2UhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348455AbiD2UhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BADD76EA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 491F361C00
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 20:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B9C385A4;
        Fri, 29 Apr 2022 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651264426;
        bh=mJwM9kYiqD3MWh4ufFdQRNVIdYK+ZNJ3as0lI4uuVH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xCvsVijlvrTtk1RzeXAoZaMixC4mvk/zmb8C9kir/tVaBvHCyYBuufanpBQfP22BL
         EHR91IYXvm7RHt/MWLaZ2WDdJpZXZngwe2r2TTfCodMIWPv0Y23I4IzhsdpbJPE8Z8
         ScVJJn08m5xs/617bA3tMnCpsuQkvCDlmvf8FokM=
Date:   Fri, 29 Apr 2022 13:33:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlbfs: fix hugetlbfs_statfs() locking
Message-Id: <20220429133345.d79af45fb107340c31655c8e@linux-foundation.org>
In-Reply-To: <20220429202207.3045-1-almasrymina@google.com>
References: <20220429202207.3045-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 13:22:06 -0700 Mina Almasry <almasrymina@google.com> wrote:

> After commit db71ef79b59b ("hugetlb: make free_huge_page irq safe"),
> the subpool lock should be locked with spin_lock_irq() and all call
> sites was modified as such, except for the ones in hugetlbfs_statfs().
> 
> ...
>
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1048,12 +1048,12 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  		if (sbinfo->spool) {
>  			long free_pages;
> 
> -			spin_lock(&sbinfo->spool->lock);
> +			spin_lock_irq(&sbinfo->spool->lock);
>  			buf->f_blocks = sbinfo->spool->max_hpages;
>  			free_pages = sbinfo->spool->max_hpages
>  				- sbinfo->spool->used_hpages;
>  			buf->f_bavail = buf->f_bfree = free_pages;
> -			spin_unlock(&sbinfo->spool->lock);
> +			spin_unlock_irq(&sbinfo->spool->lock);
>  			buf->f_files = sbinfo->max_inodes;
>  			buf->f_ffree = sbinfo->free_inodes;
>  		}

Looks good.

This seems to be theoretically deadlockable and less theoretically
lockdep splattable, so I'm inclined to cc:stable on this.

I wonder why we didn't do that with db71ef79b59bb2e78dc4.
