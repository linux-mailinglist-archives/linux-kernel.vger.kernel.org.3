Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E250646445C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbhLABFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbhLABFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id l7-20020a622507000000b00494608c84a4so13916332pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wRJ39po7HsfJjQChqWF7dX5OJ+xHL3WIGYjKvPYR7PM=;
        b=cFWUsraufbpb7ZULKuP7ICSEezEsjeGmtFRwl90XVHwllO2GPyWGS0XBgzjriYtFtc
         IiulShhSyVLrQC+YpBlF4Qa3YJv788wlcRE4ISoiEmCh0kRSAlNaCSSF62eKCkaydxzU
         cIwQSQh71JyXHjs8d4hWulx4eahz5uRNlFDap0HacWt75NXtMvlOln5K50aq3M0oOzta
         p1L8Ff61xN071vxR+Qi9h0Y7Cl8L09bbdUv7W0iS7tICPus5mwzR1E4OHRHfckeT48MT
         qTQFkOq8ue47k11dnWPYWPfyakJgN98LmRBEx562mE3kuVmDtV5NrsnAq2UuLd/wGlUU
         60Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wRJ39po7HsfJjQChqWF7dX5OJ+xHL3WIGYjKvPYR7PM=;
        b=T1cxf8280/laVdJPM05ZEvAwSMcFfs074KUFlqILzeu02Uq2hrc/vAF/tvMuUvLcJj
         kd8x9e8f9fAkmUNMpbS/pcTxuHayEBT5uook97i5jyIEl2/RzYseJYSMYDe1z2Qvi1to
         oJ89f7ua6kGe+bdiCFDzKLyAMdl1PSnqPglyZW3mBGwvhLXIC6iGh9eEb8X7BmC0bwYE
         FlHfVlqR8vWhPMP61i1A7XpWRgFHMvC8qCUH0rHc+mMgp69yswHD4w2q+zJdpXFL7v8Q
         /yV1ncPysYaDKFHyG8FsPv2p25B1QxjxpTbsrZwk2oaVNWXvRVkoRaBJPmg19EymheWI
         3jyQ==
X-Gm-Message-State: AOAM5302pQcFMEHUziSj+vCXxbKVcmNZi57fHvU/gZ6UsUcjj0l8027b
        VLR+kaihVi8vfpNS5QWhRWgd8MXoDmR/gNCJuQT5opmex0c6uoOmLRsH9NBnwSvdvXMJF+weQe7
        f4ra6KTv+CLajZvsXOtPwbsqK17AgWr+HgoKlSvo9NMG2CxrwpW/Qyg8JhtutGsl/IGE5+8dQ
X-Google-Smtp-Source: ABdhPJwJsr+Jky3q9sf4+0fmbbpHRGfay7A3Rq2hBFImOxnVbofqmZjoRF4354Ti4Iv7haUt2+IIacE8rOA2
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a05:6a00:130c:b0:4a2:6c4c:55d0 with SMTP
 id j12-20020a056a00130c00b004a26c4c55d0mr2618096pfu.5.1638320545991; Tue, 30
 Nov 2021 17:02:25 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:06 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-3-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 02/13] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
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
2.34.0.rc2.393.gf8c9666880-goog

