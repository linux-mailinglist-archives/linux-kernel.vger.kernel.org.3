Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E455A2580
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbiHZKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbiHZKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:06:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB4D5DCB;
        Fri, 26 Aug 2022 03:05:19 -0700 (PDT)
Date:   Fri, 26 Aug 2022 10:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661508318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Vkeal0AztGkEtbXmbLzaghy0nAXJByD5CEpU8ihtJ4=;
        b=qDToFtGfrV8hGKn+rPvW46yzDCBp/UIG4Sfn9CB3wTr04CDOPK/Cptb7OS12pVLbmse951
        I7iVfHCsabc2Dpv4Q+LM+dSEi+NR9HL80HkB12e7cRf0qVP7wO3xevzLC5nSfjU5CMz934
        LldgKD9Z/jC57BluDRRmtuRYVkTFtiTVSs4FuFh8JjhPlyeJzHla4vEY73aCEL+PMNQbTs
        tm478/grsHV3bk7pBRaYba5ZKkK3vloT3GdQivD9k7eNPwvObTsYC64Ie+wqyDoF9qkqWk
        9Ty3JnxULZZ7lZ0pyte9MNcqNIsYvNLJK4F/Fgg7Hx5Ci9QDB6hO8pQIgCEPYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661508318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Vkeal0AztGkEtbXmbLzaghy0nAXJByD5CEpU8ihtJ4=;
        b=GiZk9SLqbMVE7CYdUn6FDdfknqsba/kC6BqI89ixbgY6J2DWiJxCz2RL0WlBGzrbVAP6M8
        GggUugkaQNGs/TBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Remove ->request_microcode_user()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825075445.28171-1-bp@alien8.de>
References: <20220825075445.28171-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166150831648.401.9089001181596106367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     8c61eafd22d7207039bff85c6e1d386f15abd17e
Gitweb:        https://git.kernel.org/tip/8c61eafd22d7207039bff85c6e1d386f15abd17e
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 25 Aug 2022 09:51:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 26 Aug 2022 11:56:08 +02:00

x86/microcode: Remove ->request_microcode_user()

  181b6f40e9ea ("x86/microcode: Rip out the OLD_INTERFACE")

removed the old microcode loading interface but forgot to remove the
related ->request_microcode_user() functionality which it uses.

Rip it out now too.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220825075445.28171-1-bp@alien8.de
---
 arch/x86/include/asm/microcode.h      |  3 ---
 arch/x86/kernel/cpu/microcode/amd.c   |  7 -------
 arch/x86/kernel/cpu/microcode/intel.c | 17 -----------------
 3 files changed, 27 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 0c3d344..7f7800e 100644
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
index 8b2fcdf..5f38dd7 100644
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
index 025c8f0..1fcbd67 100644
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
