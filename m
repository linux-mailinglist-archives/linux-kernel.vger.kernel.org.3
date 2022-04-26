Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87D50F947
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbiDZJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbiDZJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:57:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E924387B2;
        Tue, 26 Apr 2022 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650964554; x=1682500554;
  h=from:to:cc:subject:date:message-id;
  bh=IbCZhL5dtMpAnfh6d6qY6fF2LqJySHYeU8LCRLMN9ng=;
  b=W1vnJkRM+ce2cT1BOG3+ujXevnBsywjEHYInTHuOj7RaOKZI60xmG4NW
   wTpx1H3KUlcrc5NXtLWuYgMmCP2zq0TXVjsWQhG1+9gJEgo/CcOgsn/Nv
   rLFhg43tVabC2JI1DqJW+kd6O33T6/1goh2cGAKL+3U7Ijy64IiwisXaW
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 02:15:54 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2022 02:15:53 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 26 Apr 2022 14:45:35 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 98D8A3AEA; Tue, 26 Apr 2022 14:45:34 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     ulf.hansson@linaro.org, avri.altman@wdc.com,
        linus.walleij@linaro.org, vbadigan@codeaurora.org,
        shawn.lin@rock-chips.com, s.shtylyov@omp.ru, merez@codeaurora.org,
        wsa+renesas@sang-engineering.com, briannorris@chromium.org,
        sayalil@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kishor Krishna Bhat <quic_kishkris@quicinc.com>,
        kamasali <quic_kamasali@quicinc.com>,
        Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: [PATCH V1] mmc: core: Select HS mode in device first and then in the host
Date:   Tue, 26 Apr 2022 14:45:32 +0530
Message-Id: <1650964532-9379-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sayali Lokhande <sayalil@codeaurora.org>

While switching from hs400 to hs200 mode, high speed mode
timing should be selected in the device before changing the
clock frequency in the host. But current implementation,
(mmc_hs400_to_hs200) first updates the frequency in the host
and then updates mode in the device. This is a spec violation.
Hence update the sequence to comply with the spec.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Kishor Krishna Bhat <quic_kishkris@quicinc.com>
Signed-off-by: kamasali <quic_kamasali@quicinc.com>
Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 drivers/mmc/core/mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8691c00..b4bcebc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1259,10 +1259,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	int err;
 	u8 val;
 
-	/* Reduce frequency to HS */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
@@ -1276,6 +1272,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
-- 
2.7.4

