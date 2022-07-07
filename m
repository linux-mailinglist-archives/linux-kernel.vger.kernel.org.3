Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C1C56ACB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiGGU2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiGGU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:28:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5672559D;
        Thu,  7 Jul 2022 13:28:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a15so21622478pfv.13;
        Thu, 07 Jul 2022 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RngVt0W9Nt0ARR4BcBhKZM+Jx2aWfm3fgCdPS5bV+Y4=;
        b=aWunEcvKQJyhExfqZiqVwOOoWTqIVARGMm5+/PMlM829wUxhP5oYEjg6QTXQJK3681
         oTVksPwG90x9KMt4Cb/wyHxZr1hbWhbnMETFb9/k1vZtJMb/ZBp/DDnTubgKv12EF7f6
         q82eID7oHS+OfVg9umN2LrxQgQbkCfI/qMM95ykI3RYTtPoITV5DITPRfF3lyA1FVwKg
         ZN4Fr/tZ2/KZGS4rzvm7RsOUkhCO2eLWAKFVWHCtL8nUO1q/xsH+05mEDUG+eq0qQucQ
         1upUrjLboxzVv3v049jj3cx+j6EFT4xEROMQjEmXhFKYc8yT6+4S8Pj/whkFQrqv80Z+
         iIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RngVt0W9Nt0ARR4BcBhKZM+Jx2aWfm3fgCdPS5bV+Y4=;
        b=I7G7seXSqBjWiJt5fjfrx6URj0UeUkr3b7av/YZc2IQY0wwdzjnY+w6tl5x3YC60Vf
         49WMN5TVEsTZUCD8mlMmb9VJrPxSQP4E/VbylB21+Gt+K50K/X7cJf4ALNzqGp0ooxkB
         Ozz8ne/fRjQAkhdExPv+Z6NtEwUw2warMyqNhT21JpefYeNBYfePNvpg1XmDKH11bN61
         GvVyEpwu7yuYdDR4YLBC7voxnZhvFa4GHlxCS5BCkcaCSN2SZresJznx6uPPtEzphP7H
         6fi1KrYJ0uaHdxNajhz5QZRkTOcNKM7GMqOwXZiNQ/wnZHuBMrFCyG73nTKbizzg11j+
         tXqA==
X-Gm-Message-State: AJIora92ruE12T2/uid+uXH/WIk0VV2ykRDUTnWfXgLVwD2ybIseodjN
        UyMZTx64eZFokm9Tu4LpCAEHnZHJxhI=
X-Google-Smtp-Source: AGRyM1sGHjVGGPl+1Zu4PflHFpbSK5D/TJSxSO3bHaJ6b9kaVIDdHHwyY4GSY5zykYIo7Ml7MtABHA==
X-Received: by 2002:a17:90b:4ac1:b0:1ef:c1ba:e73e with SMTP id mh1-20020a17090b4ac100b001efc1bae73emr7315056pjb.47.1657225684923;
        Thu, 07 Jul 2022 13:28:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h14-20020aa796ce000000b005281d926733sm14716804pfq.199.2022.07.07.13.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:28:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: vdso: Utilize __pa() for gic_pfn
Date:   Thu,  7 Jul 2022 13:27:58 -0700
Message-Id: <20220707202759.1224809-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC user offset is mapped into every process' virtual address and is
therefore part of the hot-path of arch_setup_additional_pages(). Utilize
__pa() such that we are more optimal even when CONFIG_DEBUG_VIRTUAL is
enabled, and while at it utilize PFN_DOWN() instead of open-coding the
right shift by PAGE_SHIFT.

Reported-by: Greg Ungerer <gerg@kernel.org>
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 3d0cf471f2fe..b2cc2c2dd4bf 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -159,7 +159,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	/* Map GIC user page. */
 	if (gic_size) {
 		gic_base = (unsigned long)mips_gic_base + MIPS_GIC_USER_OFS;
-		gic_pfn = virt_to_phys((void *)gic_base) >> PAGE_SHIFT;
+		gic_pfn = PFN_DOWN(__pa(gic_base));
 
 		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(vma->vm_page_prot));
-- 
2.25.1

