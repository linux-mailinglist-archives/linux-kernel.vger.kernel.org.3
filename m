Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27F4A5E76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiBAOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbiBAOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:41:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F819C061714;
        Tue,  1 Feb 2022 06:41:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c24so35113904edy.4;
        Tue, 01 Feb 2022 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YlB7zlFSI5Xx6Oi94mB0ruJo7k87kHZWZYG/IWCl5Ks=;
        b=Yuy5wtvem1qXqHw9nz9JVB7iXu5lPoechBtxKDxX9eLg+kcWDHViatYhvSWyDBh7b/
         D4OpR6hITF3cFsgzQrpR/uHXD7upaIDmjd3ZTagqYjPcK/n1He5gX8N1WkIR6f1WltoA
         sqS3o/fMwPSfHUTr6LcoWrD1FpRdL5prNyvAbOxR1FgZvl/2vKGpgwLaWsZUyf05QMc5
         PC+0SPcA6tvMHGZVE9XVlfYalJDk/ppXymjEL+3/6KYEjZ105fu0TVLRxeigpjmqZs8z
         IDrBvrWHMVdjsxF6gb2fZkrub8/yweSMW2l9+KLUBwdMd80DICCWGiLZcRl2lm8lhW6x
         a5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YlB7zlFSI5Xx6Oi94mB0ruJo7k87kHZWZYG/IWCl5Ks=;
        b=d51hLsYPH7yb0VwAK/Ow4UHSRVXuJQfyHWsqQ7di+d9axnsfCjYTg+6SRWcVi9eg87
         mmRyiHDGoJMmZPIwc41SiCqcCurLAS0ndOpOgY2Q5OG414qtbbF63xKB/Xrg+L1IIZuB
         UcZdXiQ4ntHaZ2Hd5/uG6npFuhE9LWjHgd/QveRBBduyD3zuRP65Fsd48/mcZV5CwUu1
         0xwsOoWHv0FFc3a2pkpfOdROpu1VrfLp6LoRUaIayz4y/WEpLdGk8BJDQNxWfxSgQxPz
         hX1QaOoSOlDCWxMjWDK93F8cL9JTmf7IUW9bVmk5h2eDVClySHR1k+QX6MHTr7CNwbCB
         TV1w==
X-Gm-Message-State: AOAM530Vtdqg4D3AH7NcBCLWmU2Gm60geh5fMSUd50ppaapNeNa4yaKX
        uNOyTvMSfogym3B5MVUDsXs=
X-Google-Smtp-Source: ABdhPJyLYo0653RXI4dgoqe3YEiD7SYUQYHlbnKGRU+NA/rPEWI+vQ8HOG8ZuMQbxjaY3Oira1bCTg==
X-Received: by 2002:a05:6402:1d56:: with SMTP id dz22mr26491813edb.82.1643726473570;
        Tue, 01 Feb 2022 06:41:13 -0800 (PST)
Received: from felia.fritz.box (200116b8264e13002de5049704703386.dip.versatel-1u1.de. [2001:16b8:264e:1300:2de5:497:470:3386])
        by smtp.gmail.com with ESMTPSA id re16sm3160079ejb.29.2022.02.01.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:41:13 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/fault: cast instr to __user locally in prefetch()
Date:   Tue,  1 Feb 2022 15:40:55 +0100
Message-Id: <20220201144055.5670-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 35f1c89b0cce ("x86/fault: Fix AMD erratum #91 errata fixup for user
code") uses accessors based on the access mode, i.e., it distinguishes its
access if instr carries a user address or a kernel address.

Since that commit, sparse complains about passing an argument without
__user annotation to get_user(), which expects a pointer with __user:

  arch/x86/mm/fault.c:152:29: warning: incorrect type in argument 1 (different address spaces)
  arch/x86/mm/fault.c:152:29:    expected void const volatile [noderef] __user *ptr
  arch/x86/mm/fault.c:152:29:    got unsigned char *[assigned] instr

instr is a user-space pointer in this branch of prefetch(), though:

If user_mode, then instr is from user space. And if not user_mode, then
instr is from kernel space. So, in this user_mode branch, confidently
annotate instr with __user before passing it to get_user().

This annotation does no harm and just reminds everyone of the reasoning
above and convinces sparse that the address spaces are handled correctly
here.

There is no need for others to check the situation of different address
spaces on this specific branch due to this warning from sparse again.

No functional change. No change in the generated object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d0074c6ed31a..fad8faa29d04 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -149,7 +149,7 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 		unsigned char opcode;
 
 		if (user_mode(regs)) {
-			if (get_user(opcode, instr))
+			if (get_user(opcode, (unsigned char __user *) instr))
 				break;
 		} else {
 			if (get_kernel_nofault(opcode, instr))
-- 
2.17.1

