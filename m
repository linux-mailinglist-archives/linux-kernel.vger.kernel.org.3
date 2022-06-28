Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C936C55CFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiF1CuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbiF1Ctt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A710E7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DE561486
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19158C34115;
        Tue, 28 Jun 2022 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656384586;
        bh=RCdzDyyspYZBbTy21S73pVMkpsXGg+X2fE0S4NTTvrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEkHb4EOokE+b0s6/tFxK/7Dy/zJ2l5+Y2TaH19ERYx3aocGIFDuMWGQhRX6QF43Q
         xo1WLZ6dytalM553zy0QzILZK2FTiWNG23Lp4/ozz3yh/tmL8IA+9gxiw5iKNltwwl
         FmlQXR02CE8tFJts0zr2k4W9ZgZ8Rln0Laz0+GsestXhNvWjES7HHtCBQNlQxB/S4C
         uZCJTcRBNfK92pCzOXrFeryDfh2a6O8WmbIQND+aNdnIWvmWpRJT16B5hNXlf8cX4w
         l72m2X836aQh9pFgAt3SMeJAhpIwxk51sTyxVa+t3eib1y8+/N3zJ4Gom+M01mWojg
         wr8uXUYj/hw3g==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 11/11] platform/chrome: cros_ec_proto: return -EPROTO if empty payload
Date:   Tue, 28 Jun 2022 02:49:13 +0000
Message-Id: <20220628024913.1755292-12-tzungbi@kernel.org>
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
2.37.0.rc0.161.g10f37bed90-goog

