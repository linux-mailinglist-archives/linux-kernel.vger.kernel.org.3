Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3C4938F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353916AbiASKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:53:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbiASKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:53:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99BEE1F37E;
        Wed, 19 Jan 2022 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642589583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNbkJylEzbsuZ8MUUC0ZW96A4kPfyCHmPwNaay0J140=;
        b=Mlmh+iSkR436G8QLFgMBjt3gxxZRa0MJlFUkE8DADA+MQkH4JjttXDF7Mh/tBxC+n2kbbG
        vkt/kEtX4JtD8lT+Ih6vtnBUIE3PhlpigsNuLcgrtXvMdD4wJw11uGB09SmQ0rF50+W3Xh
        R1pTVOVQ17HnDp5aO1qaMecpQKlvZhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642589583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNbkJylEzbsuZ8MUUC0ZW96A4kPfyCHmPwNaay0J140=;
        b=D610S6bk2RPTrKpSChtO23WJwSMdcNnG6rrQE4Ksx7TjBUDvFGGCxpYfdnJk0IxyvbH0rL
        TbIYYIrydwwq6XBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50F1F13B3D;
        Wed, 19 Jan 2022 10:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W2kNE4/t52FPVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 10:53:03 +0000
Message-ID: <c7fdc80d-4c6f-da67-098d-04435b05b0bc@suse.cz>
Date:   Wed, 19 Jan 2022 11:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 39/66] binfmt_elf: Take the mmap lock when walking the
 VMA list
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
 <20211201142918.921493-40-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-40-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
> is very careful to take the mmap_lock in write mode.  We only need to
> take it in read mode here as we do not care if the size of the stack
> VMA changes underneath us.
> 
> If it can be changed underneath us, this is a potential use-after-free
> for a multithreaded process which is dumping core.
> 
> Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

To be honest this feels out of place in this series. Send separately and CC
Jann who AFAICS added dump_vma_snapshot()?

> ---
>  fs/binfmt_elf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index d41cca755ff9..5915518c8a1d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1652,6 +1652,7 @@ static int fill_files_note(struct memelfnote *note)
>  	name_base = name_curpos = ((char *)data) + names_ofs;
>  	remaining = size - names_ofs;
>  	count = 0;
> +	mmap_read_lock(mm);
>  	for_each_vma(vmi, vma) {
>  		struct file *file;
>  		const char *filename;
> @@ -1662,6 +1663,7 @@ static int fill_files_note(struct memelfnote *note)
>  		filename = file_path(file, name_curpos, remaining);
>  		if (IS_ERR(filename)) {
>  			if (PTR_ERR(filename) == -ENAMETOOLONG) {
> +				mmap_read_unlock(mm);
>  				kvfree(data);
>  				size = size * 5 / 4;
>  				goto alloc;
> @@ -1681,6 +1683,7 @@ static int fill_files_note(struct memelfnote *note)
>  		*start_end_ofs++ = vma->vm_pgoff;
>  		count++;
>  	}
> +	mmap_read_unlock(mm);
>  
>  	/* Now we know exact count of files, can store it */
>  	data[0] = count;

