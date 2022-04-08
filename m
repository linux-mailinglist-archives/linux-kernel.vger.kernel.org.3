Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A254F904B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiDHIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiDHIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:03:09 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BC10E548
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=tlytTLsKpuU/sl
        CZe9lQ4C9OV9T4f+EbPMiEe+zd9wM=; b=LGhAmM1ao8zNGAqakLszhN8MbQfmwt
        QdXm98BuoXhK/te4GzGZ4TA7MEHnEcgf90d4CaCdzpxEhfs+tY8gL+159hrGt6/B
        PARTUR7puB8IVQTgOJOA2Kad1R1p9sBMgdNcGGuxGyXmnokUjN+k6/4KomMPJS8n
        RWeCxztLzXd94=
Received: (qmail 3517236 invoked from network); 8 Apr 2022 10:00:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Apr 2022 10:00:50 +0200
X-UD-Smtp-Session: l3s3148p1@IRE1/h/cUKQgAQnoAEvdAHNhR6IfKwZI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: core: improve API to make clear that mmc_sw_reset is for cards
Date:   Fri,  8 Apr 2022 10:00:43 +0200
Message-Id: <20220408080045.6497-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408080045.6497-1-wsa+renesas@sang-engineering.com>
References: <20220408080045.6497-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it unambiguous that mmc_sw_reset() is for cards and not for
controllers, we make the function argument mmc_card instead of mmc_host.
There are no users to convert currently.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since RFC:
* don't rename the function but only change the argument type

 drivers/mmc/core/core.c  | 3 ++-
 include/linux/mmc/core.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6f2561469a8f..57c64c0583ac 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2020,8 +2020,9 @@ int mmc_hw_reset(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
-int mmc_sw_reset(struct mmc_host *host)
+int mmc_sw_reset(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	int ret;
 
 	if (!host->bus_ops->sw_reset)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index de5c64bbdb72..6efec0b9820c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -176,7 +176,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
 int mmc_hw_reset(struct mmc_card *card);
-int mmc_sw_reset(struct mmc_host *host);
+int mmc_sw_reset(struct mmc_card *card);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
2.30.2

