Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7D565DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiGDTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiGDTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:10:15 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3331E4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:10:14 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8RSToSo9rZDzU8RSToUB9C; Mon, 04 Jul 2022 21:10:12 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 04 Jul 2022 21:10:12 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Use the bitmap API to allocate bitmaps
Date:   Mon,  4 Jul 2022 21:10:08 +0200
Message-Id: <a93d3e94be2003922c7e9652b57e96261cc47641.1656961792.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

While at it, turn a bitmap_clear() into an equivalent bitmap_zero(). It is
also less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm64/kvm/vmid.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index d78ae63d7c15..f4612cdb60ff 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -47,7 +47,7 @@ static void flush_context(void)
 	int cpu;
 	u64 vmid;
 
-	bitmap_clear(vmid_map, 0, NUM_USER_VMIDS);
+	bitmap_zero(vmid_map, NUM_USER_VMIDS);
 
 	for_each_possible_cpu(cpu) {
 		vmid = atomic64_xchg_relaxed(&per_cpu(active_vmids, cpu), 0);
@@ -182,8 +182,7 @@ int kvm_arm_vmid_alloc_init(void)
 	 */
 	WARN_ON(NUM_USER_VMIDS - 1 <= num_possible_cpus());
 	atomic64_set(&vmid_generation, VMID_FIRST_VERSION);
-	vmid_map = kcalloc(BITS_TO_LONGS(NUM_USER_VMIDS),
-			   sizeof(*vmid_map), GFP_KERNEL);
+	vmid_map = bitmap_zalloc(NUM_USER_VMIDS, GFP_KERNEL);
 	if (!vmid_map)
 		return -ENOMEM;
 
@@ -192,5 +191,5 @@ int kvm_arm_vmid_alloc_init(void)
 
 void kvm_arm_vmid_alloc_free(void)
 {
-	kfree(vmid_map);
+	bitmap_free(vmid_map);
 }
-- 
2.34.1

