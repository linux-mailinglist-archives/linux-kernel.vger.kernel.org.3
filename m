Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F350517C31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiECDYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiECDYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E03B283
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:21:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so13970935plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgGgMxYprzA3l/xL3EqCp11c0RZBUqA2IVp2y5zwqwA=;
        b=S+Zz45MWXks4nx4ynNsiBuY3M56T6z4EiXW0WpmvNvAkBcDnPi8B/Nxm2oX3Z21Nlh
         o9DHs790/56cgU/3G6nNFMfyqo94VMk0tay8JMcYI3+N971ZUh3amcaL689ltG6XmDuY
         IK2GaVJXyrqdi7LJ+/F3TB5iEgSQiq7w5IUtDss4ocWgJxoLIwITm2xPzG8440Bo0dDT
         yBXkbyKCNdx8kCSIqKduqeO3rZB/PqYVuTCEx5wvgUwqMP5HX6nW8rFauA1sRdEDHGQ7
         oPQPH2ApTrqLUkj+keH1EdMrx4W7pEAFHOyQzYwcTHI8fptOHu6Ny+CLiOemC2rKRET6
         KkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgGgMxYprzA3l/xL3EqCp11c0RZBUqA2IVp2y5zwqwA=;
        b=BJnx5WT/kNBZ4FR7nLW7S7t3v/fsXQ/AMF9/nh7DfG5dNXBfe8yvSUbW4uGchtRBWZ
         p9UAvK/B7oseieUVEOvum3ZxPKu1mgclD2CZHB2jstnHpRuC8MmYe56/xoDJe6ZxJAL2
         z3pwTZDeJtryZVL8WH6hBTlQwG8KiqHgdif86nMCHiWRmaZy0B8tEuJ8cSeOQciCEkuZ
         PiaOMr9Tg9P6F+6+29P1BVWsyVJ/h6CbonbVXVB5koYfaB4y69lb7SgFFl9tIXDImpFu
         T1Wjr1zZcaZsNNDSDsX6UQMt/obKhI7JEbVIvpx82geDqhZEVM81u6MTO7DHJy+u/Srz
         ofmA==
X-Gm-Message-State: AOAM530wUoIWTo7CHeJRH0oFjtG3DU5iYYa9/0MLDwnwK6POkGsqmVnf
        4YtnnrYO8FXE2VlRR+qrjOcNrEz4nGo=
X-Google-Smtp-Source: ABdhPJzCceSsy+gBasYlsMUGbi/7N68x5v0EIJSpy2AZTAAtMRoJOfWLebTQyavueQvCLGEv1Mc4Xw==
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id b12-20020a17090a488c00b001c7b62e8e8cmr2477589pjh.157.1651548064578;
        Mon, 02 May 2022 20:21:04 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a17-20020a631a51000000b003c14af5060fsm11896873pgm.39.2022.05.02.20.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:21:04 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V7 5/6] x86/entry: Don't call error_entry() for XENPV
Date:   Tue,  3 May 2022 11:21:06 +0800
Message-Id: <20220503032107.680190-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220503032107.680190-1-jiangshanlai@gmail.com>
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When in XENPV, it is already in the task stack, and it can't fault for
native_iret() nor native_load_gs_index() since XENPV uses its own pvops
for IRET and load_gs_index().  And it doesn't need to switch the CR3.

So there is no reason to call error_entry() in XENPV.

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ab6ab6d3dab5..062aa9d95961 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -336,8 +336,17 @@ SYM_CODE_END(push_and_clear_regs)
 	call push_and_clear_regs
 	UNWIND_HINT_REGS
 
-	call	error_entry
-	movq	%rax, %rsp			/* switch to the task stack if from userspace */
+	/*
+	 * Call error_entry() and switch to the task stack if from userspace.
+	 *
+	 * When in XENPV, it is already in the task stack, and it can't fault
+	 * for native_iret() nor native_load_gs_index() since XENPV uses its
+	 * own pvops for IRET and load_gs_index().  And it doesn't need to
+	 * switch the CR3.  So it can skip invoking error_entry().
+	 */
+	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+		"", X86_FEATURE_XENPV
+
 	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
-- 
2.19.1.6.gb485710b

