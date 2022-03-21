Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB274E271C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347684AbiCUNCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbiCUNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8A0F13EF99
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647867651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+eufLnpVokFrbEaIu897l2dh/pat5lF2bZZu9LjdBSY=;
        b=LzZPVN/V7CHdp+yTi3++Da4D/D+0Ya5ZTzwutbjJutdzFe3f/G3Dasbj6OxnNyBbcGjSDf
        2Er0iuLq92i12cY8mSY861kq2Dxr+/4EhCLNvrT0N6Df7vZ7B205r3qlvFRzyEKjqG+IjW
        D1/AJ8D9tkd0qz5I6s3KuPEQHg5bIS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-FmWPyz3sPZW_t3aw1n64vQ-1; Mon, 21 Mar 2022 09:00:48 -0400
X-MC-Unique: FmWPyz3sPZW_t3aw1n64vQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D21CC811E76;
        Mon, 21 Mar 2022 13:00:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09BB7440EE0;
        Mon, 21 Mar 2022 13:00:46 +0000 (UTC)
Subject: [PATCH 0/2] watch_queue: A couple more fixes
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, fmdefrancesco@gmail.com, jannh@google.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Mar 2022 13:00:46 +0000
Message-ID: <164786764630.1025645.12332376420230352947.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Here are fixes for a couple more watch_queue bugs, both found by syzbot:

 (1) Fix error cleanup in watch_queue_set_size() where it tries to clean up
     all the pointers in the page list, even if they've not been allocated
     yet[1].  Unfortunately, __free_page() doesn't treat a NULL pointer as
     being "do nothing".

     A second report[2] looks like it's probably the same bug, but on arm64
     rather than x86_64, but there's no reproducer.

 (2) Fix a missing kfree in free_watch() to actually free the watch[3].

Both have syzbot reproducers.

The fixes are also available through git:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David

Link: https://lore.kernel.org/r/000000000000b1807c05daad8f98@google.com/ [1]
Link: https://lore.kernel.org/r/000000000000035b9c05daae8a5e@google.com/ [2]
Link: https://lore.kernel.org/r/000000000000bc8eaf05dab91c63@google.com/ [3]
---
David Howells (2):
      watch_queue: Fix NULL dereference in error cleanup
      watch_queue: Actually free the watch


 kernel/watch_queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


