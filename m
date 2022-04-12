Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174354FE0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354154AbiDLMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355240AbiDLMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98D10FCC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so2719698pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1flPZn7KfxFftAsobgisj3+41XCbW7e4EGW5Tqzb8+g=;
        b=Nf0HpfxvT7Ry4yE7lVio3FcL8ye5fqe2hbFqsnPm43aqNED8RDsVAVtWp6jBk8jYef
         ymkf3/C7FGfZJKsfhdqDL3D002DtQMYuybDOZAAp5kecqmxeKzmRZfQgtPB7GTuSmr+v
         0gtXEBSjDtRiZwF6Eo5qv7dB+QUMSdzkmE9421aDGRd96pKvTk8PWV2fHqL2V9uyL/Nt
         KJSoWYzeuy3J0Lauv+5GIwPftXh683H+zV0qRjdDZvfIkd54YGRey/kUhaSG0xcyJJW/
         W5eyIzTXisvU91p9mmxJn+UycK0ZY+KnuPM532WfLqn3Q3zHefC1aQQMC1xZANLg3R5o
         OkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1flPZn7KfxFftAsobgisj3+41XCbW7e4EGW5Tqzb8+g=;
        b=Kml10JMZvS8mXGl4w7OpWZfNWj8UKCEGstYXJ4RWx1YQnchdwflQfJxftDiVa9klMV
         10shoDelatLcOgVhpbfx6bB8JvgYYjknzLCQfbFjwKzNxmRY+ffOp5AH7dp+FxnLi0fh
         XqWpRrhzJUv+HwZMeelMsuEEzV8Btk8cWe3Z9i5IvYh4uJ6x8dsq3F2fprU8yL/HE9Jv
         SPNl6pMddmWJxlNgvZ1fOzbIegULcJIYUWSSmsqkEwvoTa//NvD/hdGeX8Wq5p24eZGJ
         sTq2k1wideWEhs+/6nuk0gtpxJoL/OWbr301CZJrfwl6BaadA2jZrP0Dh2tNjPBQf3S6
         YqUg==
X-Gm-Message-State: AOAM5313RwEZnW4hB3nfNdLzxvF9DoWolWmjPfhJCMcpt/RqIsX/rl95
        5PY2z4kXDyjShWZlzTK3NF2j+wDY97s=
X-Google-Smtp-Source: ABdhPJwUp+KmSkve9HAzkexmkq8wQ8btJVq2enI/a9m27a5Bb6LymOdTUfdCpHULLpOqWI9zopMBaA==
X-Received: by 2002:a17:902:c2d8:b0:154:b384:917b with SMTP id c24-20020a170902c2d800b00154b384917bmr38234316pla.58.1649765728232;
        Tue, 12 Apr 2022 05:15:28 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm42206082pfl.141.2022.04.12.05.15.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:15:27 -0700 (PDT)
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
Subject: [PATCH V5 5/7] x86/entry: Don't call error_entry() for XENPV
Date:   Tue, 12 Apr 2022 20:15:39 +0800
Message-Id: <20220412121541.4595-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220412121541.4595-1-jiangshanlai@gmail.com>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
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

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7b6a0f15bb20..3aca7815fe79 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
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

