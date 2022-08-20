Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392AE59ADF1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiHTMeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiHTMeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:34:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA01BEA9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C376CB80926
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AD6C433C1;
        Sat, 20 Aug 2022 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660998834;
        bh=mCz2SxJKYp8oLIDh+dfPccwFT6pIPPbM7vRC1B7QWME=;
        h=From:To:Cc:Subject:Date:From;
        b=DBch2/TSovQN6bsHK3PYXvYmjx2yg/WBvzNi404oyhcuXHxP22Vpx73Rc0tI6hAtL
         7p5eI8zlCjDwcow2VW3jrLtUl4RbN7MNBeEpAsXOYFUlND1OWD7QQlVUyb9n5JaDRA
         0qQaLrd1/g5hWz0ovxwYHrJKPIkbt49e256KHrrd64BKTjZT0dVaUstVrR2EzIkx37
         96kJTYUwiAaKPtPxFVJc2/4rOITmT644yH0EEu04gO6OoITQY/Bb31V2rskJfcqHBs
         M169miU07sCQxviv/SMR7CgUgCVekCVrxNLMGDphs00Qtlwve4kcrhAyliMCZXRRP4
         K4aXS/jywVBEg==
Received: by pali.im (Postfix)
        id 9F2095D0; Sat, 20 Aug 2022 14:33:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/fsl-pci: Choose PCI host bridge with alias pci0 as the primary
Date:   Sat, 20 Aug 2022 14:33:27 +0200
Message-Id: <20220820123327.20551-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's no PCI host bridge with ISA then check for PCI host bridge with
alias "pci0" (first PCI host bridge) and if it exists then choose it as the
primary PCI host bridge.

This makes choice of primary PCI host bridge more stable across boots and
updates as the last fallback candidate for primary PCI host bridge (if
there is no choice) is selected arbitrary.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/sysdev/fsl_pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 1011cfea2e32..e4b703943dd3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1125,6 +1125,19 @@ void __init fsl_pci_assign_primary(void)
 			return;
 	}
 
+	/*
+	 * If there's no PCI host bridge with ISA then check for
+	 * PCI host bridge with alias "pci0" (first PCI host bridge).
+	 */
+	np = of_find_node_by_path("pci0");
+	if (np && of_match_node(pci_ids, np) && of_device_is_available(np)) {
+		fsl_pci_primary = np;
+		of_node_put(np);
+		return;
+	}
+	if (np)
+		of_node_put(np);
+
 	/*
 	 * If there's no PCI host bridge with ISA, arbitrarily
 	 * designate one as primary.  This can go away once
-- 
2.20.1

