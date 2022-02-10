Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A254B1A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbiBKAEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:04:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiBKAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:04:41 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6F26CD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:04:41 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id n6so6797750qvk.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4Pnr1geQeZZNYUvmzTdrAcaSDDBHcWYiYOpV2+IuXsY=;
        b=igNyfPN7wFlEB1yG0Q94kr/PxThWMFSj7uV6Xa4lsNO8Eodt/gd8/VSAkzJPPNNLqD
         qQwMyH8ytBWbsWit97TH9K8POhN09okti3ZyrqvzyHsbekkA+9K/sE9UpcWfflBJ6IX+
         rhewR0hrCY8scmAiE3GTbwcTImsKu8PHITWAJ8KcJjCbRrQVFfaIPsg5CJBI+XMVT1T2
         Mpfbx/rAP4rZXHBa7IM2cBBntYJ+Tq2sImYYlI9cqsl2/gWObSkvu8rlLJoLDx7IJcj1
         jCx2oUFhq59q3xZWxiZBd6OlaPcAu9p4kvX0V3N74k5jHjhmq4ZfoiAb7ipvUDuOUeOL
         9MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Pnr1geQeZZNYUvmzTdrAcaSDDBHcWYiYOpV2+IuXsY=;
        b=UU6GMNB0fsGJrG3DfVheY67iM57aasdZCTqsTCSs5wrXVFYICw/TLQLnD9tN8YnGS6
         gI76ub3oSZ1shTs4MUftCP/ZyU8pv96I1mltbJNexVTgogFQCHDDXjIqffeKDhHAuXGc
         MNHY4d1nYp243k8Vp5iEYL5A2rCh04kUXN3AAEn2rfUWNLi/EN+lt6/RGJRQFWxfnmDS
         nG9RI/fBHDagAY4+vFETd7PBAWMyVB8934dRIBRPM5WzSFXSETKf6cNDbz5nqQ8UTUVY
         SqZJDFj+R8LXa9mOSXt/OR1qSIXrjUHU8uraOlX0fLUpmqGEl3KgVg9HDcNawpr7+IiT
         x8dQ==
X-Gm-Message-State: AOAM533wGaB+ZxL0iXl4l6FPXwCKDM0J0CbF35eSwO7p+RhU+kCvIN9w
        QAJHsxwxcuVH5cYPPWzJN9ljTBMJryNVeQ==
X-Google-Smtp-Source: ABdhPJyfV3TF5HzHznBEsBWEauR+HTDxani3jRA7hek8YabMaXIpvx3P8mEI1Y1Wy7MVJOQjILfz9w==
X-Received: by 2002:a05:6214:2306:: with SMTP id gc6mr6804104qvb.45.1644537881043;
        Thu, 10 Feb 2022 16:04:41 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id 195sm10710640qkf.30.2022.02.10.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:04:40 -0800 (PST)
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
Subject: [PATCH 33/49] perf: replace bitmap_weight with bitmap_weight_eq for ThunderX2
Date:   Thu, 10 Feb 2022 14:49:17 -0800
Message-Id: <20220210224933.379149-34-yury.norov@gmail.com>
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

tx2_uncore_event_start() calls bitmap_weight() to compare the weight
of bitmap with a given number. We can do it more efficiently with
bitmap_weight_eq because conditional bitmap_weight may stop traversing
the bitmap earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/thunderx2_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 1edb9c03704f..97d5b39778fa 100644
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
2.32.0

