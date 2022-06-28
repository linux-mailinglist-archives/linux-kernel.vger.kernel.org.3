Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7D55DC54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiF1Ct7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343789AbiF1Ctp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A26F29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86D93B81BC2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CD0C341CF;
        Tue, 28 Jun 2022 02:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656384582;
        bh=MY2CsMAMjNg3ebYD8mcpnnStMEQdNHHn6XyNk73BJns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cyj0asfmbcWRj+P0vYwcNJAQzXxyVEwl1Fqu+MX2+CSbO56uL+eFaZ/wf/fHF5s1y
         AYnj+ClwJrZg21B3BGFIo7V6QVPzLuBWhYy/ATo2FehHCJE3kmP3BHFwbeDEaXV507
         ytgaFg5DJewASj3L4o277RpAQ8m8UmMaqYBpf6Lf7KoHfyP037RelpfVPp6CKPuPv4
         WqKYF8lzaTEpClxmNfAiDaGNwDL1yo2pVaJj1OJrjOzHDBvzqcjMsPAmbrhdua0GAn
         9MYHnRr7LR03/pimbrEv/Z3UQ0nyK0KbFgRV1BOsmFE6BFcKEgWT6mOur1ABUPleIx
         lSRCwyO3Vz0eA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 08/11] platform/chrome: cros_ec_proto: change Kunit expectation for EC errors
Date:   Tue, 28 Jun 2022 02:49:10 +0000
Message-Id: <20220628024913.1755292-9-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628024913.1755292-1-tzungbi@kernel.org>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_wait_until_complete() checks `msg->result` for
EC_CMD_GET_COMMS_STATUS.  However, it doesn't return standard error codes
like most of others.

Change the Kunit test expectation to align them.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index fbb872040711..2a6b099fbfd9 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -1927,7 +1927,7 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_return_error(struct kunit *t
 	}
 
 	ret = cros_ec_cmd_xfer(ec_dev, &msg);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
 
 	KUNIT_EXPECT_EQ(test, msg.result, EC_RES_INVALID_COMMAND);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

