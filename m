Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF94E226D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbiCUIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345402AbiCUIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0271A6E00
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647852415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOTtoGOaj/bLg++xwN8hAlAI+e0GqN0W18n+jyMNEsI=;
        b=E85ZRcCY64pz8urV+XAlhRkuZwFRmV2nJPnh1EYV6iagsafJQY6RV0noLd9bvY9fPGmyz/
        bQv4UL1ok+b5YFCxjsNbUbrcB8+hZl5ElZI4j+0WGu/AvldmctHgOpqiahDU5Ba7UPcQd2
        +E4oKcnv1rCzMGLeJ2NSvSPrL1lVC9o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Q_cVDoIdMC2yMzDVUvMfSQ-1; Mon, 21 Mar 2022 04:46:53 -0400
X-MC-Unique: Q_cVDoIdMC2yMzDVUvMfSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DABA1C06910;
        Mon, 21 Mar 2022 08:46:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65577C15D40;
        Mon, 21 Mar 2022 08:46:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1821968.CQOukoFCf9@leap>
References: <1821968.CQOukoFCf9@leap> <000000000000b1807c05daad8f98@google.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <977072.1647852411.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 08:46:51 +0000
Message-ID: <977073.1647852411@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

How about using my patch instead?  I wonder if __free_pages() should check=
 for
a NULL pages pointer...

David
---
watch_queue: Fix NULL dereference in error cleanup

In watch_queue_set_size(), the error cleanup code doesn't take account of
the fact that __free_page() can't handle a NULL pointer when trying to fre=
e
up buffer pages that did get allocated.

Fix this by only calling __free_page() on non-NULL pointers extracted from
the list (the list was allocated by kcalloc() so was pre-cleared).

Without the fix, this can lead to something like the following:

BUG: KASAN: null-ptr-deref in __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
Read of size 4 at addr 0000000000000034 by task syz-executor168/3599
...
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __kasan_report mm/kasan/report.c:446 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 page_ref_count include/linux/page_ref.h:67 [inline]
 put_page_testzero include/linux/mm.h:717 [inline]
 __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
 watch_queue_set_size+0x499/0x630 kernel/watch_queue.c:275
 pipe_ioctl+0xac/0x2b0 fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-and-tested-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.=
com
Signed-off-by: David Howells <dhowells@redhat.com>
---
 kernel/watch_queue.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 00703444a219..09f35bab496e 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -272,7 +272,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe=
, unsigned int nr_notes)
 =

 error_p:
 	for (i =3D 0; i < nr_pages; i++)
-		__free_page(pages[i]);
+		if (pages[i])
+			__free_page(pages[i]);
 	kfree(pages);
 error:
 	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->nr_accounted);

