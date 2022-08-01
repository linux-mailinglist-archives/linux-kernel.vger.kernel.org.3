Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8495862AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiHACfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiHACfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:35:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166912D18;
        Sun, 31 Jul 2022 19:35:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t2so9246525ply.2;
        Sun, 31 Jul 2022 19:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=05yqPtQPTf7ci9YCnKgRef4tjyfFywaN/GoiFJ0YjOE=;
        b=I7J1Tt2AoMlpWf7ocbBYJyXVFnGRake41dwUCDfgo04DRKkXDA83/TwaZfnII6HmTI
         PY/h2yeLaIeDEmiCLrg8rRJ7gBeYG5enucjxqLCrVmpvoI87i1aP5lgFinwcoqgNyA1C
         0vNvlssNXWIWFvcTELv7P/Bv15uQmploiYXbfD1zr/lnO2QGXl+5TMAeD8Ue9X6rbN1v
         qJLR+CHFOzcdOLxkWR4wknaRuajUYinbKD9yfyueiuiUcMd1U91dmPuExOoAmYinz9Xc
         dE+8fTlkpSL9ZyoCjjxa4QDEcXT4iWihb5LSOlhpW4zyVhgCh1QxQfYW2okpkHAsRybK
         fpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=05yqPtQPTf7ci9YCnKgRef4tjyfFywaN/GoiFJ0YjOE=;
        b=cSrkdaP6wJeIMMJA2P+aJq+kt/i7mvPkMZA7otD35CMSx7uRT8uth2pY537ylMr9Md
         8mTQG7wCS8OTS5lYEQ91quFWp4bxISMRG/WZl8GUqqUj6+4JXHBY80vKDNkbmDixEx/9
         ib6i2PZxO00ZhbqTZa+Tf8hTIM2bfeUjFKiPbYC1gzftFjxKDNNPFYML2vgDH3uynjf8
         EWzu91Zvt4my++IpSgMAtN8U2MOIt+IClxT/PCU+5rsnV4DwbBcDYjRPtvhpM43LbrGx
         B6N12vhNAjk7ym3bwAfGMboqkue40R1UOw3tVRafsSiXTNLmBYDSbK04zLyaUIM4xeAO
         nhKw==
X-Gm-Message-State: ACgBeo33eLP65nWl9KIEIjCVm8MBX6qM349d7mmaqLagE52RwDowq5ZK
        U7xwOnUlm5yX3zP9Jf5ycRN7nKX+O9M=
X-Google-Smtp-Source: AA6agR5ANAUOldoWBdgDfPgTkC2NwGER016r7xM3vQLroEoUjf81/eG4YADIx+t9uOGcoXwHYf/4gg==
X-Received: by 2002:a17:903:4054:b0:16d:afc6:e7b5 with SMTP id n20-20020a170903405400b0016dafc6e7b5mr14536856pla.55.1659321301738;
        Sun, 31 Jul 2022 19:35:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090a2f0500b001f218ddd5e2sm10205068pjd.32.2022.07.31.19.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:35:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-remoteproc@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] remoteproc: qcom:q6v5_pas:using the pm_runtime_resume_and_get to  simplify the code
Date:   Mon,  1 Aug 2022 02:34:29 +0000
Message-Id: <20220801023429.1595033-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 98f133f9bb60..6da68a4e5fe9 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -106,9 +106,8 @@ static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
 
 	for (i = 0; i < pd_count; i++) {
 		dev_pm_genpd_set_performance_state(pds[i], INT_MAX);
-		ret = pm_runtime_get_sync(pds[i]);
+		ret = pm_runtime_resume_and_get(pds[i]);
 		if (ret < 0) {
-			pm_runtime_put_noidle(pds[i]);
 			dev_pm_genpd_set_performance_state(pds[i], 0);
 			goto unroll_pd_votes;
 		}
-- 
2.25.1
