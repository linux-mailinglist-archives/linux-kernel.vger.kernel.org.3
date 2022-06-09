Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278A54469D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbiFIIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbiFIIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57748330
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EEF0B82C83
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544E1C3411F;
        Thu,  9 Jun 2022 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764636;
        bh=f069RBwbvty/hrrbrykAMX7yJ7tJNSW+6U5hCyLUYZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZVRsKg6IuidfW4OHyD38cNwoXMeI+q7JwwJR5X2jQ4FTW+8TABWe0iLL2JoegLuU
         ZWuAWiyt8gJVzhuYhw2EuGQr6MM+rE1eVU8qkSXkrbGoCVYfDUVJqgP9kNRMNJnP6P
         kBMhm5EQctfHNK6wtbme59c62XRfa8e7XsAT6pK+6So9MrvkboxGeRXbKqs44LRsZl
         zDsOlB+FDXPP48AfG2094Au/BvzQc13K4SWbtghql8X8154dGdFh/qbjuDDnvMewNu
         +ubO54aicN6AGljp4KifbyIMufUSj3m6vYDrvhMY+glpW2sVQE0XifY197RXGtn6ey
         baJcRH10Zn+Dg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/21] platform/chrome: cros_ec_proto: handle empty payload in getting cmd mask
Date:   Thu,  9 Jun 2022 08:49:54 +0000
Message-Id: <20220609084957.3684698-19-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609084957.3684698-1-tzungbi@kernel.org>
References: <20220609084957.3684698-1-tzungbi@kernel.org>
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

cros_ec_get_host_command_version_mask() expects to receive
sizeof(struct ec_response_get_cmd_versions) from send_command().  The
payload is valid only if the return value is positive.

Return -EPROTO if send_command() returns 0 in
cros_ec_get_host_command_version_mask().

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ac445bbbd060..28c103315144 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -458,6 +458,11 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 		goto exit;
 	}
 
+	if (ret == 0) {
+		ret = -EPROTO;
+		goto exit;
+	}
+
 	rver = (struct ec_response_get_cmd_versions *)msg->data;
 	*mask = rver->version_mask;
 	ret = 0;
-- 
2.36.1.255.ge46751e96f-goog

