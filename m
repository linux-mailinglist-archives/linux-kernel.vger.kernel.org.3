Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC14937D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353347AbiASJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:57:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbiASJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:57:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C401A1F38B;
        Wed, 19 Jan 2022 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642586256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOo66zzdOMi0rKAhY9iaubkRgFnRqTsRXgFgd3j6mFM=;
        b=uFW9RzhIJpN4/rZlqR7nXLuC190DVZMJvokDVE16qI38mCEYY9cBcrW+cNx7miZXaCgI3y
        zw9mSbbTcNWE0x34R5N90vtTjXvLJIFql3cDiVAn+46QWbWJz5s5A2qPUKl7D6hPe+Mvdk
        x20NcS5GFmXrpMX1oUfXA5RVoPKu/Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642586256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOo66zzdOMi0rKAhY9iaubkRgFnRqTsRXgFgd3j6mFM=;
        b=wKxd7NxQ1NZ0+7+Hu9pUfc8w8YfU2CZgp2Oyi/ZhUQ9arOSA/XxE/43M1PxVNTwnoRof/8
        WfMWpOP6fckXMYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A71113E11;
        Wed, 19 Jan 2022 09:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z9cNHZDg52GUNgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 09:57:36 +0000
Message-ID: <7323485e-9385-0171-7e61-6926d9480992@suse.cz>
Date:   Wed, 19 Jan 2022 10:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 37/66] binfmt_elf: Remove vma linked list walk
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
 <20211201142918.921493-38-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-38-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the VMA iterator instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/binfmt_elf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f8c7f26f1fbb..d41cca755ff9 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1622,6 +1622,7 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
>  static int fill_files_note(struct memelfnote *note)
>  {
>  	struct mm_struct *mm = current->mm;
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>  	unsigned count, size, names_ofs, remaining, n;
>  	user_long_t *data;
> @@ -1651,7 +1652,7 @@ static int fill_files_note(struct memelfnote *note)
>  	name_base = name_curpos = ((char *)data) + names_ofs;
>  	remaining = size - names_ofs;
>  	count = 0;
> -	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
> +	for_each_vma(vmi, vma) {
>  		struct file *file;
>  		const char *filename;
>  

