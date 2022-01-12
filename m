Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEDB48BFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351584AbiALI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351552AbiALI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:27:37 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0019C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:27:36 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p12so2142149qvj.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h01bjARNb7y7qwRAWKIHAQxTQlqFFpWv+tbnghhAPks=;
        b=XL5p1cRjWWRnif4ZWMp10WAKVQdktJ99CU8VrSpzsX/FUAArUV/A1MuAIXUG84F3vT
         8zJKLliDpSc0y/ozvXau1+VEV1va7sA+WRQfWgs6skTruDynejqBAPwmbNiovWE5+hiw
         0MEfgVzD4cOyNkFjmZbp7fXxatgGzEj1cQUXMO2V00zDlT3Vl6warlaIE5EoJ4y1MKZj
         pWdnqUwIDzlaOi8knlQ3Lt+WnD+zpot79koOHu7gv8yX/Y2KEJ0oRXxEDVdTvmGtLioF
         vP0HS3naVii9fve0BC8YSPrQOIawksy85ADaSn/rnoiGi7DIN2Yk2gbD4QctN9blL71E
         w6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h01bjARNb7y7qwRAWKIHAQxTQlqFFpWv+tbnghhAPks=;
        b=wfyDwwx2HzwIoK9E2McEhz6hnxBfteYTuN1J0MiwDU42FkBHXpBEroDRIRa4mSM8Nq
         4Ei5mTvlXrygBYzRRdLa5vsO6Xo2Dc8aTI97ejklr9Z/vHdvGyglRUZtVNK8elzUclei
         /3KwX3c/r8zIWzjU1B7GXlpznyrPBJ/7gezDknb9mlG+qiVHESF9bZbjHNVX9PZDP47E
         73wfB9OS+Y0pi6ihwLaeYfPTkOzJLE2k4f+nNRcR0OJWkWB/m4yuKxyiTbonyWnBIo8E
         9pUg18Btdm1PNoLbC4nO0TYeYPSelYyyBuSKhHb6iQEY9WOF4mROB25zN/BRIpkTBHme
         qsXg==
X-Gm-Message-State: AOAM532AjoKTzo9P3Wq0Aja9XJUhntG3S7/xdEZMqbmmMvmilfYR+mI/
        RkshQLbqbU8WfhpSLWFMHvU=
X-Google-Smtp-Source: ABdhPJx9HqhPLSYFpsALofcmkf50IwgYwMGyWYj6KUBpbyFlCzbmmO1ZzDD3XoR+d2IVbZ8VIEcuHQ==
X-Received: by 2002:a05:6214:d0f:: with SMTP id 15mr7204173qvh.18.1641976056188;
        Wed, 12 Jan 2022 00:27:36 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r3sm3174416qtc.84.2022.01.12.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:27:35 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     oleg@redhat.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] arch/riscv/kernel: remove redundant err variable
Date:   Wed, 12 Jan 2022 08:27:29 +0000
Message-Id: <20220112082729.667743-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from user_regset_copyin() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 9c0511119bad..a89243730153 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -42,12 +42,10 @@ static int riscv_gpr_set(struct task_struct *target,
 			 unsigned int pos, unsigned int count,
 			 const void *kbuf, const void __user *ubuf)
 {
-	int ret;
 	struct pt_regs *regs;
 
 	regs = task_pt_regs(target);
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
-	return ret;
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
 }
 
 #ifdef CONFIG_FPU
-- 
2.25.1

