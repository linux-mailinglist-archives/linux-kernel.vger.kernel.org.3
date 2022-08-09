Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9C58DFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbiHITHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348221AbiHITGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:06:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0126103
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:49:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z19so12165054plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=wxjpe2mRFKGT8P+j55tH9VVKtl0m60jJkcmkH27O1X0=;
        b=rX510oQLQTQgYsGfs52YJ2Pqzej/cCIfJYbCr+UQ7zuyxHrUImZc/1D2IXbhA+aWx4
         9ge6y085uD4FX3x7eFej+7Wfiu/9UE6M8cKl1AZ7b1woItJw1DTyOfb17t1gAJCHJWiX
         XBUd1WphWCmHL+RKY/E7NPEwAW7cTRIzLyIAN7OhCa/v5kjBMeOvUr8AERC1w0NLbbPr
         FBeq+0hDfjgwUYmbeQON/xFV+3wDb8QB1Ud5hLy4MAoHhYLZ1JR+FEGRn9rtQ7FsJdeU
         hk5WVgwL1ms9QyE9I48mldDcHNg4cYxgyDbihYQqBTxsXBLM/vkb0CTXBPBi2lEQb5Ga
         lfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wxjpe2mRFKGT8P+j55tH9VVKtl0m60jJkcmkH27O1X0=;
        b=VZYqL29pDyL3hPKulQ1DHh4BGk2xWA3GLB7QxDXYO1mcJQpniR4XIGhu2SYk71yAMV
         mwDma+pPze/V8YMx3f30PA0FbMB6VbnIRfTXl0+hGXRyIK+RVMIGkcnjZMz2On+If1yX
         6nPQxZmdeyKx8cJS6dGXZo67403U7IN8RAh8aiyWBuqcwPdu66po24mZu/dYGLbAYX0j
         bwPbXwYdZx3kSAW5SW44zLp1yj5YZRz+BtUVpBMxq5zvnNqfs2yTX8dJuFAdy4WiMrvL
         Hvpj/J3XAtAZaHnJgnt+nLy69u3+FFb5Vx2rAi50HLJfqS87QEJ/FqzSxcbsk0yE2+qj
         Qj/A==
X-Gm-Message-State: ACgBeo3r9tjzUe51lsSERpRo6yxVvRQzQ6JKlKVesF6jBSkaP6OGcdUS
        LqJsKOEMl6UPENf5bAlts7c3VA==
X-Google-Smtp-Source: AA6agR7V/N6oONYQ68gqg6oMgkl+qhMG1P6S21y/lICvQ32LYHpb4CDM+tIsSE+rHs9qxpl3WUxl2A==
X-Received: by 2002:a17:90a:7aca:b0:1f1:ff59:fe7e with SMTP id b10-20020a17090a7aca00b001f1ff59fe7emr27772289pjl.11.1660070951915;
        Tue, 09 Aug 2022 11:49:11 -0700 (PDT)
Received: from google.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b0016bfbd99f64sm11331143plh.118.2022.08.09.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:49:11 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:49:07 +0000
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
Subject: Re: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Message-ID: <YvKsI5pMbgQ5Irup@google.com>
References: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
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

On Tue, Aug 09, 2022 at 04:06:31PM +0000, Liam Howlett wrote:
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
>  drivers/android/binder_alloc.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index f555eebceef6..c23cad7fe313 100644
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
> @@ -922,17 +925,23 @@ void binder_alloc_print_pages(struct seq_file *m,
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
> +	if (binder_alloc_get_vma(alloc) == NULL)
> +		goto uninitialized;
> +
> +	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {

do we need to hold on to the lock while we loop through the pages here?

> +		page = &alloc->pages[i];
> +		if (!page->page_ptr)
> +			free++;
> +		else if (list_empty(&page->lru))
> +			active++;
> +		else
> +			lru++;
>  	}
> +
> +uninitialized:
> +	mmap_read_unlock(alloc->vma_vm_mm);
>  	mutex_unlock(&alloc->mutex);
>  	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
>  	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
> -- 
> 2.35.1
