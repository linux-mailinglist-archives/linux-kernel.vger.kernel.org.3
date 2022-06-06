Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141053E0DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiFFF1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFFF1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:27:10 -0400
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4D6F4A6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:03:48 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-07.nifty.com with ESMTP id 25651Pml026657
        for <linux-kernel@vger.kernel.org>; Mon, 6 Jun 2022 14:01:25 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2564xNUT024943;
        Mon, 6 Jun 2022 13:59:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2564xNUT024943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654491564;
        bh=02SaZmEKBPMSF76nbpCPhuGFilCILCVnozQUdrfNE4A=;
        h=From:To:Cc:Subject:Date:From;
        b=RkkHLUjqmtVqOahyc+gud1UArOBglFYPpJZgVzg8bXRPULtWmrJ+kliGNUKHHtDny
         JiWmrEm1pKeMQhx2JCtK9wQffux2NWWrU2BsRIZYg4fVi8QAJBz/YpNdoCzKKf7LoC
         vlI95bU/MbYRII7rJ4vFT9VnOmGsvYvVjmfBi67GMgy6q/HMo/eJE1mr/Cp8Ciqoyv
         0YxSF9sCrBzJ/Pj0oh9NLLnSXjg/VriRCI5ccSBEb2gDb7aiUlEeceQTnmO3Sunl3e
         3lE9jXK7ywjcnYJylguEOjMYY88BLGf0e+gIJPOolZo3FUDfdRnG2wpAtAxSG0/lgj
         ONhdPeLT6l+rg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org (moderated for non-subscribers)
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Julien Grall <julien.grall@arm.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH] xen: unexport __init-annotated xen_xlate_map_ballooned_pages()
Date:   Mon,  6 Jun 2022 13:59:20 +0900
Message-Id: <20220606045920.4161881-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL and __init is a bad combination because the .init.text
section is freed up after the initialization. Hence, modules cannot
use symbols annotated __init. The access to a freed symbol may end up
with kernel panic.

modpost used to detect it, but it has been broken for a decade.

Recently, I fixed modpost so it started to warn it again, then this
showed up in linux-next builds.

There are two ways to fix it:

  - Remove __init
  - Remove EXPORT_SYMBOL

I chose the latter for this case because none of the in-tree call-sites
(arch/arm/xen/enlighten.c, arch/x86/xen/grant-table.c) is compiled as
modular.

Fixes: 243848fc018c ("xen/grant-table: Move xlated_setup_gnttab_pages to common place")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/xen/xlate_mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 34742c6e189e..f17c4c03db30 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -261,7 +261,6 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xen_xlate_map_ballooned_pages);
 
 struct remap_pfn {
 	struct mm_struct *mm;
-- 
2.32.0

