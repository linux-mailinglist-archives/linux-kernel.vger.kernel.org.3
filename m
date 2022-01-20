Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD4494CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiATLWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:22:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60102 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiATLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:21:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7A971F394;
        Thu, 20 Jan 2022 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642677690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49k1Nhn2OdMKjjsIe/Lbva1DgR/JMbP9KE0CH84wQAc=;
        b=VcktyTxQ/nbNP3tJa7iJMiYgEEfWATFYULARsNcoYQN/NXIzdMBalq+AEV4Ev2sjbIJPnS
        YEcZyfSO83FrIIBtkH6UsvynX6q52Zp/LCA28NoPkTGCAaJF+ar6iHCZvDeB0fhkhx0b0w
        Hfk6ABQio5PG+NAEnImrw956G5HCc5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642677690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49k1Nhn2OdMKjjsIe/Lbva1DgR/JMbP9KE0CH84wQAc=;
        b=6GiaYmeZ14ezrsGcClGbgIlJaqhnrBksyUteCjjj0HLYuGfietyF6E4fTYM/cZG1urWKuv
        QLUFWTwyG2i1NJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AADA13E46;
        Thu, 20 Jan 2022 11:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIIbJbpF6WGxQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 11:21:30 +0000
Message-ID: <3d5a348a-1c99-9cb5-3279-31a9419da032@suse.cz>
Date:   Thu, 20 Jan 2022 12:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 54/66] mm/memcontrol: Stop using mm->highest_vm_end
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
 <20211201142918.921493-55-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-55-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/memcontrol.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 781605e92015..ac95b3eca557 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5808,7 +5808,7 @@ static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
>  	unsigned long precharge;
>  
>  	mmap_read_lock(mm);
> -	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
> +	walk_page_range(mm, 0, -1, &precharge_walk_ops, NULL);

Wouldn't ULONG_MAX look better?

>  	mmap_read_unlock(mm);
>  
>  	precharge = mc.precharge;
> @@ -6106,9 +6106,7 @@ static void mem_cgroup_move_charge(void)
>  	 * When we have consumed all precharges and failed in doing
>  	 * additional charge, the page walk just aborts.
>  	 */
> -	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
> -			NULL);
> -
> +	walk_page_range(mc.mm, 0, -1, &charge_walk_ops, NULL);
>  	mmap_read_unlock(mc.mm);
>  	atomic_dec(&mc.from->moving_account);
>  }

