Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD79534306
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiEYSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbiEYSdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:33:43 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDCCB2243
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:33:42 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g11-20020a056e021e0b00b002d1b5e8389bso5524639ila.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=3LlA84a/shawwGbR9ADlhr9ClWSvap2W3MAcAR6xg8Y=;
        b=VDYbCNl6kelFvH1dl47OLoZL7UAnHPcewg+47v8BbUwI6Zd5EO1w/6MtV6bmaB2zLp
         tY70A8ccplkEY/3faltwFIBSw4AErG5TJ0fBpOMrYKTD3AdqNls5P18d3EP3g0OenWd0
         X8nZX/jYqjDkUc8EnK39wijgtVDKEBeLXUlfEeL9+Sm6r6kRJjoRYUtw950Vm8++2y+M
         dTFcOIKNfH1zSAskGtENDD/yLHYBN72ujeMtxGxfWy1fEWnfHCF2yHk0BsN4vMMZeSnU
         vJyL5r2g+/bcICbdAkHBrvKYbjuEjoEhYQURj89c3Ojp9Mz5i1I9XmePjQI70oJkGxu6
         IMcw==
X-Gm-Message-State: AOAM532RfWdffWqLfX4w8PLbp2E0GObpvxlp7Udqog1PX80W7ac3GBDg
        V7RycmkRPyA/cQAq12Oa6EEk5F7H0Tye3Lu+DzhLhNHlsKDT
X-Google-Smtp-Source: ABdhPJwWD6CehZmGOUJFH/NGAkaozrOXWy/L6yb3NhEbFRBjSMW8lzjCVIVxul6oWoBnMYu3Q+l23mplGwhDmB8/vHSwanpPbBy4
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:2d1:8475:2f4d with SMTP id
 r3-20020a92cd83000000b002d184752f4dmr13420747ilb.229.1653503621753; Wed, 25
 May 2022 11:33:41 -0700 (PDT)
Date:   Wed, 25 May 2022 11:33:41 -0700
In-Reply-To: <Yo52gzYYOpU0NwDo@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002766a05dfda5023@google.com>
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
