Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112AD481A86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhL3HzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:55:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL3Hy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:54:59 -0500
Date:   Thu, 30 Dec 2021 07:54:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640850898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ECLkPxFtfQEaaeiz42q1dTaFNdOsmkNiPaPnJ7W64e0=;
        b=ZalLcCUsnueuleoMAcBAURwmtWuF8BU+J0iUFAMdBhoc09p/aYONJB/krBobCfOa5y0v2e
        MBL858MQJmFqirdzICx7ELUNIBaOKjsMSxyL9tqrDqiXPqnSgx+lZp3bWGhg9aCwpfoeFm
        K03FiZY5CFfpUiF8Ej5SR+PFb/7/AgM9otfsarKnZTTOj9555UWe6YzbQTOjUzbqOyX7aH
        v8CvPTQg5OURCKaeTObGrmExZxMoAzQ02R1JP0WYg8DEaxJ23RtWD0WeNAYLnkAfKTO9/u
        4FxyuMeoFWYcrki5a1k264aeP0L2MfAcfZsBMPxJpZYfB6PYdeFAl1QNRZvCCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640850898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ECLkPxFtfQEaaeiz42q1dTaFNdOsmkNiPaPnJ7W64e0=;
        b=9F1j9RzMuLZwedxeaqdVRx43ximXkyC0m+4A3r6bSMj38By6URqFt1fdIHBA1l5mONTVen
        ddLxIjSI2YhLmsDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/defconfig: Enable CONFIG_LOCALVERSION_AUTO=y in
 the defconfig
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <164085089696.16921.141923588862661030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     ff936357b49681cf823ca82a565dbdd0fd439819
Gitweb:        https://git.kernel.org/tip/ff936357b49681cf823ca82a565dbdd0fd439819
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 30 Dec 2021 08:25:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Dec 2021 08:37:54 +01:00

x86/defconfig: Enable CONFIG_LOCALVERSION_AUTO=y in the defconfig

With CONFIG_LOCALVERSION_AUTO=y enabled, 'uname' provides
much more useful output on debug kernels:

 Before:

   # CONFIG_LOCALVERSION_AUTO is not set

   $ uname -a
   Linux localhost 5.16.0-rc7+ #4563 SMP PREEMPT Thu Dec 30 08:28:38 CET 2021 x86_64 GNU/Linux

 After:

   # CONFIG_LOCALVERSION_AUTO=y

   $ uname -a
   Linux localhost 5.16.0-rc7-02294-g5537f9709b16 #4562 SMP PREEMPT Thu Dec 30 08:27:17 CET 2021 x86_64 GNU/Linux

This is particularly valuable during bisection, if we want to double check
the exact kernel version we are testing.

(Just remove the config line, the global Kconfig default for this is default-y.)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig   | 1 -
 arch/x86/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index e818853..5d97a2d 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e8a7a0a..30ab3e5 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
