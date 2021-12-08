Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2E46D1AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhLHLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhLHLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14263C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:09:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q17so1288469plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WphTuTVslZby+oDEm50XCSesh2uHM5bzyfp9NXbgOWI=;
        b=htwdJLPu0gbuBqzNfz7sUj3efCTwW2LVgoh7ceQ0BMbkeYhPhXwXqOasG0Bd8RJnve
         XAAXE8iaSVBK6I6+t8twEOP/RHaK4mAkcL91G9J2LxApElT1FlYqrg1s/Gg2QuqLEqAt
         Xp4KqW62Iq1m5547lpOp1SrpBcM3mYOrFm91iX6Fb7OiOY1ScjdTivEC2Oy/lIyYlKLm
         gZAsMcM2ZGf8cfQoKLV6309j6vQq+DLsm0OVA24wlnmsN4Ki2w52UEmZGesy0mkRCwlx
         D6oBpssBTUieU9+0PWVIpucZ1qx6OzKjivCUNTWYSj2ChMJ0rvHeSI5cVlCD5IXjw/IB
         1w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WphTuTVslZby+oDEm50XCSesh2uHM5bzyfp9NXbgOWI=;
        b=NGHhSIEo8N8V6pnZ3XnIrDcQ8JyNVHQsTgsUhXJdbVwj4jiZ1iMowNVstcLY4wWg72
         yFukkQOWCxJUtojlJ8VyCYNN53b/6CZ5sa+0qE7ShTSEYhmk5A3NVrTte1CPk41lP3SD
         +I/qmAN/t1ItuAYyNzpWy9SI3L38Ax9hPoPT1FZsKJfPazI7Gnc6WV2f/ukeImqouw1W
         XjlsVX0qMC6CH4FKn983DrW3dhQ4N8DfSuANgEcEBz4oKVCcvcqYdavdm0qv9vxRDdV8
         fs4pfAm6mj2T+OH653BO3JM9fDYajG6J+JAW+lv0wYJSxTg4OP0fsXlSSODj56LZvUzS
         gFIw==
X-Gm-Message-State: AOAM532eiSQNZiSo5pKipZlvjBwKHSxibkbk+q4uWrKDm6eCCdASDOIb
        e6OaOUOM+H2OvGmA8MLZ/B08aiRxfM8=
X-Google-Smtp-Source: ABdhPJygiu3o+VoYWbdot6ZOwAuTCklCWFi5NzkjvztY5lMtfZYeyM7huQwfqLtMKHLX/ykwc3TFVw==
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr6446123pjb.238.1638961759479;
        Wed, 08 Dec 2021 03:09:19 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id s15sm2665417pjs.51.2021.12.08.03.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:09:19 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 09/11] x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
Date:   Wed,  8 Dec 2021 19:08:31 +0800
Message-Id: <20211208110833.65366-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV has its own entry point for SYSENTER, it doesn't use
entry_SYSENTER_compat.  So the pv-awared SWAPGS can be changed to
swapgs.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64_compat.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index a4fcea0cab14..72e017c3941f 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,7 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-- 
2.19.1.6.gb485710b

