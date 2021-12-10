Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64037470C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbhLJVG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243297AbhLJVG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC4C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y17-20020a2586d1000000b005f6596e8760so18446901ybm.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zt4KB3dafqgTHRLA9U//R+IbzCQEPW5t7yq7SGqr+Xo=;
        b=GfezHHA2+faKrb9R8Fqmri7nt/RbHNc54wPwo5bzmu6kHVIQtqav3NWqKu9Hl9GbRO
         b7W9bohr0fEBqFITWZDDhiyg6rqynnQztLk8au98QHL7FjwBXekPqUMrrHM+Ma+FyAb9
         uiFL4OujUj4h2vh3j1rYMThMaeM0SOVJ/KUXOFnjlKJa2V30X1mPXS0+CQncWdA1N4so
         uuXjjPQn5D9N/E3Yf0PYFQdFQwTbmmrVOvhROtXddYQh0jr3/Wl+feBhUrwXbER8X/cA
         aSPMjLdELtUtvXZInUZj38Ht4pZaPS+Opy4+Py4GH/kyIe+KKzv+SiLtjX8ApVtjWZBP
         4Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zt4KB3dafqgTHRLA9U//R+IbzCQEPW5t7yq7SGqr+Xo=;
        b=5SyYSma548t0l0fwASeal/AnSnnvCHlS61Lh4yKBlyi8TtNnJ5FkmW8wSlCtxfCwzv
         gGVyojHRfoAqD0WQ2JLSlhF09oj9EZMYg2Ld6+J63vqRJY3f5u248feHrUWlceNgchW+
         zxs7A0tGhqGvyio/e/Ny7PCECccOhNQ/hA3bA9PNL3XnqCCB9FxM4mJlPNZCe2vvmyBV
         t52FOZg+Fn8Ry+RWd54YrAmQH2XO4zHthGfOCqyOj17TDdbtp+Hrn05w9zUuluM1xwX3
         NJYwqtlo0xMYwL3FMsnzPpdslV5B/QUTQpagC/qoAEOSCP3SGcnQLAkm2yAFSX0DwdaB
         ePgQ==
X-Gm-Message-State: AOAM5300Zx7/CUbcGQW+01troxsK6GErsEj2UIgsNzpcQOuqjCD3bDLa
        OgaCZ06gkGFBm7tDqcnW8OTsWZ8x7Xh8ImTUB/UZKD9h19LwtAVAtOr3vg+51Wy/uUASkNxlwte
        oZyWW9AAkmCwK81N14Bsc2bDCD95QJH2yvOZWcTXNLK/eMBemFuPdGO5np0XvXMma10e6QK7t
X-Google-Smtp-Source: ABdhPJwuEb+MghLJgtscOay7YvBpInPhrnq4pIBNGrmRFmsty8+eScHlz2JNpgg2GaJF/ciwkfLBFnhU0jGp
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:bf8d:: with SMTP id
 l13mr17039947ybk.713.1639170171401; Fri, 10 Dec 2021 13:02:51 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:17 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-3-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 02/14] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
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
index d5b5f2ab87a0..e71443f93f04 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_BRS		(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.34.1.173.g76aa8bc2d0-goog

