Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29C046E4AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhLII7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:59:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34444 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhLII7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:59:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 949711FD2A;
        Thu,  9 Dec 2021 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639040157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+s9ocO6QrkH8V9cI2Zh3oL0gb/sFsdyKU33Hg/kIFg=;
        b=BCAMjIB//Cd1qJCAZPw70FoxBGHMMSAjZC3k4grBBsCU9YImQAkWmHx/YPjLi+IZgzcfoZ
        hFzdYWFPeWZSppVggg3hy7tVDM3jnaio91hsq+ZxdERo5Yte57CsMpK8kT29uuPFuf0tm6
        JlLdG/Wf5q1r8nydrBLCBT2D9xaG6WQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5A4B5A3B95;
        Thu,  9 Dec 2021 08:55:57 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:55:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 2/3] mm: document locking restrictions for
 vm_operations_struct::close
Message-ID: <YbHEnFdjECnM2r20@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
 <20211208212211.2860249-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208212211.2860249-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-12-21 13:22:10, Suren Baghdasaryan wrote:
> Add comments for vm_operations_struct::close documenting locking
> requirements for this callback and its callers.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7e4a9e7d807..b9b88ba7564b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -577,6 +577,10 @@ enum page_entry_size {
>   */
>  struct vm_operations_struct {
>  	void (*open)(struct vm_area_struct * area);
> +	/**
> +	 * @close: Called when the VMA is being removed from the MM.
> +	 * Context: User context.  May sleep.  Caller holds mmap_lock.
> +	 */
>  	void (*close)(struct vm_area_struct * area);
>  	/* Called any time before splitting to check if it's allowed */
>  	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
> -- 
> 2.34.1.400.ga245620fadb-goog

-- 
Michal Hocko
SUSE Labs
