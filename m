Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A961B46423A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhK3X0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbhK3X0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:26:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38FC061574;
        Tue, 30 Nov 2021 15:22:41 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638314559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8iMH2Ed8C2uouwXugRDlsoZFisgLCua+SBbCFNPpYs=;
        b=2RWUod4yzv7on4mZFoMvC5lxBKojWFH9UHU22Z5kmkLCChi0+oFgtui2ZB0TjMjj8pNG2Z
        eLPpUSxeP9wefDNbpHTmsl/hOkGLssR9/5iZvXEUJziQgbYH0wq4bY/NHpeAjazHBK3ueI
        9NtI7YJ/dSYC5zus7B09sTj3bpdBlNbKiQLa4YWYcLP84jV/XXlcjBX2T8VZczHjyWrPTU
        WDu5igx0FmdpGbi1EJXAUknZ50sZYy2RMMixD9f+LhKMtIed64sonmBDJy1YATDhcGjPb5
        fxRcXBoHONVeh8Fl6YE4BtKWWRdLIqhM9skMqmITxPjwNYwPLxcc1mq3A5Ngag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638314559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8iMH2Ed8C2uouwXugRDlsoZFisgLCua+SBbCFNPpYs=;
        b=/XDEIHdHmT9AC5SL+wt25TH7OL6fTvIBI4oBmrIwZplFi9mhnH8dtCZeVk+XUiRaaN9Fdv
        Jn1hwYnryvzrdHAg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/signal: Initialize sw_bytes in save_xstate_epilog()
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126124746.761278-1-glider@google.com>
References: <20211126124746.761278-1-glider@google.com>
MIME-Version: 1.0
Message-ID: <163831455793.11128.4485814974540705191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     52d0b8b18776f184c53632c5e0068201491cdb61
Gitweb:        https://git.kernel.org/tip/52d0b8b18776f184c53632c5e0068201491cdb61
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 26 Nov 2021 13:47:46 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 15:13:47 -08:00

x86/fpu/signal: Initialize sw_bytes in save_xstate_epilog()

save_sw_bytes() did not fully initialize sw_bytes, which caused KMSAN
to report an infoleak (see below).
Initialize sw_bytes explicitly to avoid this.

KMSAN report follows:

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user ./include/linux/instrumented.h:121
BUG: KMSAN: kernel-infoleak in __copy_to_user ./include/linux/uaccess.h:154
BUG: KMSAN: kernel-infoleak in save_xstate_epilog+0x2df/0x510 arch/x86/kernel/fpu/signal.c:127
 instrument_copy_to_user ./include/linux/instrumented.h:121
 __copy_to_user ./include/linux/uaccess.h:154
 save_xstate_epilog+0x2df/0x510 arch/x86/kernel/fpu/signal.c:127
 copy_fpstate_to_sigframe+0x861/0xb60 arch/x86/kernel/fpu/signal.c:245
 get_sigframe+0x656/0x7e0 arch/x86/kernel/signal.c:296
 __setup_rt_frame+0x14d/0x2a60 arch/x86/kernel/signal.c:471
 setup_rt_frame arch/x86/kernel/signal.c:781
 handle_signal arch/x86/kernel/signal.c:825
 arch_do_signal_or_restart+0x417/0xdd0 arch/x86/kernel/signal.c:870
 handle_signal_work kernel/entry/common.c:149
 exit_to_user_mode_loop+0x1f6/0x490 kernel/entry/common.c:173
 exit_to_user_mode_prepare kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290
 syscall_exit_to_user_mode+0x7e/0xc0 kernel/entry/common.c:302
 do_syscall_64+0x60/0xd0 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x44/0xae ??:?

Local variable sw_bytes created at:
 save_xstate_epilog+0x80/0x510 arch/x86/kernel/fpu/signal.c:121
 copy_fpstate_to_sigframe+0x861/0xb60 arch/x86/kernel/fpu/signal.c:245

Bytes 20-47 of 48 are uninitialized
Memory access of size 48 starts at ffff8880801d3a18
Data copied to user address 00007ffd90e2ef50
=====================================================

Link: https://lore.kernel.org/all/CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com/
Fixes: 53599b4d54b9b8dd ("x86/fpu/signal: Prepare for variable sigframe length")
Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lkml.kernel.org/r/20211126124746.761278-1-glider@google.com
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d595827..91d4b6d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -118,7 +118,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 				      struct fpstate *fpstate)
 {
 	struct xregs_state __user *x = buf;
-	struct _fpx_sw_bytes sw_bytes;
+	struct _fpx_sw_bytes sw_bytes = {};
 	u32 xfeatures;
 	int err;
 
