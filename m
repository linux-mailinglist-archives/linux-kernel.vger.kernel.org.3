Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698A946C874
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhLHAIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbhLHAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:08:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CBC061574;
        Tue,  7 Dec 2021 16:05:14 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E338DCE1ECB;
        Wed,  8 Dec 2021 00:05:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8367560EBC;
        Wed,  8 Dec 2021 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638921911;
        bh=uA2tjAPOCqPu5oyDY/yHUgBofZT6FAsAe0t5Dw+fZkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bxc/cdmU3aqOjKzv01krX8OHbweiZx256hr8gZQYWIBDw6i1vABexDTh5t1ra9uAQ
         bXh8lmbW4LHS9g5DnBZw1yOUF8maQw7dnkPSZau2LbWPUlIOWDN5S/SRb+fSI8+/E0
         JvjfCe4t5ZHJVXEb47lL+r2v2TVf9QkU0BTKqEPI=
Date:   Tue, 7 Dec 2021 16:05:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com
Subject: Re: [PATCH v2 3/4] mm: page table check
Message-Id: <20211207160508.6ef48f273c1ae14c0d02c6ac@linux-foundation.org>
In-Reply-To: <20211204182314.1470076-4-pasha.tatashin@soleen.com>
References: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
        <20211204182314.1470076-4-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Dec 2021 18:23:13 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> Check user page table entries at the time they are added and removed.
> 
> Allows to synchronously catch memory corruption issues related to double
> mapping.
> 
> When a pte for an anonymous page is added into page table, we verify that
> this pte does not already point to a file backed page, and vice versa if
> this is a file backed page that is being added we verify that this page
> does not have an anonymous mapping
> 
> We also enforce that read-only sharing for anonymous pages is allowed
> (i.e.  cow after fork).  All other sharing must be for file pages.
> 
> Page table check allows to protect and debug cases where "struct page"
> metadata became corrupted for some reason.  For example, when refcnt or
> mapcount become invalid.
> 
> ...
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1307,6 +1307,9 @@ config HAVE_ARCH_PFN_VALID
>  config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	bool
>  
> +config ARCH_SUPPORTS_PAGE_TABLE_CHECK
> +	bool
> +

I guess a dependency on CONFIG_DEBUG_VM would be appropriate?


