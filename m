Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEF528524
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbiEPNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbiEPNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69124952
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i1so14397883plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPVmCWUy/pAelwn42xkgA5+/zRNQTu28RGMt2EDlrN0=;
        b=dKY6h7ZsI4pVBvrxHfHPPaegi8MMoVaKM/UCpPdoFM0qDfYhGhk65ILAr+auBUalZb
         GlJldS7I3QfheX5OIh2GLJeqOPYxqbPFBx81u7JKM+xZdP4RMsjg2h499XVBWcjcjnQc
         +QyxsEkiuSmI8tYNl+BCee4SqPVCykJIIhb4emm+51h2e8epMVFBtVtNBOgw1Hiqjbms
         rLthOTvrDD1Ea9yyGlPhtBhAF4W8GoNLn6sWLcGgoOj8WLLiGLoFYxe1CO7LY8SEeB9U
         AoXoIkCyTahZ9yHXeBCofXMFMHyrede9xAB8DluvW5UfTzvUvKei8dqYPE+I2mozztoY
         SncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPVmCWUy/pAelwn42xkgA5+/zRNQTu28RGMt2EDlrN0=;
        b=VioaLkZkK0n+aZ+HObQbsAfyLAWylSQXRgzab3iYQFyNd2XXNvMHl0WANEyBQDspMd
         3Ze961Etap/XXProqsXCWCKenF+LSVPvNKwKtWXjKYTY93PhnQjzb1Vs0iQftxm6nz8R
         x5q/jz6sFGvf9CKjNUFVx2Lf82C/jxp5O1WRr8c4Frilm8Kcu6+swis6EFDtdSnzLglp
         tcns/S70uL07voYDfonFl+EIn2z+SW0SqjeZID9/M8YU3IeTtSehKCSPYIS5Rd24OvNk
         3qwBlCeQFme1y44vhylpZ41Wx1aw598pCrMCikbAe3dEVewdZHFxZK27iCUeu3u/M7Aq
         1bfA==
X-Gm-Message-State: AOAM5319awLF6WTwveFtCgDZj3BpGlygRl275uLRnLDCGhLLrqJbQHQa
        FkBNoDAiisFyTTgopf6lQF09Rzn4AT8=
X-Google-Smtp-Source: ABdhPJx9nQG9bcFjsTqtttmgbi21slFg7XmMCrJ5I0wRYdLrI+WVXp+I9pBDjk1TxkuGFMIhKARkwQ==
X-Received: by 2002:a17:902:e808:b0:161:946c:d2a5 with SMTP id u8-20020a170902e80800b00161946cd2a5mr1782372plg.93.1652707031495;
        Mon, 16 May 2022 06:17:11 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b0015eab1ad02esm6931710plj.215.2022.05.16.06.17.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:11 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH V2 3/7] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Mon, 16 May 2022 21:17:34 +0800
Message-Id: <20220516131739.521817-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220516131739.521817-1-jiangshanlai@gmail.com>
References: <20220516131739.521817-1-jiangshanlai@gmail.com>
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

Mark __native_read_cr3() & native_write_cr3() as __always_inline to
ensure they are not instrumentable and in the .entry.text section if
the caller is not instrumentable and in the .entry.text section.

It prepares for __native_read_cr3() and native_write_cr3() to be used
in the C entry code for handling KPTI.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 45b18eb94fa1..dbaee50abb3c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
-- 
2.19.1.6.gb485710b

