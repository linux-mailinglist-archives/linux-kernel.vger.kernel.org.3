Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD2471FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhLMEW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhLMEWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:22:25 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BCC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id a23so8857480pgm.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4agykccp0fGnUsyUTXuX0J1hO48HF9UWwqQTrPJDyPU=;
        b=ke1Vlfzl6hLVDvXVVPM9wwD70jRv+cSJlCT9jxjuQzZgDRt+PRsqKynkBbwGyuO+T1
         GxSBylWz96wYQQCEYD4GBSoQ1fz7yvNoA+pMfxD9oVy/qGtJHyeNHR+KsXGmXTsst6Vb
         sGhC/8pg+YVSlo6EcjFcfQm5uKTJVQAm7RYZsJsUis3H/ILhlt16KWE6wr+aIzFR/iUt
         cl0V3aJoSsAsEk9uJnR1dUFBjJpdC3xXQ6caSQ/qHmm8S8f172GGu8klu/9Y2QJ9RDWW
         oWvy2js+TKHwwcVzUUGK7BpVe5Dhsnht5SKsJl1RUyi8dTlB9y+FNlk/ZCLVDl0oaCQU
         5sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4agykccp0fGnUsyUTXuX0J1hO48HF9UWwqQTrPJDyPU=;
        b=KyvIWZwLYwHaMonJyQqUGIYZRhXQAf80S5Svlouhqv4BZKhGS316/WlaB8y0B5mYfg
         b+pU0DAKS0xxNU7HP56mOXMWZCTkvWNOHATJ0MzxLoZlWKl3NYeqsuL8uBKx5s6TLFUA
         7spCCaLJFTFpk+oGlzJXnTN0/kF9DkNO8QtxUueg8oa3To+p45XYoJn6CxG3OU2T+c7p
         xZj5RBFsICwJpxjNneNK64pU2hIYufcsejrpQrJrNF/7vG5V5BpVEsdfywrusHE7GUbk
         yHW6V+9FpLl/V9+qn1KftGmIBeh4EfLr08rHL63A1wI8Qjy+xvgoI5366+DFUF/IvUKW
         32Jg==
X-Gm-Message-State: AOAM5318ntHTfAdAtZqL1aJIP/eFtoNdRrmPtKU/fuXcS2Ft9DSbWaiZ
        nx7gj2con7uu7rJoy5nyNbW9vx0FUDmKbg==
X-Google-Smtp-Source: ABdhPJyVmI97E4s/LBrrEjqCHLk5cwXH4VIh2SEc4PFfx9pUjMvueTxpbc/mutIaxUb4TAiCYHW61w==
X-Received: by 2002:a05:6a00:21c8:b0:4a8:125:de32 with SMTP id t8-20020a056a0021c800b004a80125de32mr31421759pfj.49.1639369345041;
        Sun, 12 Dec 2021 20:22:25 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id j8sm11257370pfc.8.2021.12.12.20.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 20:22:24 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] x86/hw_breakpoint: Add stack_canary to hw_breakpoints denylist
Date:   Mon, 13 Dec 2021 12:22:14 +0800
Message-Id: <20211213042215.3096-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213042215.3096-1-jiangshanlai@gmail.com>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When stack-protector is enabled, entry functions may access
to the stack_canary.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/hw_breakpoint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 668a4a6533d9..b2b64afdf9c0 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -315,6 +315,14 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 		if (within_area(addr, end, (unsigned long)&per_cpu(cpu_dr7, cpu),
 				sizeof(cpu_dr7)))
 			return true;
+
+		/*
+		 * When stack-protector is enabled, entry functions may access
+		 * to the stack_canary.
+		 */
+		if (within_area(addr, end, (unsigned long)&per_cpu(fixed_percpu_data, cpu),
+				sizeof(struct fixed_percpu_data)))
+			return true;
 	}
 
 	return false;
-- 
2.19.1.6.gb485710b

