Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94246D19E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhLHLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhLHLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B4C061A72
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:08:59 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r130so2189162pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTzYOcv7GXMsuudeRCCVKvQE4p4RTznbhZKVu0xYKUU=;
        b=km30WDN3p/x6O1LN4IM4fy77QF1NVRUPK5sP06Gal6+QGtjqpUUYFI0ArnBEImqtBx
         AuUANxaE5TNvqfzwlIxrjFaBsxfD6p1eT/U6KemlwxP4SBJRnkOXwocKlRobPiXwphiK
         nnKNx8a17oUYe1aBF9xVYjEfT0JHyVlsyWpuNHWRttKft7eHMogyjA4hHEpDixYozui/
         Yp9HWHVmMbUx0pUgEzC7X+43ukc3qPqWPrcwKNA92/m1IkWkKcYC2169qQXVTznVDh9C
         8FdQ3N0QnfLfiyMM1qnRw3/LhI95W2mPf5Ae8J85boc7Vk+qIFVR2qqDY1HLZcu21xTg
         Tx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTzYOcv7GXMsuudeRCCVKvQE4p4RTznbhZKVu0xYKUU=;
        b=rk51IO8Z2pFsBJOZLXmcVFC8a57RB3cRfZa2SI6WsMsg2WmcPL+0JVaNmZ1zGc8NLp
         GdrI/oPD7D8OCgjfdrck/x4Tx/VYKmKBdO1twosKy7DfNK7xf8jhUm7ZvNSed6jEg11R
         uLrHCPvpAWGj6rHSGoYJRuUGfJXvTQxv73jgdjE93USAlG+x4mCFnvDMAMSw4Uo2qe+z
         9eVFe0YGnI7nXD3h6tg6pkj/fkFbpQDjOal0IB/+ff5qsE1cAlMVlFUhWzLUNwsR7OlQ
         Wp0WuodVosiek0whQIUvik+6PBMWB6AyE2iBIqVGoUl2GX/U1VycFkLpw3FIQMCF4KmS
         qj9A==
X-Gm-Message-State: AOAM533wl+Tb82663nCre/EVHuAxNpTYjjD+XHKg/0iKUeS+OuW+k1Dv
        zN0+GRS3ANTeEEbkf7VTYGYk+s5dd7o=
X-Google-Smtp-Source: ABdhPJyG8RspzExM0YLJHIGBovB6b/ZNv9oPLLxl7bIY/uiUpBpyPdvWlt/3qAb05wwKy/zxp0w/Lw==
X-Received: by 2002:a05:6a00:ad0:b0:4a3:1056:e2ae with SMTP id c16-20020a056a000ad000b004a31056e2aemr4931125pfl.2.1638961739024;
        Wed, 08 Dec 2021 03:08:59 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id gc22sm5791712pjb.57.2021.12.08.03.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:08:58 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 06/11] x86/entry: Don't call error_entry for XENPV
Date:   Wed,  8 Dec 2021 19:08:28 +0800
Message-Id: <20211208110833.65366-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When in XENPV, it is already in the task stack, and it can't fault
for native_iret() nor native_load_gs_index() since XENPV uses its own
pvops for iret and load_gs_index().  And it doesn't need to switch CR3.
So there is no reason to call error_entry() in XENPV.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ee1d4adcdab0..383070aa9272 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -325,8 +325,17 @@ SYM_CODE_END(ret_from_fork)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	call	error_entry
-	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	/*
+	 * Call error_entry and switch stack settled by sync_regs().
+	 *
+	 * When in XENPV, it is already in the task stack, and it can't fault
+	 * for native_iret() nor native_load_gs_index() since XENPV uses its
+	 * own pvops for iret and load_gs_index().  And it doesn't need to
+	 * switch CR3.  So it can skip invoking error_entry().
+	 */
+	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+		"", X86_FEATURE_XENPV
+
 	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
-- 
2.19.1.6.gb485710b

