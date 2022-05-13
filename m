Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F740525ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377005AbiEMEl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352463AbiEMElz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C566C9C2F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 635E16193E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1EC34117;
        Fri, 13 May 2022 04:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652416913;
        bh=ycSplfvhJBgyqVaDnwdG10RG2hZTpSWYOLvcXcTWo7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEndrKx+qPfxAUAvAituNyZ2R+oklYxuUMRfZJUb2Kj8L+mp1Z2M0ju0HsXE9HYew
         I1e3zaWVNA8oR2eMouWMG154Ux2B9HfR9S6Nvmud0hIbXFSVcWCSHaHCcwiXZh4dbT
         49vPszc/3s01iSBw04ONhFschQOEALSaZ08tupJ3AoJYe9T0vyjgRFLXxpdw9uHeSX
         Sdhwv0XAky7OyPrs5Lg+NnDJafm6i19rbUcHN+lhaKSd6+VEP90HZkSyCyvb1tN1m0
         VJ4z3jLcEwROP9NK1R8GnM2gdw6jtrq21FspQzhc7D97Kf7LMo50MNO4Pngp1zamq0
         By9Y2pucWhqow==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] platform/chrome: cros_ec_proto: drop unneeded BUG_ON() in prepare_packet()
Date:   Fri, 13 May 2022 12:41:37 +0800
Message-Id: <20220513044143.1045728-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220513044143.1045728-1-tzungbi@kernel.org>
References: <20220513044143.1045728-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_packet() gets called if `ec_dev->proto_version` > 2.  For now, it
must be equivalent to EC_HOST_REQUEST_VERSION.

Drop the BUG_ON().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ac1419881ff3..db1c8ba43171 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -60,7 +60,6 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
 	int i;
 	u8 csum = 0;
 
-	BUG_ON(ec_dev->proto_version != EC_HOST_REQUEST_VERSION);
 	BUG_ON(msg->outsize + sizeof(*request) > ec_dev->dout_size);
 
 	out = ec_dev->dout;
-- 
2.36.0.550.gb090851708-goog

