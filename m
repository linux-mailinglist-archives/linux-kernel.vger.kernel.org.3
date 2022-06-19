Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639E9550C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiFSRPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 13:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiFSRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 13:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4160D558B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 10:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8916120F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BE2C34114;
        Sun, 19 Jun 2022 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655658942;
        bh=EOaC8SnRT3BTyKb+6oHGcBDutsyklJb4+wCJ/KSpZKU=;
        h=From:To:Cc:Subject:Date:From;
        b=fD+ZZ//F1Efwr0zAAQbxGZDMgaOowTvF82BSx8enp4x5myUQTiSXQOUt2ucOIZz0J
         2b54PNisfVsJQinuqmgD18Jc1juvGXAPkgio5ohaXoymf/NgQDAHFX4Zj2jlTrCKQy
         UQcp9eEuNVIMJh5qzf6toEFZ6UNUQVqZ/5H3D0jik22c9NPXDzmOyrZtiLsppMCnfg
         LPx0PWZyicy0Gg6qGhek+F+FvE/kLo9Hp8LBPMK102FeL4lX6KbouGZSkDRKX2TZlE
         Mnpyjyc8ZsU0DFwinTGGyPqcvyVuvbfOARWVB/xN0CeeuwSj7dMIDxidLzdpP04Q2e
         kClq6FWJs63eA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nick Terrell <terrelln@fb.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: boot: add zstd support
Date:   Mon, 20 Jun 2022 01:06:57 +0800
Message-Id: <20220619170657.2657-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support build the zstd compressed Image.zst. Similar as other
compressed formats, the Image.zst is not self-decompressing and
the bootloader still needs to handle decompression before
launching the kernel image.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/boot/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index ebe80faab883..a0e3dedd2883 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -16,7 +16,7 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo
+targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Image.zst
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -35,3 +35,6 @@ $(obj)/Image.lzma: $(obj)/Image FORCE
 
 $(obj)/Image.lzo: $(obj)/Image FORCE
 	$(call if_changed,lzo)
+
+$(obj)/Image.zst: $(obj)/Image FORCE
+	$(call if_changed,zstd)
-- 
2.34.1

