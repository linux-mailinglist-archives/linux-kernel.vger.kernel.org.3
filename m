Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2157BEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiGTTkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGTTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:40:08 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1565D4A;
        Wed, 20 Jul 2022 12:40:02 -0700 (PDT)
X-QQ-mid: bizesmtp91t1658345995to035zp2
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:39:43 +0800 (CST)
X-QQ-SSF: 0100000000200030C000C00A0000020
X-QQ-FEAT: +bXiSo2NuBeKioPucw27azFzSN7FKN7KqmpjEqbFFM0StNhYLSCZB7gZB64hp
        Mrbc+QPsqLWG1ZxJmJ0GmLM6JOHIdY7zPZsRak1+247BDVvvyXgKZu84vZqYxmzE1KMmlwP
        ITwh7ZFK/zDWEKxC4S4bxEvmYJ6FwnATDKXTp3vf32SzVqfmm11SiGnj5acrIs9PlOJXLOa
        +ooV4XJrMIOEke6MaMHLs+Eu6UAi9S74yDs8kAlsvBLph8MVvmSW4vQYMTPfI+f+1E34N3n
        CcYrYKXJRVshGzLvu+A7PDGEr43d+hSX0CNUtAqpZwelYmldqckvKQ1DUJnp7rPyNqBFypW
        r6gyyLxTCTeGtwaKc/QIKLH2xLMR9CKjrJ6c/toUexu00hw1VCaooFi2rzr6w==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] dma-mapping:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:39:41 +0800
Message-Id: <20220720193941.8261-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/parisc/kernel/pci-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 160996f2198e..ba87f791323b 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -36,8 +36,8 @@
 #include <asm/tlbflush.h>	/* for purge_tlb_*() macros */
 
 static struct proc_dir_entry * proc_gsc_root __read_mostly = NULL;
-static unsigned long pcxl_used_bytes __read_mostly = 0;
-static unsigned long pcxl_used_pages __read_mostly = 0;
+static unsigned long pcxl_used_bytes __read_mostly;
+static unsigned long pcxl_used_pages __read_mostly;
 
 extern unsigned long pcxl_dma_start; /* Start of pcxl dma mapping area */
 static DEFINE_SPINLOCK(pcxl_res_lock);
-- 
2.30.2


