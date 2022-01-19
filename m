Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A877493E94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiASQvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:51:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33810 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243495AbiASQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:51:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2C3921126;
        Wed, 19 Jan 2022 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642611097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcNkutNEUdp9tNCGv2eq1CnHkXbyaGxeNqKqSZ28AG8=;
        b=zVHxQO4Xv8Woim81RYvQnEF/90eYeX7QaT6p/QjrJcePnJFi85h9bqzpC3GBpn/jrixuRv
        gv/FEAXdlQrvDbQ8dPBcr+zYisQr6NQyczJsLshSbS0N+F0MXJbCShXTmRW61mDHzllcm2
        AYb2whyA9oiJtPvrPWw01+riG1X9o9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642611097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcNkutNEUdp9tNCGv2eq1CnHkXbyaGxeNqKqSZ28AG8=;
        b=4QThA5FBH2vf2Fqu5ss7T4AoRKDjRJboGbAyNcRe8QS2mLcNHt+gspF2HyI8/k6T24CEoK
        BkA/g76kOjZhGXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E8ED13B77;
        Wed, 19 Jan 2022 16:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KoVRFplB6GHVLwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 16:51:37 +0000
Message-ID: <3f565267-078e-ad4c-dfd2-36dba2201afe@suse.cz>
Date:   Wed, 19 Jan 2022 17:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 48/66] fork: Use VMA iterator
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
 <20211201142918.921493-49-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-49-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The VMA iterator is faster than the linked list and removing the linked
> list will shrink the vm_area_struct.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  kernel/fork.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3493117c8d35..6de302e93519 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1228,13 +1228,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  	/* Forbid mm->exe_file change if old file still mapped. */
>  	old_exe_file = get_mm_exe_file(mm);
>  	if (old_exe_file) {
> +		VMA_ITERATOR(vmi, mm, 0);
>  		mmap_read_lock(mm);
> -		for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
> +		for_each_vma(vmi, vma) {
>  			if (!vma->vm_file)
>  				continue;
>  			if (path_equal(&vma->vm_file->f_path,
> -				       &old_exe_file->f_path))
> +				       &old_exe_file->f_path)) {
>  				ret = -EBUSY;
> +				break;
> +			}
>  		}
>  		mmap_read_unlock(mm);
>  		fput(old_exe_file);

