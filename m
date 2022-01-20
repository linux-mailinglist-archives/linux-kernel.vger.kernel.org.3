Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C20494E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbiATMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:43:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40078 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiATMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:43:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAC501F394;
        Thu, 20 Jan 2022 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642682613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgBzc7I2pJqwfBdmwKli8iUZ76Vy/MpRiILYANtDveU=;
        b=CXVwEuHtk7eur32TnMb/OXG2m3p4+BhfrZZL2uqe9aTIW2bhia+ZahQ/0SWb/AcQ+TONAk
        dGj16S7y3OizP+SB9CzWWC5GiOf6Sut/lnPc9cK1fSVM0TKvE39Kf/Fob+vntfxTPw9xtX
        lFflZXgDGVKGsyyllRctWiMVpFxZCx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642682613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgBzc7I2pJqwfBdmwKli8iUZ76Vy/MpRiILYANtDveU=;
        b=Y23c0VpocTiQpAHyHLWlhSB7aRliGeSTDgjc5BVrkttCsIYyjCB48kJ/FlDFoYwySTeyt+
        VMSjOpIyFC1PW7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6207313E9E;
        Thu, 20 Jan 2022 12:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FUwyF/VY6WFrZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 12:43:33 +0000
Message-ID: <bd20144f-a443-9761-a50f-7d08ea922dac@suse.cz>
Date:   Thu, 20 Jan 2022 13:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 60/66] mm/oom_kill: Use maple tree iterators instead of
 vma linked list
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
 <20211201142918.921493-61-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-61-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Could be VMA_ITERATOR?

> ---
>  mm/oom_kill.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1ddabefcfb5a..1694b30eb46c 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -516,6 +516,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	bool ret = true;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
>  	/*
>  	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -525,7 +526,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 */
>  	set_bit(MMF_UNSTABLE, &mm->flags);
>  
> -	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
> +	mas_for_each(&mas, vma, ULONG_MAX) {
>  		if (!can_madv_lru_vma(vma))
>  			continue;
>  

