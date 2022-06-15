Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02054C119
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbiFOFNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbiFOFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6429A26AED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A4B61697
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4A4C34115;
        Wed, 15 Jun 2022 05:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269992;
        bh=1Ziar4/L2yYTjXxZ9eePmtAtdMdL2lsbb8Bw9TmQToM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdnTk7gYSmjQxxysxldnd/wF83UM/qfSHCYgSTCoCc5JzgqyXiXzYbsW7vi8uvyX0
         WeFNf/DdKmngt3KkjrPHI1BSAnrJD1Lw/Ry7E7Yo9pkmcne2ImOZsXttF7ANG/rONq
         nRl00diCDDt3sM2yGN6jVDlcWGq5pPuseprUYDVDSkNBmUVOfhHHEoGtf22/pEfu81
         XOIzg8Jgwdr+KlaTFUd+FbUgcgwCQ5KQFAdEAeCMSocNJz+yfa+xhPTYJcBFx4kuFB
         JDj3hX0I6+sKR1sQ0Cc7I4vtm7BEYDobjSatrfYtUNcmdyAf6J2jxEqdCS7kewdQls
         pjq+IO3NY0nJw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] platform/chrome: cros_ec_proto: return -EAGAIN when retries timed out
Date:   Wed, 15 Jun 2022 05:12:44 +0000
Message-Id: <20220615051248.1628156-8-tzungbi@kernel.org>
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

While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
cros_ec_wait_until_complete() doesn't return an error code.

Return -EAGAIN in the case instead.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 466ecb063bd6..49772a4c5353 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -167,6 +167,9 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
 			break;
 	}
 
+	if (i >= EC_COMMAND_RETRIES)
+		ret = -EAGAIN;
+
 	kfree(msg);
 	return ret;
 }
-- 
2.36.1.476.g0c4daa206d-goog

