Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B241C4CB9A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiCCIyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCCIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:54:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D7ECB09;
        Thu,  3 Mar 2022 00:53:33 -0800 (PST)
Date:   Thu, 03 Mar 2022 08:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646297612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2TAbRctTTqetHFgNZ/dxnfVR4kDZIM4+M3pCcy2QaFg=;
        b=m3BT+TLFmEv1pW2C11HREPkDQ27h8ffgq2q6j5iQOHCTumGGbqlQbsZQtNXFc66MNFVnDH
        SwGnV69zJV41zrEJ79/uMZwwjc24Z2+lzqoVac6jCAWglKbltuKXgJRxHvSV88ZIUDVNBj
        kCTm/rT66m5vQSmcP9r6cUrnANa3T5wYA1VRW6SCalnqBb5vj+LmcOGBsM8XbQ3j3j3EFW
        fdG9/gnZvyh+Wzfg0tjpQ8uHNth+uJVZglQ38x6P/Fv/kQLbCsE0xYWsqkMM9d+dJM5tJb
        thax+YQ7Aq60jIa1VHzkEmb00vTa4RN0nti+r+2RKZOFZNmeUunh0cgQpUaKKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646297612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2TAbRctTTqetHFgNZ/dxnfVR4kDZIM4+M3pCcy2QaFg=;
        b=aAlnosntwxNGXFOTFHB6T/HH6GpF9CG6ENO+Crh+O87bpPwP/DzS2lf5ASQzU0m0r2/mgW
        4ABtqzKnoL1657Dg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix the build on
 !CONFIG_PHYS_ADDR_T_64BIT
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164629761097.16921.9969025085170581381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     02a08d78f5c429c7dc8e5b9417b4efb518b3d041
Gitweb:        https://git.kernel.org/tip/02a08d78f5c429c7dc8e5b9417b4efb518b=
3d041
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 03 Mar 2022 08:57:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Mar 2022 08:58:22 +01:00

perf/x86/intel/uncore: Fix the build on !CONFIG_PHYS_ADDR_T_64BIT

'val2' is unused if !CONFIG_PHYS_ADDR_T_64BIT:

  arch/x86/events/intel/uncore_discovery.c:213:18: error: unused variable =E2=
=80=98val2=E2=80=99 [-Werror=3Dunused-variable]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_discovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index 61185d1..5fd72d4 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -210,7 +210,7 @@ static int parse_discovery_table(struct pci_dev *dev, int=
 die,
 	void __iomem *io_addr;
 	resource_size_t addr;
 	unsigned long size;
-	u32 val, val2;
+	u32 val;
 	int i;
=20
 	pci_read_config_dword(dev, bar_offset, &val);
@@ -221,6 +221,8 @@ static int parse_discovery_table(struct pci_dev *dev, int=
 die,
 	addr =3D (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) =3D=3D PCI_BASE_ADDRESS_MEM_TYPE=
_64) {
+		u32 val2;
+
 		pci_read_config_dword(dev, bar_offset + 4, &val2);
 		addr |=3D ((resource_size_t)val2) << 32;
 	}
