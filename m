Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA844CDF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiCDVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiCDVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:04:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC73555BC3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646427847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aB6Kk4CiP7ma9Bi5vpnU1x/1xVJ2+zGmFV9PkjhVvyE=;
        b=bcw+a2fHoOHI4KmNCTmO4SszGG+dXszhRzPFyiAX7WhR/y7qQzdILqkDcTPvLCCpGwfR6Z
        4SHDAWZfYXQmTxEtnL9MUBVXD0W+qe/au1t+Y3B2OwOmPeEoeI0paEK0Vbg4CL0L4Feqa9
        qUUWS+T5Z66VRT4Rdn323jAfgPD7kOw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-xkjudbt_NtCqBEMv2Rfo5g-1; Fri, 04 Mar 2022 16:04:06 -0500
X-MC-Unique: xkjudbt_NtCqBEMv2Rfo5g-1
Received: by mail-qk1-f197.google.com with SMTP id 199-20020a3703d0000000b005f17c5b0356so6528359qkd.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 13:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aB6Kk4CiP7ma9Bi5vpnU1x/1xVJ2+zGmFV9PkjhVvyE=;
        b=aLsuVMx7lWSLpaF7ppmzcXJzDKNyS9/JLnAHDHSEKwh2niMWxTCWDt1FiCuH1gSJZl
         Q/h24d6nRwOcseS/wF6uXBbxul/WcXlxp7VyQkSZJ29/6Cpn0Wh5W9gSZSVWtP+9gMQM
         M/8COz2+1W6r+NjVrmQgi/c3XFCzxgivR4VEmcfcXzSKBrAqwwBAkJxDakrh8mad1fB6
         A7CRNoBlLjnmKeDiEJnl5M+2k5Gup+pC+cr/0m/WIhb3gY7w1qjc6pkbKXxMVapiUm0x
         NLf3UKvUH36CYKHjkD2cFtMYcVIjLL6TiyxOoznJIIEG+MNp6brVUNkBsSIp19YftFCI
         36vg==
X-Gm-Message-State: AOAM533GGgiDg0VqOOKr0lk5fMYkhS4uDF1AmM/PqI7292cOMXOcpHYi
        Ys7fkPty3xpzfb1/ESk5I+tVqO8S6dWuRwdhV6CHdA1cP4mEq1Ej8OdkXuPHy8FuhDSpb2jTEa/
        u7y0JTHsReYfAw1Gor/46nkwS
X-Received: by 2002:ac8:7d0d:0:b0:2e0:4e16:d3e3 with SMTP id g13-20020ac87d0d000000b002e04e16d3e3mr596099qtb.140.1646427845910;
        Fri, 04 Mar 2022 13:04:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl8+Ou2jNdvl2lw+bUe6/hKRdnkUMPqvw52WVW8CnKDZfAXFw9zzSyaFkAoX7LqTGuVUhhjg==
X-Received: by 2002:ac8:7d0d:0:b0:2e0:4e16:d3e3 with SMTP id g13-20020ac87d0d000000b002e04e16d3e3mr596051qtb.140.1646427845459;
        Fri, 04 Mar 2022 13:04:05 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002de711a190bsm4066708qty.71.2022.03.04.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:04:05 -0800 (PST)
From:   trix@redhat.com
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, ville.syrjala@linux.intel.com,
        matthew.d.roper@intel.com, lucas.demarchi@intel.com,
        airlied@redhat.com, imre.deak@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915: rework the error handling in *_dpll_params
Date:   Fri,  4 Mar 2022 13:03:55 -0800
Message-Id: <20220304210355.608898-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
intel_dpll.c:472:31: warning: The left operand of '-'
  is a garbage value [core.UndefinedBinaryOperatorResult]
  this_err = abs(clock.dot - target);
                 ~~~~~~~~~ ^

In a loop clock.dot is set on successful call to
i9xx_calc_dpll_params().  If the call fails, the later
*is_valid() will use the previous loop's clock.dot.

The *_dpll_params functions return an arithmetic statement
with the clock.dot as the variable.  Change the error handler
to set clock.dot to 0 and jump to the return statement.

Fixes: dccbea3b0704 ("drm/i915: calculate the port clock rate along with other PLL params")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dpll.c | 32 ++++++++++++++---------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll.c b/drivers/gpu/drm/i915/display/intel_dpll.c
index 0ae37fdbf2a5b..ba7cada704288 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll.c
@@ -309,11 +309,13 @@ int pnv_calc_dpll_params(int refclk, struct dpll *clock)
 {
 	clock->m = clock->m2 + 2;
 	clock->p = clock->p1 * clock->p2;
-	if (WARN_ON(clock->n == 0 || clock->p == 0))
-		return 0;
+	if (WARN_ON(clock->n == 0 || clock->p == 0)) {
+		clock->dot = 0;
+		goto end;
+	}
 	clock->vco = DIV_ROUND_CLOSEST(refclk * clock->m, clock->n);
 	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
-
+end:
 	return clock->dot;
 }
 
@@ -326,11 +328,13 @@ int i9xx_calc_dpll_params(int refclk, struct dpll *clock)
 {
 	clock->m = i9xx_dpll_compute_m(clock);
 	clock->p = clock->p1 * clock->p2;
-	if (WARN_ON(clock->n + 2 == 0 || clock->p == 0))
-		return 0;
+	if (WARN_ON(clock->n + 2 == 0 || clock->p == 0)) {
+		clock->dot = 0;
+		goto end;
+	}
 	clock->vco = DIV_ROUND_CLOSEST(refclk * clock->m, clock->n + 2);
 	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
-
+end:
 	return clock->dot;
 }
 
@@ -338,11 +342,13 @@ int vlv_calc_dpll_params(int refclk, struct dpll *clock)
 {
 	clock->m = clock->m1 * clock->m2;
 	clock->p = clock->p1 * clock->p2;
-	if (WARN_ON(clock->n == 0 || clock->p == 0))
-		return 0;
+	if (WARN_ON(clock->n == 0 || clock->p == 0)) {
+		clock->dot = 0;
+		goto end;
+	}
 	clock->vco = DIV_ROUND_CLOSEST(refclk * clock->m, clock->n);
 	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
-
+end:
 	return clock->dot / 5;
 }
 
@@ -350,12 +356,14 @@ int chv_calc_dpll_params(int refclk, struct dpll *clock)
 {
 	clock->m = clock->m1 * clock->m2;
 	clock->p = clock->p1 * clock->p2;
-	if (WARN_ON(clock->n == 0 || clock->p == 0))
-		return 0;
+	if (WARN_ON(clock->n == 0 || clock->p == 0)) {
+		clock->dot = 0;
+		goto end;
+	}
 	clock->vco = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(refclk, clock->m),
 					   clock->n << 22);
 	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
-
+end:
 	return clock->dot / 5;
 }
 
-- 
2.26.3

