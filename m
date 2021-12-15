Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775B5475DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhLOQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:43:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhLOQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:43:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8BCB21112;
        Wed, 15 Dec 2021 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639586606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mc+NOCo8gFAcIat9O5ZbYkdJnvydq3UrnGWVFeBnwXA=;
        b=Q56ITFqIWCHrKTC7YasLp1lMw54M3KUsiRTZ4gfVQWE6WA7gsbGbmZDIS83d1UyQp7BvFb
        inU5dlvW7aiw8oavyg35HXewcF1kieK2HvzZyfwSA6FlCEsk4xaQievz7AuYFDOPU5/EPC
        1kXdJZ9gMbBxP5fddEV+fUBqNNacyUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639586606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mc+NOCo8gFAcIat9O5ZbYkdJnvydq3UrnGWVFeBnwXA=;
        b=VIiUza+iTA5qjLV6YQpqFmNZF67sEdrklSc2+Gth5pfWfwWTRaL9/3noJK1lSSyGnwvvTM
        ruFoHWaCX7PAG5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C37813B75;
        Wed, 15 Dec 2021 16:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pCmoIS4bumEIKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Dec 2021 16:43:26 +0000
Message-ID: <97b96d36-434e-fb4e-3e0f-7c96faa9cef9@suse.cz>
Date:   Wed, 15 Dec 2021 17:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 11/66] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
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
 <20211201142918.921493-12-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-12-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The maple tree code was added to find the unmapped area in a previous
> commit and was checked against what the rbtree returned, but the actual
> result was never used.  Start using the maple tree implementation and
> remove the rbtree code.

Nice cleanup. But...

> Add kernel documentation comment for these functions.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

>  
>  	/* Adjust search length to account for worst case alignment overhead */
>  	length = info->length + info->align_mask;
>  	if (length < info->length)
>  		return -ENOMEM;
>  
> -	rcu_read_lock();
> -	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
> -			   length);
> -	rcu_read_unlock();

Why is RCU locking being removed as part of this? Ditton in
unmapped_area_topdown()
