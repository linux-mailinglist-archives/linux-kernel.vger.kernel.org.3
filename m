Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B724B3AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiBMK75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:59:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:59:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB35E764;
        Sun, 13 Feb 2022 02:59:51 -0800 (PST)
Date:   Sun, 13 Feb 2022 10:59:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644749988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMR3p9kaQHJX8bg1ergqR/M9P8iE9Vd/91eyWu7CNBI=;
        b=j0CaMZmw6QuKJkk8jYUxThSa/FFMovpJU543iaYHpQBFpGJfpn0LO5wVQLOQxAISKACaY6
        cDqkAZfRy1rX/3zvdW4FGaXLCI/fNRkRlG/tTd9PbCVeTzb5Dnc1iPHVvZ8xEjFRiXF/Wz
        MbVrKAuy840DOTFJJ3Yc8iwb8ipwB+GJiUlTVCA//r+HHcNGo3ERsfO63bcT8V1RHp0kud
        mERm8YSjGRSypVPl8361KLwWJX8BvfaScffjCqFQQaZGpFbXfchcgQtRl443BOVsqAP+UE
        CmrXe6T6klZZH0nVYlolcbNbK2jAKwJPm1mGKdlcGAWmUHSjefyyRoRHWExzcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644749988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMR3p9kaQHJX8bg1ergqR/M9P8iE9Vd/91eyWu7CNBI=;
        b=f7YmS+VtaO0hZ1u4xa+AFiMSFJEdrTYrgwmzm/iGIaQB0ogVKkwmJdWxUMJzmcaJuLx9Rz
        OIrxAxsIc1GZ5zDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/ptrace: Always inline v8086_mode() for
 instrumentation
Cc:     Borislav Petkov <bp@suse.de>, Marco Elver <elver@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220204083015.17317-3-bp@alien8.de>
References: <20220204083015.17317-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164474998680.16921.15682828457736571792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b008893b08dcc8c30d756db05c229a1491bcb992
Gitweb:        https://git.kernel.org/tip/b008893b08dcc8c30d756db05c229a1491bcb992
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 04 Feb 2022 09:30:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 12 Feb 2022 22:07:13 +01:00

x86/ptrace: Always inline v8086_mode() for instrumentation

Instrumentation glue like KASAN causes the following warning:

  vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.constprop.0() leaves .noinstr.text section

due to gcc creating a function call for that oneliner. Force-inline it
and even save some vmlinux bytes (.config is close to an allmodconfig):

     text    data     bss     dec     hex filename
  209431677       208257651       34411048        452100376       1af28118	vmlinux.before
  209431519       208257615       34411048        452100182       1af28056	vmlinux.after

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20220204083015.17317-3-bp@alien8.de
---
 arch/x86/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 7036631..4357e0f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -137,7 +137,7 @@ static __always_inline int user_mode(struct pt_regs *regs)
 #endif
 }
 
-static inline int v8086_mode(struct pt_regs *regs)
+static __always_inline int v8086_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_32
 	return (regs->flags & X86_VM_MASK);
