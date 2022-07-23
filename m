Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AF57ED03
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiGWJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiGWJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:22:49 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C7101E7;
        Sat, 23 Jul 2022 02:22:43 -0700 (PDT)
X-QQ-mid: bizesmtp89t1658568153ta68gvag
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 17:22:32 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: XBN7tc9DADJ43OkaAz2JfV5ErFMn90b2HStIVW8LIUKuOgnydgnI6Krvii5q0
        X2A4YgUOftGzv+FxcU6Y6JqPFh0yxWVFXTgfwI7vbQJu29RWzLiyrOYn/xlv6kuucwhCHkq
        RTZW/C2S+d8vuvdFAxR2tNEAVXezZ5zZZ6Xub7nkG+0Wiyzv6wZYdKVXBpnpvIbKLyq4i4j
        gdDaYqweMeGIPTocPiN3TNpvpvIw5l7eRzDrdQMHFCXK2pQO+a0NPMVd65GXGR0YRxj7nGE
        YCWaWLVJrgZt30b1Bavsu6u4aKTHD3Gw+ij9cyaBI7eMIOpR0+OXIu2ijkhafl2E1eSRGvF
        M58mwVZ3jJXIv9iGPcCzK1f48fZunmIJaiOxezn9rVgXJaT762LHE/8LYpFZJlqi/iMulqf
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ink@jurassic.park.msu.ru
Cc:     rth@twiddle.net, mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] alpha: Remove the static variable initialisations to 0
Date:   Sat, 23 Jul 2022 17:22:00 +0800
Message-Id: <20220723092200.6659-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise global and static variable to 0 is always unnecessary.
Remove the unnecessary initialisations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/alpha/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 64fbfb0763b2..bce5f07c1d79 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -210,7 +210,7 @@ static struct pdev_srm_saved_conf *srm_saved_configs;
 static void pdev_save_srm_config(struct pci_dev *dev)
 {
 	struct pdev_srm_saved_conf *tmp;
-	static int printed = 0;
+	static int printed;
 
 	if (!alpha_using_srm || pci_has_flag(PCI_PROBE_ONLY))
 		return;
-- 
2.35.1

