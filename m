Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D61493943
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354021AbiASLKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:10:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45088 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353333AbiASLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:10:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4FAD6218E4;
        Wed, 19 Jan 2022 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642590607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQns7ry+S4QtQCYHYjH5vlhwIvoPhGouvztO1/xkhOw=;
        b=TazNgORzPiPdgRTXlVdu2RRANPhrUJFZEv5id/U7dtjkdIMmC1rm7JkBPKqxwzICxBNelX
        d9XqomwC+9ya7KB+qXtAveVCV9e9TTosR+5mg60AWMkW0BehhkdNn4SgmRgtlVyfai94zV
        CjVPpd/YLmoGkARdp/pLgfiLnZA1ZAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642590607;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQns7ry+S4QtQCYHYjH5vlhwIvoPhGouvztO1/xkhOw=;
        b=8hxMguh1nXY//+N2o65JGa4x2elWOqSS3Gnrj7mLJUQPz+pb6axFSsnah15g+4iyTQrB3E
        SslLsrJ9Z0uW+GDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14D2513B4A;
        Wed, 19 Jan 2022 11:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JTt7BI/x52HuXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 11:10:07 +0000
Message-ID: <699d9f0c-e330-f651-a6c8-f9e11e1844fd@suse.cz>
Date:   Wed, 19 Jan 2022 12:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 41/66] fs/proc/base: Use maple tree iterators in place
 of linked list
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
 <20211201142918.921493-42-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-42-Liam.Howlett@oracle.com>
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

> ---
>  fs/proc/base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 13eda8de2998..ea17ee988158 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2323,6 +2323,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	GENRADIX(struct map_files_info) fa;
>  	struct map_files_info *p;
>  	int ret;
> +	MA_STATE(mas, NULL, 0, 0);
>  
>  	genradix_init(&fa);
>  
> @@ -2350,6 +2351,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	}
>  
>  	nr_files = 0;
> +	mas.tree = &mm->mm_mt;
>  
>  	/*
>  	 * We need two passes here:
> @@ -2361,7 +2363,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	 * routine might require mmap_lock taken in might_fault().
>  	 */
>  
> -	for (vma = mm->mmap, pos = 2; vma; vma = vma->vm_next) {
> +	pos = 2;
> +	mas_for_each(&mas, vma, ULONG_MAX) {
>  		if (!vma->vm_file)
>  			continue;
>  		if (++pos <= ctx->pos)

