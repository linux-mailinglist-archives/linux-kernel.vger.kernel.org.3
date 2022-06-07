Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C95401E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiFGO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbiFGO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:57:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22652F5068
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC102B81FD1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA9C34114;
        Tue,  7 Jun 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613825;
        bh=XwmnYW1bHgKYNtepxHi8KGRf1O+kTXO80jyusPq+X1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzVeFxAyFzPe9nFnmYvO1FypMb3tgzrKkeeoDqBRC6kKPRAddLXUZfJG9AjpJKREV
         baWgKoWQQ1abzhT3xg+0oZg920gjvSRpbZiRKYndqR3ueKOmpmj24MS9BJLI2Nkwqq
         ntMhIUFo4worJ/262TRzQZpzYZIctwoTiu0dOoKJB5Jn6kc4tA9X9/PW9Ppd6Dfqzp
         mXJoGqV0b+3fu16WCSUq2OSYtyq7AH+OQ1qQCNV7XZCHsNn2lgvfA87l3J1p+nHnOw
         VruWGbtYC+dku6r23FahmCF0yY2BgVh9l5KfddJyvBCma++F2ZNbjCSr8kX24gpHhZ
         nu3JAgsZYoLzQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 11/15] platform/chrome: cros_ec: don't allocate `din` and `dout` in cros_ec_register()
Date:   Tue,  7 Jun 2022 14:56:35 +0000
Message-Id: <20220607145639.2362750-12-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607145639.2362750-1-tzungbi@kernel.org>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
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
No v1.  New in the series.

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

