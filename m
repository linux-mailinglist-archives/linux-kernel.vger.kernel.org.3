Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167DB46C798
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhLGWlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhLGWlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:41:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C2AC061574;
        Tue,  7 Dec 2021 14:37:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso538883wmr.5;
        Tue, 07 Dec 2021 14:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTn8oDbqL3WtQZWuVrPgPxffXFkLIxBUazDaxIaO7GM=;
        b=qVxGvW0ErqCtKsYWFlXTbzpVWB1gQlVikS9mO4DRLtrjoeZ7cntYCdILadmV/hNU1n
         pMoG9eG79mqpXEr2EP1fLpc3urPlO+aBAkshv6S/uOWgTdOKjiH2pNwxErWhy5Z/PTLD
         HUsp4+qBMF1TwCfB5RdVc+wZ50dUK0NC7k4/RWvFqwm9SzNSBh9hP/+/BaeONKFEwPER
         jxL7SHShbzAd8REjMuMh+bSqj7vErgWCuGbIQ5wGk08TlQ1XdKfaNCND5nLJW5BnVU7A
         z9pnBIGylkvTqcbpu65dz0LIM8sCDEriLU22olCW7Gg3pZRgZwZeSg9zdQPFR6mFK9g/
         NH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTn8oDbqL3WtQZWuVrPgPxffXFkLIxBUazDaxIaO7GM=;
        b=HZWekG/bgtSD3vN5MNY7TOdMp2QpNtt9pftYUy06uYxlgC4tpAWwlF3z8I44m2djJe
         MYVu2rbXJcMfvzkbPAwEnz0ScOZmCtEI6NdrIRMx57KP7CNzmk8jMCFoT5ZlPLWUK/zM
         kWCI0R2n9if5NnYB28hmIYfqF/ChIiatlRTZJjFXUB85HiTZUqP31xBePmpxNrooPhAO
         RxBqL9S3VHewgsxUigegD/zAVgj6n749fHr7xp2qOkBJAkN77IH+ZVGFSE7N9NbEx/ZP
         +iYFwETFhdT29PBRf/JkE4Z2H7bw+Kcg25ktQOhAqZNYzr1VZkZgbQ1fndkSzxtH9q9n
         AGJQ==
X-Gm-Message-State: AOAM530B7FEgAvANVh+ahLuMKv8vqbQItuEKzPJW2pfgklIqu1TNNpaB
        lLO14w5nCnG87KlWkdKgumE=
X-Google-Smtp-Source: ABdhPJwD+IOz2uSLw8sYwlDLWXqqp2+6zQ/dAwhgMOxC3tRsKdCVbJAAQImGzbxGTR/JDOqhzO6GaQ==
X-Received: by 2002:a1c:488:: with SMTP id 130mr10747983wme.157.1638916656663;
        Tue, 07 Dec 2021 14:37:36 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f13sm1169223wmq.29.2021.12.07.14.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:37:36 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/resctrl: remove redundant assignment to variable chunks
Date:   Tue,  7 Dec 2021 22:37:35 +0000
Message-Id: <20211207223735.35173-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable chunks is being shifted right and re-assinged the shifted
value which is then returned. Since chunks is not being read afterwards
the assignment is redundant and the >>= operator can be replaced with a
shift >> operator instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c9f0f3d63f75..eaf25a234ff5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -282,7 +282,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	u64 shift = 64 - width, chunks;
 
 	chunks = (cur_msr << shift) - (prev_msr << shift);
-	return chunks >>= shift;
+	return chunks >> shift;
 }
 
 static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
-- 
2.33.1

