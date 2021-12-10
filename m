Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A18470C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbhLJVGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344350AbhLJVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA5C061A72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso18542933ybl.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=atlWq7i2l+4GpRbeigohJeKFsrjYZzb6hQQ7ZtA69do=;
        b=fWxoeNEtoWjx6FP/CYnXwUue0wYzFcQ6aEK/j15XWp7B01C5GHds6uN7FAtcS1qxpo
         UzoRNXEUBdQy3TF35sSJeNwJBy0m3KApLshsphEJvEUWugaxuvr2A/LUiJOMUW472U4h
         KOqmlTWHIoijK7KK7PuAjickyieRYu6mIxIC9x8hxx9TpchUC4Q+782axI21BmCeBqmQ
         o97coy4nEPQg/nSinBjrq38f+mfj3nbKEyrtveZJw75dsqPYISpIahQBFMZuToB60pho
         VT30r6smGf+zvuRWOmpjnsps0o3rbFJfxPIas8IfRBjLpGAuH5OB6/jhSEvk8DeOufIB
         jvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=atlWq7i2l+4GpRbeigohJeKFsrjYZzb6hQQ7ZtA69do=;
        b=7wWQ1nUfGYykBKriih7Mf7CF+28A2XQU+kHhhk89Xkbpx0gj1FogK4TyaFUHW9P/j8
         usFTpvMYcvXczUXTGQTFHt4agnd0CXYBa80f6XekPjrorYIPKw77/6QL1c3Hjfo5bj19
         a3Vw5Ff8BoF1vSbJ2LNReU+3zlyfQ5xO8ae0fuBOvpuk35J0bWe0xwRGIWrrfXTaqGp9
         M3+rIZz7yiG6ZQSSYWTGKAbArQLH7t9adOBBHwJZZ2VmEn96qI0yFuf7AcK0MOZvaFzp
         ThVIajd7ikRmNHBGFuLuzxaQ3ox4+7tN+BI1QrcLDHhk/uHDJ2/Qegaixz8U7eQN1beN
         vFew==
X-Gm-Message-State: AOAM531p5Zl0kcvgG9+fmUT2hkqOMVkE4XYsgxHOMNMneJrchzy+FMfw
        s/wV//r4cBWhIs6WNNABx4egqtUiNMbqRd31LUiCrq4Bk07dVGdSZJUFtM+BkEIVz0aBLOuqiBY
        2rIClrP7L6PiXYA3FNcEQfTFNtJcXTrcpw9EMe6BEl7Ya0ouDzR9y4abSXw95Z5sTyjW033H0
X-Google-Smtp-Source: ABdhPJxSjT8UyXLPt0TExciN5F4obZJ6BHfn+hYGNmWG4SLBLScP7crRlhNZ9AifPNGbGhhT9zRqL00PHot0
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:7a42:: with SMTP id
 v63mr18263423ybc.659.1639170178906; Fri, 10 Dec 2021 13:02:58 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:20 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-6-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 05/14] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Branch Sampling features does not provide hardware filtering by
privilege level. The associated PMU counter does but not the branch sampling
by itself. Given how BRS operates there is a possibility that BRS captures
kernel level branches even though the event is programmed to count only at
the user level. This patch implements a workaround in software by removing
the branches which belong to the wrong privilege level. The privilege level
is evaluated on the target of the branch and not the source so as to be
compatible with other architectures. As a consequence of this patch, the
number of entries in the PERF_RECORD_BRANCH_STACK buffer may be less than
the maximum (16).  It could even be zero. Another consequence is that
consecutive entries in the branch stack may not reflect actual code path and
may have discontinuities, in case kernel branches were suppressed. But this
is no different than what happens on other architectures.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 851b03bcbea2..1e5524494631 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -92,10 +92,6 @@ int amd_brs_setup_filter(struct perf_event *event)
 	if ((type & ~PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_ANY)
 		return -EINVAL;
 
-	/* can only capture at all priv levels due to the way BRS works */
-	if ((type & PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_PLM_ALL)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -195,6 +191,21 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
 
+static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+{
+	int type = event->attr.branch_sample_type;
+	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
+	int plm_u = PERF_SAMPLE_BRANCH_USER;
+
+	if (!(type & plm_k) && kernel_ip(to))
+		return 0;
+
+	if (!(type & plm_u) && !kernel_ip(to))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Caller must ensure amd_brs_inuse() is true before calling
  * return:
@@ -252,8 +263,6 @@ void amd_brs_drain(void)
 		if (to == BRS_POISON)
 			break;
 
-		rdmsrl(brs_from(brs_idx), from);
-
 		/*
 		 * Sign-extend SAMP_BR_TO to 64 bits, bits 61-63 are reserved.
 		 * Necessary to generate proper virtual addresses suitable for
@@ -261,6 +270,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
+		if (!amd_brs_match_plm(event, to))
+			continue;
+
+		rdmsrl(brs_from(brs_idx), from);
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;
-- 
2.34.1.173.g76aa8bc2d0-goog

