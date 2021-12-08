Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38F46D1AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhLHLNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhLHLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2350C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:09:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so4115372pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Kd9tDbqkXgV+uDS+ZN2PkifPpO4nwWCGziDx4Ai290=;
        b=DZBRV+VFT9+KfIlW9vI1YNTWjjSwY9UVdpausVhNvxvTeFCAhQr4BL86f1ZVb5wqYx
         daMm0jsnf1EZop+hPS3Rsl+eU347P7jXAR0P3RT2+WtY7EQ2A2yWN79dg12hx04Hs3DY
         iR2cUpLa4sLw2jps+ZS2rPZ95nG7mTU3J1k/V23q7IYOzjDvAuCF7BShXIc9S6F75RGg
         tKsQ5jKl/9h3kXq8Er5D+XxIEwR7FRorkvKKVlKBNuLRh7xuwrknY5JB9iLYWlgPc5Ip
         brHSmlHdSmwtVh6ZsE/XtTcbGI9NZy6tbBUp6sONJacjKJ0aJI0Wz9IDXReHISQ2qhXx
         46UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Kd9tDbqkXgV+uDS+ZN2PkifPpO4nwWCGziDx4Ai290=;
        b=Nl2YFOi4mjCWQPKarI8pfObjn/KvCwv8dAYdmbcGzeNubqH2w66//9ntcylJYnSEiK
         o3E0dxoXzGF46vF1a0U9aUy0wjmhUBCa5zG6T7Henl8qG2KUEm+wdHRKfeHL2/M3wAdN
         43Xe5+lOR/SPMXvrkiWzb9kD55NDa1FoT98Z0/ZzpQDIoqqpXDidjy7oXQ2HhThwsya3
         b8SqyJLg75sf6AIsorAhsa7qC4Iu9GkNkUYYJ+d8KlzRY3Dtz3k4c7XHeyec9BDepvcw
         VA9HTxhwAy2XmCuTWi0r8kzXKViGst1+kCdpxDEqTFOHv1ax89Xo+gg2sswSof3L4JOz
         /1gA==
X-Gm-Message-State: AOAM532WYlf/+duVIvSnLBPUCA1c5l0urJt+bgLBlf7bvBeRWR9pg8Oy
        Lc1Fhr59bGABVK4ZZwNVErRARMUYRdY=
X-Google-Smtp-Source: ABdhPJwtuS/bFQhmnmbhADvj6guciKxV5lk7NvScGFOlc2udq8C8NxlaMojhnh/rnPK9YGSNXl3k8g==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr6251592pjy.139.1638961766047;
        Wed, 08 Dec 2021 03:09:26 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id e4sm2315444pgi.21.2021.12.08.03.09.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:09:25 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH 10/11] x86: Remove the definition of SWAPGS
Date:   Wed,  8 Dec 2021 19:08:32 +0800
Message-Id: <20211208110833.65366-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is no user of the pv-aware SWAPGS anymore.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/irqflags.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 87761396e8cc..ac2e4cc47210 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -140,13 +140,11 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 #else
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
 #define INTERRUPT_RETURN						\
 	ANNOTATE_RETPOLINE_SAFE;					\
 	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
 		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
-#define SWAPGS	swapgs
 #define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
-- 
2.19.1.6.gb485710b

