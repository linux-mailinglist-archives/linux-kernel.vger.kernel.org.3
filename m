Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909754C116
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbiFOFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbiFOFNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4B29373
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A61E4B81BF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768DAC3411B;
        Wed, 15 Jun 2022 05:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269997;
        bh=+DHhSqosE4XJOM/fy6PqZfeINZkN9gw6GDOPcgfkxIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmmvWJt7/KEN9iqPCpXt88y5IrUee/OKe2tBCoTg3FcnO70ioMynPNBJO6Q7JAlY8
         YKeUotl/SH/UKARFt0EP54uKJEhE/KEmj9mH8G+AxuSuGBbIMF+DcDvmQ6huckjAaK
         EcLPp+QKdf3XlliPYuFHTueqtTL3stU0/p766OIpNj3iLVYcRzWLpBBlXXbim3LqDb
         rQi6VQDdXb2YrsbBZpUYiIgyHotRwxq72P+tBApldM/76xjyZ7CvRhKr2Zw+B/w/FU
         mXYZSzpvVk6heS50n2wfGMtO0TOpxAO1sdjF9nPAPHS30Y8t4La3N3PqH79KvD1HGe
         dZJhPMHGnVVAQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] platform/chrome: cros_ec_proto: return -EPROTO if empty payload
Date:   Wed, 15 Jun 2022 05:12:48 +0000
Message-Id: <20220615051248.1628156-12-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615051248.1628156-1-tzungbi@kernel.org>
References: <20220615051248.1628156-1-tzungbi@kernel.org>
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

cros_ec_wait_until_complete() sends EC_CMD_GET_COMMS_STATUS which expects
to receive sizeof(struct ec_response_get_comms_status) from
cros_ec_xfer_command().

Return -EPROTO if cros_ec_xfer_command() returns 0.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 5323edddb540..0c7042aa2640 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -166,6 +166,11 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
 			break;
 		}
 
+		if (ret == 0) {
+			ret = -EPROTO;
+			break;
+		}
+
 		if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
 			break;
 	}
-- 
2.36.1.476.g0c4daa206d-goog

