Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8856CA73
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGIP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGIP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:56:49 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8210F19C33
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:56:48 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ACp2olvOKOXCyACp2oyRKl; Sat, 09 Jul 2022 17:56:47 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 09 Jul 2022 17:56:47 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] KVM: PPC: Book3S HV: Use the bitmap API to allocate bitmaps
Date:   Sat,  9 Jul 2022 17:56:43 +0200
Message-Id: <52e843a460bc374973149b8da0bd04f9761b80b7.1657382184.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 598006301620..95de5fac6497 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -1187,8 +1187,7 @@ int kvmppc_uvmem_init(void)
 
 	pfn_first = res->start >> PAGE_SHIFT;
 	pfn_last = pfn_first + (resource_size(res) >> PAGE_SHIFT);
-	kvmppc_uvmem_bitmap = kcalloc(BITS_TO_LONGS(pfn_last - pfn_first),
-				      sizeof(unsigned long), GFP_KERNEL);
+	kvmppc_uvmem_bitmap = bitmap_zalloc(pfn_last - pfn_first, GFP_KERNEL);
 	if (!kvmppc_uvmem_bitmap) {
 		ret = -ENOMEM;
 		goto out_unmap;
@@ -1212,5 +1211,5 @@ void kvmppc_uvmem_free(void)
 	memunmap_pages(&kvmppc_uvmem_pgmap);
 	release_mem_region(kvmppc_uvmem_pgmap.range.start,
 			   range_len(&kvmppc_uvmem_pgmap.range));
-	kfree(kvmppc_uvmem_bitmap);
+	bitmap_free(kvmppc_uvmem_bitmap);
 }
-- 
2.34.1

