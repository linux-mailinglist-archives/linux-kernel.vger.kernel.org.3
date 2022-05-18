Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698CE52B63A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiERJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiERJSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:18:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB301EAF2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66A94B81ED3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FE4C385A5;
        Wed, 18 May 2022 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865516;
        bh=L6zkHW06fOBMQjiYiu7OCLitsyF4v1uG+91rOEJs/Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjspsp5e6ukLQwNI1J4c/+gb4HkGQ1sD/RAHBBjHXEoyfXy7FTV1EZ0eVplVhzIzX
         M/HDaPXzxxogF4t3/jLeEcuEzlRXAGgHu4eHLOkLeAAS+lBaKTZfQFGqaXT+u5U1tV
         GMW4562QDIGPCIqik/v2M9KIaI3fpLr9/yMNLDpQBtcJk5n9uS3fZWgzLnNFjRr0Sk
         lM+eoLIozVWOi5ju8sLLpLizuevXozsT0CPq65iNh5j2OdzOw15lA4PRh7+obuG1TW
         f5aMt9aqYHRc/CYyA1sTGwJtfsrsPYhxOa2CovEd7ub+tc6NYwJ9AjrGTmt8e1iHbb
         D475h8UJgnA1w==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, dianders@chromium.org
Subject: [PATCH 3/4] platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
Date:   Wed, 18 May 2022 17:18:13 +0800
Message-Id: <20220518091814.2028579-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
References: <20220518091814.2028579-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At first glance, cros_ec_check_result() is quite like cros_ec_map_error().
They check for `ec_msg->result` and return corresponding errors.  However,
as calling from `pkt_xfer` and `cmd_xfer`, cros_ec_check_result() should
not report furthermore errors.  -EAGAIN is the only exception.

See [1][2][3] for some known userland programs' code.  The return code
from ioctl only denotes the EC communication status.  Userland programs
would further analyze the `result` in struct cros_ec_command* for
follow-up actions (e.g. [4]).

To clarify, update the function comment.

[1]: https://crrev.com/54400e93a75ef440a83d6eaac2cec066daf99cf0/util/comm-dev.c#154
[2]: https://crrev.com/fe32670a89bf59e1aff84bba9dd3295657b85e9b/cros_ec_dev.c#296
[3]: https://crrev.com/4e19eb1d89de0422ff1bbd3f7260b131c761098c/drivers/google/cros_ec_dev.c#120
[4]: https://crrev.com/54400e93a75ef440a83d6eaac2cec066daf99cf0/util/comm-dev.c#164

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from previous version:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220517082817.1591526-1-tzungbi@kernel.org/)
- Update the link of [3].

 drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 01ab58b3269b..13ced9d2dd71 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -204,9 +204,12 @@ EXPORT_SYMBOL(cros_ec_prepare_tx);
  * @msg: Message to check.
  *
  * This is used by ChromeOS EC drivers to check the ec_msg->result for
- * errors and to warn about them.
+ * EC_RES_IN_PROGRESS and to warn about them.
  *
- * Return: 0 on success or negative error code.
+ * The function should not check for furthermore error codes.  Otherwise,
+ * it would break the ABI.
+ *
+ * Return: -EAGAIN if ec_msg->result == EC_RES_IN_PROGRESS.  Otherwise, 0.
  */
 int cros_ec_check_result(struct cros_ec_device *ec_dev,
 			 struct cros_ec_command *msg)
-- 
2.36.0.550.gb090851708-goog

