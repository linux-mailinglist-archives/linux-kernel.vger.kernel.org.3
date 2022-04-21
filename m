Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E562250A1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389078AbiDUONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389020AbiDUONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:13:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BDF3B022
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q3so4991045plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgGgMxYprzA3l/xL3EqCp11c0RZBUqA2IVp2y5zwqwA=;
        b=M36LrAYWtb8/DoIhQ7z4mrZyLrYcU/P5mDTC8OcvJeJwkp5xp8E/y7f+cIJhpcGd44
         BvYLzOew7P4Py83ksLyx9FX0mCGqSP21YfUc2Xfl6rmzBp1aUhIVu/j78Dc/jB/GZZZ2
         TXv4Ga/iBpaNrPhhnBx2hzVkSlaplNMGKTGoiMmPDASV/GIYouSrciYUG+Ib0o7vPX/Z
         L0jhhEgeZg5A26zJpfarDt3zFdgCvdoa+xpBQYrp1tC5Yx74frA+Sl9zD6BSujs74orn
         o9b3aiZEzdyXuKfgb2lHXit0Ts6B8S1iE0vbUiVMmxucEUkeNphg4hfpPtuQqD+LBXz1
         hdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgGgMxYprzA3l/xL3EqCp11c0RZBUqA2IVp2y5zwqwA=;
        b=F1eft448SYSPSc1fuMWRBnRary0434hV/QQ0AVRFwmfrHSQq/2/05KC5+B2Tf20/Ge
         Lnsygs6BYc4+FWiyaghLBxKNLWJHyKDgf4kH+JlZ3yRhsxatN2kiAQMKz+bQkU1GBVHv
         OEJkCuZvNbJBKUCchGarVjYFdmBh1HRxfG2HW0Az8z9pNwoku3MqisNaJ2HMRLIth3Ks
         gEfP/iacFAUsHO/TPL7HgJ1FeRjhVt8r2AJQkrbAJGqhb0nVyczjheo83IHgXWgL+t2O
         oYJ6OSUPxK7jUmFkhJD//g1HF3VvaHpBhnZ0pNKbMy9hBW8tOIs8YWKwOXhGhx6JkD/Q
         clsQ==
X-Gm-Message-State: AOAM530013Mh/fvixeUPnEXUJISv8yAvlY7JCFao4gc6xBO4lJ26VSL3
        nVtkKpCTfkBSmEHYu0BbXd8iODb9+CQ=
X-Google-Smtp-Source: ABdhPJxX/H8qICvWj3ZVLuik1LZmVooJXj2X2VrvAd6Bo8EThbQNUg/GImEzOpiauwj5/xCyYdKGXQ==
X-Received: by 2002:a17:90b:3c47:b0:1cb:8121:dcc8 with SMTP id pm7-20020a17090b3c4700b001cb8121dcc8mr10800735pjb.35.1650550243502;
        Thu, 21 Apr 2022 07:10:43 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm2672000pjv.2.2022.04.21.07.10.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:43 -0700 (PDT)
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
Subject: [PATCH V6 5/8] x86/entry: Don't call error_entry() for XENPV
Date:   Thu, 21 Apr 2022 22:10:52 +0800
Message-Id: <20220421141055.316239-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220421141055.316239-1-jiangshanlai@gmail.com>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

