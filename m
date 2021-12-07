Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CA446C31E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhLGSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbhLGSxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:53:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C975C061574;
        Tue,  7 Dec 2021 10:50:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y196so81980wmc.3;
        Tue, 07 Dec 2021 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7XdQ/VlUebIhlzUYrxt+KTqCljNtBCSdqeyIMtJSqY=;
        b=ZgMyPGocPP0u+RadRzuGuF00EcUdZ2CgWzvpnArMSAlVtRL87cupTzcHB1W7kJFv/J
         wiMGGO2Wd6eR6P4jh60L65U9ThbB06XZ3p67/U+4GtPWQ9DikNqxEsmSYMPe1oJWBolv
         z52Ch+zU9oh00Q/9siz8BYw1UZflLH0Yky/nrWGfsVfoIZd8KPw9kKk5oB40/STeHkST
         ShMaXwYxN/QMXl9hnm+9hR64VQbBme2IrpvCB4zeJiROUgeDGYA9CR6gjrY2mmupgngA
         jqGWSxnGvp04VejB/HIIHEre8i8pMfhZf31FuciK7+OYVS/QmpzG9tsJ0Fq7TUysdEbr
         yumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7XdQ/VlUebIhlzUYrxt+KTqCljNtBCSdqeyIMtJSqY=;
        b=SpHMGtd9Pg6KZb+OE0o8MO1d/1KXgipB20sM98bxa4TBcH6WrWgK2eh2/HiRV1Vhv4
         xLzIgwFSyYAhbfOFiG6YgHgfCaoVZ0VX4w6m6V9UKsS4j+3LEIi9j4MJQJXMfHZBXcbg
         zCkMFC8duL6auoFT1Zc9ohJy785smg9P8l24vayOmzYB6EYZOTvr7F3V8+1JuQfG6XI6
         GRTEgCOfnrzUYJ5UrXhc/qogQGQfRuFkKz6JCyjwyfhLM1UsKeR++InouKnrPRLnT4If
         frI3T4XGY7dkhSYbr1CKxXP14Ad4mk8M52mWLV5/KnYjdADKkr9Im/f5XvxovQm+vUvR
         /UpA==
X-Gm-Message-State: AOAM532QcjJbp3GzXtHBePMfNNpJviV3KE6i3z4BlBAiiAfTEwNbHR47
        XpE1M9lcX/sTEhMULtrKpu8=
X-Google-Smtp-Source: ABdhPJwRvYVHCzKduuOwGUniyws4VRLzGZenCEc6xuGWd6jjWuIYl85FoHnukV0g99cuQ5seLvkkvA==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr9111142wmf.177.1638903002849;
        Tue, 07 Dec 2021 10:50:02 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o12sm514723wmq.12.2021.12.07.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:50:02 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/events/amd/iommu: remove redundant assignment to variable shift
Date:   Tue,  7 Dec 2021 18:50:01 +0000
Message-Id: <20211207185001.1412413-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable shift is being initialized with a value that is never read, it
is being re-assigned later inside a loop. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 913745f1419b..b15f7b950d2e 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -161,7 +161,7 @@ static int get_next_avail_iommu_bnk_cntr(struct perf_event *event)
 
 	raw_spin_lock_irqsave(&piommu->lock, flags);
 
-	for (bank = 0, shift = 0; bank < max_banks; bank++) {
+	for (bank = 0; bank < max_banks; bank++) {
 		for (cntr = 0; cntr < max_cntrs; cntr++) {
 			shift = bank + (bank*3) + cntr;
 			if (piommu->cntr_assign_mask & BIT_ULL(shift)) {
-- 
2.33.1

