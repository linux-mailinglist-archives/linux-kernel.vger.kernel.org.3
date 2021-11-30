Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F67463F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbhK3VBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbhK3U7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:51 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D62C061758
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:07 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id m17so19309209qvx.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftlkm48GgrtwxM9ZBSrPo0gHXcfTvOAZFMx0tYmDnxI=;
        b=A5NJrnJOvU/2PGanlZDgcn7YamWiFc/49HEJdfAGgc7EwsQF1+M35tlu9ruE7uxiRn
         zj8sJsYkY5LqtRwGff5BdSbvn0Ob90Swfa9roq+a7BqlyiOaWhikWldYS/sf+E5N1A4g
         ZWTblwyASJAOV5biDVhgcrFfUiRpUuq3L0zyYCK2fHa2qr7dvk9XZ6EECM3ve2qvucc8
         0fkHrYqB7efE1PoLXx7/zXpe6ECDk8dc4AavBwx/vVZr9dKckF/heW7T/MtpGZIexysZ
         eqPki9rfiwPbxNjvO+CpNpYspwnwt7DnOQUOTbimlZ8wy1WMC5Y/xA6Ks4bIwudSRo2A
         ivLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftlkm48GgrtwxM9ZBSrPo0gHXcfTvOAZFMx0tYmDnxI=;
        b=XRuH575SlKP2tP1Omvo5NUEjvE9zIjaAhpukHIa+BZWQFj4n93cg9902apCjrIInDD
         TLFgPkdldGTTFgf/Rv6vVhT+QlwfLamdmPKWgnJ4nO07yZAY8C3db+c9ot0YnrRwcVZz
         sDMovqVy6ZlI5MhYqKQDfpKDZfvjWTM7OfkDBZKkyjkdeu92KWa2KE4+EH+Yrx+CnRCa
         RqLNa4yWVOR0ZyZdvSp8kdxOqyX1nRCF+WfFloQfTLAnDvP1od88HPu0huhItOfKJzcO
         RJq/SYJMPwKUI4MASOhx3yCGlkGpt/f0H2R+W/fVeapy5KjIK048KYkWaIALeXPmq0Vk
         eGoQ==
X-Gm-Message-State: AOAM533e94aJSXD/Qv2Qqp+eT0t9X3DSUj+TTzFtWg/RnP41ONyMrLuI
        qdhWInmlowQU+ifq9WMlmrDQQSft8g==
X-Google-Smtp-Source: ABdhPJze7BEPzPrSLEiVLn22SoBsq7zGUjC/dTaniUgEWhydsllYOqG45PsCUeicPHxcBCTDcERyMA==
X-Received: by 2002:a05:6214:c65:: with SMTP id t5mr1546406qvj.27.1638305766100;
        Tue, 30 Nov 2021 12:56:06 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:05 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 6/6] percpu: Remove PER_CPU_FIRST_SECTION
Date:   Tue, 30 Nov 2021 15:55:49 -0500
Message-Id: <20211130205549.116673-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130205549.116673-1-brgerst@gmail.com>
References: <20211130205549.116673-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/percpu-defs.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..a7fc94e1b985 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1056,7 +1056,6 @@
  */
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index af1071535de8..819d1b9ff8fe 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -26,13 +26,11 @@
 #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
 #endif
-#define PER_CPU_FIRST_SECTION "..first"
 
 #else
 
 #define PER_CPU_SHARED_ALIGNED_SECTION ""
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
-#define PER_CPU_FIRST_SECTION ""
 
 #endif
 
@@ -114,16 +112,6 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
-/*
- * Declaration/definition used for per-CPU variables that must come first in
- * the set of variables.
- */
-#define DECLARE_PER_CPU_FIRST(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-#define DEFINE_PER_CPU_FIRST(type, name)				\
-	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.31.1

