Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0B4681F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384077AbhLDCWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384063AbhLDCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:22:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EEC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:19:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq11so3654891pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 18:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HySgl1aazEFF/0pHlVuKtbQoUuOrWhUzXZK/cM+YaDA=;
        b=MFjgvfk/Rmqmiy1u6FdgpcYXFuJGAloSbFeEpYylnuP/xSsGCdMV4gAW2U2nl4BUlX
         +5vQi2xybslX5pGdV2EV/+etfFPdHEIx8koWwwNCYIY1vv2LgZ4+lPrqJe9An7FivsQz
         mVeDvbPNe3Q67vRCNs1W2FSOUltDbFgWCWy3BeVsBKJgvXxLnFpDRfGur822YGn/hYU7
         9Mxf6/50NCfQF73afsWzRirRzeXLpD99dA6SSNhuIIbkNVO/493pEfl1etypPyhQfxFr
         01ck/7NPwDEyPCfNDg8pydck7pwl60J7WJ1Wc4T5ganqtXutywnpiIwD884Tez61KRN3
         Y2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HySgl1aazEFF/0pHlVuKtbQoUuOrWhUzXZK/cM+YaDA=;
        b=WJEeXpLjjKF3utQd6ofoleBbVLUtcLACZvbmtrbxzLR8bgQ53xk00Zv6qnfI3lcNi1
         /GN8EORlgQss6A2+TESY1il/zDHGUbFOHU7Cds2awoCGuVFAcgKUAESo1y8wEvkaUC2p
         kH7PuYBhLWF/72MYwiaxZPCn+qO7PAZsoRhC4T+K1RST7y/WBdi6lusx6xPw0GVf95pa
         mqj0yUI6FOaJezBSB8TGSklEkzddA06i+/DIfCQp7xpYENTWSq0FQNFEUD08UOLA06B1
         uWI8TWTuMbiHHHd2w/PHu1vWsoRWLQLFrCw26qlbdWiCDo6PjJ4STCM3wwXuCmYrsY9C
         wfpA==
X-Gm-Message-State: AOAM533x2u3YKpwrYx39bQP+lPyKLSbVW+mM82vYymwVimz5/JBHx1wL
        +Mvg/AQ19tq+YemrBPvNFHqwAFBqOAT6HA==
X-Google-Smtp-Source: ABdhPJwUGVH+woQYAqfI5V4YKXxdrSDOHdd4IPtHx/Xzs5CJeMo0O9rf0JhXCmj06z5YoH98R/Ym5Q==
X-Received: by 2002:a17:90a:3b02:: with SMTP id d2mr18284888pjc.159.1638584352154;
        Fri, 03 Dec 2021 18:19:12 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 63sm4573644pfz.119.2021.12.03.18.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:19:11 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] openrisc: Add clone3 ABI wrapper
Date:   Sat,  4 Dec 2021 11:18:42 +0900
Message-Id: <20211204021842.1853549-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211204021842.1853549-1-shorne@gmail.com>
References: <20211204021842.1853549-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like fork and clone the clone3 syscall needs a wrapper to save callee
saved registers, which is required by the OpenRISC ABI.  This came up
after auditing code following a discussion with Rob Landley and Arnd
Bergmann [0].

Tested with the clone3 kselftests and there were no issues.

[0] https://lore.kernel.org/all/41206fc7-f8ce-98aa-3718-ba3e1431e320@landley.net/T/#m9c0cdb2703813b9df4da04cf6b30de1f1aa89944

Fixes: 07e83dfbe16c ("openrisc: Enable the clone3 syscall")
Cc: Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/syscalls.h | 2 ++
 arch/openrisc/kernel/entry.S         | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/openrisc/include/asm/syscalls.h b/arch/openrisc/include/asm/syscalls.h
index 3a7eeae6f56a..aa1c7e98722e 100644
--- a/arch/openrisc/include/asm/syscalls.h
+++ b/arch/openrisc/include/asm/syscalls.h
@@ -22,9 +22,11 @@ asmlinkage long sys_or1k_atomic(unsigned long type, unsigned long *v1,
 
 asmlinkage long __sys_clone(unsigned long clone_flags, unsigned long newsp,
 			void __user *parent_tid, void __user *child_tid, int tls);
+asmlinkage long __sys_clone3(struct clone_args __user *uargs, size_t size);
 asmlinkage long __sys_fork(void);
 
 #define sys_clone __sys_clone
+#define sys_clone3 __sys_clone3
 #define sys_fork __sys_fork
 
 #endif /* __ASM_OPENRISC_SYSCALLS_H */
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 8cd2113057c5..3ca1b1f490b9 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1165,6 +1165,11 @@ ENTRY(__sys_clone)
 	l.j	_fork_save_extra_regs_and_call
 	 l.ori	r29,r29,lo(sys_clone)
 
+ENTRY(__sys_clone3)
+	l.movhi	r29,hi(sys_clone3)
+	l.j	_fork_save_extra_regs_and_call
+	 l.ori	r29,r29,lo(sys_clone3)
+
 ENTRY(__sys_fork)
 	l.movhi	r29,hi(sys_fork)
 	l.j	_fork_save_extra_regs_and_call
-- 
2.31.1

