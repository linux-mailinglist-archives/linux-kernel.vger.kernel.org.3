Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D959A719
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351815AbiHSUfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351798AbiHSUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:35:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1780375;
        Fri, 19 Aug 2022 13:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F2BCB828FD;
        Fri, 19 Aug 2022 20:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83DDC433D6;
        Fri, 19 Aug 2022 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660941340;
        bh=X/X0s+8BQ7VAiqjRr6lbXkUnJWAqWC8ePhWIIvLa++I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z6VWucaNDqk5FHfcwUPHVDXlhoINPFMK1VmHHxitpnoWFWVuYGr8Q3faTSJ+IrlP7
         XIuuugTIVgH5nUMGrUp9kRDjjW1MEVapuYW8yoQXLB1+2BO2uRREKzg+tYFQzghOOm
         Tay7Dt4xWs6deAw6CY2ZBGkcUMl4NFuvX2Jbu68w=
Date:   Fri, 19 Aug 2022 13:35:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Message-Id: <20220819133539.f8eb934e29e8f4f72c62752b@linux-foundation.org>
In-Reply-To: <20220819133458.eqshbr5xp4yr3xws@revolver>
References: <20220819082714.5313827d@canb.auug.org.au>
        <Yv8vZQB25NE0r/uN@kroah.com>
        <20220819184027.7b3fda3e@canb.auug.org.au>
        <Yv9QArukYhIgg3R7@kroah.com>
        <20220819133458.eqshbr5xp4yr3xws@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 13:35:04 +0000 Liam Howlett <liam.howlett@oracle.com> w=
rote:

> b3bb668f3dc6 is the older v1 of the patch [1]. d6f35446d076 from
> mm-hotfixes is the correct v2 version [2], although I don't think that's
> currently in mm-hotfixes-unstable.  It looks like version 1 is now in
> mm-hotfixes-unstable as well.
>=20
> 1: https://lore.kernel.org/linux-mm/20220809160618.1052539-1-Liam.Howlett=
@oracle.com/
> 2: https://lore.kernel.org/linux-mm/20220810160209.1630707-1-Liam.Howlett=
@oracle.com/

I moved "binder_alloc: add missing mmap_lock calls when using the VMA"
into mm-hotfixes-stable this week.

It's the v2.  I intend to send this Linuswards today or tomorrow.  Below.

So I think we're all good.


commit b3bb668f3dc6a97a91c47a4cebb0e3f33554c08c
Author: Liam Howlett <liam.howlett@oracle.com>
Date:   Wed Aug 10 16:02:25 2022 +0000

    binder_alloc: add missing mmap_lock calls when using the VMA
   =20
    Take the mmap_read_lock() when using the VMA in binder_alloc_print_page=
s()
    and when checking for a VMA in binder_alloc_new_buf_locked().
   =20
    It is worth noting binder_alloc_new_buf_locked() drops the VMA read lock
    after it verifies a VMA exists, but may be taken again deeper in the ca=
ll
    stack, if necessary.
   =20
    Link: https://lkml.kernel.org/r/20220810160209.1630707-1-Liam.Howlett@o=
racle.com
    Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to the VMA=
")
    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
    Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
    Reported-by: <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
    Acked-by: Carlos Llamas <cmllamas@google.com>
    Tested-by: Ondrej Mosnacek <omosnace@redhat.com>
    Cc: Minchan Kim <minchan@kernel.org>
    Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Hridya Valsaraju <hridya@google.com>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Martijn Coenen <maco@android.com>
    Cc: Suren Baghdasaryan <surenb@google.com>
    Cc: Todd Kjos <tkjos@android.com>
    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
    Cc: "Arve Hj=F8nnev=E5g" <arve@android.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 1014beb12802..d247742bb42e 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -402,12 +402,15 @@ static struct binder_buffer *binder_alloc_new_buf_loc=
ked(
 	size_t size, data_offsets_size;
 	int ret;
=20
+	mmap_read_lock(alloc->vma_vm_mm);
 	if (!binder_alloc_get_vma(alloc)) {
+		mmap_read_unlock(alloc->vma_vm_mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
+	mmap_read_unlock(alloc->vma_vm_mm);
=20
 	data_offsets_size =3D ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -929,17 +932,23 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) !=3D NULL) {
-		for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			page =3D &alloc->pages[i];
-			if (!page->page_ptr)
-				free++;
-			else if (list_empty(&page->lru))
-				active++;
-			else
-				lru++;
-		}
+
+	mmap_read_lock(alloc->vma_vm_mm);
+	if (binder_alloc_get_vma(alloc) =3D=3D NULL)
+		goto uninitialized;
+
+	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		page =3D &alloc->pages[i];
+		if (!page->page_ptr)
+			free++;
+		else if (list_empty(&page->lru))
+			active++;
+		else
+			lru++;
 	}
+
+uninitialized:
+	mmap_read_unlock(alloc->vma_vm_mm);
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);

