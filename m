Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3648E534308
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbiEYSd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbiEYSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:33:48 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A36B2243
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:33:47 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id l67-20020a6b3e46000000b00660b8c61a31so8601853ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=jBh+sSzl4wfXD/kPQJA89QqmrKGas63PcudsVVN500M=;
        b=orOWBhbKxiYO7gWAZeDv+AbEf5fbkIq0wcd8GWI7j0RpLXLq7LKRNI8KYnGETa09YE
         GNY1TlZGU+xtVa9taGj0jXEK8TO81u9VBRSVqiepdp3Gwx9a4swV8Q7+p8VarqxJ1Ak8
         kTjv7RPJxEzUbQq6ktL1xzGGJP8dq64dMFxLgO3LJ4VQjR3sd8rsSt98zxqVFUDMqib9
         +FwDALl+dAtHHfMZ6I9n3JIAuH3onjw4oo/Et/MT45+DVvV/ZFH3nvYGLwQW58LSiZrX
         8iBSnhCc7HvP5CMrVLwIcyJ7mQOnrGcd3dMmXyc4kUHHGFy/nHtjWImOWtHQ4er8hxj3
         Gz2Q==
X-Gm-Message-State: AOAM5317LChnE74DkgKElxFlFjbs7WJm3IyBcthr++jAu7PhiMDEcdeR
        6jNVdBwO+wROFrCkL/XIrffKHRlFY5OQYGQl6s25VJB84+cb
X-Google-Smtp-Source: ABdhPJyAHVM+GHbGuvRjp+RpiuOF4QyRyVcQFg7NsXY8j80zDGnjoXHBvqgzEfTImjNZ9asqN8GB4m/9gi1NXkTy9w/J7uW8/aCC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1481:b0:330:4470:b7a4 with SMTP id
 j1-20020a056638148100b003304470b7a4mr3502656jak.61.1653503626838; Wed, 25 May
 2022 11:33:46 -0700 (PDT)
Date:   Wed, 25 May 2022 11:33:46 -0700
In-Reply-To: <Yo52gzYYOpU0NwDo@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000500bbb05dfda50af@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in do_sync_mmap_readahead
From:   syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 25, 2022 at 06:57:55PM +0100, Matthew Wilcox wrote:
>> 
>> Ohh, that makes sense.  We unlocked the mmap_sem, so the file is
>> pinned, but the VMA isn't.  I'll whip up a patch.
>
> #syz test

want 2 args (repo, branch), got 7

>
> From 01a4917c4cfe400eb310eba4f2fa466d381623c1 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Wed, 25 May 2022 14:23:45 -0400
> Subject: [PATCH] mm/filemap: Cache the value of vm_flags
>
> After we have unlocked the mmap_lock for I/O, the file is pinned, but
> the VMA is not.  Checking this flag after that can be a use-after-free.
> It's not a terribly interesting use-after-free as it can only read one
> bit, and it's used to decide whether to read 2MB or 4MB.  But it
> upsets the automated tools and it's generally bad practice anyway,
> so let's fix it.
>
> Reported-by: syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com
> Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9a1eef6c5d35..61dd39990fda 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2991,11 +2991,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct address_space *mapping = file->f_mapping;
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
> +	unsigned long vm_flags = vmf->vma->vm_flags;
>  	unsigned int mmap_miss;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Use the readahead code, even if readahead is disabled */
> -	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
> +	if (vm_flags & VM_HUGEPAGE) {
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
>  		ra->size = HPAGE_PMD_NR;
> @@ -3003,7 +3004,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		 * Fetch two PMD folios, so we get the chance to actually
>  		 * readahead, unless we've been told not to.
>  		 */
> -		if (!(vmf->vma->vm_flags & VM_RAND_READ))
> +		if (!(vm_flags & VM_RAND_READ))
>  			ra->size *= 2;
>  		ra->async_size = HPAGE_PMD_NR;
>  		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> @@ -3012,12 +3013,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  #endif
>  
>  	/* If we don't want any read-ahead, don't bother */
> -	if (vmf->vma->vm_flags & VM_RAND_READ)
> +	if (vm_flags & VM_RAND_READ)
>  		return fpin;
>  	if (!ra->ra_pages)
>  		return fpin;
>  
> -	if (vmf->vma->vm_flags & VM_SEQ_READ) {
> +	if (vm_flags & VM_SEQ_READ) {
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		page_cache_sync_ra(&ractl, ra->ra_pages);
>  		return fpin;
> -- 
> 2.34.1
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/Yo52gzYYOpU0NwDo%40casper.infradead.org.
