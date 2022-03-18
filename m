Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72714DDB66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiCROQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiCROQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:16:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC66125718F;
        Fri, 18 Mar 2022 07:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67730B823E0;
        Fri, 18 Mar 2022 14:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12665C340EC;
        Fri, 18 Mar 2022 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647612894;
        bh=yTCl81Bijd2qcUVd8R+X71hdx9fBecmpYWObswzq7HE=;
        h=From:To:Cc:Subject:Date:From;
        b=dfSdF0aZTeZL279RotjOfSOG/aTFeqHy1u72eAPdMTpKDWV2qKOpdHhbraPMk/40I
         wwpKR2uZ5mp7jhfP8majiRI86ged94Sz+MNl7+XV8YrBa/57Nvdl/gIfeT6oN+4Lzv
         PccE7JTuL0ipwxa8ZLuUTI8oaFMcdVU4y5LJOX0CBJV+UUvM2AMRcI7wSj2JzDFRJ0
         KbjxMB3Motj7KXu3ORPqjMvNxPWthzgUnZAX76wEubUFb7HopthhOU4tcH1bfrmsNL
         vWCkw6EXEvCvWms6tvpOuNv6CwpKXnwz93e3iygpjI4N6l25g4IIY82iWLFV1PnrcG
         tCZZQXJ0poDTg==
Received: by pali.im (Postfix)
        id 1CD9A9CF; Fri, 18 Mar 2022 15:14:51 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Marcin Wojtas <mw@semihalf.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"
Date:   Fri, 18 Mar 2022 15:14:41 +0100
Message-Id: <20220318141441.32329-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bb32e1987bc55ce1db400faf47d85891da3c9b9f.

Commit 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v regulator stabilization")
contains proper fix for the issue described in commit bb32e1987bc5 ("mmc:
sdhci-xenon: fix annoying 1.8V regulator warning").

Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable")
Cc: stable@vger.kernel.org # 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v regulator stabilization")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mmc/host/sdhci-xenon.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 666cee4c7f7c..08e838400b52 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -241,16 +241,6 @@ static void xenon_voltage_switch(struct sdhci_host *host)
 {
 	/* Wait for 5ms after set 1.8V signal enable bit */
 	usleep_range(5000, 5500);
-
-	/*
-	 * For some reason the controller's Host Control2 register reports
-	 * the bit representing 1.8V signaling as 0 when read after it was
-	 * written as 1. Subsequent read reports 1.
-	 *
-	 * Since this may cause some issues, do an empty read of the Host
-	 * Control2 register here to circumvent this.
-	 */
-	sdhci_readw(host, SDHCI_HOST_CONTROL2);
 }
 
 static unsigned int xenon_get_max_clock(struct sdhci_host *host)
-- 
2.20.1

