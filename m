Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0517453DB09
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245117AbiFEJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350947AbiFEJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:31:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3172E6A4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:31:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dFpRWKPODUhp2CdDTQOhreDjP/1BEPmurYOKch6Cf/0=;
        b=rK//GCYFhNw/Wm+M6C9AzQJbwH++tzdK+7EAdJgh9t5shC8jmTCv34C3yJoMJM2U4F/9aW
        GcSlHHMygsJMXIeBPdmZ8dIneiNSSg7s+YEfdfKaf8J6nuTSoCTYkfARBPQAS1b/wUsHOf
        2wwmuckHvhSUBhUlqtyVTUojSi0aWxTbSlxzoBKATed2+wmwQaX3+OJHpufvQbVCnnx/Ud
        fetrpnCO1WqVfyVkJGnPP75t4OsxudwrPC9hVdGQ3dc7hZJiUT1tOawxpjApDTXzji2WTD
        AjhDcChX2edlGNWMPBEmF+x7Ws7Ew74vUJ77x9RT7lf8m259U1uFfWrXKugnXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dFpRWKPODUhp2CdDTQOhreDjP/1BEPmurYOKch6Cf/0=;
        b=anNanoQHwjVcuLzh9AbJmXEB0Eu1250enwKgk8u6Tq8buyK7Ouv5BMj3tnGbSEas9rRex0
        htGMBZqPYHFg27Dg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/mm for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442138128.152751.14866011543351593668.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:31:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/mm branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2022-06-05

up to:  e19d11267f0e: x86/mm: Use PAGE_ALIGNED(x) instead of IS_ALIGNED(x, PA=
GE_SIZE)


Use PAGE_ALIGNED() instead of open coding it in the x86/mm code.

Thanks,

	tglx

------------------>
Fanjun Kong (1):
      x86/mm: Use PAGE_ALIGNED(x) instead of IS_ALIGNED(x, PAGE_SIZE)


 arch/x86/mm/init_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 61d0ab154f96..8779d6be6a49 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1240,8 +1240,8 @@ remove_pagetable(unsigned long start, unsigned long end=
, bool direct,
 void __ref vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
=20
 	remove_pagetable(start, end, false, altmap);
 }
@@ -1605,8 +1605,8 @@ int __meminit vmemmap_populate(unsigned long start, uns=
igned long end, int node,
 {
 	int err;
=20
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
=20
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err =3D vmemmap_populate_basepages(start, end, node, NULL);

