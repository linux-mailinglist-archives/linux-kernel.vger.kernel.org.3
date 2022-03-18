Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148814DDBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiCRObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiCRObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:31:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F55DE55
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bx5so7537158pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p16mVRwfAs4lOC/jhpdduor9Cpu9c9v3C71RdCE1eKU=;
        b=k2UBtOMTP5XnazjZlWUlQAkBTrclhFjgpu6Vn/6fC4rZIygIgiqhuzR2tVVQH9IxHY
         5/MeBbTVOEBy8HQw3QWQ9Hy8yjCJzPAO+Slf8ZYit9ppQutXpc0WiK7QcYqfUFzBUgaI
         9ZMn8G6rPEj3ilRFdhDI7uCT/rAX7i3K1+XLcQ9capSr7Kwo1/43480eAaroz/hUVbci
         Tn3WS23QreUG2SZO7DGzP5WEkkxvlv9GaiWMi3pNEi91FNgyALnje0STgu/sv9v8H+an
         iC3Gcn6tXUvgTeTORHegDDbEZwi8F+gEsDR3GJ+aBlcLyMWRLk10JyyVhy08B09NZkF1
         BQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p16mVRwfAs4lOC/jhpdduor9Cpu9c9v3C71RdCE1eKU=;
        b=jQR/0dr7dz0gUINpXFHJoJUfWqZ7+ENULIjUBbOstuHFpf+3xP0zO3E9L3nXClLfj2
         6GFWcd9QUeM7EDvyewBGQjq0FmjJeO8QlfSccEPxsoOw5gxbayegzrRhis4HzJiS6d9X
         c0DfkmQlXNDBMOfpWL86xRYBv/KWNAkauOMsq+oUhULo+7sV2Pb4EL7NcQMDngeIwAVq
         n7nCFMaZEPVaYgmE/3X8T4kj71zoleZXOwzi+bvc5TAnQRIPbnkmYReAEFPmQejsdnom
         T/nTNo23nAJf5NbnYR8g+Ltt4IS0WdOwSELdRx6lnPic/ZRx4N/US9XKzmbSO+sEXwTV
         +W8A==
X-Gm-Message-State: AOAM531HyukQGeDXhVP/UYVHjpi8oZeAvp2kQCR0FGuBRekWNRqL0pf6
        xYDqVvhQSB/SWKVSmSI3BCQkBTq5MQw=
X-Google-Smtp-Source: ABdhPJyrKXLLP4SUQc0RG8A6ybc/o7QcU+F9ALNyMcXTy9LLeuHTseNT4hg5cloDQXs885RIuUgoxQ==
X-Received: by 2002:a17:902:d2cc:b0:152:fda8:f3ff with SMTP id n12-20020a170902d2cc00b00152fda8f3ffmr10465772plc.92.1647613810403;
        Fri, 18 Mar 2022 07:30:10 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm9982929pfh.83.2022.03.18.07.30.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:30:10 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 5/7] x86/entry: Don't call error_entry for XENPV
Date:   Fri, 18 Mar 2022 22:30:14 +0800
Message-Id: <20220318143016.124387-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220318143016.124387-1-jiangshanlai@gmail.com>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
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

When in XENPV, it is already in the task stack, and it can't fault
for native_iret() nor native_load_gs_index() since XENPV uses its own
pvops for iret and load_gs_index().  And it doesn't need to switch CR3.
So there is no reason to call error_entry() in XENPV.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8121b9f3fceb..e9fe9f00d17c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
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

