Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743AE48C89F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355264AbiALQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:42:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47412 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbiALQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:42:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F35C12111A;
        Wed, 12 Jan 2022 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642005728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPj77zfOxRCcPyyK297Nw8fAGEmReWAwmZRBcfRDDwI=;
        b=Lbem7p69GLWKSbIxnPTzAQw4r9cVFVUDjIJyfVJEhj5PIH3JLRLQSbg4qKu3AIaxAjIeEz
        NV4/PpwDGlgnZgjO/gmGuvYUas2cfoKiTz+xaRNofe3h6jPGpzTqn/BDtM0Ki55G22d8+8
        k07G644Dmvi2BZH9IEGOiNzBIVUGD+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642005728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPj77zfOxRCcPyyK297Nw8fAGEmReWAwmZRBcfRDDwI=;
        b=SizK2zmP+zoXfYhgsaqQYwmKHnfGeHkTQPdKoh6MZWiBN4KZMmA8i+UNYc3s308oMqg28r
        XwgWtuI5gN20YOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A419113BE6;
        Wed, 12 Jan 2022 16:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GbRIJ98E32H8TAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 12 Jan 2022 16:42:07 +0000
Message-ID: <4f0c30d7-fd10-84c7-4e7f-6d103e4ba9c1@suse.cz>
Date:   Wed, 12 Jan 2022 17:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 20/66] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
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
 <20211201142918.921493-21-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-21-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> vma_lookup() will walk the vma tree once and not continue to look for
> the next vma.  Since the exact vma is checked below, this is a more
> optimal way of searching.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e99101162f1a..0ff7d72cdd1d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1433,7 +1433,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>  void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>  {
>  	unsigned long haddr = addr & HPAGE_PMD_MASK;
> -	struct vm_area_struct *vma = find_vma(mm, haddr);
> +	struct vm_area_struct *vma = vma_lookup(mm, haddr);
>  	struct page *hpage;
>  	pte_t *start_pte, *pte;
>  	pmd_t *pmd, _pmd;

