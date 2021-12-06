Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0232A46A0DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359599AbhLFQQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:16:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50140 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbhLFQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:16:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57556CE16C4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B956C341C5;
        Mon,  6 Dec 2021 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638807153;
        bh=Pwe0wYHKG5lxvAb6z5/hTI+22/H72lsdHUeOXryUv9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTthzCPNXZsIEG0DB5CS9wiZM+kKPI1cgbZDwA9kKTHfyUBjdHKrDbAEmobT7ni5a
         xTnX6fk/MLonIW5znbVYv62epkKB55ZMZNvFFyi6kSxZr0I7Xytz3hjl4MtU6Xbyvp
         xxtrwjuSuqwMs8EyXxLd60XZuGfwz1naw9L5M7eYhlz5H8xnwfjZ0iFOHYwJUuqnyb
         +VzDdARPnLckFenOQOuw+/RKJMof/D1wBE3OTD3aHgwO56dUQV4QwMTzx2XBVPwUv6
         5L4nOMXBFT7QXKqK5WeBs1KEX4dCrxLYmkprqqk4aq5+OpMvF1mYasqr/ua1YA6pbK
         RRj8yZHjFUZ3Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: [PATCH v2 1/5] kexec: make crashk_res, crashk_low_res and crash_notes symbols always visible
Date:   Tue,  7 Dec 2021 00:05:10 +0800
Message-Id: <20211206160514.2000-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
References: <20211206160514.2000-1-jszhang@kernel.org>
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

