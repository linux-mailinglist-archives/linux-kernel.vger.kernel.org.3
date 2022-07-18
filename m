Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD4577A47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiGRFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiGRFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C599120BC
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8A0EB80E4C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98B8C341D0;
        Mon, 18 Jul 2022 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658121015;
        bh=AiSiBQ+ZaUZkBmavl4dmYj+PPOpZmD0zS6L5wecAMb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dl6hlM84u/rIJC03z6Acjppsw5YvKJqmX/f4eXYe8cxJtRQ9a83UHYRO06bf44hSq
         lg95VYqHbnPrkCPsH0qb3SOGOnCJ7Aye5lI9pLx6gVK1RRtUmUeCnxS9hIJ10pS8F/
         jYSlK2O3j6z4/9vCZhaI6FGbQzG8wuSBidQmiUtpAOzg8zLeZNfqr0Tg/jefx8Jo6M
         nQ02D8lHWq27Eoqj9S/QiTmzoNU0NztX5WDKSlwn+zF3eFiLTLtDTS1Fuqj/f6mRXh
         I95bHfEm2UBS//PzDg5K0IyB4CS2hZ5Tpab5ZSRreJwO0LT+aLX3XIuR2On3Q8o8Rn
         DZCIP6gDPk2UA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] platform/chrome: cros_ec_proto: change Kunit expectation when timed out
Date:   Mon, 18 Jul 2022 05:09:11 +0000
Message-Id: <20220718050914.2267370-8-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220718050914.2267370-1-tzungbi@kernel.org>
References: <20220718050914.2267370-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
cros_ec_wait_until_complete() doesn't return an error code.

Change the expectation to an error code.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 64100fd81c6a..fbb872040711 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -1870,9 +1870,7 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing(st
 	}
 
 	ret = cros_ec_cmd_xfer(ec_dev, &msg);
-	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_comms_status));
-
-	KUNIT_EXPECT_EQ(test, msg.result, EC_RES_SUCCESS);
+	KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
 
 	/* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
 	KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 51);
-- 
2.37.0.170.g444d1eabd0-goog

