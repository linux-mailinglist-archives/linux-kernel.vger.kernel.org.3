Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1A467169
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbhLCFWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:22:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33296 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbhLCFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:22:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE25662936
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D838CC53FAD;
        Fri,  3 Dec 2021 05:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508756;
        bh=Pwe0wYHKG5lxvAb6z5/hTI+22/H72lsdHUeOXryUv9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQwA+lKlGMNL5+ZkG7fJpteCU1piW7MSKcUDcDOMfJURL53112HoSUivtVDIQCJiP
         VWXAID0dxXH0vkl/fKdMXC64Li71glf4sdbelM1ePF123whpN3CxzO5sQ19+Y2vxbB
         iAXdJyYE82EhSthCH4WnMQkVD7Od2ZIGSNPAk42hZEYNLF4liT7QVFHzu4SIEdBw5P
         j8oAiWpE/h62SA+diLe3gNQWcfrkXTuleSNcGg2+QZQe/TpT34DSvQgL9YZwJys8Dk
         4wiirN0zV2EkksxpTmadF5ewDJt/IlWbtu9HiilkY3W+c5OBXHQuZj7jKeZ9Tvvvx2
         KeKEISnvy75Kg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: [RFC PATCH 1/5] kexec: make crashk_res, crashk_low_res and crash_notes symbols always visible
Date:   Fri,  3 Dec 2021 13:11:53 +0800
Message-Id: <20211203051157.2160-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203051157.2160-1-jszhang@kernel.org>
References: <20211203051157.2160-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the forward declarations of crashk_res, crashk_low_res and
crash_notes always visible. Code referring to these symbols can then
just check for IS_ENABLED(CONFIG_KEXEC_CORE), instead of requiring
conditional compilation using an #ifdef, thus preparing to increase
compile coverage and simplify the code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 include/linux/kexec.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..58d1b58a971e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -20,6 +20,12 @@
 
 #include <uapi/linux/kexec.h>
 
+/* Location of a reserved region to hold the crash kernel.
+ */
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+extern note_buf_t __percpu *crash_notes;
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -350,12 +356,6 @@ extern int kexec_load_disabled;
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS)
 
-/* Location of a reserved region to hold the crash kernel.
- */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
-extern note_buf_t __percpu *crash_notes;
-
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
 
-- 
2.34.1

