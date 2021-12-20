Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A147A3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 04:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhLTDDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 22:03:10 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:35166 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhLTDDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 22:03:09 -0500
X-QQ-mid: bizesmtp54t1639969379t0j5g246
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 11:02:57 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: 41KXR1NaKbO0H/MDMmDlfCm0qdxo3eLEOoQ8C7F1vC044E/M3q+AJJJPNZU6c
        LDYacxNXYg/IyAAgWVXIPkjsr+QznLng9Py0iryZAXRKsihpNAAFOuJRsgQ1FKaBo600BWV
        KjCldsMwNarRKn7Lmy6FCjb85ZHYlFLLxiICIU/zMYyCCDjyTkiIOGAbgi7DK5Gf4/levec
        wTIRcivYHm20VAJiYONP4lXdqCzA3kxSUTWLAWZXMYJ1u0S8t7jKft8nSsIIl1Z4x95yM5h
        F2X8bAGTLNMzDS8kgaP1/OtKFitYDldUe/ukvH6Ws1J7UDHSVeJ5O1TYilmKcVL3dB7lLLc
        WxGYLlz
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, wangborong@cdjrlc.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kvm: no need to initialise statics to 0
Date:   Mon, 20 Dec 2021 11:02:43 +0800
Message-Id: <20211220030243.603435-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initialization.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index c3e31fef0be1..1ae09992c9ea 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -228,7 +228,7 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 	struct kvmppc_sid_map *map;
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	u16 sid_map_mask;
-	static int backwards_map = 0;
+	static int backwards_map;
 
 	if (kvmppc_get_msr(vcpu) & MSR_PR)
 		gvsid |= VSID_PR;
-- 
2.34.1

