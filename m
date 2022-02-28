Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16E4C6E09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiB1NXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiB1NXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C327826121
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646054585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PlD7TMS0jB91fn4FULs2gWc+/7qJIEEnhaVLcZF9VF0=;
        b=WRrFxXYl2nA2pRdgyp+KL2EsoQKzLcTZHZWxPIVA8mKCdTyYzIaU9+2W/GGc23ZHl3poxE
        VJuaQ39le6hlYbP7BFKg3FnEmQSKcG91+bYaAghh0JzTjS66n79S8i+0aaRhMKtbvTTosm
        3v08jGCn7zYzoDxPxqIJL2B+5rwj2bM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-tmaySKIlOYekywmpiySahA-1; Mon, 28 Feb 2022 08:23:00 -0500
X-MC-Unique: tmaySKIlOYekywmpiySahA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0488066F4;
        Mon, 28 Feb 2022 13:22:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAAC8838C0;
        Mon, 28 Feb 2022 13:22:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org
cc:     dhowells@redhat.com, willy@infradead.org, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Export PageHeadHuge()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2494561.1646054576.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 28 Feb 2022 13:22:56 +0000
Message-ID: <2494562.1646054576@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    =

Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
such as folio_file_page() and folio_contains().  Matthew suggested I use
the first of those instead of doing the same calculation manually - but
I can't call it from a module.

Kirill suggested rearranging things to put it in a header, but that
introduces header dependencies because of where constants are defined.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: willy@infradead.org
Link: https://lore.kernel.org/r/163707085314.3221130.14783857863702203440.=
stgit@warthog.procyon.org.uk/

---
 mm/hugetlb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61895cc01d09..5768df43b05c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1854,6 +1854,7 @@ int PageHeadHuge(struct page *page_head)
 =

 	return page_head[1].compound_dtor =3D=3D HUGETLB_PAGE_DTOR;
 }
+EXPORT_SYMBOL(PageHeadHuge);
 =

 /*
  * Find and lock address space (mapping) in write mode.

