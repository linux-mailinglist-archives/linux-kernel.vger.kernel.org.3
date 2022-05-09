Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9A51FC34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiEIMIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiEIMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:07:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C118B97E;
        Mon,  9 May 2022 05:03:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso16833849pjb.1;
        Mon, 09 May 2022 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G91FP2kdxPJqQWpl2gzd87PoVI6tPI5VOFgNQA9koO4=;
        b=XEAXQJ39bFgOpxmA091ggA0yryBWnNNHdn5AI5+VXuCvie1plVl+zHDxHU9W3g6Clx
         GlPyEtNcp2Xi8GRa/7qsGDO6OVqMsOwNg+I/F7BN5lwXvL8RnKU8k87HGNduXYdz7/XC
         gq7GesuyPithvZC5nI/n86M58WwvOE/kwfoDlQ/aKJMTvsMcQktk3c6WLMACZXgfcNNn
         ZTXkFBhJ/T0qA287GBpquC5WFoRxwkvoQt9h2kBjHeUc+MwApKovYRChCBbN6KhlOcOW
         53LZ1mm8XU9emQDkzHAJiSh8IbalsWzsWNllS0VbgRkvbbMXIRIdzmOQdSXXKPxeVsln
         fT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G91FP2kdxPJqQWpl2gzd87PoVI6tPI5VOFgNQA9koO4=;
        b=6HAHc6DfsKyRhYi8IFPIM3QMZV/uOudpALIXzjqvl442phm62FvlMFnV0Ye8xphtbh
         Nm3mxA+sN/zh530a9AHYmUfIU+Ilm9m8joRh2K9VtyR/X0yBMdlmBojMCh6ev4yMPnJJ
         aRmz7ygBClhCkuO9SNROMQ+bZ3vZ7hD9QDUMYI8AHiI7OvD1VacDwL3JjGJJtk5fTAwx
         tNp8YO5S4S5q16bX9waRAnFl3pD4pbj9sG4S0Rn0d30bkV0Ksf+iNqOVuoLOjh//Oilq
         OTRbMFO5RubpboC3j9zAmHnzCO0+rsEhtzNo7Z6FH+nACIVgL/viC53HYSl1Xn9eR2I0
         2g6w==
X-Gm-Message-State: AOAM530xv7OJxrBUkd99NL0FMEMz40Cqt/3XJ0037vKINBZ2DMf+zuEB
        a7d8/mvqkscyrmX7Okseu+K5lw6STwTwxA==
X-Google-Smtp-Source: ABdhPJwWKZUOd+ibpdk60tmfB9dVdiKtw7LPyFzjey1ZEcl1VaDe0ZwQt5pkRa7bpc1H/dkaTBo2Pg==
X-Received: by 2002:a17:90b:3901:b0:1dc:5a24:691 with SMTP id ob1-20020a17090b390100b001dc5a240691mr26215318pjb.40.1652097835245;
        Mon, 09 May 2022 05:03:55 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0015e8d4eb245sm7020283plh.143.2022.05.09.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:03:55 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3 3/4] PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
Date:   Mon,  9 May 2022 21:03:36 +0900
Message-Id: <20220509120337.92472-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509120337.92472-1-cw00.choi@samsung.com>
References: <20220509120337.92472-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep the consistent coding style between passive_devfreq
and passive_cpufreq, use common code for handling required opp property.
Also remove the unneed conditional statement and unify the comment
of both passive_devfreq and passive_cpufreq when getting the target frequency.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 66 ++++--------------------------
 1 file changed, 8 insertions(+), 58 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3fba05beaf24..db02f5219684 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -92,65 +92,16 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp, *p_opp;
 	int i, count;
 
-	/*
-	 * If the devfreq device with passive governor has the specific method
-	 * to determine the next frequency, should use the get_target_freq()
-	 * of struct devfreq_passive_data.
-	 */
-	if (p_data->get_target_freq)
-		return p_data->get_target_freq(devfreq, freq);
+	/* Get target freq via required opps */
+	child_freq = get_target_freq_by_required_opp(parent_devfreq->dev.parent,
+						parent_devfreq->opp_table,
+						devfreq->opp_table, *freq);
+	if (child_freq)
+		goto out;
 
-	/*
-	 * If the parent and passive devfreq device uses the OPP table,
-	 * get the next frequency by using the OPP table.
-	 */
-
-	/*
-	 * - parent devfreq device uses the governors except for passive.
-	 * - passive devfreq device uses the passive governor.
-	 *
-	 * Each devfreq has the OPP table. After deciding the new frequency
-	 * from the governor of parent devfreq device, the passive governor
-	 * need to get the index of new frequency on OPP table of parent
-	 * device. And then the index is used for getting the suitable
-	 * new frequency for passive devfreq device.
-	 */
-	if (!devfreq->profile || !devfreq->profile->freq_table
-		|| devfreq->profile->max_state <= 0)
-		return -EINVAL;
-
-	/*
-	 * The passive governor have to get the correct frequency from OPP
-	 * list of parent device. Because in this case, *freq is temporary
-	 * value which is decided by ondemand governor.
-	 */
-	if (devfreq->opp_table && parent_devfreq->opp_table) {
-		p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
-						freq, 0);
-		if (IS_ERR(p_opp))
-			return PTR_ERR(p_opp);
-
-		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
-						    devfreq->opp_table, p_opp);
-		dev_pm_opp_put(p_opp);
-
-		if (IS_ERR(opp))
-			goto no_required_opp;
-
-		*freq = dev_pm_opp_get_freq(opp);
-		dev_pm_opp_put(opp);
-
-		return 0;
-	}
-
-no_required_opp:
-	/*
-	 * Get the OPP table's index of decided frequency by governor
-	 * of parent device.
-	 */
+	/* Use interpolation if required opps is not available */
 	for (i = 0; i < parent_devfreq->profile->max_state; i++)
 		if (parent_devfreq->profile->freq_table[i] == *freq)
 			break;
@@ -158,7 +109,6 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 	if (i == parent_devfreq->profile->max_state)
 		return -EINVAL;
 
-	/* Get the suitable frequency by using index of parent device. */
 	if (i < devfreq->profile->max_state) {
 		child_freq = devfreq->profile->freq_table[i];
 	} else {
@@ -166,7 +116,7 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 		child_freq = devfreq->profile->freq_table[count - 1];
 	}
 
-	/* Return the suitable frequency for passive device. */
+out:
 	*freq = child_freq;
 
 	return 0;
-- 
2.25.1

