Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF64DA939
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353511AbiCPEQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbiCPEQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:16:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFB4705F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:15:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s8so2183176pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I24iEOm39f3KoXc9DR3nNWn7n6V53zLEWsTntZ8tBcw=;
        b=RNHp15mjCaWC0I38NdkhHl4ga654F6hUn9ZIEKZSyU36d9KuuaP/0IfdhualqSh5hp
         td23U2hxcrqWqwIOKwFW0IzAjo/hQsPO0cY60w15rh4b6rTtmYfhy7ZjpOibH7H/P7Mf
         eyhug2TKuoE1VX37YM1r07vnFqMnl4OpNJ2vuRBMAWFWAR4LlG7eEk7LgLfRMJSC3CJ4
         veCKVFDWnvCotBkngd7QDuLI2wUbEZfCPtZEbQan4zgALBcXl9hhIvFuHnMupWnZYte4
         I50RRtKLMxqFitl94zAy2Hijkc/UIZnLlTrqUbBx0g3oz92YKlqKReTF9hNuWtSz0ckD
         NAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I24iEOm39f3KoXc9DR3nNWn7n6V53zLEWsTntZ8tBcw=;
        b=Pqd8cD1TT6FWYvp0slxHjzOOZ8Q1SBRDoKdVHa80Wlbte9ldomOCfGkiOmt9JoXzYy
         KMuNZK8VJF2dAIBuv5pIgl/V4oqRYcMCdZI80HwAqE3aI8DHn8v46sX41hMC7b0mbVaD
         CxlFtWpbuDpMFL/+eV3tCYnR9l0q+rpbebsjtALXNVYi0OV0XOopGMCsJD0cbUkyvuEq
         x9MATnN9j+9C5ETEkBid7TgJJEdiWz00xorNOR1JXclMz+TrPW5loxiLl/g5rPyNDybL
         HOxl90+jWwAFYqpW7DLw1x/j1s/ok3KklOynyRpeCx1AB43XmBlVomE1hWlStD6YwLbo
         U71A==
X-Gm-Message-State: AOAM530BZkwKmggOthKqkpp+wLiLN/e8o9hXnejBJ6w+tB/qutulTjxE
        KRZX1OJT70QFcS6o3t+YDiRBuwbBv7I=
X-Google-Smtp-Source: ABdhPJwH9kTtGnCFwQsilO633TPXjVOYn5Wyorrx6wlFkGingOYNlRVf3UKBQJRkJHb0YYn2jEz5Iw==
X-Received: by 2002:a63:6843:0:b0:37c:43ce:32e8 with SMTP id d64-20020a636843000000b0037c43ce32e8mr26792817pgc.456.1647404137725;
        Tue, 15 Mar 2022 21:15:37 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm755148pfm.207.2022.03.15.21.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 21:15:37 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed for #VC
Date:   Wed, 16 Mar 2022 12:16:12 +0800
Message-Id: <20220316041612.71357-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

In idtentry_vc(), the real frame is changed after it switches to new
stack, ENCODE_FRAME_POINTER should be called in case for unwinder.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e20eabaa56b8..f99f2881ed83 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -540,6 +540,7 @@ SYM_CODE_START(\asmsym)
 	call	vc_switch_off_ist
 	movq	%rax, %rsp		/* Switch to new stack */
 
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	/* Update pt_regs */
-- 
2.19.1.6.gb485710b

