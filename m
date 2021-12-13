Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A52471FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhLMEWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhLMEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:22:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0814C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so13739023pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMfgKJwCnxCe6VxyJFMWTEF6oBbM5kN5hKLiFuP6lsc=;
        b=OmDu5tgH7fuEbSxL717aCjcCPePGAUjckBy3q+bzxx4i2C1z12GGgLJLVScQruUGUo
         K2OS5DYvkziEkaDWTYBsmpAQDBrMkrf0gE0I0+jYMsFZ0aREWaJ6rDudcBBGj4TlV1An
         QG87LehW5yrdbBr+DGRGySvA2Y7Tod9uZjMHfVeXrzFHxb0gtSrzbecXQQs4dDqnt/HH
         CKZ8GOQiwFa+7+JdfbOjMjO6MPwXGPt8d50yL5c9Qoz6fgOeAC5io4jy6pubdExb+jMu
         4TlaHzKZWKD8rw+mdhXJM+0pt23gyll6ZiuF5aL/leWyrszQ5kLopt6y06RkdsNwZDdl
         8SEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMfgKJwCnxCe6VxyJFMWTEF6oBbM5kN5hKLiFuP6lsc=;
        b=YFcBOVHwzS7jipMj2D1a1RnGzZBRPqL5H5YhvDHZ0HeKsffC+1PAIAqlFAQWiI59H0
         xK3sySd2FfPf3A+s86fYaxF8dQWC4DrwXNPpYjb7O3FyT7CnkoM4jAasWeuNDzXdCUVL
         kpM+wKsmreIWe25Pzmq06VCWb/e8b7qimZHS+j/PuOv0W/HcT6TWtX9M0WoEUJ3guSbX
         KssfTWOEiQuFfs1iWwmEQaqg2PWP22YHb2W0oTtV7Btd+FgsrPu4Fc3FywncUI+1dRwK
         06qFdxVljoTZgPj5X5ntbH+8iAAGCBtIaKJlTMPVD1W30Zgd3pBlBrr6Nfteq00Apgd2
         cV+w==
X-Gm-Message-State: AOAM532kSgrdDbzpImB/5/Vjz7rUUt6jMMiAsY8qMdQSmMsU2PcANMbQ
        6guvzfJ6IPnHSvdPGDiTUpOf3vpy2IxTkQ==
X-Google-Smtp-Source: ABdhPJxMNEOy8G+UfEBHEZhHQ2huu/czG/Ucqs570fyLPJ1tU/lp7Q+WRrJZaM709p6PThy5bLULHw==
X-Received: by 2002:a17:902:e550:b0:142:2673:d873 with SMTP id n16-20020a170902e55000b001422673d873mr93487285plf.5.1639369334293;
        Sun, 12 Dec 2021 20:22:14 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id t3sm10755794pfj.207.2021.12.12.20.22.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 20:22:13 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] X86/db: Change __this_cpu_read() to this_cpu_read() in hw_breakpoint_active()
Date:   Mon, 13 Dec 2021 12:22:13 +0800
Message-Id: <20211213042215.3096-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213042215.3096-1-jiangshanlai@gmail.com>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

__this_cpu_read() can not be instrumented except its own debugging code
when CONFIG_DEBUG_PREEMPT.  The debugging code will call
__this_cpu_preempt_check().  __this_cpu_preempt_check() itself is also
noinstr, so __this_cpu_read() can be used in noinstr.

But these is one exception when exc_debug_kernel() calls local_db_save()
which calls hw_breakpoint_active() which calls __this_cpu_read().  If
the data accessed by __this_cpu_preempt_check() is also watched by
hw_breakpoints, it would cause recursive #DB.

this_cpu_read() in X86 is also non instrumentable, and it doesn't access
to any extra data except the percpu cpu_dr7, and cpu_dr7 is disallowed
to be watched in arch_build_bp_info().  So this_cpu_read() is safe to
be used when hw_breakpoints is still active, and __this_cpu_read() here
should be changed to this_cpu_read().

This problem can only happen when the system owner uses a kernel with
CONFIG_DEBUG_PREEMPT enabled and deliberately use hw_breakpoints on
the data that __this_cpu_preempt_check() accesses.  Sot it is just a
problem with no significance.

One might suggest that, all the data accessed by noinstr functions
should be marked in denylist for hw_breakpoints.  That would complexify
the noinstrment framework and add hurdles to anyone that who want to
add a new noinstr function.  All we need is to suppress #DB in the IST
interrupt entry path until safe place where #DB is disabled in hardware
or #DB handler can handle well even it hits data accessed by noinstr
function.  Changing __this_cpu_read() to this_cpu_read() is fit for it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/debugreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index cfdf307ddc01..20189ce41578 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -87,7 +87,7 @@ static inline void hw_breakpoint_disable(void)
 
 static __always_inline bool hw_breakpoint_active(void)
 {
-	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
+	return this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }
 
 extern void hw_breakpoint_restore(void);
-- 
2.19.1.6.gb485710b

