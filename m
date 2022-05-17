Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF99529C79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiEQI3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbiEQI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B544496BD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A756124F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63540C385B8;
        Tue, 17 May 2022 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652776116;
        bh=z0Xym3AE/OPgfmfQslBqghpEiHagGntjg80lX/HSvug=;
        h=From:To:Cc:Subject:Date:From;
        b=CIoI/LSeCrZ86ryVm8YaWPWy6y+RC8wZPXQHTvnYcuGGqUoshLt+DHmm2uFKu0+4e
         A02DiYmSTDAYPPLjpLOsVmw3IFAmTupNAJXZzBtoyRf8EAn4H/TreaZ+IKdHQnpEjf
         CnZzzQJ8cg434u307h5VpA+B7p4D/iMFuujuKpfRZHtuwdUG5+AENNUfKBT06uSIuf
         Q953swId4ZeitThTCCQ5/K3QD4ihdB0laZNHOtoXiTyK2+y/I+/ucuqBclUAqdAfP+
         Bhb/C5Wa6cbplm0g62h1rFkFl9OboslnnPQFK4Mtium54d5cfs8s6A+0hf+zGp+ZKw
         RVdnasog857qg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, dianders@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
Date:   Tue, 17 May 2022 16:28:17 +0800
Message-Id: <20220517082817.1591526-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[3]: https://crrev.com/5952a561abaeed1491294a33883d6fd2c2c4089f/drivers/google/cros_ec_dev.c#120
[4]: https://crrev.com/54400e93a75ef440a83d6eaac2cec066daf99cf0/util/comm-dev.c#164

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Also see commit 57b888ca2541 ("platform/chrome: Re-introduce
cros_ec_cmd_xfer and use it for ioctls") in for-next branch for some
other details.

The patch bases on the latest for-kernelci branch.
(https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?h=for-kernelci&id=0534c15c9291a0d571d813fa7c54358736d9ef4c)

 drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ff767dccdf0f..48b28745bb84 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -199,9 +199,12 @@ EXPORT_SYMBOL(cros_ec_prepare_tx);
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

base-commit: 0534c15c9291a0d571d813fa7c54358736d9ef4c
-- 
2.36.0.550.gb090851708-goog

