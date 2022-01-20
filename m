Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D104950B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357821AbiATO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:59:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346102AbiATO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:59:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A24E21906;
        Thu, 20 Jan 2022 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642690752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DL3B1IO3fZVXuhiBZXzTq6wFq3VQYTl8syynoxUgKjg=;
        b=FS83u84srngcHTE69hytGOIlMTCDiRWDIztkO2NjkKltuZgh4NWPK4c8t2LMaW/hYlWPff
        Rqg8rQF+GlsWbtzo60YDAZC07dZP5Qc7iJdi8tlMrGfzhfMBlBm6RqisJulOaA+Ig6gPU0
        HeD7ZQv8V+pT8EtOEcoluKk0qACA6Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642690752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DL3B1IO3fZVXuhiBZXzTq6wFq3VQYTl8syynoxUgKjg=;
        b=tyt3IlqYMBdLvexWL/ZRt99q/mP3Kk0FhMjyx0Vpg9KzBMFuvr4MgD8uRPcUgfBSAgk4D8
        eeugbMTMda9AVOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3930A13BCF;
        Thu, 20 Jan 2022 14:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zYZNDcB46WHJLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 14:59:12 +0000
Message-ID: <807fa53c-6492-52ca-abf3-ce58cc84ca08@suse.cz>
Date:   Thu, 20 Jan 2022 15:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 63/66] i915: Use the VMA iterator
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
 <20211201142918.921493-64-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-64-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Replace the O(n.log(n)) loop with an O(n) loop.

Not true?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 3173c9f9a040..39960973c130 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -425,12 +425,11 @@ static const struct drm_i915_gem_object_ops i915_gem_userptr_ops = {
>  static int
>  probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
>  {
> -	const unsigned long end = addr + len;
> +	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
> -	int ret = -EFAULT;
>  
>  	mmap_read_lock(mm);
> -	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
> +	for_each_vma_range(vmi, vma, addr + len) {
>  		/* Check for holes, note that we also update the addr below */
>  		if (vma->vm_start > addr)
>  			break;
> @@ -438,16 +437,13 @@ probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
>  		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>  			break;
>  
> -		if (vma->vm_end >= end) {
> -			ret = 0;
> -			break;
> -		}
> -
>  		addr = vma->vm_end;
>  	}
>  	mmap_read_unlock(mm);
>  
> -	return ret;
> +	if (vma)
> +		return -EFAULT;
> +	return 0;
>  }
>  
>  /*

