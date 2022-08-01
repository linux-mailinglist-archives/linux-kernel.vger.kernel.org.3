Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64C3586D14
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiHAOlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiHAOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C98E3D580
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKrUoRnDZ3N/f9AupvreAkywYQigdqg4xJd8FTCpS7Q=;
        b=dzuElEUbn/xc4Ofz7QEV36JfAenKndM2RHzHOUR68a5BfE/NeqXd1E4KXpkhyqV9raXOVW
        xm+K+09gMiRoanNB2SqhBq+PmjpN/Q39uHnxOwhsqpupXoZBpx+UT+65QpzZl8JbLEY/vU
        Ko//ZEyhqSYykLliG+gwvZ/+WBaR9p0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-L8yZD93EODmWXar_uTWN_A-1; Mon, 01 Aug 2022 10:40:58 -0400
X-MC-Unique: L8yZD93EODmWXar_uTWN_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4845882404E;
        Mon,  1 Aug 2022 14:40:51 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 411F6141510F;
        Mon,  1 Aug 2022 14:40:46 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 03/11] mm: ioremap: allow ARCH to have its own ioremap definition
Date:   Mon,  1 Aug 2022 22:40:21 +0800
Message-Id: <20220801144029.57829-4-bhe@redhat.com>
In-Reply-To: <20220801144029.57829-1-bhe@redhat.com>
References: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures like xtensa, arc, can be converted to GENERIC_IOREMAP,
to take standard ioremap_prot() and ioremap_xxx() way. But they have
ARCH specific handling for ioremap() method, then standard ioremap()
method.

In oder to convert them to take GENERIC_IOREMAP method, allow ARCH
to have its own ioremap definition.

This is a preparation patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/asm-generic/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 0b5cd3cef99d..444761c3a44b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -995,11 +995,14 @@ void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
 			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
+#ifndef ioremap
+#define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
 	/* _PAGE_IOREMAP needs to be supplied by the architecture */
 	return ioremap_prot(addr, size, _PAGE_IOREMAP);
 }
+#endif
 #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
 
 #ifndef ioremap_wc
-- 
2.34.1

