Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F054C115
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbiFOFNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbiFOFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:13:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D3286F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF108B81BF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B919EC341C0;
        Wed, 15 Jun 2022 05:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269993;
        bh=ouMi+OrOc1vdWAJZIxurgSh0grbjdWfmqXvHpzaOysA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdBgEqbehzX3muATuka1QXahgd/QR7A/6g84zTd6wEpvPjeWadHV7XbFKzdVxH1tQ
         R/RneL0rTryU1we8pa2Z5MrNRDLCrCxCxPX7E49bycU1J1EzOE4/E2tXdwj4Ohzh31
         mBomMgFuUTGjPjoJpfGF+Q/Egjg3m4Jbon6VIYxKaznBxkHQsF6h+XyoMXgHscf+xH
         oW+hpXnY4VdifBa+iXbTyTMjLJDRfHXjXplz+6aeYZX/5nGawuMQD0QRosIYVieSjD
         74ZLSaQ/6zVoJISaWfNHonppDJRsh0Aw4ahb3SOxGFzfUWkZBp3GrIRxiBrzppiTvy
         beaC7kUh+OmKg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] platform/chrome: cros_ec_proto: change Kunit expectation for EC errors
Date:   Wed, 15 Jun 2022 05:12:45 +0000
Message-Id: <20220615051248.1628156-9-tzungbi@kernel.org>
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
2.36.1.476.g0c4daa206d-goog

