Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACB5AB9C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiIBVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIBVCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:02:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02BBADB8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:02:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v15so1805717iln.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=keY88H+1hbyGiRZeqHCulNm4eRlJSKK4BM1mzktooc0=;
        b=ABPQzlV96Q16lH11eCbT2/RhU70y/fWPsS4Exd+elUdxXiWe579ocaIO3r994OB7th
         160hfV1GscmW/buhdfA3u/8Dex3EB3cwsG88+xs8G6TGkYpiXLjvSrZRWfcZpdD4PMLT
         B9OCNmkRRffpls/tAQcT2tsgQmGTlbOS5UkpkFTHE58b6dAVUVZiCpyMqwoYE/ySXPIK
         8SS0i2AhOmCbgpwI/xTBegZmujrpkuGVA0nQFph8kN4fu/v31tk9UZL9dXpPtaFfu8BB
         selIZu1pwurYCgrceVYLn6StBzoFW0TDj3GV2iaV0ZFsW7E6Jy4iXchry//DCEwndBn5
         1NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=keY88H+1hbyGiRZeqHCulNm4eRlJSKK4BM1mzktooc0=;
        b=YFJEjBS7BObXW8Z09OrTHLI0xyWnezc8MIqkfUVgXZwuGnzp7fz7Q1VC9rSme2pXF+
         faoIODKXLw7m02dVwZDFfstHrKNhihVjkBWYHtMS+bf6OajDkpXzGZvxaGnvD0BsBxTT
         ikeBUXDmxttEqRVIwf56z5jJ5cLFaSrgMGiTFqpUk1RCuiV0/aGuPuU041csG+9XCrK5
         ty8imGd8sPM034p9ydjETaCYRjWPQgvpeqXgqPQOaK0c9WbhYDWGh+iUua9NiJGsPT8i
         duwSgGuON+dQlyl4CXjHEdtV+oJr1pJuoFN5o2apASbdPeP/WuJ7qv3gSpVnNGJlDvTJ
         sDRQ==
X-Gm-Message-State: ACgBeo3NmF/1vox6dOCGIcLjK3WRy5lDFGRcE+XdAmHtwKIfosmUT5cJ
        e3IYgrogPUf3zThJdymGW3/6BQ==
X-Google-Smtp-Source: AA6agR7QBR4VEiK7Ff13qBJNczp9ygOUOj0dKr2/XrzzwElGRrNV9oi9nouw9sUmWsMLlb6vVIckfA==
X-Received: by 2002:a05:6e02:148a:b0:2ea:37bc:b312 with SMTP id n10-20020a056e02148a00b002ea37bcb312mr20726800ilk.96.1662152547675;
        Fri, 02 Sep 2022 14:02:27 -0700 (PDT)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i7-20020a0566022c8700b00689e718d971sm1259208iow.51.2022.09.02.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:02:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: ipa: further simplify gsi_channel_trans_last()
Date:   Fri,  2 Sep 2022 16:02:17 -0500
Message-Id: <20220902210218.745873-6-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902210218.745873-1-elder@linaro.org>
References: <20220902210218.745873-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a little more refactoring in gsi_channel_trans_last() to simplify
it further.  The resulting code should behave exactly as before.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 46 +++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 841a946bc286a..16df699009a86 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -710,42 +710,32 @@ static void gsi_evt_ring_program(struct gsi *gsi, u32 evt_ring_id)
 static struct gsi_trans *gsi_channel_trans_last(struct gsi_channel *channel)
 {
 	struct gsi_trans_info *trans_info = &channel->trans_info;
+	u32 pending_id = trans_info->pending_id;
 	struct gsi_trans *trans;
-	u16 trans_index;
 	u16 trans_id;
 
-	/* There is a small chance a TX transaction got allocated just
-	 * before we disabled transmits, so check for that.
-	 */
-	if (channel->toward_ipa) {
-		/* The last allocated, committed, or pending transaction
+	if (channel->toward_ipa && pending_id != trans_info->free_id) {
+		/* There is a small chance a TX transaction got allocated
+		 * just before we disabled transmits, so check for that.
+		 * The last allocated, committed, or pending transaction
 		 * precedes the first free transaction.
 		 */
-		if (trans_info->pending_id != trans_info->free_id) {
-			trans_id = trans_info->free_id - 1;
-			trans_index = trans_id % channel->tre_count;
-			trans = &trans_info->trans[trans_index];
-			goto done;
-		}
-	}
-
-	/* Otherwise (TX or RX) we want to wait for anything that
-	 * has completed, or has been polled but not released yet.
-	 *
-	 * The last completed or polled transaction precedes the
-	 * first pending transaction.
-	 */
-	if (trans_info->polled_id != trans_info->pending_id) {
-		trans_id = trans_info->pending_id - 1;
-		trans_index = trans_id % channel->tre_count;
-		trans = &trans_info->trans[trans_index];
+		trans_id = trans_info->free_id - 1;
+	} else if (trans_info->polled_id != pending_id) {
+		/* Otherwise (TX or RX) we want to wait for anything that
+		 * has completed, or has been polled but not released yet.
+		 *
+		 * The last completed or polled transaction precedes the
+		 * first pending transaction.
+		 */
+		trans_id = pending_id - 1;
 	} else {
-		trans = NULL;
+		return NULL;
 	}
-done:
+
 	/* Caller will wait for this, so take a reference */
-	if (trans)
-		refcount_inc(&trans->refcount);
+	trans = &trans_info->trans[trans_id % channel->tre_count];
+	refcount_inc(&trans->refcount);
 
 	return trans;
 }
-- 
2.34.1

