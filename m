Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23259981D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347341AbiHSIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348013AbiHSIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7739EEC48;
        Fri, 19 Aug 2022 01:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DFF761034;
        Fri, 19 Aug 2022 08:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84DEC433D6;
        Fri, 19 Aug 2022 08:55:32 +0000 (UTC)
Date:   Fri, 19 Aug 2022 10:55:30 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Message-ID: <Yv9QArukYhIgg3R7@kroah.com>
References: <20220819082714.5313827d@canb.auug.org.au>
 <Yv8vZQB25NE0r/uN@kroah.com>
 <20220819184027.7b3fda3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819184027.7b3fda3e@canb.auug.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 06:40:27PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Fri, 19 Aug 2022 08:36:21 +0200 Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Aug 19, 2022 at 08:28:18AM +1000, Stephen Rothwell wrote:
> > > 
> > > Today's linux-next merge of the char-misc.current tree got a conflict in:
> > > 
> > >   drivers/android/binder_alloc.c
> > > 
> > > between commit:
> > > 
> > >   b3bb668f3dc6 ("binder_alloc: add missing mmap_lock calls when using the VMA")
> > > 
> > > from the mm-hotfixes tree and commit:
> > > 
> > >   d6f35446d076 ("binder_alloc: Add missing mmap_lock calls when using the VMA")
> > > 
> > > from the char-misc.current tree.
> > > 
> > > I fixed it up (I used the latter as it was committed later even though
> > > the author times were the same) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.  
> > 
> > These should be identical, if not, something went wrong :(
> 
> Something went wrong :-)
> 
> $ git range-diff b3bb668f3dc6^..b3bb668f3dc6 d6f35446d076^..d6f35446d076
> 1:  b3bb668f3dc6 ! 1:  d6f35446d076 binder_alloc: add missing mmap_lock calls when using the VMA
>     @@ Metadata
>      Author: Liam Howlett <liam.howlett@oracle.com>
>      
>       ## Commit message ##
>     -    binder_alloc: add missing mmap_lock calls when using the VMA
>     +    binder_alloc: Add missing mmap_lock calls when using the VMA
>      
>     -    Take the mmap_read_lock() when using the VMA in binder_alloc_print_pages()
>     -    and when checking for a VMA in binder_alloc_new_buf_locked().
>     +    Take the mmap_read_lock() when using the VMA in
>     +    binder_alloc_print_pages() and when checking for a VMA in
>     +    binder_alloc_new_buf_locked().
>      
>          It is worth noting binder_alloc_new_buf_locked() drops the VMA read lock
>     -    after it verifies a VMA exists, but may be taken again deeper in the call
>     -    stack, if necessary.
>     +    after it verifies a VMA exists, but may be taken again deeper in the
>     +    call stack, if necessary.
>      
>     -    Link: https://lkml.kernel.org/r/20220810160209.1630707-1-Liam.Howlett@oracle.com
>     -    Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to the VMA")
>     -    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>     +    Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the VMA)
>     +    Cc: stable <stable@kernel.org>
>          Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
>     -    Reported-by: <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
>     -    Acked-by: Carlos Llamas <cmllamas@google.com>
>     +    Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
>          Tested-by: Ondrej Mosnacek <omosnace@redhat.com>
>     -    Cc: Minchan Kim <minchan@kernel.org>
>     -    Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
>     -    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     -    Cc: Hridya Valsaraju <hridya@google.com>
>     -    Cc: Joel Fernandes <joel@joelfernandes.org>
>     -    Cc: Martijn Coenen <maco@android.com>
>     -    Cc: Suren Baghdasaryan <surenb@google.com>
>     -    Cc: Todd Kjos <tkjos@android.com>
>     -    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>     -    Cc: "Arve Hjønnevåg" <arve@android.com>
>     -    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     +    Acked-by: Carlos Llamas <cmllamas@google.com>
>     +    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>     +    Link: https://lore.kernel.org/r/20220810160209.1630707-1-Liam.Howlett@oracle.com
>     +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      
>       ## drivers/android/binder_alloc.c ##
>      @@ drivers/android/binder_alloc.c: static struct binder_buffer *binder_alloc_new_buf_locked(
>     @@ drivers/android/binder_alloc.c: void binder_alloc_print_pages(struct seq_file *m
>      -		}
>      +
>      +	mmap_read_lock(alloc->vma_vm_mm);
>     -+	if (binder_alloc_get_vma(alloc) == NULL)
>     ++	if (binder_alloc_get_vma(alloc) == NULL) {
>     ++		mmap_read_unlock(alloc->vma_vm_mm);
>      +		goto uninitialized;
>     + 	}
>      +
>     ++	mmap_read_unlock(alloc->vma_vm_mm);
>      +	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
>      +		page = &alloc->pages[i];
>      +		if (!page->page_ptr)
>     @@ drivers/android/binder_alloc.c: void binder_alloc_print_pages(struct seq_file *m
>      +			active++;
>      +		else
>      +			lru++;
>     - 	}
>     ++	}
>      +
>      +uninitialized:
>     -+	mmap_read_unlock(alloc->vma_vm_mm);
>       	mutex_unlock(&alloc->mutex);
>       	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
>       	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
> 

Oh wow, ok, I'll go drop my version and assume that Andrew's is the more
correct one and let it come through his tree.

thanks,

greg k-h
