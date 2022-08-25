Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0795A0ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiHYHzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHYHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:55:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D495FCB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:54:53 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B91A71EC05DE;
        Thu, 25 Aug 2022 09:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661414091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=UGRq4akNUG59xkhRh7o3k1+G/F+GgEUlb+NCJhtY/0U=;
        b=qPZKoaJpGAb3SYeJlG33++UcEWLxXSSE2I21kPG8ShV3V7lT2yPEIowEA5iYXwSNmMFMFX
        OaEQsDpI+u6g6LzSTbPIyO/Q0A3s3TxqmjsaPXfRPYnpYUiza1ZmjCtsI2oTWKvipFJv74
        UaJwq+2ZZvLzrUSYG/DBkdSeA3IFON8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: Remove ->request_microcode_user()
Date:   Thu, 25 Aug 2022 09:54:45 +0200
Message-Id: <20220825075445.28171-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

  181b6f40e9ea ("x86/microcode: Rip out the OLD_INTERFACE")

removed the old microcode loading interface but forgot to remove the
related ->request_microcode_user() functionality which it uses.

Rip it out now too.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/microcode.h      |  3 ---
 arch/x86/kernel/cpu/microcode/amd.c   |  7 -------
 arch/x86/kernel/cpu/microcode/intel.c | 17 -----------------
 3 files changed, 27 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 0c3d3440fe27..7f7800e15ed0 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -32,9 +32,6 @@ enum ucode_state {
 };
 
 struct microcode_ops {
-	enum ucode_state (*request_microcode_user) (int cpu,
-				const void __user *buf, size_t size);
-
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
 						  bool refresh_fw);
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8b2fcdfa6d31..5f38dd75cbc5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -924,12 +924,6 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	return ret;
 }
 
-static enum ucode_state
-request_microcode_user(int cpu, const void __user *buf, size_t size)
-{
-	return UCODE_ERROR;
-}
-
 static void microcode_fini_cpu_amd(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -938,7 +932,6 @@ static void microcode_fini_cpu_amd(int cpu)
 }
 
 static struct microcode_ops microcode_amd_ops = {
-	.request_microcode_user           = request_microcode_user,
 	.request_microcode_fw             = request_microcode_amd,
 	.collect_cpu_info                 = collect_cpu_info_amd,
 	.apply_microcode                  = apply_microcode_amd,
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 025c8f0cd948..1fcbd671f1df 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -916,24 +916,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	return ret;
 }
 
-static enum ucode_state
-request_microcode_user(int cpu, const void __user *buf, size_t size)
-{
-	struct iov_iter iter;
-	struct iovec iov;
-
-	if (is_blacklisted(cpu))
-		return UCODE_NFOUND;
-
-	iov.iov_base = (void __user *)buf;
-	iov.iov_len = size;
-	iov_iter_init(&iter, WRITE, &iov, 1, size);
-
-	return generic_load_microcode(cpu, &iter);
-}
-
 static struct microcode_ops microcode_intel_ops = {
-	.request_microcode_user		  = request_microcode_user,
 	.request_microcode_fw             = request_microcode_fw,
 	.collect_cpu_info                 = collect_cpu_info,
 	.apply_microcode                  = apply_microcode_intel,
-- 
2.35.1

