Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D165862A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiHACeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiHACdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:33:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937312D09;
        Sun, 31 Jul 2022 19:33:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r186so8526855pgr.2;
        Sun, 31 Jul 2022 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8giRET0pvaf54yPGh/kXDfoNJjjS3Fva+lNxv26CL/o=;
        b=GO8tf+XCcCK7Md0o632eTEN0OeCkG5fDikPw4CVVpsjC/W9mXWzLTcISyi1+FCgI3c
         GREa4i3vPiKqMP7/K9eLgxwZsmPk8YHb8oHHEdq2mDeqqZlyJ7AupxZWd5bnFg0Ru8im
         bbKHb+DKsSAntCHuMrl7lCJTuh350ILV2JaZWURZ+br1qH9c9ekK0NbgLHSFM8KZyMbr
         /w4Zp0rrWDPSbVM3yWtwjaWRgvkyu8C42wkANwN9mM8/QgyLJ4EOErT6D0KSHgaiWrAM
         TG3Jp9EaoLhEp/fnlhPw52IT8qCvMM935kf6kuUt5bES1A+0HwKa9ibb62j7QcX/3MQB
         X2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8giRET0pvaf54yPGh/kXDfoNJjjS3Fva+lNxv26CL/o=;
        b=gkW/qHtMgATB/AWXJ1y0+PoQtIEr3Y2Bm9UTy6GVN+ugcrm5//qTHo8oD+ShsbujhG
         YQ/rOnswl7qzDatw2m2IAv8srwfA9RlIgRCztvIExQGq/RTo7sXUnFAd7lqkAxknSYoz
         ByFDf6VAqE2UinQnnKur2T4QdaAxya1RIKoGAdpv5EhcQB468KjVCFGspvVjaDzdDfIT
         jR1Wvs2/1amZnelllPG77AgSeqYeAq778+sHJDIK6ZLafr4jHZUsf4IAwKglOkyDhWb+
         pR161Rchnb7+zsAyt86SEBN33HqkXq6xvnyQH8C4q+PpyFAR0SVjrdBKJ4grWZqUav9g
         zHdw==
X-Gm-Message-State: AJIora8umb7XZkeg4ObrJcfj+yQXw8pkgxTRaDcyF42xOIV227Rw6Gbi
        UtHKeN7/MV2+J7NDwSTpV2vKe2JlBCE=
X-Google-Smtp-Source: AGRyM1ueKIW1nzxQnEbz04idMC21pMzfI2Ajc5GRnQXCVfM1az8nJ76K+tryPdFzGJiaVGMVeGOyTA==
X-Received: by 2002:a05:6a00:1797:b0:52a:f2e9:ddd2 with SMTP id s23-20020a056a00179700b0052af2e9ddd2mr13686921pfg.12.1659321231747;
        Sun, 31 Jul 2022 19:33:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016dc240b24bsm8267630plg.95.2022.07.31.19.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:33:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-remoteproc@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] remoteproc: qcom:using the pm_runtime_resume_and_get to  simplify the code
Date:   Mon,  1 Aug 2022 02:33:47 +0000
Message-Id: <20220801023347.1594969-1-ye.xingchen@zte.com.cn>
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
 drivers/remoteproc/qcom_q6v5_mss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index fddb63cffee0..738daac2ca71 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -374,9 +374,8 @@ static int q6v5_pds_enable(struct q6v5 *qproc, struct device **pds,
 
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
