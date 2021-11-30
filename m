Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37483463E08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhK3Sxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbhK3SxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:53:13 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD73C061756
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:52 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z8so42995779ljz.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8JvFrUg/XkYpRnUn/w4Q2QFlAdyzGQLFckDXE4H52c=;
        b=WS4SoGxPYnlsOfhTthCkLmyF0zVtvB0uslAY9iJk4m/Gu2gcj1qaEJ6UmPkDb53qw5
         Jk/0fMvq42sP/LV+I/5Z4oRElC36/+qb9UM1OoiUS7AiVVMGhTkHtMn0S2nr1RsE/XLv
         pKskBghukrvCdLMarF8N9zq379CxWW5Vpg/4qWITUJ/3X4qa4nW9Rbfb7AqkjpQfX3lH
         fBPmNgj7WtOluVm5qxAdm3Z/xMBbQFapZ7iRAWPt7AkaXHWilxfroTLNfh2+470Xhxsp
         XxA6SFFIVm9L6wicw4zuCo7bhIz5gYAnoctLq7H0F8FLMxe/o0LIpNnb7oqJ7qDCafSO
         G27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8JvFrUg/XkYpRnUn/w4Q2QFlAdyzGQLFckDXE4H52c=;
        b=gReOgiir+OgOtL+bj5Azv/OaBF1Rgu6ew2M3EIXIMO7VlirMEMYKpDy+RuWcH0OWZC
         PlcCdh2kFNwM/2+zdGhnMXJBPNViwfs3OUTqEECEMDB5GPHXzL/8Ij9hdyQ50rM+aI6h
         7cR1TDYsMzNkDjqhFiONUADMWRe9oJGZ5JASF/qBceUB71BDhkGQFpMYY6n03b0mvZ07
         MJGy0pRdJax9blfweUxPyeRIMXiMYVrinerxBmWQPuumf6XUpd+4qBEir0BZzR4oXTgC
         v5s6lL8H7NB17SCrmXsg4Y10owK7JoIowVHmCj6MqDgu24F7R3RGegNVWxf02gu+alf3
         giRw==
X-Gm-Message-State: AOAM531JK4A4SGXnR9ck76UsR+7fO58qvQPem9fFNxjD/HS2aRQKJQ/1
        S4PjdxEHfR5Z/q80sUSLjZg9zw==
X-Google-Smtp-Source: ABdhPJwhr09clYIXcbtKu2de8HtLwxUjEnDA8i/nbvVyRnYPmFWx0FvS1hHi4nJcJDtoyYAjsHWuhg==
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr701233ljm.121.1638298191226;
        Tue, 30 Nov 2021 10:49:51 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b13sm1797741lfc.79.2021.11.30.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:49:48 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 9613C103663; Tue, 30 Nov 2021 21:49:49 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 1/4] x86/insn-eval: Handle insn_get_opcode() failure
Date:   Tue, 30 Nov 2021 21:49:30 +0300
Message-Id: <20211130184933.31005-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

is_string_insn() calls insn_get_opcode() that can fail, but does not
handle the failure.

is_string_insn() interface does not allow to communicate an error to the
caller.

Push insn_get_opcode() to the only non-static user of is_string_insn()
and fail it early if insn_get_opcode() fails.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/lib/insn-eval.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index eb3ccffb9b9d..868d80ea85d9 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -37,8 +37,6 @@ enum reg_type {
  */
 static bool is_string_insn(struct insn *insn)
 {
-	insn_get_opcode(insn);
-
 	/* All string instructions have a 1-byte opcode. */
 	if (insn->opcode.nbytes != 1)
 		return false;
@@ -1405,6 +1403,9 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	if (!insn || !regs)
 		return (void __user *)-1L;
 
+       if (insn_get_opcode(insn))
+               return (void __user *)-1L;
+
 	switch (insn->addr_bytes) {
 	case 2:
 		return get_addr_ref_16(insn, regs);
-- 
2.32.0

