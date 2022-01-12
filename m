Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EDA48C854
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355223AbiALQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:31:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbiALQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:31:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69B84218B1;
        Wed, 12 Jan 2022 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642005067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV3kQKunh58VF+mTmP2xUGZg8Wv6NBLE1ZHzMECIK2I=;
        b=PBvvxIKVBgX2HbGTKkbPqZr426GwPvyItMU4P1SzOEbWwhGewbsr6rcecQP+kzAOa0C3Q8
        xJSmogzCbtkdXfzE6HEeK4/bB7VSCAWQS2zVUc/27sPl9ViF2rWN3kBik03r7/ISNLmZ49
        MTTY++QfEkfbbyVsrO9+N6qUapWGY50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642005067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV3kQKunh58VF+mTmP2xUGZg8Wv6NBLE1ZHzMECIK2I=;
        b=SFL+969Qam7/nf5C1OIHiW/CJc0ebCyXQh9B0FsnUV070RVgccIOLWPUeCC8aW38DdZRrZ
        KLLzZus04iRv2LBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C83613BE6;
        Wed, 12 Jan 2022 16:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Kw/BksC32FBRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 12 Jan 2022 16:31:07 +0000
Message-ID: <91b92b66-e7b1-6185-3f13-1c3f02245054@suse.cz>
Date:   Wed, 12 Jan 2022 17:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 19/66] mm: Optimize find_exact_vma() to use
 vma_lookup()
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
 <20211201142918.921493-20-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-20-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use vma_lookup() to walk the tree to the start value requested.  If
> the vma at the start does not match, then the answer is NULL and there
> is no need to look at the next vma the way that find_vma() would.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 784f8fec3b65..c08f6d541b8a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2879,7 +2879,7 @@ static inline unsigned long vma_pages(struct vm_area_struct *vma)
>  static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
>  				unsigned long vm_start, unsigned long vm_end)
>  {
> -	struct vm_area_struct *vma = find_vma(mm, vm_start);
> +	struct vm_area_struct *vma = vma_lookup(mm, vm_start);
>  
>  	if (vma && (vma->vm_start != vm_start || vma->vm_end != vm_end))
>  		vma = NULL;

