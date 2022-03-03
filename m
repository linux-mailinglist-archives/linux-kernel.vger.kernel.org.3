Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844974CB593
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiCCDzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCCDzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:55:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A2145AC8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v4so3592077pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2/ej5DrRdUXhbTtL7As/s+7H+Hg/qh6D0nKyde9b4I=;
        b=Cf6C+jFzvaQJqp+87aHDyXKn1AnopM3mxsZXXVve5nRwKAHyoEW6RWZ82BxB1/MpAs
         YBeLSbTIABdPihhCBaQaZsH8HO4BpyuxMiloaRGq75Q5JXATrMsGuFrephWtRRSjs0d0
         AP8Ob0+dxLcisk1yC6u47FptP4V+sB38bpPne1a+RruGrkn+5HAvkGofli4prSWlKBOk
         VY/TjCZNnz8fjIVkgNqx9yrwJT2Df9mWqoPIpIhEMtK4vr/RX1QVkozI+4TLCweH6z0C
         6S5+8I7OuILJGTyjV4G8zHIXKeFnGVL+oaiF5ViG74XDU5C/o5tq6C3NiluQPvx+9TjH
         10+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2/ej5DrRdUXhbTtL7As/s+7H+Hg/qh6D0nKyde9b4I=;
        b=m/dCZQhc5WnKBwuV54ijnZt1PHcR41r2npNIts3ZR4bz7alFonm6UCIgTT7CUFbYo+
         jBzykOlWJFzQa+EguFQAo7eOx/tf0hr7MawC+iPS/4ohjf+7PD0FidCnoSQRxzVLs221
         dWOM6jh4jxzITtykuC7O2F6ExOAcQhspEcd/8lHr9n7+FZeY3aFVXpe3Iij8Z7R2tmEN
         RVvoF56L8CqV/lyUAdymhMp8dkD30DoxH61My61trznzGRp1Swjidb3c9J06KVjxuJsu
         +Hw229kR4DoX3lNIqTNyVdpHVyOeKntVUkgZRkMPd7q6remKGCn5YU/ziApT3j5Ostbu
         XApg==
X-Gm-Message-State: AOAM532DRSlgaJWZDodKQJdGUtXeqS7tcJWG98CJFfE4yTnZo4chElmr
        ohhLZ4ViQ8herHAOuKMriG8guRBfaxQ=
X-Google-Smtp-Source: ABdhPJwMqYGzS+07MgSD+XrJLZC6tb4GmJcD1c0Voe27uz+8Clqe4zPHlwkCb0iXztvSKqT4uzsfvw==
X-Received: by 2002:a17:902:e945:b0:14e:b8d9:aa07 with SMTP id b5-20020a170902e94500b0014eb8d9aa07mr33517195pll.163.1646279670545;
        Wed, 02 Mar 2022 19:54:30 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bedddf2000sm537800pjb.14.2022.03.02.19.54.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:30 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 5/7] x86/entry: Don't call error_entry for XENPV
Date:   Thu,  3 Mar 2022 11:54:32 +0800
Message-Id: <20220303035434.20471-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220303035434.20471-1-jiangshanlai@gmail.com>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
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

Cc: xen-devel@lists.xenproject.org
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 630bf8164a09..adc9f7619d1b 100644
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

