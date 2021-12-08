Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C746D197
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhLHLMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhLHLMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E0C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:08:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g18so2159783pfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnQefY0SqcDF3kPq8KJwIjgVaMNVB8DughUGvzU8o18=;
        b=ZkLOIb1g7XpNcLLrO2xyloqg63+eDW8c1N54mOfbRuFF15rJgWz2gE91JKdJydbYqG
         8eL+r+UhBdoKdktkRc6tlgzDzsYJ6NEY/1TBuKklxnRsWEthwhlQQghbv4vM7av0dghG
         YG6zw3TvtD0aPRSriB0gRBQvxZg2vVXXuprrdD3o0j3Qbt2CneEC83iXlxyIWawDUhZw
         D0iIjqE7yyGv7egqdw5VoqBiJosZhNCpE68DlbCNteQlDu4Axl6SfUW4B/3Jil8jexsd
         tyJwF/W/PbqJoQPqUimewZeAPGV5Cx7WcudydaUIl40hyGzVhigr/W2WRHOIV/UiSSyJ
         MqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnQefY0SqcDF3kPq8KJwIjgVaMNVB8DughUGvzU8o18=;
        b=aBhQ7MjgcLwDq90Ao2V+LAJK/f5dM2zFVNJ4jgj1alYDnLpNn7lsi9vVCcgfEabqWw
         mqvmkhQEAXOQsPzDBGo6UMlpKQxj+EVRRpOkN1cSycg1FjWM0iNKrofCAWAFV6msgkXP
         fqPBUAEMKJGDl0o4ADKkYiQaVnWxg462oAKT2cGJLIFILWY4MjPVU/ujj+M/fdhG0JWj
         gCeJ5NJ8ek/F3YnQP0aLtQXYZaffm6KtAMTBmMrSZB4O3iz9h+A1RiFfsPOkvPmQuLh9
         cmcGC5EyeAgvnAhhauyX7itdHSfVG/2oQq6mEzwctfUFXZ79Iw1cj+9KwHxX58Q3OQcF
         /N9A==
X-Gm-Message-State: AOAM530t5dG5X92hwccETX2e9XLoqs2xCKrzNKQihbfI4WmxHQFLGMyX
        BoUHm5vaRE59BAnzffxQGzQBCivLWbc=
X-Google-Smtp-Source: ABdhPJy9TsqtHV5JdjlSkcLb9NlmtdqMIVu0NVHyePzQqWTpNS604qrVcpVV8sNyEJaBLMfE3D+HqQ==
X-Received: by 2002:a05:6a00:a18:b0:4a7:ef65:ddfb with SMTP id p24-20020a056a000a1800b004a7ef65ddfbmr4953445pfh.17.1638961708633;
        Wed, 08 Dec 2021 03:08:28 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id b10sm2960927pft.179.2021.12.08.03.08.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:08:28 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 01/11] x86/entry: Use swapgs and native_iret directly in swapgs_restore_regs_and_return_to_usermode
Date:   Wed,  8 Dec 2021 19:08:23 +0800
Message-Id: <20211208110833.65366-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

swapgs_restore_regs_and_return_to_usermode() is used in native code
(non-xenpv) only now, so it doesn't need the PV-aware SWAPGS and
INTERRUPT_RETURN.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 97b1f84bb53f..d95a02ecee16 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -608,8 +608,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
-- 
2.19.1.6.gb485710b

