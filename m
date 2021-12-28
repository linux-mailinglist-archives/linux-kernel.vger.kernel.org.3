Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01560480A22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhL1Oke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:40:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52290 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhL1Okd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:40:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6313EB8117D;
        Tue, 28 Dec 2021 14:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEABC36AE7;
        Tue, 28 Dec 2021 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640702430;
        bh=3byrm+yGxeKMJ9kNoapVVFJejVfsvroXVI00JX6Y684=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwKk5m2/mZUm+Bsf/+Fyq2v5OH3XgZW4Q2TKi6sy6PSQ/w0bAXqCo8NONWGZmcTJy
         BJssa4oCWgmmKeyUu7kX2JUXK38a8bre/c87Xfj/9ceJv/NcqRq+PJ4N70yty6LcDq
         y/OGDGHXvhc0Md2fFstFbtKsmS4bW4M3/wHrQnZ7YuS8o+T3JN/legZ+tl0EqGUFro
         Iu627DO+21OiKutZrMzZvJrt+/Fwj17vv33ogwOiEYvkKyMyqRVBl8Z7Ygyb8adhAe
         Tm5S8S4HOTMdYl9PtraKaDMsOITAsSKWjzW9D53BxB/ysL5Bv/6nR887OEFY2OZFOp
         mlX38KEoDgDWA==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 03/17] asm-generic: fcntl: compat: Remove duplicate definitions
Date:   Tue, 28 Dec 2021 22:39:44 +0800
Message-Id: <20211228143958.3409187-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228143958.3409187-1-guoren@kernel.org>
References: <20211228143958.3409187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove duplicate F_GETLK64,F_SETLK64,F_SETLKW64 definitions in
arch/*/include/asm/compat.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h   | 4 ----
 arch/powerpc/include/asm/compat.h | 4 ----
 arch/s390/include/asm/compat.h    | 4 ----
 arch/sparc/include/asm/compat.h   | 4 ----
 arch/x86/include/asm/compat.h     | 4 ----
 include/uapi/asm-generic/fcntl.h  | 2 +-
 6 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index eaa6ca062d89..276328765408 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -73,10 +73,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 7afc96fb6524..83d8f70779cb 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -52,10 +52,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index cdc7ae72529d..0f14b3188b1b 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -110,10 +110,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64       12
-#define F_SETLK64       13
-#define F_SETLKW64      14    
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index bd949fcf9d63..108078751bb5 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -84,10 +84,6 @@ struct compat_flock {
 	short		__unused;
 };
 
-#define F_GETLK64	12
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 7516e4199b3c..8d19a212f4f2 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -58,10 +58,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 /*
  * IA32 uses 4 byte alignment for 64 bit quantities,
  * so we need to pack this structure.
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index ecd0f5bdfc1d..5bc1e51d73b1 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -116,7 +116,7 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-#ifndef CONFIG_64BIT
+#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
-- 
2.25.1

