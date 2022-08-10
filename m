Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6749158F065
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiHJQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiHJQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:27:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732F6D9CD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:27:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f28so14174574pfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=iaOXFsKF+VEOO1NtlLaIlaeLAxiEe5HdvjUlYcOWT3Q=;
        b=GVeX1RfPqCV4MNhmySGhqVn74U978EnXNlWy8V4rYKKPVMl+gZdNyfITPC6O1m7XA3
         UjyTN0wfJ/TOOzSXUVhjCj6sO7zhn3q55rwo2cYlRPZp53jFzhY97gJn7NOepzENJC17
         911046olUQ8Oxebz/BVk9RQfS9RHpiGgZBGD+Yejcwc5gLsODnSxBe9Yg7D/o+aP6mUt
         uRAuOiJbG+pk8Ic5/M6miuaKzbyYwZ12hrI7AujiS4CYR/h1hRKEc7LNMWVYjQXS4eFL
         Yvj98HZt91azKkPv3+HHPjurpgBb3dZSG3wA/dUHnhwUgOzhbn+FZPh4wWsKQRwV5aMZ
         7O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iaOXFsKF+VEOO1NtlLaIlaeLAxiEe5HdvjUlYcOWT3Q=;
        b=KmtqJf/bSxOFYrKWCadtCt9ZNi2ANSbEuFgE1rk+4siyBXgq537MqxZw0RIzf1H5+c
         uCOIiQcgZmVMVEdE4ILM9IirlRpfgoTgWMwQ44ehI0Es3PWuS9j+Mz0ha3kTjxBUuE+C
         Ya4Btk/aD+yeOvswX6LgCbqkCYRnOGRJchlhDT0D6Sb1p3JLNaJGg8sZ+ZGqw1VkmC0l
         08QmLSkS7eM3IaTCm4bBBw3Ll3HXMn2UFPsMkT8wUd60z8hcKahEUHaic5PUvtaxpWTE
         JsAaiNPHqMCWBaotkdKgj5RD5vyWblh5qnW625xRuu4VDb94+JE5mlyL6fD5hHqGoxyV
         y5rA==
X-Gm-Message-State: ACgBeo1+0VVUfyxsgpRguU8q+oT7a4ovyPtMgRNz/7xzXktRt3p3Fo7q
        rkSkXnzXoRciyeSokXT+GSMqew==
X-Google-Smtp-Source: AA6agR6wL/KmEd1PVXtdHewoboaIumIX8l2OdRxgDFKHwjSDuXqF//vBbcweilEAqT2bqmFBdDoTIA==
X-Received: by 2002:a65:6755:0:b0:41d:70c1:be0 with SMTP id c21-20020a656755000000b0041d70c10be0mr12905489pgu.99.1660148836261;
        Wed, 10 Aug 2022 09:27:16 -0700 (PDT)
Received: from google.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a2c0300b001f021cdd73dsm1851984pjd.10.2022.08.10.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:27:15 -0700 (PDT)
Date:   Wed, 10 Aug 2022 16:27:11 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: Re: [PATCH v2] binder_alloc: Add missing mmap_lock calls when using
 the VMA
Message-ID: <YvPcX6/1E0hAhOO5@google.com>
References: <20220810160209.1630707-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810160209.1630707-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 04:02:25PM +0000, Liam Howlett wrote:
> Take the mmap_read_lock() when using the VMA in
> binder_alloc_print_pages() and when checking for a VMA in
> binder_alloc_new_buf_locked().
> 
> It is worth noting binder_alloc_new_buf_locked() drops the VMA read lock
> after it verifies a VMA exists, but may be taken again deeper in the
> call stack, if necessary.
> 
> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
> Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the VMA)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  drivers/android/binder_alloc.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index f555eebceef6..c5e7c6d3a844 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -395,12 +395,15 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>  	size_t size, data_offsets_size;
>  	int ret;
>  
> +	mmap_read_lock(alloc->vma_vm_mm);
>  	if (!binder_alloc_get_vma(alloc)) {
> +		mmap_read_unlock(alloc->vma_vm_mm);
>  		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
>  				   "%d: binder_alloc_buf, no vma\n",
>  				   alloc->pid);
>  		return ERR_PTR(-ESRCH);
>  	}
> +	mmap_read_unlock(alloc->vma_vm_mm);
>  
>  	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
>  		ALIGN(offsets_size, sizeof(void *));
> @@ -922,17 +925,25 @@ void binder_alloc_print_pages(struct seq_file *m,
>  	 * Make sure the binder_alloc is fully initialized, otherwise we might
>  	 * read inconsistent state.
>  	 */
> -	if (binder_alloc_get_vma(alloc) != NULL) {
> -		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> -			page = &alloc->pages[i];
> -			if (!page->page_ptr)
> -				free++;
> -			else if (list_empty(&page->lru))
> -				active++;
> -			else
> -				lru++;
> -		}
> +
> +	mmap_read_lock(alloc->vma_vm_mm);
> +	if (binder_alloc_get_vma(alloc) == NULL) {
> +		mmap_read_unlock(alloc->vma_vm_mm);
> +		goto uninitialized;
>  	}
> +
> +	mmap_read_unlock(alloc->vma_vm_mm);
> +	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> +		page = &alloc->pages[i];
> +		if (!page->page_ptr)
> +			free++;
> +		else if (list_empty(&page->lru))
> +			active++;
> +		else
> +			lru++;
> +	}
> +
> +uninitialized:
>  	mutex_unlock(&alloc->mutex);
>  	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
>  	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
> -- 
> 2.35.1

Thanks Liam, this looks good.

Acked-by: Carlos Llamas <cmllamas@google.com>
