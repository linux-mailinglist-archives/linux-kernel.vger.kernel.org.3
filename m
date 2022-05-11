Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721C522F92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiEKJhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbiEKJgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:36:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B215721;
        Wed, 11 May 2022 02:36:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j14so1352346plx.3;
        Wed, 11 May 2022 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g25WGG1vpFupwV33LLgbbZgLkXMYB1hohiIAGu6RTaE=;
        b=d2701dGfOOHvIu1VNj/6HzpmUSUj2fxUHUDvFfGz1Ca8ygUVZsAx4Ob1tdeoIe5rii
         JifK7g1lUgkDDpVZJKVjliKdEl06R+iJ7vyRgqQ+rU9KVRyGljjolfgtOvrU/7lchdk1
         8VdDj9miCQyZJXD8MIsxmCI5jGIm2yWdSu8NhlTKBoyra5qS4WVnrZyHSsRqYs2L8YkK
         btPhed06kRyc+EO2YGf9p4EjnYpMCMId89YIs95BlON6GJyNXx4M2fqIHtIzZM1e+PHY
         OlMq5gHtA49gJVI10OXBLoFTpv+d1pgvzWRxpiIEQMoRj5kt0x2/CoWMTP61ZCUmhWAG
         OORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g25WGG1vpFupwV33LLgbbZgLkXMYB1hohiIAGu6RTaE=;
        b=bTMy9fK3lb/aYBRA61qYSCjgtlX9pRDTi/mWJB/nJvEE3N4f/YnYgOV/DmlclRQkeF
         0IZkWxwSZucBxfSZKbroxPXlHMrEgLNgzKjHvcUkURsvgpImuQZEGVv0bqGlG2I+1c+X
         O7a4yOkIqRm+YCPGam09LsEmHEdhmFfSCdhgDIuXOqP6+zaWX9BuwkUrqpZRgDLfArs0
         Q6N9IYwp5W95TcRWkwPNWHhrXI0hJIuGKzkH3cMrpZyCh39fJfqeibuskCldhRDvOlCa
         AvX/PWJKieWdL1/NQCqsNNzFM4/BPU7b0AMd3vAOYWNblNZf/jmMoYoiyieD12GlYfER
         yYsA==
X-Gm-Message-State: AOAM531oZ3eO0oMk28NtFtLPn9XwX5A9L1QZ07YjrODAKLY9IqaMZl94
        UR7Byi95m9d7iPNFKaRkNWIrWgHz7vrL3Q==
X-Google-Smtp-Source: ABdhPJwdBm4wZXnYUhrC5MEd5rFqnK2251yTbMBWYS+SnW5T2tIrjaBRrNpIuawSFoFlTMyZ0TvMAw==
X-Received: by 2002:a17:903:124a:b0:154:c860:6d52 with SMTP id u10-20020a170903124a00b00154c8606d52mr24773395plh.159.1652261771809;
        Wed, 11 May 2022 02:36:11 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a428e00b001dcf8960a13sm3492640pjg.40.2022.05.11.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:36:11 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 3/4] PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
Date:   Wed, 11 May 2022 18:35:53 +0900
Message-Id: <20220511093554.17535-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511093554.17535-1-cw00.choi@samsung.com>
References: <20220511093554.17535-1-cw00.choi@samsung.com>
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

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
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

