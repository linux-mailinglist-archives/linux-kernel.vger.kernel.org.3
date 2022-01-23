Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACF4974A3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiAWSm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiAWSlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:35 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAEC061771
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:35 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e28so9333233pfj.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T5W4tcAlu9II6TGKyllSre1cwbBZX0+vG2XX1glXT5Y=;
        b=VC3JAELl4Bcc9x72apcbabSCxL7VtVtW52zOXinf9qQcKr8OiQhjNNZMIrMJHzF88t
         PBbjx7GVOfENmdJpobQoYLoM0+q14MmtfuHhOG+fjHB0cOXMjZCKVaz6bk6JD+LNKC5B
         5NUZ3S71+7ggjbktRx126GlRhxpUMjYhaZ2jbXFyzl5Lj7tIXclBHF9agDV7w5Qy9DhE
         XHds+SdkFGGW/BxKpgXgtqSdEdTmoAGhhKG9P7xJgfG1bWErw0ZgZPmTOwklfWyoaD2b
         xRSYuTXb3JFgXIhYF7+jekASh+2hU6RWDE3TB0a2Q1knyPegNCjOVKr8ZN8q72lZ8YSV
         A6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5W4tcAlu9II6TGKyllSre1cwbBZX0+vG2XX1glXT5Y=;
        b=sIiLreyopLGfEKUTqYsfLuClBnDPWFoou3+NSN0RBmaNstzRCuoG0tRENQSaGLBNAl
         wN2wtmNU1MiQq7K+c9u4XE9OrjPBX1sDuJaI0JgNRUDGa9dtT1RWyrQAcunONg0J0dyy
         kncWGBIa10zCX1FVnUs85mMpyn5K653BX+F42p9HvUojFkpRqIr6sl8ZJdpLbTBYm0Nn
         9g+CyK3H/TXLDVmsxDY0QuJUkOAADJeXzW/uJSXSfUYXQxTBGWVL8ZFHjTZK39Z30Mro
         z9HyEUMR2/0/tZ81V6C6fe7JE3PZ/2vPoGRwOfXZ8SKWKgrTtPOX5rEzWVz3Z2Q9DMrO
         Bo0A==
X-Gm-Message-State: AOAM532/ybak/HB8qBJqUYc2aAAj5ocpslZOWlBbtE3h8TcFA/Wz2pIE
        V9uTRETfX0LF/DlOB4Pd/Kk=
X-Google-Smtp-Source: ABdhPJxNACDhw+pefiza8oco2JDFigwtzNjUitC28s8922ZKmIrgEEtXSDugjM9DU6Y1rqgheHdTqQ==
X-Received: by 2002:a63:9347:: with SMTP id w7mr9366776pgm.84.1642963294566;
        Sun, 23 Jan 2022 10:41:34 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id k12sm14285241pfc.107.2022.01.23.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:34 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 34/54] perf: replace bitmap_weight with bitmap_weight_eq for ThunderX2
Date:   Sun, 23 Jan 2022 10:39:05 -0800
Message-Id: <20220123183925.1052919-35-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tx2_uncore_event_start() calls bitmap_weight() to compare the weight
of bitmap with a given number. We can do it more efficiently with
bitmap_weight_eq because conditional bitmap_weight may stop traversing
the bitmap earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/thunderx2_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 05378c0fd8f3..ebfa66b212c7 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -623,8 +623,8 @@ static void tx2_uncore_event_start(struct perf_event *event, int flags)
 		return;
 
 	/* Start timer for first event */
-	if (bitmap_weight(tx2_pmu->active_counters,
-				tx2_pmu->max_counters) == 1) {
+	if (bitmap_weight_eq(tx2_pmu->active_counters,
+				tx2_pmu->max_counters, 1)) {
 		hrtimer_start(&tx2_pmu->hrtimer,
 			ns_to_ktime(tx2_pmu->hrtimer_interval),
 			HRTIMER_MODE_REL_PINNED);
-- 
2.30.2

