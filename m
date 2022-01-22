Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6749696F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiAVCez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiAVCey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:34:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383AC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 18:34:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n198-20020a2540cf000000b00614c2ee23b7so5949765yba.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 18:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YL7R6m531ab4mu/nG0Py7+xJnaz+sbZ3l4YcriAUzsE=;
        b=A5olXp8/l8OAwPc22+ak6thOxleOy/R3vWMG8gDugaByRiJ/WGLSpyNLYqRo/cgVKJ
         yFKyzjxskrYCGwrIcrQouc3nhQ2bdE8i9R8AfVqCtqpql4C7GQ/H5JJbZR/eMqjVMfiF
         xCP2mtsGjFmG4xRxrFAtxRs6AECc/6TOINWftjlaFeZuDkCyp35MKeHHu1um49uUBdZQ
         yhIvl/DWlydR0a0lw0AKYynkImJy5IgRbrHEhybdaGJLoAJnoG5Truw3n4iLqdzvyqtR
         5b8s7HlQU4SeYEyoAeNEXMPodAKVJtpMhkLiB9d403G+yhJLTJTrDi+M+Jg96ilftblc
         vlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YL7R6m531ab4mu/nG0Py7+xJnaz+sbZ3l4YcriAUzsE=;
        b=1lex/CWbuRjm3vm1x9l+MU3TQbj7u8Ub6Og2JqJe2DLqrvjtz1fEd5cyJGrUyN0vkp
         q3WBPzuKBEBjkL7h0O65epb8UQPzobdmvy/XRowSMdDu2xC03qjZVk3uucbx2IotR6tM
         cyw2VyFvayySdCKFEC2CvjSxLQWqa3q12NU/bn+QhVOzF/Vq2rffIKl1YLmaxCwvu0qM
         WN3hT6SgukHXI8yAH2hAfT0LLO9OoKxG2+ROlBnmtptWMLzvI2RQlCfoGcNIpuyne966
         rirVEmHAFjUhccpFAgLuSjwba28rXPzuFVFei3vAR/uJsO9CAxb9Hhir+nAEjendZcH3
         5asg==
X-Gm-Message-State: AOAM532CKKvEPK8DYs3fGD58o0iEFL1+ADQWMM8D6VbqowycVXWtHpi7
        kbTSvjj2s0XHhULUYXForSbGri+Qw4Pe
X-Google-Smtp-Source: ABdhPJxZ9V/Y7oCEiURnrv2nzu4eM4nXzJFXdSR6d6I73X2bDUwfe+PomkLFAeL5wQzyOC9gk2vQBaul8uoM
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:794a:a42f:681b:1b61])
 (user=eugenis job=sendgmr) by 2002:a5b:3c1:: with SMTP id t1mr9929040ybp.486.1642818893077;
 Fri, 21 Jan 2022 18:34:53 -0800 (PST)
Date:   Fri, 21 Jan 2022 18:34:47 -0800
Message-Id: <20220122023447.1480995-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] arm64: extable: fix null deref in load_unaligned_zeropad.
From:   Evgenii Stepanov <eugenis@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ex_handler_load_unaligned_zeropad extracts the source and data register
numbers from the wrong field of the exception table.

Fixes: 753b3236
Signed-off-by: Evgenii Stepanov <eugenis@google.com>
---
 arch/arm64/mm/extable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index c0181e60cc98..489455309695 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -40,8 +40,8 @@ static bool
 ex_handler_load_unaligned_zeropad(const struct exception_table_entry *ex,
 				  struct pt_regs *regs)
 {
-	int reg_data = FIELD_GET(EX_DATA_REG_DATA, ex->type);
-	int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->type);
+	int reg_data = FIELD_GET(EX_DATA_REG_DATA, ex->data);
+	int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
 	unsigned long data, addr, offset;
 
 	addr = pt_regs_read_reg(regs, reg_addr);
-- 
2.35.0.rc0.227.g00780c9af4-goog

