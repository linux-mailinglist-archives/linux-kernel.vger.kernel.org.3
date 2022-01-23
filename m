Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14B49746E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiAWSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiAWSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E5C061401;
        Sun, 23 Jan 2022 10:40:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n32so4678122pfv.11;
        Sun, 23 Jan 2022 10:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CMyb+uatsmk9qk9XVLHK9qLtTawikXiv3prI/J8nsYM=;
        b=FEb+34HTho0mKP3DvocyY5vmMMIY0jI+I0rv7W6aUWsRjGVGKae9x0632mvuE0VukX
         zea1g8JwnWdhuggaBW8Y/WdgbU1N97zxV/0lc6CVl6kbSLEu1CjejIFbnLW9WV32C1kU
         FEkKIt5A0hJfgPODT6AEm0bK2BqHK75ha9fyOYv/j+Ck8z034STtFPkqMtYK4YAyK09y
         B5tPcb3PlT/dgTM3UlBOIsFXEQ9fL4+wKUAhRQZHjGkf7umylX7mr7nvGMt8Cfb0SjUH
         m+xIEdg2rox44nz7G2yru3pMJuVJZnJeffn9C9FJnbibfqOZnCaDstrg3EG1S4ajlJf2
         y5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMyb+uatsmk9qk9XVLHK9qLtTawikXiv3prI/J8nsYM=;
        b=ufjsuJ4ls1F6hi8WyIyfzbjo8FtAyp+LJyBCSnXuj41DDsc9bfdY1v2PCCi6n238zc
         /NOeyVc2TEeATQCpeB+m13D+XyONmKkfBEW8ck+7Z3/Kfo8vt3xti39Kj6JwZ77OxtPA
         wZp7DsEWCEo6gvwF0i/XizAFhzs0oZaHPcklZ+M0pko6sazUHGCFSeClNSzVoz9E1BIZ
         8jev3mMlZ1hPG8eBZneDMBiozxzSLsYyoR6Lsri7GOTiLB1scG5Nzs1fmgMpqiWNEnxc
         np/DmN6Jxk9MY1EYqZTTKiGtuG6InA80pr3col9Mb7b64i+i7DAM4w7FROgdeU+H5Myc
         H7nQ==
X-Gm-Message-State: AOAM530Mxt3ikBG+imDDgBQyMGxyRG2yGnfmd+HivjwHsgOLBjSXgCMn
        +HgJHMz+GbuMEAAbF0TGBEE=
X-Google-Smtp-Source: ABdhPJwf5QI0SPNdOnucozcNruZiu59ZtsANYNvXFoEq6uEFbg5cEgIjFW+kxBeTM2iWtFnYw5haWw==
X-Received: by 2002:a63:6f87:: with SMTP id k129mr9529438pgc.248.1642963204752;
        Sun, 23 Jan 2022 10:40:04 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id a1sm9996929pgg.18.2022.01.23.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:04 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 05/54] nds32: perf: replace bitmap_weight with bitmap_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:36 -0800
Message-Id: <20220123183925.1052919-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nds32_pmu_enable calls bitmap_weight() to check if any bit of a given
bitmap is set. It's better to use bitmap_empty() in that case because
bitmap_empty() stops traversing the bitmap as soon as it finds first
set bit, while bitmap_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/nds32/kernel/perf_event_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index a78a879e7ef1..ea44e9ecb5c7 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -695,7 +695,7 @@ static void nds32_pmu_enable(struct pmu *pmu)
 {
 	struct nds32_pmu *nds32_pmu = to_nds32_pmu(pmu);
 	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
-	int enabled = bitmap_weight(hw_events->used_mask,
+	bool enabled = !bitmap_empty(hw_events->used_mask,
 				    nds32_pmu->num_events);
 
 	if (enabled)
-- 
2.30.2

