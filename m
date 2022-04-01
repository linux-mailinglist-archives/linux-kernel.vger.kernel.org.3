Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7A4EE934
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbiDAHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbiDAHsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:48:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D625F652
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:46:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 4FC251F47521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648799207;
        bh=UVhZOV6XJ+PfylwaNjtDwbQrX2mrJqZLJFMmEHVtovc=;
        h=From:To:Cc:Subject:Date:From;
        b=UimVplzcmG61RHhogAJ9KWXKH4pPeCRCXapcTyqXXKENkGiqe0eDnOIFShrBdL+/d
         oe36beC32Br3D3tePQlVGm4fc3ZMpA+D96PuqMQmcUQbbmqRnKEA+ZQhlbx3iKzQe/
         1gcmNFHYpKoGplgrxaMKU959OP1xIuG/LQycuA+uSGJ/1I9mDc9AhVrvpE1naOsCSv
         9VfjK+fZNQoioqn17xfiDSXscf18NXkJ51ovP7hgZwVGSTeMocupP1zkhloj48DD2s
         +An8txkG119BLmzls0RJbMpRc04fAFVeTtbY57TVKt+UpJ8mt3VbBx90LkhK72QydG
         +uZaRvVclvccA==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Borislav Petkov <bp@alien8.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: [PATCH v3] x86/speculation/srbds: do not try to turn mitigation off when not supported
Date:   Fri,  1 Apr 2022 09:45:17 +0200
Message-Id: <20220401074517.1848264-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and
write to MSR_IA32_MCU_OPT_CTRL even when that is not supported by the
microcode.

Checking for X86_FEATURE_SRBDS_CTRL as a CPU feature available makes
more sense than checking for SRBDS_MITIGATION_UCODE_NEEDED as the found
"mitigation".

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Tested-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---

Changes in v3:
  - Simplified and more explicit solution proposed by Boris

 arch/x86/kernel/cpu/bugs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..d879a6c93609 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -446,6 +446,13 @@ void update_srbds_msr(void)
 	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
 		return;
 
+	/*
+	 * A MDS_NO CPU for which SRBDS mitigation is not needed due to TSX
+	 * being disabled and it hasn't received the SRBDS MSR microcode.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
+		return;
+
 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	switch (srbds_mitigation) {
-- 
2.25.1

