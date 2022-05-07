Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187851E7F1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446577AbiEGPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446556AbiEGPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:05:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5D43EC8;
        Sat,  7 May 2022 08:02:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 204so5832156pfx.3;
        Sat, 07 May 2022 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHmP6AHhdZCSjkztmWwZOZO3a4TJAX/YU3jVayexPKM=;
        b=ECVo6wp4LzsNTfCuGYokPNMazhFVNQk3epdfkWpzPQZ+Kh91LNUPFLq542YTvnvqmM
         maYGwcw/gAcGdJDiHSGabP81fvHYf7JORePIX44pXGTPY0C+Qh4wiudjnWHlwBwD9JTe
         taOQGagDPx4MCKF75jwY0ZBHDBbgZtbebU8zZlYQsoYIqceEE3dGDObXk9/POdT7qYNS
         Gd5EELItolSeLRO8NyntTk6whxEFXvkru9vVmAaklS+d02mG/VlyvN6AnivgtcL43NVP
         Sw8pAEoJwb/SXztA93e3cXju/eyCx2DMBQ/44pd7XYO67n/8okZzYx5Go2Nkws7DECNL
         28ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHmP6AHhdZCSjkztmWwZOZO3a4TJAX/YU3jVayexPKM=;
        b=gkE5xZtnJfnvQQ8btf0jM+M08RF+5o3OQSY2QDlPM4XOBcnVUNJ1pZvF/H4eLU5MUl
         wqUK/FcJJvpvvBLavzYG6s0WmJ/+5rTJLOZ1qNEYp43HR3KKycaNG/Z/n2nOnxvPIABS
         IaPrv0sJWOJOpQvk1vsTmgje7Hf8/6k8TDLT5wirlu7uldCl2rXaRtIwNTOslgXjmSJ7
         P6YayMtaycdWvUxEStPY6Y3XcUQR2Xg5jRax4T7zAtJt5SQ41xgXdTbD8tA9TJGVRGUT
         UQIBa9NEfbvOSzNuWXToa36egB/umQGoLPngeDo19ozSog+dImS++2Y+r+0BuINTrt+O
         LkaQ==
X-Gm-Message-State: AOAM531SCQUfz/Dwqp4zKHqjVFFijzUZ6LbP4Uueg43qw+XmT2Cbfh1E
        v0FAlrDOcKtLj9xMxqIlYk2DAxM6kyQCdQ==
X-Google-Smtp-Source: ABdhPJz1JkUn8Ya+hkFn+u0CuKE0vB89nZCjO6twgPIjNC2psJ9ViOXV5Ax5QolJdasnJIlrfdOI+g==
X-Received: by 2002:a63:680a:0:b0:3c2:7c45:c0ab with SMTP id d10-20020a63680a000000b003c27c45c0abmr6908684pgc.63.1651935723475;
        Sat, 07 May 2022 08:02:03 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902ca9500b0015e8d4eb2a8sm3711007pld.242.2022.05.07.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 08:02:03 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com
Subject: [PATCH v2 3/5] PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
Date:   Sun,  8 May 2022 00:01:43 +0900
Message-Id: <20220507150145.531864-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507150145.531864-1-cw00.choi@samsung.com>
References: <20220507150145.531864-1-cw00.choi@samsung.com>
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
index bfbe5604538d..a738a30eb3c0 100644
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

