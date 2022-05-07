Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DA51E315
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445193AbiEGBiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiEGBiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 958265F25D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651887276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vncVoL2JhBNKljKiob7OIeoa3sEmbpg073822r/dh9w=;
        b=VbH7BuufTxDCXdiSmb3llf0EXpmP+7icFWMcIHrHunjAn5q5kBuS6yIxuFdNk6Cidar384
        PBWWx//APkbZeWu2rj9f+vcM2V2WwIeNoLQ4WWWjVZDyln7EcNhU9dOjt6PA2xC5gqX6xx
        1GsQVAAyyeRV6UOZM0nHkpFCBDsj95g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-qAWFsuJSNgSMVyTzlT0U4Q-1; Fri, 06 May 2022 21:34:21 -0400
X-MC-Unique: qAWFsuJSNgSMVyTzlT0U4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3E3B2999B5B;
        Sat,  7 May 2022 01:34:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-18.pek2.redhat.com [10.72.13.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B34E40D2971;
        Sat,  7 May 2022 01:34:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, bhe@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] sh: cast away __iomem to remove sparse warning
Date:   Sat,  7 May 2022 09:34:11 +0800
Message-Id: <20220507013411.74277-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reported a sparse warning in arch/sh/kernel/crash_dump.c during
a kdump patchset reviewing:
https://lore.kernel.org/all/202204082128.JKXXDGpa-lkp@intel.com/T/#u

../arch/sh/kernel/crash_dump.c:23:36: sparse: warning: incorrect type in argument 1 (different address spaces)
../arch/sh/kernel/crash_dump.c:23:36: sparse:    expected void const *addr
../arch/sh/kernel/crash_dump.c:23:36: sparse:    got void [noderef] __iomem *

This warning happened when __iomem pointer is passed into fucntion
which doesn't expect it. Casting away the __iomem can fix it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/sh/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 19ce6a950aac..52d1d54eb6b1 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -20,7 +20,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		return 0;
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_to_iter((const void __force *)vaddr + offset, csize, iter);
 	iounmap(vaddr);
 
 	return csize;
-- 
2.34.1

