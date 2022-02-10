Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A854B18FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbiBJXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:05:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiBJXFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:05:06 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348011125;
        Thu, 10 Feb 2022 15:05:06 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d7so6703065qvk.2;
        Thu, 10 Feb 2022 15:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KXOSpbk+RXW+DBP53WQyWN4jwpILDSDDpj6Jr1j/OXk=;
        b=HI2mnNYtTkfI3G65nubNt3EonUdah48+r1Un+jjkwIm5WTUeKo1DSh7mwr1RNCRMgE
         bziELpIikolO6+XLfN0wr0paDV5evv5uQUe7vVM82nIsTufGcwsTZAklK8FgskeB/Gxs
         YgPcjoQxWhmMSZW92o3z3PKTdUgV6SSsVrFSHaVYahPoIiJ9jt9mz1ETwAec6RlUOezB
         PjTKHGc7yT7dL7Jk6cnosjN72yiOPlOXg2Z3zFIPWOIuIsIPzL/GRn8T29YfLAMDtaM7
         hpgWjT8yH+viYHDWG/BFQtM59cR+p85vdEojzwXcypdnEpm5UXp9OFxTycC6GnmsV3Js
         azPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXOSpbk+RXW+DBP53WQyWN4jwpILDSDDpj6Jr1j/OXk=;
        b=cpe/XXTxD2SxUfGsQWxJA8l+XqAtYwphlmDqQrnEzsF0sTWggfSPfJfXrpiUH8kv6f
         22xiSVeASTR2fDs0j+ykJxhF9RXBC7FQmnwLwRKgYpXoDMooeuFWaMB3XpYm1Q/U1Dzy
         ts2N+dLKzW6GxUqrVh+rYcWah2cVArCdpvKYY6Z3J0lYs7aQ59ycw1mlz1TiTiTrljZo
         PnrVcou+fBSuGr28eLWRJPHGYbe6IWjQ+usY1dA51WV54CqDGTA0yuCyOdkci4eL8QWY
         fezdQGC3KV/vSj3rldAV5X3i0sEi2FRnI5Yjhkb/D6JnMyQnvIGIpQ9Kc8cOyqZG9+Xs
         JoXQ==
X-Gm-Message-State: AOAM530zVrV0Ggq3KvwDh9FtTZ7RwVcuLPvUnizqLlAgad22dkt1xvdB
        7Mi0O/TVA+BYgsWRHeLlbIc=
X-Google-Smtp-Source: ABdhPJyoK1UXHarwQjdmthhpKPhuaMIGYQTI8x7ciOZ5He2zfHWTRwLo34b0L8nU6akmLcRZSIYSow==
X-Received: by 2002:a05:6214:194d:: with SMTP id q13mr6709929qvk.8.1644534305337;
        Thu, 10 Feb 2022 15:05:05 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id w10sm12438294qtj.73.2022.02.10.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:05:04 -0800 (PST)
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
Subject: [PATCH 06/49] nds32: perf: replace bitmap_weight with bitmap_empty where appropriate
Date:   Thu, 10 Feb 2022 14:48:50 -0800
Message-Id: <20220210224933.379149-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.32.0

