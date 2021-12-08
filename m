Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F646D1AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhLHLNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhLHLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:13:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13852C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:09:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x5so2233607pfr.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZAl8F0tOkzqNpxvhUmIBbQ/2XyCnM6LrThKg9k5W8s=;
        b=XewnByTcwGZ5HuWSJOktdkA8rXnpKBKFuSg0cxOJL7s3BdUvTPdODuZfLIDeepUm4V
         +UFNS5kKkZ64h2+SLoku6yR1tR/0A+eaTTMV6wH4OAgYBCykpmcbSC84xrwGT8DK5z6I
         NAwcRUWRE5xi4yleywYOHQ3Z+PAuijS3/ucoUSnX0O8roEEkMd3TMCNQi4/Nee7ynLP8
         YtGzd5gKmnV6H5WeuB2jtnHcA/FdVci05P8W9WFHdMj60WaDi0E67yIn6k7XYkXd2N/Q
         Pkh/hb3+/neA+1fwV3CX98BZZHeeXZYXum/i4O8YUwzfbt+j8AeThm8SubonZeZuOnPu
         cX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZAl8F0tOkzqNpxvhUmIBbQ/2XyCnM6LrThKg9k5W8s=;
        b=OKBx8GZpwbq+wBmfMlUbkLDB9GNGHHUkER78ymqG6P5zJEOcsTQnpoWbwkyZucRRt/
         lG3b46RoAxpoySkKu7JHaUdql8osnyVHwdIT0cvb0wfloDgFOI8dNzsSVY812aODWM5w
         YI1YTgvKLFU4XOA5YIOnplCIn+JNl3aVnBXNxeFRNQqusZO+xwaCXLsv7khPkATwFTka
         xjMa+9RCl0dHozrnYNs6kO4HEbPYV71SvaS9GyuPKTpEBfe6Zxxfe9S+K22S8F18wIwS
         LCosLZ/M+OuzJA1lSK0qe+0g6u4ygZhk7WHjJNdZ+wgOorNh5undPT6flfeG/YQ8LGs3
         BB5Q==
X-Gm-Message-State: AOAM533sPPVxvw9vNUg6Y7V89tDIDOgZT2MkAVdOfuwjGb2Unqh+PTbh
        VG9kGCrP+PozSm90FrOi+wfdATm8les=
X-Google-Smtp-Source: ABdhPJw1j8OimGYb+Vk6xtTFU75lvQF/n3cAmCvhA4Lo654aq4frrTPh1GDeEbLLUScPSozJ7D8kIA==
X-Received: by 2002:a65:6a0b:: with SMTP id m11mr28632692pgu.372.1638961772554;
        Wed, 08 Dec 2021 03:09:32 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u12sm3355395pfk.71.2021.12.08.03.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:09:32 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 11/11] x86/entry: Remove the branch in sync_regs()
Date:   Wed,  8 Dec 2021 19:08:33 +0800
Message-Id: <20211208110833.65366-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In non-xenpv, the sp0 is the trampoline stack, and sync_regs() is
called on non-xenpv only since error_entry is not called on xenpv, so
the stack must be the trampoline stack or one of the IST stack and the
check in sync_regs() is unneeded.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/traps.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a6c0bc9ee36f..63cdb7aedd67 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -708,13 +708,15 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 /*
  * Help handler running on a per-cpu (IST or entry trampoline) stack
  * to switch to the normal thread stack if the interrupted code was in
- * user mode. The actual stack switch is done in entry_64.S
+ * user mode.  The actual stack switch is done in entry_64.S.  It is not
+ * called from XENPV and the caller has ensured it is not on the thread
+ * stack.
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
 	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
-	if (regs != eregs)
-		*regs = *eregs;
+
+	*regs = *eregs;
 	return regs;
 }
 
-- 
2.19.1.6.gb485710b

