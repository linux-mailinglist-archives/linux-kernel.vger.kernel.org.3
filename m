Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E991476F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhLPLJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:09:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLPLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:09:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1358521125;
        Thu, 16 Dec 2021 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639652954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7O8lNZpNSZ7eUndQ51AE8lYh9+aQbI+sqqjkZKfjseM=;
        b=udj1lzgT7YU7o/k0DR2+6Jr6sMXnEHS94/kLrOV+QhYHvyIhfH5HRyifZw5cSzXwG+UzQL
        a+G3BcF11AS4lyGeJsfzURZlH7rpmpr1j0++0oXQMt9qaOd1k4F8XAu30Z1otUmrVFD7j6
        moM2TmqzDfFtnnWNZTn6NccdKbf+JmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639652954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7O8lNZpNSZ7eUndQ51AE8lYh9+aQbI+sqqjkZKfjseM=;
        b=mmrMPN9OPZMl+KGF0KI4rnEf9JzPsAjN+SnLdLXrg8+Rapw2tybzWE6rPY59JRsU4zmL7H
        L4hMRMKtG7xQCbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7D4C13B4B;
        Thu, 16 Dec 2021 11:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mGA0LFkeu2GrMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Dec 2021 11:09:13 +0000
Message-ID: <d54a6f4b-5394-5191-19aa-1b24cab40ba0@suse.cz>
Date:   Thu, 16 Dec 2021 12:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 12/66] kernel/fork: Use maple tree for dup_mmap()
 during forking
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-13-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-13-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The maple tree was already tracking VMAs in this function by an earlier
> commit, but the rbtree iterator was being used to iterate the list.
> Change the iterator to use a maple tree native iterator and switch to
> the maple tree advanced API to avoid multiple walks of the tree during
> insert operations.  Unexport the now-unused vma_store() function.
> 
> We track whether we need to free the VMAs and tree nodes through RCU
> (ie whether there have been multiple threads that can see the mm_struct
> simultaneously; by pthread(), ptrace() or looking at /proc/$pid/maps).
> This setting is sticky because it's too tricky to decide when it's safe
> to exit RCU mode.

I don't immediately see why enabling the RCU tracking in mmget is part of
the dup_mmap() change?

> For performance reasons we bulk allocate the maple tree nodes.  The node
> calculations are done internally to the tree and use the VMA count and
> assume the worst-case node requirements.  The VM_DONT_COPY flag does
> not allow for the most efficient copy method of the tree and so a bulk
> loading algorithm is used.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

>  static inline bool mmget_not_zero(struct mm_struct *mm)
>  {
> +	/*
> +	 * There is a race below during task tear down that can cause the maple

What does 'below' refer to here?

> +	 * tree to enter rcu mode with only a single user.  If this race
> +	 * happens, the result would be that the maple tree nodes would remain
> +	 * active for an extra RCU read cycle.
> +	 */
> +	if (!mt_in_rcu(&mm->mm_mt))
> +		mm_set_in_rcu(mm);
>  	return atomic_inc_not_zero(&mm->mm_users);
>  }
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc9bb95c7678..c9f8465d8ae2 100644
