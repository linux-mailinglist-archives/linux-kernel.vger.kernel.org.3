Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40425A712E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiH3Wzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3Wzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:55:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3972B5F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7406B81DFD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D86C433D7;
        Tue, 30 Aug 2022 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661900146;
        bh=dmBMU10Cnw8oAmaoJBci0czuI1FsIM74P4Qly19Szk8=;
        h=From:To:Cc:Subject:Date:From;
        b=OipFgRsYU258ug8u2T8Pa48/9qqcaBUlU/SGCXR7cHm5lpgj00XrcMe9qUeTpbwpj
         djsrOjN4Dmhuvq1YoxfR3JnvTU8NL2pVAv+mM1fgvpCXga4ZchjwDhD5KBEKrM3hNa
         Zqbq0wXNls9eAc9D+c3GDgzM7lQ7JLR5xbySvypoyl2hMm6lIbLvIc/JqkBchSv9+i
         i1+BqzAH7Or9SIY06zV05wubPHeIDmP4DDe5GZI+2hcEtL3erkpdwTfR93u6gGytga
         6CB22SY6ym4M311jI8aDZTfq3TWnh6LXjNyVPNQl2qn9GIyAAnuhFGUlTCakq7f0H4
         TXDtPtj/MYRYg==
Received: by pali.im (Postfix)
        id 5094A834; Wed, 31 Aug 2022 00:55:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: turris1x.dts: Fix NOR partitions labels
Date:   Wed, 31 Aug 2022 00:55:00 +0200
Message-Id: <20220830225500.8856-1-pali@kernel.org>
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

Partition partition@20000 contains generic kernel image and it does not
have to be used only for rescue purposes. Partition partition@1c0000
contains bootable rescue system and partition partition@340000 contains
factory image/data for restoring to NAND. So change partition labels to
better fit their purpose by removing possible misleading substring "rootfs"
from these labels.

Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index b7635f0b87a9..64c0dd733e40 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -263,21 +263,21 @@
 				};
 
 				partition@20000 {
-					/* 1.7 MB for Rescue Linux Kernel Image */
+					/* 1.7 MB for Linux Kernel Image */
 					reg = <0x00020000 0x001a0000>;
-					label = "rescue-kernel";
+					label = "kernel";
 				};
 
 				partition@1c0000 {
 					/* 1.5 MB for Rescue JFFS2 Root File System */
 					reg = <0x001c0000 0x00180000>;
-					label = "rescue-rootfs";
+					label = "rescue";
 				};
 
 				partition@340000 {
-					/* 11 MB for TAR.XZ Backup with content of NAND Root File System */
+					/* 11 MB for TAR.XZ Archive with Factory content of NAND Root File System */
 					reg = <0x00340000 0x00b00000>;
-					label = "backup-rootfs";
+					label = "factory";
 				};
 
 				partition@e40000 {
-- 
2.20.1

