Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501AC49D631
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiAZXfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiAZXfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0478C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 2-20020a251302000000b006118f867dadso2435760ybt.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S9alxEZ7Ku5WvZcthXQSXTBt/vNp2zW2Loz41ChaQ14=;
        b=ksZpQHt1SIZhp5arp7HKPrgUPNVrjEAuxs3fcebtEeqTDoWMYkhHPwAqzxca+dOAkM
         CSRWd8vQ+A49d18OBdfNs4o5t0Esws1+/0hHNUkTB+/5rdd0LR1zTZseh8+VylfJSGvT
         bZNq1twTF7Qihr2wKsc1aH6O54AXvZagxG3ragiUQtGn068aHpDNTuJMcS2zkzyoGRd4
         szj+m45YU3lwXWweSHuLnH/hYPkSu6day0n6GSrAFp/Iqw5UyUXJW496ndDQCTPPjtdy
         idGf0rHGRMQlPUiCRvMVEzr4IeK12T29SUI+ZUqn4zJDSEmN9YpEZX2cNcYiGElU3ZpV
         VD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S9alxEZ7Ku5WvZcthXQSXTBt/vNp2zW2Loz41ChaQ14=;
        b=5VmEn63rm5schW4l3mQN6ePVZLaeuw3hwQ7sIq4Dwt9iZUVNUYr3iv+g2uxGpDhx+/
         JbSJIDzMNjKQVrBmrYTQ9mWVd6uQGYMTy34WuNS2aOoPB3aOW4NWrJqmOrDQ4mHRvNTm
         CI/W9inzrlFep4hiBKGqDRTFmTtXyQgJU0aZhbwnvDW6sTbsT7ou05MZW1vKpu4Fyg4r
         RGMjiH9dd931NPJIz1iEx78ml76nHllfCLp3NxHnI7lwi1FBogeXrRq3WSuYHmGQeuxr
         +r8ItBa6sCaSV/EaMNi+lBrnFSYvZWy9LDhCWQb0P9XpW67vhSaCDwI2HRDgsocGBqlG
         D87Q==
X-Gm-Message-State: AOAM530N11tffqN0O5rYxbAyHeqBZxltpEmAce3kbi3FCYgSDVCcjYh3
        NCePDMxn6J+JEq6BZqjQ/kSHC94T+69Q2YydM4PcngjNtLoB3+aQxSsWfI/1zKmTTDPfF3ZaAYs
        O9WiGSsnwFflY7/hM4peAZ4pYVZ2LNj2ous1VaHb/Wg5zpVClumRtdoBPOmKez5o7V2fBE9ZB
X-Google-Smtp-Source: ABdhPJyXRWbuw0sjrI1Toj+7DReZzwokVfJ63YpHU0bc7T31V4u9N91y16DMW0D27foduCNCcbwe3WYhnI/Y
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a0d:db0b:: with SMTP id
 d11mr0ywe.483.1643240118330; Wed, 26 Jan 2022 15:35:18 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:43 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-3-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 02/13] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cpu feature for AMD Fam19h Branch Sampling feature as bit
31 of EBX on CPUID leaf function 0x80000008.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e2932b3d..1533b3204a6c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -318,6 +318,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.35.0.rc0.227.g00780c9af4-goog

