Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E87542EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiFHLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiFHLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC02050C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DCECB826EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65284C34116;
        Wed,  8 Jun 2022 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686484;
        bh=nAbRLFK4360U012nvucyvlqxP543Oerph53JukK7/3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Twd+zXE+e5lzG51zZu+JGVvFxl046d+PgY2ChI6Kia+1wKf2gNrMNqL7DvEFlWV/D
         GUqVHGV3HSDQcOjFgAMTyHPbhm2SFKfKNTrbMyqERNUFk5x0VAAxa4JsH4737X4mtX
         YmnnT4oOJJgLkLp+JLuC8CUstRf22ydkBwRVblmYPxDgtHocLv3w/vt+Ob1RXSs6po
         lG7WRzDvVwjEB4LfXp+p0H3IaqbT7zG11VYyFtCULCHSMghxh+NTS78Cm8MMRp+NZM
         4N1pMrmD7T+SZjX2kIU62LF+QEPxQQOmS13SGa3pdz9bi6Em1OtDigL8e0l5YVQT3f
         F69z2h8uZw81w==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/23] platform/chrome: cros_ec: don't allocate `din` and `dout` in cros_ec_register()
Date:   Wed,  8 Jun 2022 11:07:24 +0000
Message-Id: <20220608110734.2928245-14-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608110734.2928245-1-tzungbi@kernel.org>
References: <20220608110734.2928245-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allocate `din` and `dout` in cros_ec_register() as they will be
allocated soon in cros_ec_query_all().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No change from v2.

 drivers/platform/chrome/cros_ec.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index e51a3f2176c7..29d3b544dafb 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -188,14 +188,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	ec_dev->max_passthru = 0;
 	ec_dev->ec = NULL;
 	ec_dev->pd = NULL;
-
-	ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
-	if (!ec_dev->din)
-		return -ENOMEM;
-
-	ec_dev->dout = devm_kzalloc(dev, ec_dev->dout_size, GFP_KERNEL);
-	if (!ec_dev->dout)
-		return -ENOMEM;
+	ec_dev->din = NULL;
+	ec_dev->dout = NULL;
 
 	mutex_init(&ec_dev->lock);
 
-- 
2.36.1.255.ge46751e96f-goog

